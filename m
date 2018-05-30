Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeE3LUQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32771 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752566AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "Florian Fainelli" <florian@openwrt.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.571074819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 074/153] MIPS: TXX9: use IS_ENABLED() macro
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian@openwrt.org>

commit b33b44073734842ec0c75d376c40d0471d6113ff upstream.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/3334/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/txx9/generic/setup.c        | 12 +++++-------
 arch/mips/txx9/generic/setup_tx4939.c |  2 +-
 arch/mips/txx9/rbtx4939/setup.c       | 11 +++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -632,7 +632,7 @@ void __init txx9_physmap_flash_init(int
 				    unsigned long size,
 				    const struct physmap_flash_data *pdata)
 {
-#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+#if IS_ENABLED(CONFIG_MTD_PHYSMAP)
 	struct resource res = {
 		.start = addr,
 		.end = addr + size - 1,
@@ -670,8 +670,7 @@ void __init txx9_physmap_flash_init(int
 void __init txx9_ndfmc_init(unsigned long baseaddr,
 			    const struct txx9ndfmc_platform_data *pdata)
 {
-#if defined(CONFIG_MTD_NAND_TXX9NDFMC) || \
-	defined(CONFIG_MTD_NAND_TXX9NDFMC_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_TXX9NDFMC)
 	struct resource res = {
 		.start = baseaddr,
 		.end = baseaddr + 0x1000 - 1,
@@ -687,7 +686,7 @@ void __init txx9_ndfmc_init(unsigned lon
 #endif
 }
 
-#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_GPIO)
 static DEFINE_SPINLOCK(txx9_iocled_lock);
 
 #define TXX9_IOCLED_MAXLEDS 8
@@ -810,7 +809,7 @@ void __init txx9_iocled_init(unsigned lo
 void __init txx9_dmac_init(int id, unsigned long baseaddr, int irq,
 			   const struct txx9dmac_platform_data *pdata)
 {
-#if defined(CONFIG_TXX9_DMAC) || defined(CONFIG_TXX9_DMAC_MODULE)
+#if IS_ENABLED(CONFIG_TXX9_DMAC)
 	struct resource res[] = {
 		{
 			.start = baseaddr,
@@ -866,8 +865,7 @@ void __init txx9_aclc_init(unsigned long
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in)
 {
-#if defined(CONFIG_SND_SOC_TXX9ACLC) || \
-	defined(CONFIG_SND_SOC_TXX9ACLC_MODULE)
+#if IS_ENABLED(CONFIG_SND_SOC_TXX9ACLC)
 	unsigned int dma_base = dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
 	struct resource res[] = {
 		{
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -317,7 +317,7 @@ void __init tx4939_sio_init(unsigned int
 	}
 }
 
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
 	struct ethtool_cmd cmd;
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -40,8 +40,7 @@ static void __init rbtx4939_time_init(vo
 	tx4939_time_init(0);
 }
 
-#if defined(__BIG_ENDIAN) && \
-	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE))
+#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_SMC91X)
 #define HAVE_RBTX4939_IOSWAB
 #define IS_CE1_ADDR(addr) \
 	((((unsigned long)(addr) - IO_BASE) & 0xfff00000) == TXX9_CE(1))
@@ -187,7 +186,7 @@ static void __init rbtx4939_update_ioc_p
 
 #define RBTX4939_MAX_7SEGLEDS	8
 
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -263,7 +262,7 @@ static inline void rbtx4939_led_setup(vo
 
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
@@ -287,7 +286,7 @@ static void rbtx4939_7segled_putc(unsign
 	__rbtx4939_7segled_putc(pos, val);
 }
 
-#if defined(CONFIG_MTD_RBTX4939) || defined(CONFIG_MTD_RBTX4939_MODULE)
+#if IS_ENABLED(CONFIG_MTD_RBTX4939)
 /* special mapping for boot rom */
 static unsigned long rbtx4939_flash_fixup_ofs(unsigned long ofs)
 {
@@ -463,7 +462,7 @@ static void __init rbtx4939_device_init(
 		.flags = SMC91X_USE_16BIT,
 	};
 	struct platform_device *pdev;
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 	int i, j;
 	unsigned char ethaddr[2][6];
 	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
