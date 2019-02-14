Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A3EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038AB222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AyCU4diG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407461AbfBNOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:55:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38032 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439567AbfBNOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so6788736wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
        b=AyCU4diG7pR/uyn1n4EV9kfiX7l0TJT0nnZXHnIR3e2E4RkDTa2Y5dFkRoR/mrw6gk
         GlG478tQxFJO/i3vdfL9o4ZkQuPY6e/R28Hw2J4r1FP7gf8Wb55+lNNf2DFssF7Rjb2y
         U1UH+fFx6PVvbyYrF/cfMISwoxSLZeSjLvWVf0TvzBrEpIXH/Oj0escwhBFCl7NEMAwE
         QQU6Wvm5i7AaLo7XSJbDtA4QB9cnpw+nNHaooDqsDzYm5axLfa/flzXxH6TgvJpsNGX5
         bDK0bvq1mpJPe8Fgxe4PIQ+/uXYrDgVCsMQQX3cE85cwTVyVUlGuoCrJRoJgCdD7bwup
         KTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
        b=T+anJumxiS8u18Pexpd+x9hycAUF9gKKfLRvIu81nsUSEc1BaP0lWXT3ulUFTfngAn
         QyCnTQyegsGT57RdiOBg0psg1Cn8ms5xENp6dDQn3TphzPkVnFF70ghvc2DDPl7VkO0o
         HEHeAzb0tV88GeSw3CcO4PXAw/wmCKkD1HJJPCSS6tBzqdVb/SAtP2S/+im97FiVLpiB
         ZJSbwUao3l5+jE2zeMceuHGWxywOliuHMtLRVFYUddeOn0pFkcd9VAIXvJaBFuoltBoT
         7wKmR5A0agll4f1EKH+xquGAMR6FLFZn0/GFQef1KQYhC+LDGw6dn+FMQWDS65/eTk/l
         DePQ==
X-Gm-Message-State: AHQUAuY9V+wir2gD/NU48UPhaq8mGQEPtQZO2PBAQUAiefVXDXeKdRvN
        Hu7TOfkylXxSQXHBWACgRoKyKg==
X-Google-Smtp-Source: AHgI3IbQaWPH5FDilf9+cAnt6bz2PikvmtDzAd0PbFaQ6eQFexmp0Dsw6LjWLiv1vRl5ATwgN4zrMA==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr3121739wrs.318.1550155984808;
        Thu, 14 Feb 2019 06:53:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:04 -0800 (PST)
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
Subject: [PATCH v4 18/37] ARM: davinci: aintc: unify error handling
Date:   Thu, 14 Feb 2019 15:52:12 +0100
Message-Id: <20190214145231.8750-19-brgl@bgdev.pl>
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

Instead of dumping stack traces, just print a specific error message
in aintc driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 1b2eeddfabd1..2afaf19dc46c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -91,8 +91,10 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
-	if (WARN_ON(!davinci_aintc_base))
+	if (!davinci_aintc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return;
+	}
 
 	/* Clear all interrupt requests */
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
@@ -125,20 +127,28 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (WARN_ON(irq_base < 0))
+	if (irq_base < 0) {
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
 		return;
+	}
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 						config->num_irqs, irq_base, 0,
 						&irq_domain_simple_ops, NULL);
-	if (WARN_ON(!davinci_aintc_irq_domain))
+	if (!davinci_aintc_irq_domain) {
+		pr_err("%s: unable to create interrupt domain\n", __func__);
 		return;
+	}
 
 	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					     "AINTC", handle_edge_irq,
 					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
-	if (WARN_ON(ret))
+	if (ret) {
+		pr_err("%s: unable to allocate generic irq chips for domain\n",
+		       __func__);
 		return;
+	}
 
 	for (irq_off = 0, reg_off = 0;
 	     irq_off < config->num_irqs;
-- 
2.20.1

