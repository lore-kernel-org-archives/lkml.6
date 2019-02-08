Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25653C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FD82146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CHEhOsHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfBHRgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53258 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfBHRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so4362452wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
        b=CHEhOsHabB7Q+6g5PY7G1rt2tDzK2yhHLHGcseDpNpkQ6wqvMxrT9x40ZBku6JOaF7
         UmYugNCiguchqLVd6zhJiOQy3y0sfK8L02uNTBy34eLKTIxwWsS4cxg1SeRLd4MhQ7Mo
         K8B8drtKOWqf5Qn3dPeD78FjMdicMl6TwATOuP1Uy8kiLYzHM4I8a/4RL2EJoxUuYVYb
         YbJ2wzY+zhb/JzBxfYlRAZWKRbxH+Dbob5BS25oRhGRvS3QzggBDro8yZEgYsVsydZJ0
         7uHcgvi/SLljW6Yzh7TYCfHUkfjBrZwV80S6sv9C7OFCf1T8DccimuSl2K5eSPYnb51k
         BkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
        b=QfnDs0yan2lLP5m82lLz9csv3C8E3LjdR64cEqg9XliAUFuU3XlC+v2RUs9uhrjI/i
         HDCV/SeX4rVI7sTmQEPGdcbUeYYDRLAjVds7UQHO/1ClvbKHGvZ5RD/KZnAixAhXupQQ
         Z/mWJ2m79x9apXOsn7wUwzCxwKqMq75Df5ziPQc2zaUfswDw/Xgwpc1bWjMNKvgTU+Q5
         SQPQFCfaVzPrWT02NnI4nrYmuRouxBRUmFW5LrVBLoXoVYlRkxA/AQ25atEk2JKrEf3e
         /3lz4LqkKTxIpZKUNTQs8uI9XlLec+Ivcp5pjYVbhNo1uK9xcbXwLpdq1qYLhxF014ry
         LDIw==
X-Gm-Message-State: AHQUAuYYhva+lXr1BLFtew8z8OJPZIf4A4YqTWZ0IOADNRmN9ODcd8EC
        Zx2+G4vbZshkENA66hXv6Zp1Vg==
X-Google-Smtp-Source: AHgI3IZgs+fjNhBDwGb2s1NzdQV46SnE16xwpXpDN/pEJxUE8p0ixxLgaAc0UCKdA2OgF2EBY015EA==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr12459136wml.11.1549647338508;
        Fri, 08 Feb 2019 09:35:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 27/33] ARM: davinci: cp-intc: improve coding style
Date:   Fri,  8 Feb 2019 18:34:52 +0100
Message-Id: <20190208173458.4801-28-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
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
index faf3d74d3719..f3787ae4cdbd 100644
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

