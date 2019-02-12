Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980421773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WiMGI5N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfBLNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39983 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfBLNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so2969009wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=WiMGI5N5BHRyGyDI3JyZpi8tZbMC+IIoTFwOymQ2pD4PIx6nJqFH91qqi159XnxJl/
         kfonsLFklu6igy56vst/VWOqR+UVGdVfGGbVSiljGcUfsllpbNVg7VXNOaFaSChT9xry
         8VH3GowKYSFGFs+epU/yTY2DZmnG3NsWmn/84T+5ZJ3VOLrXh6LYzSFTVcmQSkwRRNmi
         exOuva1T4YR87KRLyShRShMouToiPeUueT2nXPMK5pMVxyYViF25PAeyLCPqu10rcoGp
         oDuwxqaIAehOIGtSrXEKLnH29w8mVPBK+EhpG8147AIvg/suI/tXn44fmTOX+bRhMzuy
         ycsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WGhX7lh3GClMJMpleuT6xjtmXeQaabY429BNB+za3s=;
        b=gPeCi8iErXv8EQg9QMQHIzzG3Jz8jf0hbYiB19iTuX1eAkaJNjhEsF0l/NSn6100Kz
         ovpLgNWaXfXlX8mew/2xNOsENxpyarnYP43YELXGWPQAkIzZ/0gCR3SjB6McXyUKmYV4
         bl03KZ7Rh9bLVSCm9c47SIaA1AIr6zzSa9QB//XISetXLbR/O2vaScBjROEVvNiuBKfV
         rLwiPDGTM0Zxhskx2Tbt7RC2q1GYXs1hTT45teGqB2MYge5SFxg1lmEAGQ07DJQgMAzo
         CiesWEEJoghm4o0w1tq5ttYEHO1mlCsdGN1gtDlwRD7vVK+zH/L08H578nIy3cc99EGH
         GkFw==
X-Gm-Message-State: AHQUAub20NIToOSEwcjB6uImrdyfaayBEper5BRwOSY8+iJnnJ6mDk22
        ZzHQVZu80iAeXBatmqORnYTJHWxAFyM=
X-Google-Smtp-Source: AHgI3Ibiu8kjqyTICtxueDiYC08RxBuJjmr7BIK00Vyz/r0mBobuiVeSfOAGuTef8Fu2r0+95ALwdg==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr2845111wmc.113.1549977388373;
        Tue, 12 Feb 2019 05:16:28 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/7] gpio: mockup: implement get_multiple()
Date:   Tue, 12 Feb 2019 14:15:56 +0100
Message-Id: <20190212131600.18960-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212131600.18960-1-brgl@bgdev.pl>
References: <20190212131600.18960-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We already support set_multiple(). Implement get_multiple() as well.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index b4c1de6acf74..1c945c967f60 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -102,6 +102,22 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	return val;
 }
 
+static int gpio_mockup_get_multiple(struct gpio_chip *gc,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	unsigned int bit, val;
+
+	mutex_lock(&chip->lock);
+	for_each_set_bit(bit, mask, gc->ngpio) {
+		val = __gpio_mockup_get(gc, bit);
+		__assign_bit(bit, bits, val);
+	}
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
 static void __gpio_mockup_set(struct gpio_chip *gc,
 			      unsigned int offset, int value)
 {
@@ -327,6 +343,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->get = gpio_mockup_get;
 	gc->set = gpio_mockup_set;
+	gc->get_multiple = gpio_mockup_get_multiple;
 	gc->set_multiple = gpio_mockup_set_multiple;
 	gc->direction_output = gpio_mockup_dirout;
 	gc->direction_input = gpio_mockup_dirin;
-- 
2.20.1

