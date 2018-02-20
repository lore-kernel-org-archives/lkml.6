Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeBTQ0l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:26:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbeBTQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:26:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: davinci: mark spi_board_info arrays as const
Date: Tue, 20 Feb 2018 17:24:52 +0100
Message-Id: <20180220162519.1498223-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
X-Provags-ID: V03:K0:CEL2rBjhj9qEenvQisE9yXiW+GPYa2hHI2gzFVuC91Oy2cC+aMC
 Bh1saIFYJBE9eq67YaJWdbZC5r8dWmr4GMeaIVQe8DFSUIBleRzpZWm6BOr6dNbR9jhDdbX
 gJP1c1Oe3DjeUQEATzLnJZAyAX0hNrW0SiOxGEQ6AZ2AW12OYzNbOFX/jLOh9v+8EkN+tLq
 ptyoViB8yjRRd4usFczzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pgcakMaqZBo=:YCz4R+Xa9GS0IddLGToet+
 ccyU5qiqGJb6y36ajSs+FX8NRxo2AZlblF6ejmMLS1D1sHO31DxhkgCSmoAoi+j/v3xdvkp8j
 HNSfGVeNgWq9ekf74UVpcwik5pnncfMCi/QWer72A5hVNtMOVP43qviv/JuNSvWn0ti6qNMNZ
 hybZ7tVD7jGaMC4FSU+zUXGuURKb66nezTtJdV84GO8dlkLh8K4p/PvAVgvU+zLfmUTwUGAD3
 +K9iu1dHYMYQGPENw2FM1lgclX81+q2zyHeOsV/hSipW20OiCtWBDxVknEpNRz8S8aWROVqmT
 x4wTdqtMjQqLT8QkhP2oMQj64TZIAFQBKx+2RsqUhx5L1FA9zEWb0bA8ObwFFtXe+0jg8JixB
 RNzmuGtC2XLtAapryvwaxOaBxDWnE6KD/rF/rjVKBZdoBQzwZmIE/H0/6nAwvERvvZLCrl00Q
 lF4B6u4g2KBjnWPbtvft8AJielaZ1kjtaS4pBB8X1esDIAWhQyyn38SIbXkJycb9eDu9j5NZN
 q2CI6ExiE4uxggtqYPQTIOzpsnPXSDtPnrR3cZd5taUUGR5Xp7okZxiJcybQ/yUVUmH6h08cw
 irmlGO8zM6aAjefgGmMs0o7JssdhElh4S28u38IyC2A+TbYjGBlhGrk16UkIlUBR5ezO6yyLv
 CM0t4rbFhI3ZEqc20IERwkaqcakLL7Sbnaa+XukDEhHbcKL2UsNnQo8/54QmoQ37mmpIvAzXt
 Jufhr8iLwKS5kqm8se36B01bqChO31XStO2YcA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with LTO revealed that three spi_board_info arrays are marked
__initconst, but not const:

arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
arch/arm/mach-davinci/board-dm365-evm.c:729:30: error: 'dm365_evm_spi_info' causes a section type conflict with 'dm646x_edma_device'
 static struct spi_board_info dm365_evm_spi_info[] __initconst = {
                              ^
arch/arm/mach-davinci/dm646x.c:603:42: note: 'dm646x_edma_device' was declared here
 static const struct platform_device_info dm646x_edma_device __initconst = {

This marks them const as well, as was originally intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index e457f299cd44..d6b11907380c 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -368,7 +368,7 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm355_evm_spi_info[] __initconst = {
+static const struct spi_board_info dm355_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index be997243447b..fad9a5611a5d 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -217,7 +217,7 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
+static const struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e75741fb2c1d..e3780986d2a3 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -726,7 +726,7 @@ static struct spi_eeprom at25640 = {
 	.flags		= EE_ADDR2,
 };
 
-static struct spi_board_info dm365_evm_spi_info[] __initconst = {
+static const struct spi_board_info dm365_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640,
-- 
2.9.0
