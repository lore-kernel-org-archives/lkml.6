Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E02C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5iLZPd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961E32075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJaAQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:16:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJaAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:16:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so6006431pfe.6;
        Tue, 30 Oct 2018 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9mWsTcPqMY0qr/vSPSqluFvmjGHdFxVw9fd9KQt4RmY=;
        b=N5iLZPd5Fr43f/a6dZb3Jy9HMZ9bMo6KZ1JAmhnoZSWtfA1G9W8580Ra/ccEXAvuCs
         P0jRCEWtli1tkYmGf0ERFSJBoQFHVszl41Dm6tlOfnSRqN6ABRzIeYLpz0ifW8rRz8gV
         VoA2gVourvPfCT8tBteICks5AMjYQ88PCXalbHL1rv6+W4V67SCrAXi5m0iZw/7jsRzC
         8p8aoJJRjc98+esImPkSXoCscGrK8STnxZMQKfzt8T6zJGZE4+0zhXgr0tS5gYKnSldH
         Xs0OnoD8L+JTxe/zQx4HDPxJMNAdP6B++VrIWZtMy7jYlbIq6GNxToCE0PjFfq69a8N5
         tUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mWsTcPqMY0qr/vSPSqluFvmjGHdFxVw9fd9KQt4RmY=;
        b=YrPsXtpw8NwPOEP5TfFRqztpJFoAKgpGDUANwWNDjrdrHSwOvGadA6WxsFBM5OrI4+
         LbrjFIKaAQD2wrBHi3KvjtSrYkmYQpCyrKMOMD+ltTR+K0vcWBJaKVlN6GpKFYsXfqlg
         YbIOB+KqOhFTjY6V9PZzkuwlO5aRPSjz3DPzcqEzt46plB2WX2c0uLgA3os3AmK8H2vb
         0muI6w3Q87F1EQ0hhlgBzUI+ewLM5jMsqczMDllYY/Ap1Sz0QFeCDUeKm8HfZ/9Jkl6q
         dsYQdEZRvK1kl/o8Irb5H83MWPVTf3z2gB8u4fbBczdkYQPRkOTd7u6kDpTctcjqKjCs
         BzbQ==
X-Gm-Message-State: AGRZ1gLXk4qlfiS4E6rf4BIRrHqoOyJKul5l7Vo2sz55pliVsLS2USHJ
        iw9p1uDLPOk7iY1nxjx9Xtk=
X-Google-Smtp-Source: AJdET5f3SXEBLp5Trr1/vNfM1QcGirfKIzJzBWy+7fsYwNCAoijwSHv21ybmb3tP5W+7wtSmPM5AUw==
X-Received: by 2002:a62:9c4a:: with SMTP id f71-v6mr3470438pfe.135.1540912967656;
        Tue, 30 Oct 2018 08:22:47 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id v18-v6sm1409922pgh.84.2018.10.30.08.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:22:47 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] gpiolib: Fix possible use after free on label
Date:   Tue, 30 Oct 2018 23:22:29 +0800
Message-Id: <20181030152229.90375-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_request_commit() copies the pointer to the label
passed as an argument only to be used later. But there's a
chance the caller could immediately free the passed string
(e.g., local variable). This could trigger a use after free
when we use gpio label(e.g., gpiochip_unlock_as_irq(),
gpiochip_is_requested()).

To be on the safe side: duplicate the string with
kstrdup_const() so that if an unaware user passes an address
to a stack-allocated buffer, we won't get the arbitrary label.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/gpio/gpiolib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 25187403e3ac..e600c5f5d9a7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2270,6 +2270,12 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	unsigned long		flags;
 	unsigned		offset;
 
+	if (label) {
+		label = kstrdup_const(label, GFP_KERNEL);
+		if (!label)
+			return -ENOMEM;
+	}
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	/* NOTE:  gpio_request() can be called in early boot,
@@ -2280,6 +2286,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
+		kfree_const(label);
 		status = -EBUSY;
 		goto done;
 	}
@@ -2296,6 +2303,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 		if (status < 0) {
 			desc_set_label(desc, NULL);
+			kfree_const(label);
 			clear_bit(FLAG_REQUESTED, &desc->flags);
 			goto done;
 		}
@@ -2391,6 +2399,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			chip->free(chip, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
+		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
-- 
2.17.1

