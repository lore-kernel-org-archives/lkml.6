Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeFCQBS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38346 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFCQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:14 -0400
X-Google-Smtp-Source: ADUXVKLLgE5QqS67YsN57LFHReQEo+BnYgCajET55SX+sexeO7KEBZdZYEESx0Drf/ScDTpv4/Rhtg==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 3/7] staging: mt7621-pci: add space before open parenthesis
Date: Sun,  3 Jun 2018 21:30:00 +0530
Message-Id: <eed9fbca1cd4f35a13aba7a07cd0f9cbaab73c26.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch error:

ERROR: space required before the open parenthesis '('

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index fbcee58445b3..28b9a11e9ecb 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -155,13 +155,13 @@ extern void chk_phy_pll(void);
 							RALINK_RSTCTRL |= val;	\
 						else	\
 							RALINK_RSTCTRL &= ~val;	\
-					} while(0)
+					} while (0)
 #define DEASSERT_SYSRST_PCIE(val) 	do {	\
 						if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
 							RALINK_RSTCTRL &= ~val;	\
 						else	\
 							RALINK_RSTCTRL |= val;	\
-					} while(0)
+					} while (0)
 #define RALINK_SYSCFG1			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x14)
 #define RALINK_CLKCFG1			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x30)
 #define RALINK_RSTCTRL			*(unsigned int *)(RALINK_SYSTEM_CONTROL_BASE + 0x34)
@@ -210,7 +210,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 	address = (((where&0xF00)>>8)<<24) |(bus->number << 16) | (slot << 11) | (func << 8) | (where & 0xfc) | 0x80000000;
 	MV_WRITE(address_reg, address);
 
-	switch(access_type) {
+	switch (access_type) {
 	case PCI_ACCESS_WRITE_1:
 		MV_WRITE_8(data_reg+(where&0x3), *data);
 		break;
@@ -374,12 +374,12 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		read_config(0, 0, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 0 = %x\n", val);
 		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-	} else if((dev->bus->number == 0) && (slot == 0x1)) {
+	} else if ((dev->bus->number == 0) && (slot == 0x1)) {
 		write_config(0, 1, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
 		read_config(0, 1, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 1 = %x\n", val);
 		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
-	} else if((dev->bus->number == 0) && (slot == 0x2)) {
+	} else if ((dev->bus->number == 0) && (slot == 0x2)) {
 		write_config(0, 2, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
 		read_config(0, 2, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 2 = %x\n", val);
@@ -493,7 +493,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x01);	// rg_pe1_frc_phy_en               //Force Port 1 enable control
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 0 disable
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 1 disable
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) { 	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
 		printk("***** Xtal 40MHz *****\n");
 	} else {			// 25MHz | 20MHz Xtal
@@ -516,7 +516,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) { 	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv          //force mode enable of da_pe1_mstckdiv
 	}
@@ -533,7 +533,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x400),  9, 2, 0x00);	// rg_pe1_h_xtal_type
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en               //Force Port 0 enable control
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en                   //Port 0 disable
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) { 	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
 	} else {			// 25MHz | 20MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
@@ -552,7 +552,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
-	if(reg <= 5 && reg >= 3) { 	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) { 	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv          //force mode enable of da_pe1_mstckdiv
 	}
@@ -663,7 +663,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
-	if((RALINK_PCI0_STATUS & 0x1) == 0)
+	if ((RALINK_PCI0_STATUS & 0x1) == 0)
 	{
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
@@ -675,7 +675,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT1)
-	if((RALINK_PCI1_STATUS & 0x1) == 0)
+	if ((RALINK_PCI1_STATUS & 0x1) == 0)
 	{
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
@@ -711,7 +711,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 3'b110			1		0		x
 3'b111			2		1		0
 */
-	switch(pcie_link_status) {
+	switch (pcie_link_status) {
 	case 2:
 		RALINK_PCI_PCICFG_ADDR &= ~0x00ff0000;
 		RALINK_PCI_PCICFG_ADDR |= 0x1 << 16;	//port0
@@ -749,7 +749,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 
 #if defined (CONFIG_PCIE_PORT0)
 	//PCIe0
-	if((pcie_link_status & 0x1) != 0) {
+	if ((pcie_link_status & 0x1) != 0) {
 		RALINK_PCI0_BAR0SETUP_ADDR = 0x7FFF0001;	//open 7FFF:2G; ENABLE
 		RALINK_PCI0_IMBASEBAR0_ADDR = MEMORY_BASE;
 		RALINK_PCI0_CLASS = 0x06040001;
@@ -776,7 +776,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 #endif
 
 
-	switch(pcie_link_status) {
+	switch (pcie_link_status) {
 	case 7:
 		read_config(0, 2, 0, 0x4, &val);
 		write_config(0, 2, 0, 0x4, val|0x4);
-- 
2.17.0
