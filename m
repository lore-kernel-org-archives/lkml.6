Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABA9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BBD2198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n0RcAXmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BBD2198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbeHGJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:21:55 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:46781 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388715AbeHGJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:21:55 -0400
Received: by mail-pl0-f47.google.com with SMTP id t17-v6so6704483ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=us0LJ31vN63I8uuxpJ8q105BUmNSBfomlTrvAd6Bj3Q=;
        b=n0RcAXmDioTQ5nrEUHENi3LF65KDnMVSiQ8tV6xiczpxJAeNtJVVAV1fqWRDzFYS23
         5pAb4kdEXt1jp4D5y6k0otA2qx+M+8FOzA80uOJWZ8R7NPNNEPpdp1tCiXWdfk8XuX2i
         OW+PxR+UF+IhpHb35jL8j4m3Tuv/5zoMpf2HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=us0LJ31vN63I8uuxpJ8q105BUmNSBfomlTrvAd6Bj3Q=;
        b=brwfj8Az1xj+TW1XFatYuIN6F8JVd7YAzyde5ZPiIlVPHhnVewEAD3PGkU+e4OSu9Y
         3k55oovW71exWwflcsOkpzPTAZ3waNey0t8L4ir2QEs6OdT/m+6pMk/sug7sJcE/ESTz
         x+cIZetLWX83ekGKHSAET3iXpOFwhHpbxiO12J+Fs+Gvl5MgtjH6pW86ZHAW2iqS4CA7
         rZetsK0ON0VFKOTFONvXVWpOHFP3aOmV9cSQfjvl8fVwmL6VAT7WRu7jxKBETs0abI6Q
         olD8TSd2WHK4burZRO88x5C8onZi9y7X/dL7QnfVJgJJsc5RFKlZzquTNrpPLL8k6pU/
         F1Uw==
X-Gm-Message-State: AOUpUlEMPJOg/dWCdvELgV0quc1Dh147/jJLzsuzgVnr0amJNr7p3DCn
        zue+wL045zaU3k3L1vbSYxjxtA==
X-Google-Smtp-Source: AAOMgpdrQAiD31upKT45go5J4Ya/40KD2BnU0niHanlqSEaDE68i5xwI7tR/p1vMqVE57RwWNZCURw==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr16884282pll.204.1533625738456;
        Tue, 07 Aug 2018 00:08:58 -0700 (PDT)
Received: from localhost.localdomain ([183.82.226.112])
        by smtp.gmail.com with ESMTPSA id a15-v6sm1373195pfe.32.2018.08.07.00.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:08:57 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/3] ARM: dts: i.MX6: Use consistent node names for Engicam files
Date:   Tue,  7 Aug 2018 12:38:38 +0530
Message-Id: <20180807070838.24685-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180807070838.24685-1-jagan@amarulasolutions.com>
References: <20180807070838.24685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use consistent pinctrl node names for Engicam dt files,
sufix 'grp' look consistent than actual node name

- pinctrl_gpmi_nand: gpmi-nand {
+ pinctrl_gpmi_nand: gpminandgrp {

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi     | 4 ++--
 arch/arm/boot/dts/imx6ul-geam.dts        | 2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 6feae392830e..ba93026ecee8 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -281,7 +281,7 @@
 };
 
 &iomuxc {
-	pinctrl_audmux: audmux {
+	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index d39966e80415..84d03c65f4c8 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -274,7 +274,7 @@
 };
 
 &iomuxc {
-	pinctrl_audmux: audmux {
+	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
@@ -313,7 +313,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
 			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index bf86a5e33fc5..e22ec5be2b78 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -292,7 +292,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
 			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index fe435484e69d..b1fa3f0a684d 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -239,7 +239,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
 			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
-- 
2.18.0.321.gffc6fa0e3

