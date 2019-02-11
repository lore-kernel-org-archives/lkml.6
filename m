Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB3C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517AF214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N48L8FUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBKM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46936 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfBKM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so4429768wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
        b=N48L8FUFoPpFOnAS0YTAWg2l0y48HLmUcYMfphxyLIFbMi+J20j/cmxn1D+Jr6TMkx
         C3nE+0fqWFgs9JxgI9hYR0VlnDKaCpcyam7BbB5+TP1PA1x3tSmiv9rbbOWxLFmKQXeb
         xt63EBA044XSKdXUkIFOOnHfpq6Z6cBCddV1LhDTUc5coR3GMuM9dm3aPHHHDGZuL5w0
         dOsihb4Pch/ZKCm4c/KBadPHLUd3ek6Jm4jJe6//XIbYEt5vJs6PPFChh1ad1cnJm6/4
         5omFC1Yty6qkq2YbNmK6wqnGhLim0Al572o+6tXE/7LhpbaK3gs+929Ms+Na53+WoWuW
         hvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
        b=Bib8Bvt44B0aRkQF9oKqz2myWye3CxYaR2phx5fhU92GD7vHSMtONeChCKBO4S6lv5
         hgl8LD6mWhBdpm1Lc9mr2qA6pM0JS0dZkYUSXZRUFp80XBegqMvFJ+VBP0QNJR3S0Sgz
         qOh3t+v7jwK9Xe5++vWFeFB4gGw4W16aojvVIbh6RoZs3mhy50Oi75ZVPmjV1miXOJsZ
         8bUd/VKHLnAD9WSsWNwpkDp+TAPkqJomH7FGEK28VxV60MFLOM+jB1Ysi6gDUJQcRrf2
         fBH4FJxjRJwJSlWwzpamnTZKQ/Zr8/qAJKJawq+8CfqIbkufZLKTUPRsvRRycxe3oeWi
         tNTw==
X-Gm-Message-State: AHQUAuY2Mw5Xvw4ZeypCUQ60YKdJTa07puNbGBFsLfRlIVk24p2L4TDT
        19jzsO2KyPgDl79g1bm540mqVg==
X-Google-Smtp-Source: AHgI3IYPnmpwc1HtFSRqkmujesCeydya0rEXFXaA6U+cZ064qrci+lst4vOY8YYs4YfUeyzNsVyvCA==
X-Received: by 2002:adf:f848:: with SMTP id d8mr29156469wrq.178.1549888006437;
        Mon, 11 Feb 2019 04:26:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 27/33] ARM: davinci: cp-intc: improve coding style
Date:   Mon, 11 Feb 2019 13:26:00 +0100
Message-Id: <20190211122606.8662-28-brgl@bgdev.pl>
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

