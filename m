Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04252085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I2UR00xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfAaNkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39379 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbfAaNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so2573725wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXeq39eWmFtFqzceOwGnZ9UFM2CvQxzUwG5lxEDQOVo=;
        b=I2UR00xSc5Qy4Gmfvcls86a1esPplq06/kGKZbZ15CTISczcRut/ms/OsfFKJ5wBLi
         BioURh9bB3pFUFwFBDMSo2/YbpnYqatXt/4Shk97uO1lFVHBd3yY+uhNNUaQH18RJjh5
         Wf9UGSBgFclG+YFAgxdG5EMbErVImUosa/ck5n9NtYT4GojlBtx292WaB8z2ulA6kkrC
         b9LDGIqSFIaNemKqMQ0qesBZEFnHVlwdcd5gHG4zF2nGM756rDcHAEzrcHAkgir0VDJU
         ogN+CaFnxjvJHkZMhgFxpGHtD7fyEAsOK/VvKk56J9X1crLpoEvKFyVl7W9b89ThdUSO
         MkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXeq39eWmFtFqzceOwGnZ9UFM2CvQxzUwG5lxEDQOVo=;
        b=CFGlHGHVz8SPsr5uN03cYCc+SfEXPw5oMKljgGGyO937d0lJ9lgSHq5oLURG05D340
         L/U0pacCh59T7t2oYtjAF4ESxPvpcO5txp1h21uPW2sybvKDjkvag89OGQUUofQg8TJO
         8Smv+WbGZM7c7fpCdJ1f5qwNUmWJU4VlGwqE45uFtmsDIRVZ+Wkfy6hVQQhFby7WDeHT
         lNw3YgYrDZSy3dYV61vJNHGE1BoEdx0qnXn2eBL35NJ949Lw2WlUl00Cx8znay1al3r6
         Mxkz4pKXpVdO8kO1ITqn7ae5/Pon7IKLTALX41njklBrCFU9GqTCqbMaUFPP4iVJf+Fe
         jt/A==
X-Gm-Message-State: AJcUukeurfN7b5wwK6eM0g4r+9hhJBHR0nT5yDkRrrtnHlAxtdElhtLU
        BAkoveXwNe5WbGBMC3i+6Hx3vg==
X-Google-Smtp-Source: ALg8bN6geK0rY7RKjGKVNo7k31uHEbHPv9XscohM1HlHWkdrFIaOhltZrp4yMJeUiV0ocffkVTIMGw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr29516105wmi.61.1548942016910;
        Thu, 31 Jan 2019 05:40:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 30/35] ARM: davinci: cp-intc: remove redundant comments
Date:   Thu, 31 Jan 2019 14:39:23 +0100
Message-Id: <20190131133928.17985-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 780b3f57aa59..b5ace86c419f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -55,7 +55,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -64,7 +63,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -187,7 +185,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (WARN_ON(irq_base < 0))
 		return irq_base;
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1

