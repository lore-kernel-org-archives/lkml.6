Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DEC04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633F320867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3eBm/m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633F320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeKYSeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37332 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeKYSeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so1826647wmd.2;
        Sat, 24 Nov 2018 23:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=Q3eBm/m+LTv6BE8f4JKvFY6HjFqbdHeiUwNJXMLjLzMWw/VGYydvoBAZY8ba5VCJ/X
         izpCImzCFAnaT6QEEzh4valdE0Erfjap8eRDbA8IFCXNM9b/3gQqIS3lKcJ40bx/kt9p
         MoZ44k9UJOgaRLWcBm+JRk7sf8KhYrCsY9j7mgIFJj4huid02FWyyDivjlWJnIENuA5A
         AuMvaSRQesAc1m7cSXXyYuIcXGSj1fR9kXCuRp23QObFD7rbZZ340pFjS+eXSGryKu8j
         WQVQ1FONBfz/Y6kusBN54stmbdsBFbOuH+cY1Khgs9nV7fVO7c3VWgcj0Aq13JDQnZFq
         uCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
        b=o2YJ21HWA31VG3SOUOsUeEW2XbiKUNUDeErrXQllGjISmgb5qCjX5APubKG33LdsKG
         yVVA43uqyHATtlgIWzk7lS9olU7HRJIP92yWeMMwSsKC8j58g+X2DX2+Jnh+G4P9QSUR
         qbJIzPpQMTSCaro9fR0F4vLP5GAkHsbXgSpTsJKdzt/iT0CA/9Mja/XUVwL1qyS4VoqG
         IsgLiRyJFu7/2C/N7AHy/FUfO9oM7UVWVPPeU4xRiw+RWrf/fPINV7+M/sw91dQlpyF/
         UH0+T/1tTd4eMEOfUF5IAiranZFKQcuLTGClbaYIXkXNIe+qdMnMFgqxR4BnASmbgurt
         RyNQ==
X-Gm-Message-State: AA+aEWaRPMhDPdErRoLEyH3KKOKPYrpVfR8BabSLV8yzqHJNWWIp6Mc/
        HFvszFZ06zmblLCcR2cdimp+bsMnHxk=
X-Google-Smtp-Source: AFSGD/V5fpvPtNuj0rgOKe0owqUEC3XiKuApD3Hmhvdebdxno53sS2N7GEzD0I/xMSQN/BOqwa05yw==
X-Received: by 2002:a1c:588a:: with SMTP id m132-v6mr3776347wmb.85.1543131827071;
        Sat, 24 Nov 2018 23:43:47 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:46 -0800 (PST)
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
Subject: [RFC PATCH v4 01/17] ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
Date:   Sun, 25 Nov 2018 10:43:04 +0300
Message-Id: <ff497d650f6a5d5d85b981c28695380172298701.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
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

