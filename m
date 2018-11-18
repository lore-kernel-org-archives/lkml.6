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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECF3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6928E20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mapB0eIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6928E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeKSAiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKSAiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so940398wrw.1;
        Sun, 18 Nov 2018 06:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVxn2S5b8Rm3xMwzLp61fPQf3In884gsXDLPlcLdD0U=;
        b=mapB0eIshpyPJBIcKqfWpIppTUTzzrt2o93NGkabJwAHi0DAL9tFKrCXmO3d2t8qL1
         9VhqidfEZgFtXIkZvgMA851WBbrfkJfYF2I+wLc/hIK3kieyuIhVeB/emJYXzPNI5IvV
         R3UwKhZsGeewp5Pk4dnfL8oIIdO7GTsnOVtqZd8MxxR2ceSG9bUiIGeQxNnAyRxiiume
         8Hstbq3cbY8FAFQ36qQ2/d5vhA8YqEfRmKfMR6kGsWE5WonewutTskKU5Kwj+BxFvcTz
         FZzFLA5MTb4EsShYX/43RrjcXt9xeJH62sS+tFFXSFCMpgv/QzZqhdnW4b/+itopPQqd
         sFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVxn2S5b8Rm3xMwzLp61fPQf3In884gsXDLPlcLdD0U=;
        b=UvsbePLMr/gYPlpjF5r8Bh0aagkRAj7y+vYhQy2kWPsZOsNggOVWTLB3yg29yQvuJO
         VnHE7VqZyb7tyzneKYUi2CgULKZAuAfUAT8y4/cSA3+23LgT0B4Z2CpJ+kdb71JD+vnr
         SULHu6hStRnuoLgSCs33sk2+nYVzBnulqAvQImmklY4j4gCjfJySEzirmzDt/WVnGj2A
         UVn7tc0Cbjghm0mZ99gw4N/Zp/v0q0SU1oIfqqIHlH2HGqlK88Jutb9IaboFa4J7aiHh
         I9cy5/OB0jGnW14WV0k85x+u/sW6A5QUd2g2BH+n2Su2eZi00cQ5gclXwN2ldVYuIJ8R
         XoUQ==
X-Gm-Message-State: AA+aEWZbC/WB1ID4lq/+k5zl4yNDu/j43lh6znBVpf11L1WXwPvGu9T6
        c0DPEUfLaUGVbB6zZbGDpFHgNCfOASw=
X-Google-Smtp-Source: AFSGD/VzulMOIapMrmC/bojXP97r3C6K5G9K8O7unpTysplAaZeob+20VbWbx8o5kxh++/8PC4pwXw==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr2525088wrx.303.1542550702542;
        Sun, 18 Nov 2018 06:18:22 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:22 -0800 (PST)
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
Subject: [RFC PATCH v2 03/14] ARM: sunxi: add Allwinner ARMv5 SoCs
Date:   Sun, 18 Nov 2018 17:17:02 +0300
Message-Id: <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig    | 14 +++++++++++++-
 arch/arm/mach-sunxi/Makefile   |  1 +
 arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 5db17ec..066644c 100644
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
@@ -64,4 +64,16 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config ARCH_SUNXI_V5
+	bool
+	select SUN4I_TIMER
+
+config MACH_SUNIV
+	bool "Allwinner new F-series (suniv) SoCs support"
+	select ARCH_SUNXI_V5
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index c9a83ab..fd17fdd 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,5 +1,6 @@
 CFLAGS_mc_smp.o	+= -march=armv7-a
 
 obj-$(CONFIG_ARCH_SUNXI_V7) += sunxi.o
+obj-$(CONFIG_ARCH_SUNXI_V5) += sunxi_v5.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o headsmp.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/sunxi_v5.c b/arch/arm/mach-sunxi/sunxi_v5.c
new file mode 100644
index 0000000..15f2d7a
--- /dev/null
+++ b/arch/arm/mach-sunxi/sunxi_v5.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree support for Allwinner F series SoCs
+ *
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright (C) 2018 Mesih Kilinc <mesihkilinc@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNXI_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
-- 
2.7.4

