Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50770C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2098220818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ut2KDGaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfBLKkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:40:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55572 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfBLKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so2326255wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Az3ypPlBn0rnU2jjDB+ljZF9C7NpKC51dYPhKPb90M=;
        b=ut2KDGaFqx2JElLvv0qXtMjhy7PxTPnUpAp19rewP5PShINHfjufkeLLE4uWSpGrS/
         1i4fUTBWWH6rfUk66wLHWqQy6+7ymTQ9ItdG9mf5MrCrwSFWgI3DWbvWPERmfWP//9Yk
         nL8B0g10IXSO0007xLVYp+FGKJfr5n5TyaTBJeDnUru08JMNNItMJ11NciuexLtQzuK8
         bdnKTw+NOx2h1hyQ5ELBgy0oUGFirYn2+o8p1ZvPLqIwssCk1V3AFKY059MVomtZOUcm
         NlFS7pECMQyta2na5o1QfStWAMUutuwJxQJS/11VdNiJL9X31JeiKXlJQli1vu78aDVh
         Sy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Az3ypPlBn0rnU2jjDB+ljZF9C7NpKC51dYPhKPb90M=;
        b=BRQcoImN6tDVA0fMW9YWSQduzXV9s/HesdJNPhYAG0A2OUtI4+Lhc4zvNV01RgDEH4
         Y6hQF1LMOqzRKc9NO4qvDKXi84qXy2REkuiyNezSHd15P26gtbQt8DyJTRfqWF1TiXNE
         LD+0NfKJ2JJvFT1kzNdY8H2L3GSQOl3ziN4qZUzivF9rmsWNoFfSnGqXmzsNSXP/FSAn
         tedBhbmOIgPApmJvSZzsRstoZVtmYpRbbF5SiDmOkaYTCKHgAVl0b/0QpqlGHavR/MqQ
         AvEyz9EAAvBgtAQS/pi0HIeTbMbMyiFedi/M6s1rLo3PwtX5uVuqba+FycrPmo7ut+yU
         /bTA==
X-Gm-Message-State: AHQUAua1lIugxFuiRcFV5eZqFIGTieAEEIa8pnQ3owKC3tqC/7CyilZY
        tqbXOTfoXAQ/JuquKSsna7JoFA==
X-Google-Smtp-Source: AHgI3Ib38aMEIKjPS3Tv599kkTUJeEgHHJGyXWmZ2QhFfcO1fZjrdlJ17qEnA/o9KcMOIJcUd/Vabw==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr2357484wmc.25.1549967973561;
        Tue, 12 Feb 2019 02:39:33 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 32/37] ARM: davinci: cp-intc: unify error handling
Date:   Tue, 12 Feb 2019 11:38:30 +0100
Message-Id: <20190212103835.7768-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use WARN_ON() on eny error in cp-intc initialization and drop all
custom error messages.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 25221dfe8a20..1bf11fa8be76 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -177,8 +177,10 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-	if (WARN_ON(!davinci_cp_intc_base))
+	if (!davinci_cp_intc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
+	}
 
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
@@ -210,8 +212,9 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
-		pr_warn("Couldn't allocate IRQ numbers\n");
-		irq_base = 0;
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
+		return irq_base;
 	}
 
 	/* create a legacy host */
@@ -220,7 +223,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
-		pr_err("cp_intc: failed to allocate irq host!\n");
+		pr_err("%s: unable to create an interrupt domain\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1

