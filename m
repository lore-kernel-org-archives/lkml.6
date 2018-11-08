Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17199ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JHo+tAVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D511120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeKIC3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:29:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44099 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeKIC3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:29:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so16878509wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTop1/ZKpMeTxQR7kMHNViu+sfNC80EGmmamdx7DZuY=;
        b=JHo+tAVD4pfManEDrMkNfiShzpIH5mVzw4R69EvVR6l0eMG8pV3VlfdRiNJd31vmo+
         CER3ae4qjtIaRBO1PmPjisZ2E60gQrD8hdu0EBdnJm+k+tDiZeVLhpDMofVg0qFfL6r6
         5Y+URFdiLC7cg5ArKmGZFs2SHoo+L8BAax8xWOCJACH+EnhqvnJdxL4QAPwDfaOqzbjm
         X+XcBPbJDbmZ6SI5byASnWR2OATucBdRN+4WaAnhhEdd1uAWk/+jrI7wJkXF12kSv4pe
         k6oMpM2lwUMRk+tp9uhnIfuWHiFnCG2Ei/RDYB1PVkfvgEwAg/3rAoRre3QZnztTX4AC
         DUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTop1/ZKpMeTxQR7kMHNViu+sfNC80EGmmamdx7DZuY=;
        b=jllTW2hFwxpb7x2UffPEtsi2bjn3Du6Zf3uVYBjof+bubnuOI/ngyvwRVM5Sac7Zfq
         1OGWq2rCOmXrtI82lvmwIBrRADTDOpNrauPyiIDOHBklsdrKz0ihMCt1mrELS0cbIfve
         cjIYqFqSeVsBIvKGU/MhX43bsEo8KIu0MzTjK1r/QiMYtFmU1pMdI3UTdXtgU6ZeX4/h
         Y0R8ogMtYYf/1ZuSL6pkandedHEtMRogCjE+mMG37M4HkZIKLDHyrPOWIkv0S6ixRz+x
         68e63b9dTfcgE5bSFQuQxnGkFDqXw66qBn+KLY81mX31CawdVnRkPnLgxVdzPIFMs7It
         Xu/Q==
X-Gm-Message-State: AGRZ1gJwQb2BXN8y1gfrcU4Q1+y/56jOT4FKQ35UV4HlaEF0uai7piaD
        50iMLRXzCq+PgXUxtI9Sq1SQdSf7g5I=
X-Google-Smtp-Source: AJdET5dGnFkZmPm5esPCxIyjBPPuX5HDB6qhW1s3k5075VfTeijcBxr56tE7NkQXQzel/XpmquXkZQ==
X-Received: by 2002:adf:c189:: with SMTP id x9-v6mr4773949wre.233.1541695992007;
        Thu, 08 Nov 2018 08:53:12 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h5-v6sm7815987wrs.51.2018.11.08.08.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:53:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/3] gpio: mockup: implement get_multiple()
Date:   Thu,  8 Nov 2018 17:52:55 +0100
Message-Id: <20181108165255.9940-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108165255.9940-1-brgl@bgdev.pl>
References: <20181108165255.9940-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already support set_multiple(). Implement get_multiple() as well.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 3cd92912c414..a4c054cf9c5f 100644
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

