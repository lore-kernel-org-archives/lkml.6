Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1412C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0820881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Hnrjy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbeLBUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51375 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so3723261wmh.1;
        Sun, 02 Dec 2018 12:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=R5Hnrjy5AZQR/YOegp9OG5MwjGVSqr5ylRLfDC9OEFoghKwvtTwpC65Mx1lTqqvD/c
         L/9bvjQJcCAB17o1b4hoagzj75v2qeCrjzRdpwDR6wc/h8sXAFnUQgGIsOH5i0tcVDFK
         LtjYP3IzF2/FxO5KQ4c8bMq/qqJfoLI2YlRfvjlYkjOjlzYFCL39kw5SHknsCHnpc+6L
         pgyX6/1dYQcPsVOVK/d8toQafmzS2hYPftNilLVuousgGFfQ2j3wHYE5uFluuefe3RE+
         VINLNgJ5qVyui3mq/Gu25YoIzztAAIQLCYAcNZPDoDpgY1AHQmAcqSmn42PWCRdc0OXd
         roJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=gggEqR+F9ysihFD3bHvwz5LI9ol4XsEJTZMn+5rvf7X/lRLVM00vCRbu4x8NKO8id8
         +WcURlWZwRu+kZkyq1LwzvbQXbSHz4KJfZHThdC10PBhNPrC9m7L9dxUg0N/im5R4S+J
         7LsV8iuDlhUGUaQ6GRNkjeB4SB2NcJYSuIH2pg3/Eh5YZTCuE42xOHsRMauSiR+kYpjm
         syaY9zOjWWuo78fpJL78luLRXVmCWhUs6aAGu3yuox6Wxzf/XRscIVuxs23PfvppgVjB
         wVjODS871lffRDQg6MHhRnXkV43zD8T1d+R6OkhmgaL0aEjbdwF97/4d7ogwJJZp/EE3
         s55w==
X-Gm-Message-State: AA+aEWaN5fjRr2luPydRNWceAEhP6Yqm7eHnNUpVhIt+Zrq2C0gUT6uD
        bl1yeE8ManBg0sMt5XbUaGMTvlaGa7I=
X-Google-Smtp-Source: AFSGD/X8J8uBvA+Atj2GldMyKoLN9X1VZyIrPrn5AEDmQeZ8PFIAwb3OctXByDSlmb+MmGKQBXN9Dg==
X-Received: by 2002:a1c:f0e:: with SMTP id 14mr5742096wmp.37.1543782252226;
        Sun, 02 Dec 2018 12:24:12 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:11 -0800 (PST)
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
Subject: [PATCH v6 01/17] ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
Date:   Sun,  2 Dec 2018 23:23:35 +0300
Message-Id: <1a4e6f2b1d6aa5a079e2afb5d1ddf39f830eb8be.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, check ARM_MULTI_V7 before enabling
ARMv7 SoC's. Add help text for ARCH_SUNXI menuconfig.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..185c573 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,9 +9,13 @@ menuconfig ARCH_SUNXI
 	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
@@ -56,3 +60,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4

