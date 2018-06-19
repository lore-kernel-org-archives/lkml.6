Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92E7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ABF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ABF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757476AbeFSWPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:15:08 -0400
Received: from avasout06.plus.net ([212.159.14.18]:46386 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935772AbeFSWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:15:01 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 18:15:01 EDT
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id VOmafT3u5WLW2VOmbfngd3; Tue, 19 Jun 2018 23:07:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=7mUfYlMuFuIA:10 a=beXlt2xKAAAA:8 a=81ouMDSXA1V0I4RUQfkA:9
 a=gcY2M4Ci8LIz02MwfSIM:22
Received: by hairyalien (sSMTP sendmail emulation); Tue, 19 Jun 2018 23:07:24 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
Date:   Tue, 19 Jun 2018 23:07:19 +0100
Message-Id: <20180619220719.3200-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfICAg3fdN+Y+CnyPEr8//uMk56FhSuuVTdLjL4d2zKt3sb2DZz3UGnYFN+jKdgohkVlL+ZhHIfFKDshBfr2/101b5sWaW/WXzqG/NlCoIDwV9a4Rfsv9
 UdQiimDBGS230TqBtV3t7mbnMkLyt4SOW96WQjZeIgH/i29MjcCzp5rSmzew3l6Fgik5Ra/8lKu8ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl settings were incorrect for the touchscreen interrupt line, causing
an interrupt storm. This change has been tested with both the atmel_mxt_ts and
RMI4 drivers on the RDU1 units.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index df9eca94d812..4d12ba54ba15 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -770,8 +770,8 @@
 
 	pinctrl_ts: tsgrp {
 		fsl,pins = <
-			MX51_PAD_CSI1_D8__GPIO3_12		0x85
-			MX51_PAD_CSI1_D9__GPIO3_13		0x85
+			MX51_PAD_CSI1_D8__GPIO3_12		4
+			MX51_PAD_CSI1_D9__GPIO3_13		(1<<16)
 		>;
 	};
 
-- 
2.17.1

