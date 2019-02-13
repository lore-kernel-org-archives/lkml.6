Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEEF222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AA4ASCp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394850AbfBMVdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46240 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436819AbfBMVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so4409976qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWWM0xAWumO0p3bY/5x9HLgVZOQ3s148CYkAGBmj6Ho=;
        b=AA4ASCp2mELKr3pko0Uf9JXxx6WuXxEkZtSYvfWe5+vswKI88GBJZLXygbMTr5fjVQ
         EGRU3Wf7YEt2bEOeP1Ec4scUcgv4TRBQtVF/vh6SP04SLUGKLnmpmjvM0JYsgE6vZV4J
         +RS1qwK0+UoBpvRt1EK53hEu4R+TT3N4DUSmTMhzWl+ql/v98Mc1J/Am/Ef7LYYE4AJ0
         91c6Vue80g9PSD6s7zvtX9sqVlrPuIOLqJNFsN6e+WgF0iBOKXQHCGg9Td6Ea3fmWRaT
         50q+aR4sM4R6x0ciV6+61Jq+WUNxLiuX3rrpMhjkE/wvSOvzl4FQZj7enqKkUN9Pevjm
         gzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWWM0xAWumO0p3bY/5x9HLgVZOQ3s148CYkAGBmj6Ho=;
        b=bdiUTxZ6c6Q6pQeKOaI9neVcSCWUM1yzSAkwdjMDdQJ0mXXchBAv2mH5LfBWNmoOgr
         aT3lyZtrDp662TCo/ZpwPCOYocTLc+XZt1WZuk3SDX+buz3A8k/RM/rixSZLF4Z+2WUc
         SOrf0oMdAgZGFJmUtb8yY84jD+2RLXlkjBcnpduZBv3gDff9cFCK+60MxQNxbbcLkpyM
         EmIauZfk9vJyOgaJ4cvpleu5/GwxGrn3AXrEdnzVmnFyooOw8rbg9WH0Hl681uhnTH/x
         H3Nxvpg6DuX8mOYbXC/S8igqU69VybN9BXb0ww0gsRH9A0DUrz1k46Rm0neN5U6NGx66
         tPhA==
X-Gm-Message-State: AHQUAuZkpRFCLSvkveIKo0cUDorWdIcQHMQm7Jx8lQLLzFyQIvx11AQt
        6k3zu/Vjst0ta3IdG70W9IhrTQ==
X-Google-Smtp-Source: AHgI3IY/femxih2p2G073ZpOVUi64ABe1+DQ/mhgjBNHd5Uoxbg7pDbglRMHPTNGP3fYNDBhVMMfDA==
X-Received: by 2002:a0c:86bd:: with SMTP id 58mr237102qvf.162.1550093567665;
        Wed, 13 Feb 2019 13:32:47 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:47 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 16/17] ARM: ensure that processor vtables is not lost after boot
Date:   Wed, 13 Feb 2019 16:32:22 -0500
Message-Id: <20190213213223.916-17-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 3a4d0c2172bcf15b7a3d9d498b2b355f9864286b upstream.

Marek Szyprowski reported problems with CPU hotplug in current kernels.
This was tracked down to the processor vtables being located in an
init section, and therefore discarded after kernel boot, despite being
required after boot to properly initialise the non-boot CPUs.

Arrange for these tables to end up in .rodata when required.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 383fb3ee8024 ("ARM: spectre-v2: per-CPU vtables to work around big.Little systems")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/mm/proc-macros.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..19516fbc2c55 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -274,6 +274,13 @@
 	.endm
 
 .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
+/*
+ * If we are building for big.Little with branch predictor hardening,
+ * we need the processor function tables to remain available after boot.
+ */
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.section ".rodata"
+#endif
 	.type	\name\()_processor_functions, #object
 	.align 2
 ENTRY(\name\()_processor_functions)
@@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.previous
+#endif
 .endm
 
 .macro define_cache_functions name:req
-- 
2.17.1

