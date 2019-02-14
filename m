Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE03C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A53920675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0658j7AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbfBNOyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:54:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41389 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403859AbfBNOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so6771053wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
        b=0658j7ACh1agWR//z8BaobHFmL7RX/R2bpEHD2W4/W00SBxksiZqRb2RgYchwsQFUA
         2h8vnzEkbY21CvZIqmLIfpim5mSmwiAiVqIcbl4aXTxO/JgiNBSln91Sn+cM6oF9NR8L
         d1brm9EWaiRdgopV6BA2tgxKRvZhcdS79YIYn2gPOUbzOHrxe2W4olXUEOSSAijRssnD
         9aPZnuA+xj+8X7IU5MWNtxMqTSFjF0WTn6pquyIwqLWwoBAbPTkA7vM6jqN6GOs3EqQ3
         wSpvfc/QAlkxI4JLEzHGxZzk9Sn8S/YKjDjPNQy0hPY4BoBK5F7ebGtskEibZJ6+MODr
         XNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
        b=JxhWt5WtATawxXCVKH0N7u77X9HrSlGJsvxSV2PjNycG6sEu0+Z6AMXYMAtXLjUWxQ
         KfQ0UZKVQZ0+7hRBor0W07ydHTEpGzHyY0VtdunJK+Tgg1jGZKKMaXdusGLQWEza2NUG
         slqUvch8t0GL4nFsvU90k1Leo9O3d2XNiCxnVzb7ta8lSWdWjT32R3KYrRUCeS4PsrSJ
         PQzKOQji8Vfw4OBDMo67+Oz/WX8JrHTp42+V0+lVF+C1mrO8IbTk7tP3JfLVbiqv6RBf
         f1AwSF+bKmMXLEjiF8hyVP0/mkYDrFTESBpj/91tN1ycMqmzl9irgV9rp44PlssIByk5
         SurA==
X-Gm-Message-State: AHQUAuZT9ZHA2hXttL11nVuSXNmgkI/hMfPw6IVlsb/QAjO8QC7oxYRo
        8q3PWWbAq2uNA5OQ+k1/5fXS2Q==
X-Google-Smtp-Source: AHgI3IaGxONeSlkBAe1qKfY/jtNqvQRmQcAkuYpWf9t1xu0vttrkNAtLX7HNJCKNs5a5TK+Wp7yliw==
X-Received: by 2002:a05:6000:1110:: with SMTP id z16mr3267768wrw.28.1550155999778;
        Thu, 14 Feb 2019 06:53:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:19 -0800 (PST)
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
Subject: [PATCH v4 31/37] ARM: davinci: cp-intc: improve coding style
Date:   Thu, 14 Feb 2019 15:52:25 +0100
Message-Id: <20190214145231.8750-32-brgl@bgdev.pl>
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

Drop tabs from variable initialization. Arrange variables in reverse
christmas-tree order. Add a newline before a return.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 6ab56af3be6b..25221dfe8a20 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -77,12 +77,12 @@ static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 static int davinci_cp_intc_set_irq_type(struct irq_data *d,
 					unsigned int flow_type)
 {
-	unsigned reg		= BIT_WORD(d->hwirq);
-	unsigned mask		= BIT_MASK(d->hwirq);
-	unsigned polarity	= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_POLARITY(reg));
-	unsigned type		= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_TYPE(reg));
+	unsigned int reg, mask, polarity, type;
+
+	reg = BIT_WORD(d->hwirq);
+	mask = BIT_MASK(d->hwirq);
+	polarity = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	type = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -150,6 +150,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
2.20.1

