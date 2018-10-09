Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28650C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98F20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF98F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJJE4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:56:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46343 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:56:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id q12-v6so1933002qkl.13;
        Tue, 09 Oct 2018 14:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=hblN8q8gUG/U0aFiotnemC58vA2ZfVizjitRY8gaGxA=;
        b=Utr+w645X5I3/pz4U0NweBRKB9KO/yCRMeZuE2T60mh1Txbhq6xnFI+fhZrFy6H/Ji
         HbYdljKQyDkn+LfJ33LT27dRJ+Stv/HNA1ZfoXrcycyNzPFB/zgWl9lc400BsWVyJ4y0
         Lm4HF6HHaCUzhv7wJb54/j9GcqFfiZFnjV6Mlwp/ovxvYYrq8CDJ5khA+UrYyniAeI3C
         PA2TU5XulKXdvTOh6nJVq5J9QagJE3gwudnaZtW2Y+8yggFRUD3XZh1aghowPZl06/1f
         vGhFLqVdt00kb+pkCMio0rIAtlLvSjg8Fsgc8jOo4FWQMyv6ladWYQrrb3bbr61nY2Fd
         2RpQ==
X-Gm-Message-State: ABuFfohlmQLRtk79xDdua6Xp2P6VgAwYd6vQGR3YsUn0gCKhZyDcIFPh
        HTURHra8kEcd9Eq/6xKjKcs=
X-Google-Smtp-Source: ACcGV601ckzTadSdypOw8uV+aq8AgdLFOb2dcw8yizrBCMYqfvHP67/GQzCNTbmtV2qRKSRL9q1u0Q==
X-Received: by 2002:a37:cb8a:: with SMTP id u10-v6mr21968335qkl.324.1539121024074;
        Tue, 09 Oct 2018 14:37:04 -0700 (PDT)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id g39-v6sm3495200qtc.89.2018.10.09.14.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 14:37:03 -0700 (PDT)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 09 Oct 2018 18:36:56 -0300
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: dts: rv1108-evb: enable eMMC support
Date:   Tue,  9 Oct 2018 18:36:56 -0300
Message-Id: <20181009213656.27719-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable eMMC support for rv1108 evaluation board.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108-evb.dts |  8 ++++++++
 arch/arm/boot/dts/rv1108.dtsi    | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 70f0106d1252..f3c6f52c49e6 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -226,6 +226,14 @@
 	status = "okay";
 };
 
+&emmc {
+	cap-mmc-highspeed;
+	supports-emmc;
+	non-removable;
+	num-slots = <1>;
+	status = "okay";
+};
+
 &u2phy {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 76ea24636feb..f14a733d85f6 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -772,6 +772,35 @@
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
+			emmc_pwren: emmc-pwren {
+				rockchip,pins = <2 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
+			};
+
+			emmc_bus1: emmc-bus1 {
+				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
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
2.19.0

