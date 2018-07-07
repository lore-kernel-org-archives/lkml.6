Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72ACC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6187A224F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs5EhNcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6187A224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeGGHJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:09:27 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37011 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeGGHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:09:21 -0400
Received: by mail-qk0-f193.google.com with SMTP id t79-v6so7426372qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kHvoiHgfdln5mZzhDGOPkzQdXH8ARnVhaxUZZILuCKs=;
        b=qs5EhNcN60yKMSUgLBCSURONPpPHRC97dfW4YOFh9xDrcaE0Wmx9Q1/mRZV+9g22Sb
         9FnJAj2kGPYr/EsDVTT/qRjzs9tSO+YT90Ogv3io3qNZdQOAivIH+zCZiFMIo+uZ9+AL
         rLa3rd1o9dFtCn4mojgcCwz8xnSWRv4T4tQ4PXTm28DsoLs3M1W65JRgMgWVuNiC9oZx
         JU3hEkxUUmHSfPA8lPSivavyLpnMw3s/MGXLmyc8yViQNe8rh9gei0k+Lqqr/MFhW44U
         jIcG7P4bBRnwFW6YBbusZojtgUZO7rG+dyQYhC/SBoFrUVnii9fgagL+oNx/9T3Jt1uX
         g/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kHvoiHgfdln5mZzhDGOPkzQdXH8ARnVhaxUZZILuCKs=;
        b=QGJ0u3Z3JhYg+tLbjY59LulKGeoa9xxh08WdFgivSAbSbKEjiMxsuNMAWnBbszK5OP
         H3W+Ljx44/DT6riT+GBMPBSVlkesgKbU/7ImFM7iV4LqkbEEyigWqIkIzYIr96Oj7+XN
         1eJvi9twww0Whv/IDe9VS1zMSr7AERmGOxx4Uhgw8IvO3jWvT9oAxcRN54G/s5Su58kj
         zpzqKNpbCE8qaL0IdK78atWCLInwn3+y+ZKw6AqMHX7g06vsKw8f/heGO4Adjn5lor3V
         CwfX9W70mxaKCmhR/diOFUhcHImtAwKfSE244QpKZ/A1v8oUCjrHBuNoTpp80/aotCeX
         kELQ==
X-Gm-Message-State: APt69E0n2CFAaXncetkJ99ijJzdXtUh+w690DcG3yOcc8oeiyny//0LK
        HSDCvnpdgnF5NQADAvSBr1WGws967MI=
X-Google-Smtp-Source: AAOMgpdtpG7XBdUkitwpuFq5MybmucsBvJedNj2YwnRRkHREq4m8eCTlZ0Hw4VTxcF4GdyKTv62W+A==
X-Received: by 2002:a37:ad0f:: with SMTP id f15-v6mr11461267qkm.255.1530947361286;
        Sat, 07 Jul 2018 00:09:21 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (pool-108-18-228-108.washdc.fios.verizon.net. [108.18.228.108])
        by smtp.gmail.com with ESMTPSA id t17-v6sm3880106qtp.96.2018.07.07.00.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 00:09:20 -0700 (PDT)
Date:   Sat, 7 Jul 2018 03:09:19 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     peter.vernia@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name,
        peter.vernia@gmail.com, blogic@openwrt.org,
        sankalpnegi2310@gmail.com, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: mt7621-pci: Add spaces after commas in
 pci-mt7621.c
Message-ID: <20180707070919.GA26584@peter-ThinkPad-X220-Tablet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds spaces after commas in parameter lists in pci-mt7621.c

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c7932ae..3c7978e 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -399,10 +399,10 @@ set_phy_for_ssc(void)
 		if (reg >= 6) {
 			printk("***** Xtal 25MHz *****\n");
 			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL	//Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0, 31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0, 16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
 		} else {
 			printk("***** Xtal 20MHz *****\n");
 		}
@@ -436,10 +436,10 @@ set_phy_for_ssc(void)
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV	//Pre-divider ratio (for host mode)
 		if (reg >= 6) {		// 25MHz Xtal
 			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL	//Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0, 31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO	//DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0, 16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD	//DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA	//DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1	//DDS SSC dither amplitude control for initial
 		}
 	}
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV	//DDS clock inversion
-- 
2.7.4

