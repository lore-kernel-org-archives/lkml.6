Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2AFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 03:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397792077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 03:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLtFC6jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397792077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeIBHwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 03:52:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42263 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeIBHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 03:52:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so7134464plq.9;
        Sat, 01 Sep 2018 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3K4kSuxu827WHh082ikX2FWwsZSaS31NBKKl+b98ITk=;
        b=dLtFC6jJ4fCul+bBI35/+LyMa47wy9NPgQDfBe4V7D4Z93fYtw5xNqztWID+S3zILp
         bAZx0sGcOo7e8cis2ILijXHFJmLvLYE9lizgbW5RMC7cy7mTTaIihioPaJLf8GatZbyc
         D1fdAWLtGq4+HjCI0NQ1a5keoDaXiT3pIQzVxdeK7Nxw/s2yjR4aJv2eMX1rl8UVJWpJ
         L8s5CVD/VnpW2vXp6TVI9fpz3AyAnfCmWbCdUubTCmCsL/XH7Mc71rvMSEyt0NbPl42/
         upAuwMmfnpLhv+hwOJPQIs/gII2rnHTq/oDOzcOX+6zleNwsSjJPOix96AQ8ASrkUWID
         Zx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3K4kSuxu827WHh082ikX2FWwsZSaS31NBKKl+b98ITk=;
        b=MhjrQFJK3hhhYgO59ecpLrYozG2MVfftSvS07H+t5NzA/iYB/7aNn6NJ71s+cpARYp
         K+PZ+/sl6Ug+PrtcIhrlruqOdF4uF1a3nLCphu0tOkc6RKAB3Rfhnhjd69ZQAxeTtazt
         xjYqm1bAKd1G9DaX27fSuXusWIpHcnSQSb6Apw/0BS87bBNQb4jbRdMzQ6XgDH4t8kZG
         0QlT6OQoBjkHzI66oVsFLPTHXAyP7N7B6R3cN/ZNKB4o8MuvkJkwTbkkJ1ZoG5HN8Pfu
         pGH+hvgujOX/peFLrGdI5DPwyA3UagDTkQDFKIE0wwenQng0mbIIARtiLCXxSZrpoYQ+
         f3pw==
X-Gm-Message-State: APzg51CYwShog+JnSDScDqBhMSrgEbihLNxJjHGv5649bFdB97t5qPvf
        qc1dl8FdiEbwbnC1g0VO6NA=
X-Google-Smtp-Source: ANB0VdbtrOzvzrvA3VWy2J2JF8LsQvy0McGzSS3QKFeNemBweTuMmokTXmED2eipglFOGXollHuelQ==
X-Received: by 2002:a17:902:934c:: with SMTP id g12-v6mr22331029plp.67.1535859500357;
        Sat, 01 Sep 2018 20:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id x82-v6sm29526708pfe.129.2018.09.01.20.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 20:38:19 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] pci: dwc: pcie_designware: Fix a sleep-in-atomic-context bug in dw_pcie_prog_outbound_atu
Date:   Sun,  2 Sep 2018 11:38:11 +0800
Message-Id: <20180902033811.26858-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock and in an interupt handler.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] usleep_range
drivers/pci/dwc/pcie-designware.c, 181: 
	usleep_range in dw_pcie_prog_outbound_atu
drivers/pci/dwc/pcie-designware-host.c, 479: 
	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
drivers/pci/dwc/pcie-designware-host.c, 561: 
	dw_pcie_rd_other_conf in dw_pcie_rd_conf
drivers/pci/access.c, 66: 
	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
drivers/pci/access.c, 918: 
	pci_bus_read_config_word in pci_read_config_word
drivers/block/umem.c, 630: 
	pci_read_config_word in mm_interrupt (interrupt handler)

[FUNC] usleep_range
drivers/pci/dwc/pcie-designware.c, 181: 
	usleep_range in dw_pcie_prog_outbound_atu
drivers/pci/dwc/pcie-designware-host.c, 479: 
	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
drivers/pci/dwc/pcie-designware-host.c, 561: 
	dw_pcie_rd_other_conf in dw_pcie_rd_conf
drivers/pci/access.c, 66: 
	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
drivers/pci/access.c, 918: 
	pci_bus_read_config_word in pci_read_config_word
drivers/ata/pata_efar.c, 115: 
	pci_read_config_word in efar_set_piomode
drivers/ata/pata_efar.c, 113: 
	_raw_spin_lock_irqsave in efar_set_piomod

[FUNC] usleep_range
drivers/pci/dwc/pcie-designware.c, 181: 
	usleep_range in dw_pcie_prog_outbound_atu
drivers/pci/dwc/pcie-designware-host.c, 479: 
	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
drivers/pci/dwc/pcie-designware-host.c, 561: 
	dw_pcie_rd_other_conf in dw_pcie_rd_conf
drivers/pci/access.c, 66: 
	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
drivers/pci/access.c, 918: 
	pci_bus_read_config_word in pci_read_config_word
drivers/block/mtip32xx/mtip32xx.c, 158: 
	pci_read_config_word in mtip_check_surprise_removal
drivers/block/mtip32xx/mtip32xx.c, 843: 
	mtip_check_surprise_removal in mtip_handle_irq
drivers/block/mtip32xx/mtip32xx.c, 879: 
	mtip_handle_irq in mtip_irq_handler (interrupt handler)

[FUNC] usleep_range
drivers/pci/dwc/pcie-designware.c, 181: 
	usleep_range in dw_pcie_prog_outbound_atu
drivers/pci/dwc/pcie-designware-host.c, 479: 
	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
drivers/pci/dwc/pcie-designware-host.c, 561: 
	dw_pcie_rd_other_conf in dw_pcie_rd_conf
drivers/pci/access.c, 66: 
	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
drivers/pci/access.c, 918: 
	pci_bus_read_config_word in pci_read_config_word
drivers/gpu/vga/vgaarb.c, 645: 
	pci_read_config_word in vga_arbiter_add_pci_device
drivers/gpu/vga/vgaarb.c, 629: 
	_raw_spin_lock_irqsave in vga_arbiter_add_pci_device

[FUNC] usleep_range
drivers/pci/dwc/pcie-designware.c, 181: 
	usleep_range in dw_pcie_prog_outbound_atu
drivers/pci/dwc/pcie-designware-host.c, 479: 
	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
drivers/pci/dwc/pcie-designware-host.c, 561: 
	dw_pcie_rd_other_conf in dw_pcie_rd_conf
drivers/pci/access.c, 66: 
	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
drivers/pci/access.c, 918: 
	pci_bus_read_config_word in pci_read_config_word
drivers/pci/ats.c, 139: 
	pci_read_config_word in pci_ats_queue_depth
drivers/iommu/intel-iommu.c, 1519: 
	pci_ats_queue_depth in iommu_enable_dev_iotlb
drivers/iommu/intel-iommu.c, 5295: 
	iommu_enable_dev_iotlb in intel_iommu_enable_pasid
drivers/iommu/intel-iommu.c, 5241: 
	_raw_spin_lock_irqsave in intel_iommu_enable_pasid

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 778c4f76a884..7f50f7e51543 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		udelay(LINK_WAIT_IATU_MAX);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
-- 
2.17.0

