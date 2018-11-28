Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9047AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51715213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDqLdd/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51715213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeK2JhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK2JhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so27918560wrr.12;
        Wed, 28 Nov 2018 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=HDqLdd/LfOi92fQe/MYXetnFACTuNHI6W54QmiV1l5i8Lvb6EjZFFPo4+ybqTz7yq5
         YpM4bVp8OZlLOZYWlYxRE1Fe7XPglXfYQmFP1IWhcc+5ka4v4qgOEzr/9zGzQpju3uXP
         QSw7jtfEKu6ZMdAxPE1nudDefojJ6w80C1wUD0xquMNzjOx7/IKSB8KpFexT0h2Ie7R9
         Cb2aM/RbcCiW11yS1xJQwq0c0FEHnJenzXPoLsWdqoIKln+ZE5fbgStPFDEXI2l+T2KM
         eCJUdhP7s4iRq9Hx7fxljaltHg7jC2v3kCpUy0O1Zhky5CvBLxHtPoJPFNPHycRUBh4e
         lejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=BZyVKg1IzoQihvuD6h7oAtQhBXTqCj7OfVDRmiDIuo9IbnV2AYs0bIp+qt9e1lwqja
         0TsUbZMf25MJ0R0jh57h+cudpcIgmPxlN4Ek0tfF8tNjel10er0m/q9w8giAx09180HX
         rhVLVhLqE3vQgdb9BaZxrXGWZsXNXcIhpa9U/dnMTH4LEBC+zryrwwtuu4hg+gWnqvfS
         bt9lIBL4WmT8CacZ7HaBK4RyC97y2LX92dSeaiurKm7XQZnQPyfBS7WhxU1ZdTHVP6hU
         haaIUlHf8yOS0DkvDUNpaaDsD1Z864hvZnfgsbOUsUNbcCCUFptWX5crK+DeqbFIzulE
         J8Kg==
X-Gm-Message-State: AA+aEWY+oRHZnvKi/pfSzMiwBHOGWdTUUWLGWdb24JBVZGPtnu3Jjsag
        tU38kRvLtkTFx+ZE5LF8wp/CEGzERDI=
X-Google-Smtp-Source: AFSGD/VaHZQBF8qSIVQB0pcf/SHXoj1jPif7iT75vvSv3z9QBK5WJXp9Ze0cIBq55cewBUmPQlkTTg==
X-Received: by 2002:adf:f449:: with SMTP id f9mr33585678wrp.40.1543444452948;
        Wed, 28 Nov 2018 14:34:12 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:12 -0800 (PST)
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
Subject: [PATCH v5 01/17] ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
Date:   Thu, 29 Nov 2018 01:33:11 +0300
Message-Id: <ec9d798e883d45d5dc0e01617e4bf217bc9a6be7.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

