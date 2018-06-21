Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D600C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7E219CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E7E219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFUSKO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:10:14 -0400
Received: from avasout06.plus.net ([212.159.14.18]:35478 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbeFUSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:10:12 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id W423fVooqWLW2W424foSFC; Thu, 21 Jun 2018 19:10:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=7mUfYlMuFuIA:10 a=beXlt2xKAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=pGLkceISAAAA:8 a=F3uLQHj-DGfmKU-asAgA:9 a=gcY2M4Ci8LIz02MwfSIM:22
 a=AjGcO6oz07-iQ99wixmX:22 a=ST-jHhOKWsTCqRlWije3:22
Received: by hairyalien (sSMTP sendmail emulation); Thu, 21 Jun 2018 19:10:07 +0100
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
Subject: [PATCH v5] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
Date:   Thu, 21 Jun 2018 19:10:00 +0100
Message-Id: <20180621181000.12687-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
References: <CAFXsbZr-HJE54c0BC5=d1tStByA5ytGhSSZMirNKE03JzGCDXQ@mail.gmail.com>
X-CMAE-Envelope: MS4wfLxqLVa4lMNZHMyDkgzJ/RaDw71eEd5Fkd8XqShTahJEbBxwD6/2QFS5uN39mhZmeQj5imbx8T2lLbb2Gh/WcGOwImzcknk5d2FtwCCM6yLE5sotrsTq
 Rp7tUYIpEFaEM8kP1WyTzfQy1aZeQvpzuL4XCpBB4saP8mXM6/6pNg0QxztG0FcNNNRr9l5gKNHgsw==
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
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Chris Healy <cphealy@gmail.com>
---
Changes in v5:
- Add tested by Chris Healy
Changes in v4:
- Add reviewed by Fabio
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

