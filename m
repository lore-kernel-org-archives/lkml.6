Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F62229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SY/FJts2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501928AbfBNOxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37478 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501890AbfBNOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so6789753wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4SJAgxGTa64FJdlSVfppZLdm94nwsUmmnlWWj2uXAQ=;
        b=SY/FJts2nGo8N9rDrnd0CygEqjRdybYQygidnGL/IYHQtPPXRYGBsv5Fe4ze5JyTmX
         LzPmTBuSk7eilzhaXEJ7ZO/+xeEricwQEblfaWYF8J32tAPyCEZIcpX+aTMCjDm8/3v/
         75cGmvxSWQFfP34bohqvdP56DoiHHRl1ya6G/XbSRVdwhFijoQ7evoaVatBv1yKSUuaY
         FZqlREPOmJkS7XA8OQB/Aq3vEkaRbILzp/sMZZ5Mkn5s44XJEueVVFm3HNqcdjnu8A6p
         5Pa4YVxeGRpOxcX3/6O4S8d1l0Rvb2eb8wNhon4dNjwoOMA55TykqDLdsG192ubGTT0R
         N5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4SJAgxGTa64FJdlSVfppZLdm94nwsUmmnlWWj2uXAQ=;
        b=hKfN2YUT2WT6kIHNqne5C0kve4oxAzWP1IwAFVeE6aMDAFeAB7Wj2WeqDa6zQhC6VB
         AsX4KHCNENB62DyAkoU41byuglh6BsR4BLCpIoBsbyxeopDElZfTwVXL+NPEyhMl83cf
         sqVMTNk1xqLt/4ghGJw/yQsYMK4UBP2XvzoA0mq7QQHePjy+SVkgZ3LMA3NFRiuJsBPM
         zLT9TzO3H4PlYjRLbKu9enF2n25SAlWrmeknSpTdbW/tYx1z7Bsa5OvNq2atgdkTJiUY
         4/0z4mIBS2qHRbHeopH6i4CeG+lpqFSnVpLA8huV+PglgZfM/bqxAwu8Vi9Lx2SRIdGV
         YoKg==
X-Gm-Message-State: AHQUAuZJDrMqRYxuv/WnD4Kud4ydVn31Vlm5OTplR7PG9tGxWayL9wxq
        C0QbsI7uuQn8DJP2XeT3BihjyA==
X-Google-Smtp-Source: AHgI3IaPujT99IIEBVSVoccjAhOWaMFuOqy3d9MQS4qedmwtMkYGinhq/Z41+E2A556hkYLlO/lWpA==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr3298876wrx.203.1550156000905;
        Thu, 14 Feb 2019 06:53:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:20 -0800 (PST)
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
Subject: [PATCH v4 32/37] ARM: davinci: cp-intc: unify error handling
Date:   Thu, 14 Feb 2019 15:52:26 +0100
Message-Id: <20190214145231.8750-33-brgl@bgdev.pl>
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

