Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F0CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F31F21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Pp5HBo+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfA2Io6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39637 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfA2IoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so16697438wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpLsHCDGluO1vsNVw+7Cy8rzFc8ImPXS2+/9yCySWm4=;
        b=Pp5HBo+zRn/FU3isdmHpTUH2RZxF4VrG1kIQFAFHV7e3eCTHrhIqw0HV5j+fgORdEb
         AyeOXMEEhhUV5WAOteb6y+p8Db3NR4cwuI2d6nk2DTcBeM9wrJxY3L1DumfbihVPbUir
         K8UYsOdcbW+BFEr5+nBg+p1ebfAsf/tWzkDgOWZb4fMe8AID9Lg85VvOcBf0oSHF9RVK
         LbnHmFnKYOqMG4nC//v3wcvYBkVjCvO+o/RmKxa1kKQ8YyxdXS7mSBdEQuGh1OWgHyOp
         PPsuU/Kw5vf9vNkQQCH7htsqKQsaKSZcVtgKjugMEeXPH6Zw08HIj5uxvMZ67m1SW4JV
         AOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpLsHCDGluO1vsNVw+7Cy8rzFc8ImPXS2+/9yCySWm4=;
        b=PGGhQuK8gwK8jMMPPvFMUApVltIJNasvoSPe2VtSaXrLPDK64XhAx94ERRmBUJR6ea
         hiNJWajE7hAZsVxvVYsgMUrQJJVzpSol3190jBzc7YZQZYBJutUoIL68Pfl3Uie/Uz8+
         HZd8d8OBBNoAS2SpufrT7n3gUBfY/xnocI/hSgR9cWZ2fUIKdbj5pbtIBlzL0Cb5tFO6
         S2qSG5JEwnafatNDKq8ZtYzsr7mqxQ8ZBjnxNtT5ZJQpXqVuOdhhtdTnsaKLq6pF5MXB
         xIpydnLgp5/BweF9taBhmuQ7ZJqgJj3eBsIIqNVRazwU95J3zNlhrXQzrv/rbN2T8rIT
         N3sw==
X-Gm-Message-State: AJcUukcCGohCqoSPxAZICVyNrp+p2QSmzv+mdQmLZnso9DnAGYcqFYlp
        thHldNt+bFn1sPXR/RlaLSBusA==
X-Google-Smtp-Source: ALg8bN6YcqkYwHzvCHmHeMYrBuWpIGlT1j625Q0slRB9xXDK9KqBHcVex1iZ8MJnK+qisOvn0hTZ0A==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr21019132wmf.38.1548751464206;
        Tue, 29 Jan 2019 00:44:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/9] gpio: mockup: implement get_multiple()
Date:   Tue, 29 Jan 2019 09:44:07 +0100
Message-Id: <20190129084411.30495-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129084411.30495-1-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
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
2.19.1

