Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A47DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04320815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdlozcMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C04320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeKSAir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45493 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKSAir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so7434064wrr.12;
        Sun, 18 Nov 2018 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3cTRTYQX1dq39tst1PgcbJbQuLmJE6rf6FzcT64LsY8=;
        b=AdlozcMztriRqCcXr2wC8A6d8B3pcSLWJquUK38SXn16JOCZu104KACuuzxrkqW+Q2
         yK394JGpcxwkGvX36XAow7Ql6MlIhtKWg/VfY4xXJiQSWfzW+5NmGAfDOpakmG2DdQjv
         pBBGnnxW+oAyvqJF2fOo7sPEX6FY7MfPOZjHXZnpFs4/aP7czu8X939dBXaqXFakOyOp
         Ng5A54dAoHP4bT5Lze0tlVzQkYTO/JoKiH+lcj4hZ6qx9L0Rw7NXN/u2gQ0J+Ly/A9eU
         jqAWEXm+Shgq8d//Uaajw0nRIkHlQBpZgE7e/UoE2cMYIwsLcU8+nDeRcmilKbYN+zFP
         dNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3cTRTYQX1dq39tst1PgcbJbQuLmJE6rf6FzcT64LsY8=;
        b=dGt9zj0IKjdnCfqxYh8RZcyi1sYBxWw/TmrOqCdp5RxczJeOPAEknTwyHJtxpYOkK3
         nw2utB0hQiOE1kNh7OC6wII65gkMmeGy2T9unzhHIlbT7345BM7BoFosr5BvWbzz4v3G
         6S+ii0UTlRCM+pqgN/G46TraKHVofDADm0WaKlpc/7LQsHFrbMc3k7DyJJ/4Rm4MPdfh
         gS30KmE/CtSb5wc4uSTmKe65AdlUYdSn0u4tkIY/VS8JeISL4I6kWIimq0vChYG7mZJ4
         j1LJVAi92iQP0rT8+dzWxaRCWyEKauhTNEyMNesi9o3j3OwEFxHHXqAU1EYAac5zgiFZ
         enbw==
X-Gm-Message-State: AA+aEWYscxS1H54Ovbf8fI7CjkhWKO97wKvSAp1mtamHP6jdUVALJdL9
        9iqz/Q8nAS3/Qzb+g9Hvf3m5RFVOCvE=
X-Google-Smtp-Source: AFSGD/Ul9+8jogXL1LM/tbFPPz/NcOS93aYqOSylUm0a3gUBIekLyN+Yxm+bh0ag0YGPhG1/Le5f6Q==
X-Received: by 2002:adf:d112:: with SMTP id a18mr2317549wri.17.1542550698939;
        Sun, 18 Nov 2018 06:18:18 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:18 -0800 (PST)
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
Subject: [RFC PATCH v2 01/14] ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner SoCs
Date:   Sun, 18 Nov 2018 17:17:00 +0300
Message-Id: <abbb75165c8ef41da6963d72f4155ad6ae79140c.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
a common option which is selected by both V7 and V5 sunxi option.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig  | 25 +++++++++++++++++--------
 arch/arm/mach-sunxi/Makefile |  2 +-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..5db17ec 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PINCTRL
-	select PM_OPP
-	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
+config ARCH_SUNXI_V7
+	bool
+	select PM_OPP
+	select SUN4I_TIMER
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select SUN5I_HSTIMER
 
 config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
 
 config MACH_SUN7I
 	bool "Allwinner A20 (sun7i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select ARM_PSCI
 	select ARCH_SUPPORTS_BIG_ENDIAN
@@ -39,13 +46,13 @@ config MACH_SUN7I
 
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
-	default ARCH_SUNXI
+	select ARCH_SUNXI_V7
 	select ARM_GIC
 
 config ARCH_SUNXI_MC_SMP
@@ -56,3 +63,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 71429aa..c9a83ab 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,5 +1,5 @@
 CFLAGS_mc_smp.o	+= -march=armv7-a
 
-obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
+obj-$(CONFIG_ARCH_SUNXI_V7) += sunxi.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o headsmp.o
 obj-$(CONFIG_SMP) += platsmp.o
-- 
2.7.4

