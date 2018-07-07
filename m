Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C1C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380D82241D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Obe4MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380D82241D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeGGHH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:07:59 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41496 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:07:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id d22-v6so7414994qkc.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KoTsG+RY7Iqld1O2wFGKVQYt+xETDEGiMyzL6ZcgasA=;
        b=T0Obe4MJZzuuG3G/CI+bOPN5oPzfzfCG4WdZ46lh9mhUKGum/FdeO45obiFtiBR0as
         DWD2dKObEJVIOhCZDA6rui1ui3n3n2Xbnotiwub133UMO7uj5ure3WImNepWjfAJ/yt6
         34w/tw+A5o+loLhf0qsAyGwA2C7n/ACrf9r0dXUqU79kGxjTpI2k/Y58UAJxSKV1c4+J
         18XcNd3WqNErsURenqRweL66dJqfbO9Ozn5MiN+gqtmH5SP5N7D1rcYGYpJQzlME1+Of
         TFWzF9Mvtv7iLBZVPLhTKaCX9PSXu/orhjteohkf2bO2BPMn/eLBbInAOacgip7iR/38
         KSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KoTsG+RY7Iqld1O2wFGKVQYt+xETDEGiMyzL6ZcgasA=;
        b=k2sMbAGQGtrrfA+OxvfSzbWgBvA36F3isypvgotbV6vqaHIqSFbbuuQzye5tARXFw+
         g9U+vAQtiKsZwa5wWQX8qynTV++33DMgo8+D6aYoOHuVUb6EKuL4FKWC4VW1u/YeIjPN
         tqUV7CgI6qn8ENhNVQ7+FnpbZ0W5jv7QIl32QOVeq6XGNbFAs1S1qiV+lxSGQcTkgup5
         QIlSVrsthNVwKzJEox02z7uH3RGBK7Yg/MtLr6N12fIQffFxgjSTgbwU1MYPhMF7ZJhp
         +/CWHV1XxFAk83sNOQCIN+/GMd/SoPcWghkurFjXQRtDSKFiaBqPIwAF0oksDasNJNxP
         /63w==
X-Gm-Message-State: APt69E3YTRwKs4FeUkLBN9V+XyxVz3En4tLIDnCsGhfjwNxGTHzBcLl1
        YgOae+k++XW24KeOcmdQ6t4=
X-Google-Smtp-Source: AAOMgpcVNT4qW7MG4nCOQLSRr71TJOxF2zQEDn7+PDZSyWkYEumYs7Q+wLYdmKZWFzYSZUcg/tboCw==
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr10863008qkd.32.1530947277389;
        Sat, 07 Jul 2018 00:07:57 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (pool-108-18-228-108.washdc.fios.verizon.net. [108.18.228.108])
        by smtp.gmail.com with ESMTPSA id s127-v6sm3998544qkf.80.2018.07.07.00.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 00:07:56 -0700 (PDT)
Date:   Sat, 7 Jul 2018 03:07:55 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     peter.vernia@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name,
        peter.vernia@gmail.com, blogic@openwrt.org,
        sankalpnegi2310@gmail.com, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: mt7621-pci: Fix spaces around parenthesis in
 pci-7621.c
Message-ID: <20180707070755.GA26557@peter-ThinkPad-X220-Tablet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds spaces before open parenthesis, and removes spaces after open parenthesis

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index b373d76..ded58ba 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -139,14 +139,14 @@
 			rt_sysc_m32(0, val, RALINK_RSTCTRL);		\
 		else							\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
-	} while(0)
+	} while (0)
 #define DEASSERT_SYSRST_PCIE(val)	\
 	do {								\
 		if (rt_sysc_r32(SYSC_REG_CHIP_REV) == 0x00030101)	\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
 		else							\
 			rt_sysc_m32(0, val, RALINK_RSTCTRL);		\
-	} while(0)
+	} while (0)
 #define RALINK_CLKCFG1			0x30
 #define RALINK_RSTCTRL			0x34
 #define RALINK_GPIOMODE			0x60
@@ -195,7 +195,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 				(func << 8) | (where & 0xfc) | 0x80000000;
 	MV_WRITE(address_reg, address);
 
-	switch(access_type) {
+	switch (access_type) {
 	case PCI_ACCESS_WRITE_1:
 		MV_WRITE_8(data_reg+(where&0x3), *data);
 		break;
@@ -206,7 +206,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 		MV_WRITE(data_reg, *data);
 		break;
 	case PCI_ACCESS_READ_1:
-		MV_READ_8( data_reg+(where&0x3), data);
+		MV_READ_8(data_reg+(where&0x3), data);
 		break;
 	case PCI_ACCESS_READ_2:
 		MV_READ_16(data_reg+(where&0x3), data);
@@ -391,7 +391,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x01);	// rg_pe1_frc_phy_en	//Force Port 1 enable control
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 0 disable
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 1 disable
-	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
 		printk("***** Xtal 40MHz *****\n");
 	} else {			// 25MHz | 20MHz Xtal
@@ -414,7 +414,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
-	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv	//force mode enable of da_pe1_mstckdiv
 	}
@@ -430,7 +430,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x400),  9, 2, 0x00);	// rg_pe1_h_xtal_type
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x01);	// rg_pe1_frc_phy_en	//Force Port 0 enable control
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x00);	// rg_pe1_phy_en	//Port 0 disable
-	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x01);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
 	} else {			// 25MHz | 20MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
@@ -449,7 +449,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  8, 4, 0x01);	// RG_PE1_H_PLL_IC
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4ac), 16, 3, 0x00);	// RG_PE1_H_PLL_BR
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  1, 3, 0x02);	// RG_PE1_PLL_DIVEN
-	if(reg <= 5 && reg >= 3) {	// 40MHz Xtal
+	if (reg <= 5 && reg >= 3) {	// 40MHz Xtal
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  6, 2, 0x01);	// rg_pe1_mstckdiv		//value of da_pe1_mstckdiv when force mode enable
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x414),  5, 1, 0x01);	// rg_pe1_frc_mstckdiv	//force mode enable of da_pe1_mstckdiv
 	}
@@ -532,7 +532,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	*(unsigned int *)(0xbe000620) |= 0x1<<19 | 0x1<<8 | 0x1<<7;		// set DATA
 	mdelay(1000);
 
-	if(( RALINK_PCI0_STATUS & 0x1) == 0)
+	if ((RALINK_PCI0_STATUS & 0x1) == 0)
 	{
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
@@ -543,7 +543,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		RALINK_PCI_PCIMSK_ADDR |= (1<<20); // enable pcie1 interrupt
 	}
 
-	if(( RALINK_PCI1_STATUS & 0x1) == 0)
+	if ((RALINK_PCI1_STATUS & 0x1) == 0)
 	{
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
@@ -554,7 +554,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		RALINK_PCI_PCIMSK_ADDR |= (1<<21); // enable pcie1 interrupt
 	}
 
-	if (( RALINK_PCI2_STATUS & 0x1) == 0) {
+	if ((RALINK_PCI2_STATUS & 0x1) == 0) {
 		printk("PCIE2 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE2_RST);
 		rt_sysc_m32(RALINK_PCIE2_CLK_EN, 0, RALINK_CLKCFG1);
@@ -578,7 +578,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 3'b110			1		0		x
 3'b111			2		1		0
 */
-	switch(pcie_link_status) {
+	switch (pcie_link_status) {
 	case 2:
 		RALINK_PCI_PCICFG_ADDR &= ~0x00ff0000;
 		RALINK_PCI_PCICFG_ADDR |= 0x1 << 16;	//port0
@@ -613,7 +613,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	RALINK_PCI_IOBASE = RALINK_PCI_IO_MAP_BASE;
 
 	//PCIe0
-	if((pcie_link_status & 0x1) != 0) {
+	if ((pcie_link_status & 0x1) != 0) {
 		RALINK_PCI0_BAR0SETUP_ADDR = 0x7FFF0001;	//open 7FFF:2G; ENABLE
 		RALINK_PCI0_IMBASEBAR0_ADDR = MEMORY_BASE;
 		RALINK_PCI0_CLASS = 0x06040001;
@@ -636,7 +636,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		printk("PCIE2 enabled\n");
 	}
 
-	switch(pcie_link_status) {
+	switch (pcie_link_status) {
 	case 7:
 		read_config(0, 2, 0, 0x4, &val);
 		write_config(0, 2, 0, 0x4, val|0x4);
-- 
2.7.4

