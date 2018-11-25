Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB513C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C3C20664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbWMZ46J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C3C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeKYSeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeKYSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so15217598wmf.5;
        Sat, 24 Nov 2018 23:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=sbWMZ46JrvjrVsAyayza3dRa2nNfvJp1vn3wprNIjpnDN8wTWwKuLUicOn7QMoKOPw
         204UsEODAXtIjDbrisH6TmH/F1RwqSqN8Wabi7xRZZ7HLMoYB+VBjoI8Nfy/E4aUCinZ
         0cBPpKmwGJ/hITTq9Hl3zVo0AigB95jKlHID/nH0fiTj/p3q0Q4FWKjaaFeoDWP3d8b2
         y/6mP5EMt++izDSKS/BSZLYbgAD9p5opMlHWRvjdo4P/2BlyrC8ldFM84qg11aRfR4Wg
         hb5edgPWufNCe9NFZhsxLnvqUEboL7zzW7QryL9Rttx5rouvQBNrV67ncLmUpQIJK9sA
         6Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=kMLTKPqxLnFMZ5gC+Fv1kOpYpJEls4D2S0Ty0ot8u/u/IivkHS19uAsX5akGaPSoN3
         Ir5mY+qLPI0HFYUdpbOSgWoU8KuqUSQeAG96yQM9nKtvOQeP9tFDY6juaNKdNT0FyTNz
         kIDLdG4tfIdPHn4Yfl1q+/nJwduKrCWJAtVfUt8m/H5nPfJVi6k5TBhJZQJsQ7nHFc7Q
         viku93mLKpy3X69zI9ZFJ21msfTDvwRrtjGeN7mNG14eDJwx5rPL55p8FXdgBZnwklsd
         nk4R2YpZBETZX1mZc2xRLlaxfbKJr0+B2BO3Z8C4/mNbC66lv1ya6TC1e/w8Bp2QQLxN
         EDIg==
X-Gm-Message-State: AGRZ1gISUGwYG+T4ea4QtDrBG5Vikn9Uf/u2LY36cDbsrnjlkGVfCKCk
        +nZX74+eeRwMn6H8zY6BpfgAnru86Co=
X-Google-Smtp-Source: AJdET5dnQfJnz8oTf/mGLFMk5rAWt5n7KJnt2OWMnB78ZYV8z7GLVfLSXteedd6YqfCMbrYtjpEgeA==
X-Received: by 2002:a1c:1c86:: with SMTP id c128mr18760157wmc.107.1543131830569;
        Sat, 24 Nov 2018 23:43:50 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:50 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v4 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
Date:   Sun, 25 Nov 2018 10:43:06 +0300
Message-Id: <39fa35deb1bf35803e314f2b7143637e97fc4d63.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig | 13 ++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 185c573..7fa6a3d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -61,4 +61,15 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	default ARCH_SUNXI
+	help
+	  Support for Allwinner suniv ARMv5 SoCs.
+	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e9..155cd9e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -101,3 +101,13 @@ static const char * const sun9i_board_dt_compat[] = {
 DT_MACHINE_START(SUN9I_DT, "Allwinner sun9i Family")
 	.dt_compat	= sun9i_board_dt_compat,
 MACHINE_END
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNIV_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
+
-- 
2.7.4

