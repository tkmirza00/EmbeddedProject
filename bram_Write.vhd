----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2021 12:17:41 PM
-- Design Name: 
-- Module Name: nn_ctrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Stores nn_res_in value in BRAM when it's between 0 and 9.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bram_write is
    Port (  i_Clk       : in STD_LOGIC;
            nn_res_in   : in std_logic_vector(31 downto 0);
            o_BRAM_addr : out std_logic_vector(31 downto 0);
            o_BRAM_ce   : out std_logic;
            o_BRAM_wr   : out std_logic_vector(3 downto 0);
            o_BRAM_din  : out std_logic_vector(31 downto 0)
          );
end bram_write;

architecture Behavioral of bram_write is

    signal pred : integer range 0 to 15 := 0;

begin

    PROCESS(i_Clk)
    BEGIN
        if rising_edge(i_Clk) then
            -- Convert nn_res_in to integer for comparison
            pred <= to_integer(signed(nn_res_in));

            if (pred >= 0 and pred <= 9) then
                -- Write to BRAM when value is between 0 and 9
                o_BRAM_addr <= (others => '0'); -- Fixed address
                o_BRAM_ce   <= '1'; -- Enable BRAM access
                o_BRAM_wr   <= "1111"; -- Enable write for all bytes
                o_BRAM_din  <= nn_res_in; -- Write nn_res_in to BRAM
            else
                -- Disable BRAM write for other values
                o_BRAM_ce   <= '0';
                o_BRAM_wr   <= "0000";
            end if;
        end if;
    END PROCESS;

end Behavioral;
