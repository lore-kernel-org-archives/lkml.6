Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808212085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yXsqvJsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfAaNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34475 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbfAaNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so2149442wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1HTTn1zj1MT4j+ZQRh8biG0PnZ1oRBNNapN+dBPCQc=;
        b=yXsqvJsgY0gXnH7Bhgddj++HS6M1/Mg/ntCKI/aXRWNdAEdnbki//I/WxKRK+J1W7s
         +xyKHgCe4FgJkPTgve5sxnI9ebBjgsRPR6qxic3g97nQ9J3ZhflMuop4CMqqB2kR5ZwE
         byqrOtHObAyNu38zWDaUfuGrSUaJ/ErrWnyFfJSpBj1sWI1/ITjec3IqRvP9uQfiY47V
         lJH9kqFEr5hhFw3gUej2hAL19d7saNoAVft4PEKt5ZqF/iFdCUwB7a0y+v1zOhfEmaVB
         Tn5g2gVzoWH4RkQlA3mXX5Ll8FFGYkXn+/kh6wTLpe3vscW33fHqxjYF6G4dEdNsdCYb
         UjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1HTTn1zj1MT4j+ZQRh8biG0PnZ1oRBNNapN+dBPCQc=;
        b=kZjVy/MS4le82Xpme3V8RrXRFfNsO2fFlzIyz8Li/W6GlqQtWN6KleX9E/UQoiPaw9
         KLWh1zp/F+GY6Ju++q5tH5AvFXkmn1Fd5ITVokeE2+Jc2LpgdxEL607bkzQO9iZ0HRmX
         U+UT0V6dW5nVq93kSSMN2OVugulz3yFp5RqQRqd891EBG+dA78nwf/HH1IqPGUQR3oD5
         e1YvPyekIcDCb1EPC6fVVJ/BofGEhvxog54rsT3LdwjtsrIMkx+3JxmFdBPKDSaq3dlw
         XXiLiVctUJi9ALiX8BR7skd18dVaiJnfcBa84cWuv6ek9Fg5P59NVn8HDeJXB2m24XuU
         Pycw==
X-Gm-Message-State: AJcUukd7K0B/48HdM8f99wy8BGEGw18an/w2oYzEjj1oTfm74EiKophG
        BzEwD1o5QCdDn6lFKObDN20WEzfHFLg=
X-Google-Smtp-Source: ALg8bN4fZmcsLxh6VIkBDvi3YojOuyTp7UWE4fZ6I6gO0T9djSicgcYPZ9ew+621Hws57Xi9IezELA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr29382352wmi.58.1548942012453;
        Thu, 31 Jan 2019 05:40:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 26/35] ARM: davinci: cp-intc: improve coding style
Date:   Thu, 31 Jan 2019 14:39:19 +0100
Message-Id: <20190131133928.17985-27-brgl@bgdev.pl>
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

Drop tabs from variable initialization. Arrange variables in reverse
christmas-tree order. Add a newline before a return.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 2ce0b7653c88..4cd515b507f4 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -76,12 +76,12 @@ static void cp_intc_unmask_irq(struct irq_data *d)
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
@@ -137,6 +137,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
2.20.1

