Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063BC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BC3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XvFefnzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBKM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52531 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfBKM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so17486701wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
        b=XvFefnzcpYD5ALIRM2KGQQj34oyU/+3fZ3ZGR2mqxf7Uqhi092067rNqVHIuthUeuL
         jOhU+zbBtwvKMi8Li1WBP/nXj/NXGQDWqE5tIe1v+Ar1RnGt21ywt7q6Pcxb/G70EWrJ
         +1CpNRjIsSF8OJg/bvQGnxLNruUhnII5i/PJsoMXlKuEBVLegCr978ffcXWzvd/Y3RuC
         ffdnF+HUKNADFBnlwN6DYoXoY8jePRWiSWOdd5xfHVubOYf9PCKEnOcVrJzg4Q654zku
         Z6bXnYH5rLekdGtsh+nAexx9xr+uZv9rk/sMynirzr9BQInaiopTaDJscIi8RKut2nQA
         rKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
        b=g05FPriofISH5xp75t68rYiPwJ4Ko1L5dj7HaUa6KmfyTG0Z+YRUHhrmDaiYPAznWX
         4M+tAOE19HWmz4nJHf8TmA+uUceIdwujHPOqf1MBSCvsQeCAEVlAIVp680oeL1COSrJD
         Kj+66Ddr4p4AXWNd1MyAjs04PPXOTcRfZ7OOHUUCjyIFgKRrMtZHPhS+gfrB1ZXQfgXB
         oVeUxQwjun20f3R1mtGQaIhibkfo/wKGlq4qtPXdnk2xYWY1Uyb7OTSBXpihdvcfzLdY
         YNUd9jdw0mSHs2JQ1tSdaC7pVHYafpheKCyeP3H9ChE/P/rLZVlclaZ7BA9bmnl7MHR8
         881A==
X-Gm-Message-State: AHQUAuYPOlqOiCTdZ3XNytKwiN/MnhKmWhJq14KPi2o/6DW4Wd5hRLTU
        +Wq/Al+AXeph05ZnoJA+fWLnCw==
X-Google-Smtp-Source: AHgI3Iarb1FLcGmry7RiSvTBrPz9ALtXwOgxsIwgzDlDv7AO4KuEI6zOMYR15AfaHbJg7pe29O0CLA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr10088623wmh.144.1549888011093;
        Mon, 11 Feb 2019 04:26:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 31/33] ARM: davinci: cp-intc: remove redundant comments
Date:   Mon, 11 Feb 2019 13:26:04 +0100
Message-Id: <20190211122606.8662-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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
index 2040c974689a..e32fa3b1889d 100644
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
@@ -201,7 +199,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (WARN_ON(irq_base < 0))
 		return irq_base;
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1

