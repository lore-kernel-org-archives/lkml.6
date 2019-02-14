Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001CCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43CD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w3nTqgmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501919AbfBNOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43617 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501903AbfBNOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so6767229wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
        b=w3nTqgmdVjXLMVjYsM0ujnlUSdoziCTXEeTKsG1sLi3x3U9fAjBmmJ3fb5ppf/Hf2V
         COf+NPBhV+IchdXWPqXhj4/3/dU5HTX3GcH0bWx1s/c5wGLfxoZx+thegvmB+TWASbiT
         aCwvrKIr4KG6oamd41jYZy1TF8t0g0P+qP0yvmuxaOZPp23j97Nl2DaKCsegTSBBM6+K
         mTwBfsj1EXFaCqk215G36FSmw8KxhIgOwx/1ant2EizrshZvSGnlUR/LRqx020iZq3yq
         ALoG16BPwVpg0nW5zn6lhoVs7+rZ5n4WBxIyH8h1SWTVss9FhZ/SZMvoLPbR7SWESKwT
         9nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
        b=PZmhzI/7VD2/D1T1c7sZyLh1UM9KzrH5fnDNcECBTPUOUwY1GzXjwOwJsvYIOwicru
         WeEZxF5M6gtlK1xn6tfmndbJnh4cAwe7z79hLCH4onJpowV/i/wMC5kN3zo4AG9jcg6c
         1JGfOZfZTm2XttgXmJ6ax6OIsqstCy6jxE9SkH9+L8OG6mj0oDd7VOReY7cb5yJMV+Am
         XCOgxPW+a4UQiyefx5SBQ92yP47hgXJvJBp8bsWHPe2jsPSmWil5T2xFJBk8lSsibecS
         D+4B5+xu3ZonDEPutLhLULXb25HwUkq7uVPP+zkzOAdLD61JyfsOd87M5sjGm9De+MFF
         hAOw==
X-Gm-Message-State: AHQUAuaa9C8x/pZs1SrICdsPmzTzZgyKF775Dmhky0/rTtvrfm8GIpHj
        lgPdJ+5Dr7Bh/yi2Fgyp1Bhh9w==
X-Google-Smtp-Source: AHgI3IZ69LEUTwcyKTMiUGEw39TftmUZE/9/jTDns23doIfGX5NHvKq9oO90uRQVPmHfbx9jrhMt4g==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr3064136wrx.74.1550156004389;
        Thu, 14 Feb 2019 06:53:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 35/37] ARM: davinci: cp-intc: remove redundant comments
Date:   Thu, 14 Feb 2019 15:52:29 +0100
Message-Id: <20190214145231.8750-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index eeb3351016f0..276da2772e7f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -57,7 +57,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -66,7 +65,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -215,7 +213,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 		return irq_base;
 	}
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1

