Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE707C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A4A214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frh5Ln65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A4A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbeKVFHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52483 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeKVFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so6504703wmb.2;
        Wed, 21 Nov 2018 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mnsltmYAdfzx//1tNZey2yDKhj5NRJvXDg0n2PKqos=;
        b=frh5Ln65+nXFgBkMzCH1gttsHvU62SCD7t977TGysujbPP3/hc+K+hvrSKxjHw/3a0
         3b56gaVxh5LB1TUqE0RzUuJt8tt8D2VoSVfiOq0EG8GaWJCnR71NKpV7GTgX+y+MugCS
         nuFEnGPFsMVkxj6m9c1BA9MMo/iK/gjA5XIhky0BzYTnmlf9rueZGe6DK2V/dqdcmsNs
         gzx0J84n7Ez0J2BfOqfyQn6odIbXb6GAcszBjtCBHP1QF7QrZDg7TSZC3+1sTOQ6aoMK
         UsdiL8GFjvEFpqsmE96ST83wLmNd8f216gdUDu370uMz9C2hKI4bpl7DhI/nbDWLvNiq
         iUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mnsltmYAdfzx//1tNZey2yDKhj5NRJvXDg0n2PKqos=;
        b=QSemKETj73RLX5KbN8bZeM/IQnu1nwPO183vHvE/zLH5i/r9Rpe4EZ7LiPdV1JRclA
         z5WCbxQ0faVfrIl2MzxxorpZDAltgz3lUwdYhbzQFb+t+BxqTTn8FOtyRxlQnUasi65b
         eo4w26UMTL4gG+VkNR4t4iNVpYPWg48LG3cLWsUdGiV+FPd3lomCfcktyZjq8fZgoPKi
         Do5qcWm6iHkoR+nrViL6HWeqWMNi4dyJ/wDvyyC9UwpW12lVzQJPkKjUrE0PD9iIDe4v
         5kxNl6ZXE9yp5DmtKzL9u7NNi8P0sGhaMH64GLZ+lkqH9R+vxv6MZAl+S3rRT9NqCESW
         v3Mw==
X-Gm-Message-State: AA+aEWaKLnJ+0AGuqZEpOULdpj9vcTgWTbOUMqPHoT+7SRi/TgG/uDLT
        6gDTbGqUPPYv3FvqTRrT4cUMN9aYYxM=
X-Google-Smtp-Source: AFSGD/Wnob+ckMQNDOypexd/EFvkZyhhSZPTpVox1sAsbQG3UugK2cx7QQYnnI8IInq0cv2gKP7rlg==
X-Received: by 2002:a1c:9f0e:: with SMTP id i14mr3747061wme.10.1542825106444;
        Wed, 21 Nov 2018 10:31:46 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:45 -0800 (PST)
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
Subject: [RFC PATCH v3 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
Date:   Wed, 21 Nov 2018 21:30:36 +0300
Message-Id: <731846a31ad2c602ca4fcf1c417deace60c625b8.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 16 +++++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 7e5f173..23dffbd 100644
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
@@ -64,4 +64,18 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config ARCH_SUNXI_V5
+	bool
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	select ARCH_SUNXI_V5
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

