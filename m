Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BCCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACDF20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="U4Drm4/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACDF20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeGIPtz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:49:55 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49838 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbeGIPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:20 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0A0B85C1E51;
        Mon,  9 Jul 2018 17:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531151359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3e3VROFueMbjSB10IdkTi1mIjjMAgaVr0wWUHEX1RU0=;
        b=U4Drm4/Paz9I8/qAw6dH471Kj5VQAOD8qYikrzrPiXO9etlZihhWpWd8/vIOSPVbFwCJXr
        Jj0EYrqdhDxUG/taRIFE2ulCeKWP1vQrNo9vJUyhaYR7TjDVZEvldoe5UCxnRB6Y1LGNPM
        afobO4FL5NJGF5oygisNFhUxTHCBPV4=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        maitysanchayan@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 8/8] ARM: dts: imx6qdl-apalis/-colibri: remove unused pinctrl groups
Date:   Mon,  9 Jul 2018 17:48:48 +0200
Message-Id: <20180709154848.5401-8-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
References: <20180709154848.5401-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

100/200MHz states for USDHC3 are not required since the SoC
does not support modes faster than DDR52 for the on board eMMC.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 34 --------------------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 34 --------------------------
 2 files changed, 68 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 8c04f42fdb71..05f07ea3e8c8 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -947,38 +947,4 @@
 			MX6QDL_PAD_SD3_RST__SD3_RESET  0x17059
 		>;
 	};
-
-	pinctrl_usdhc3_100mhz: usdhc3100mhzgrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170b9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100b9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170b9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170b9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170b9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170b9
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170b9
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170b9
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170b9
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170b9
-			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET  0x170b9
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3200mhzgrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170f9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100f9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170f9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170f9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170f9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170f9
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170f9
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170f9
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170f9
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170f9
-			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET  0x170f9
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 6821ea511051..87e15e7cb32b 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -692,40 +692,6 @@
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3100mhzgrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170b9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100b9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x170b9
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x170b9
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x170b9
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x170b9
-			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET	0x170b9
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3200mhzgrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170f9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100f9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x170f9
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x170f9
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x170f9
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x170f9
-			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET	0x170f9
-		>;
-	};
-
 	pinctrl_weim_cs0: weimcs0grp {
 		fsl,pins = <
 			/* nEXT_CS0 */
-- 
2.18.0

