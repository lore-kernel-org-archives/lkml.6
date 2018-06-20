Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B87C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3DD20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3DD20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFTUVJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:21:09 -0400
Received: from avasout06.plus.net ([212.159.14.18]:58713 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeFTUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:20:57 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id Vjb4fURWUWLW2Vjb5fo3ZI; Wed, 20 Jun 2018 21:20:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=7mUfYlMuFuIA:10 a=beXlt2xKAAAA:8 a=VwQbUJbxAAAA:8 a=F3uLQHj-DGfmKU-asAgA:9
 a=gcY2M4Ci8LIz02MwfSIM:22 a=AjGcO6oz07-iQ99wixmX:22
Received: by hairyalien (sSMTP sendmail emulation); Wed, 20 Jun 2018 21:20:54 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>, stable@vger.kernel.org
Subject: [PATCH v3] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
Date:   Wed, 20 Jun 2018 21:20:45 +0100
Message-Id: <20180620202045.27965-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620194239.2730-1-nick@shmanahar.org>
References: <20180620194239.2730-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfKYjF4aTLtOSC5VXyk7pSqHK8BtUybgREcDuGXD6ZMgPUULw80i2QQ34MCT7+Pqe/PV+l7yzBVPk2ROiyDoJteO1K56jM+IVvnTXMnHK619J9rcKernF
 jL8rgIjvX/aiPPHZR9cLbokcoDqVi7ba6MMRjkon027RjqUeKqa7dWkp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl settings were incorrect for the touchscreen interrupt line, causing
an interrupt storm. This change has been tested with both the atmel_mxt_ts and
RMI4 drivers on the RDU1 units.

The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
from the old vendor kernel.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
Cc: <stable@vger.kernel.org> # 4.15+
---
Changes in v3:
- Update commit message to add source of 0x4 value, fixes tag and CC stable
Changes in v2:
- Use hex, only alter IRQ line config

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

