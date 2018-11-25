Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDEB20868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDEB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeKZIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:06:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39741 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKZIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:06:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id n21so15466443qtl.6;
        Sun, 25 Nov 2018 13:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=aYfajAnnLcz/9Kt8brXteTgaaCgo35dcBQZALcVEwrc=;
        b=rrHfuT51nDM4hKDKUYUgb1zyN28N48Os7RFP+UYmDyQgkazPxx5Uf81V8b/bv+xzOV
         LXhuTS5bPIrUF/BxGLCjp2II9n1lFOZ+s+wyoXGmOHa8BN0QmSAoBaRZDjYVz+7vol6s
         OLmBlPlcCGsuLM81j/XeMrCOTkXGxCQ2Eu6wESi9wpDjzlclHuNsNnG5HffACoNPUXzy
         PD5cjplxCjshwp8U1iqaIZ+6UrWqiZg+IwnwJPv3a4gYofkBdfS1zYKa7EKt6gyQk3uY
         LA94eOidKgkkvoMFD62SQpznKHTOlXAttQRmBapM8FF35teEMVuu2w8O32/0+z0IuAAv
         Mo3A==
X-Gm-Message-State: AGRZ1gJOjbm7zEQj6tfzJfTlYJvlhcmdpFnuCAR8esS/VhalZArWYsAT
        Vd4PzcjqmpAHL0itL5jykqZaS+f5
X-Google-Smtp-Source: AJdET5doYpN0T2IVPa8NInhj9lQKjMzvaEkjMdnOHBtunIBRiWrHiTVZyVl8Y2R5XELG+Jw38rBE9g==
X-Received: by 2002:ac8:2ca9:: with SMTP id 38mr23732002qtw.338.1543180482405;
        Sun, 25 Nov 2018 13:14:42 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id b20sm33864725qkb.17.2018.11.25.13.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:14:41 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:14:35 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] ARM: dts: rv1108: enable eMMC support
Date:   Sun, 25 Nov 2018 19:14:27 -0200
Message-Id: <20181125211427.4926-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable eMMC support for rv1108.dtsi as it can be used across multiple
boards.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- rework evb device tree (Heiko Stuebner)
- avoid adding the evb use as it is not present on evb but
  minievb (which I don't have to test) and we are using it on a custom
  customer board.

 arch/arm/boot/dts/rv1108.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index ed8f6ca52c5b..4f4275599f7a 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -734,6 +734,27 @@
 			};
 		};
 
+		emmc {
+			emmc_clk: emmc-clk {
+				rockchip,pins = <2 RK_PB6 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+			};
+
+			emmc_cmd: emmc-cmd {
+				rockchip,pins = <2 RK_PB4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
+			};
+
+			emmc_bus8: emmc-bus8 {
+				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA1 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA2 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA3 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA5 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA6 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
+						<2 RK_PA7 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
+			};
+		};
+
 		sdmmc {
 			sdmmc_clk: sdmmc-clk {
 				rockchip,pins = <3 RK_PC4 RK_FUNC_1 &pcfg_pull_none_drv_4ma>;
-- 
2.19.1

