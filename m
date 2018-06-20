Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED1C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E732520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E732520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFTTms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:42:48 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56231 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeFTTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:42:46 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id Vj06fUPHSWLW2Vj07fo34F; Wed, 20 Jun 2018 20:42:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=7mUfYlMuFuIA:10 a=beXlt2xKAAAA:8 a=81ouMDSXA1V0I4RUQfkA:9
 a=gcY2M4Ci8LIz02MwfSIM:22
Received: by hairyalien (sSMTP sendmail emulation); Wed, 20 Jun 2018 20:42:42 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v2] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
Date:   Wed, 20 Jun 2018 20:42:39 +0100
Message-Id: <20180620194239.2730-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfDGh99dMvRexTo07K7MF+bBKlKW/hNPrATALU7AYNmCIwyItp/LZcA5kz85O7gDfVc6G1at9sjPR/BLS/WdBjkoQd6HYmR5oXDxTJnIDrft2yY7wsjYW
 sSMNILrM4OP7zhnSEA8MAG0SlA7FrRx82vj9Zaqw2mScXCw8t0SU4HXQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl settings were incorrect for the touchscreen interrupt line, causing
an interrupt storm. This change has been tested with both the atmel_mxt_ts and
RMI4 drivers on the RDU1 units.

[v2: Use hex, only alter IRQ line config]

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index df9eca94d812..8a878687197b 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -770,7 +770,7 @@
 
 	pinctrl_ts: tsgrp {
 		fsl,pins = <
-			MX51_PAD_CSI1_D8__GPIO3_12		0x85
+			MX51_PAD_CSI1_D8__GPIO3_12		0x04
 			MX51_PAD_CSI1_D9__GPIO3_13		0x85
 		>;
 	};
-- 
2.17.1

