Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA34ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE2208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PDUiOt95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABE2208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeGPJBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36526 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeGPJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so14941153wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puWJdGpBMsO19IRLChl84gsQ52QaGi0Ol+HJelqloys=;
        b=PDUiOt95HXM8yczayVbNPgJiE7eahygG+HIKJor5th+cuPY4LJNEHkNZqgpqGWJSkM
         FOunpH8XMyxTUAdN0iepaXqp/4l+DvTHsILx8XHQBpxBSuffoTvHex0Q9h4z8gTklsXQ
         //1itSOzrIPgR1F3jMc5mI8n1CqOB2MjqZ4EAcNKUdKfi0tpiCfFymg/gmf1CIawL9v0
         ZaOLQV1RPo1GBYUYkYrh1JxwinHh6RlCa0OG9hr1DNM2byOcmFVjbHpvNGokaoMhpcUE
         t/MKoiSOsCJEQ0nLQo86+EeNWg4QANmAgNWM9IOT4gJuy9xXMkAxbPkcz9iFoeMYQaFJ
         nXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=puWJdGpBMsO19IRLChl84gsQ52QaGi0Ol+HJelqloys=;
        b=OhRRE3Qz5h6cG09Ovp4Sx0w2xQHs2UsMI8fOsWkLDPV2IzkDymTsnur4Op5bs99aV3
         uO2odrZ+M6MM/pY9i+A3Ii6E+DQk0yqD2JdByrbsFlxyxUwLcuYkUyFlJy8H/iybgbUi
         GVgWaHLgbBjsjM/Hctb3NQCkrMOJvLzRYRIaYcpQhN5+mTGCTQxK2ssnFwQ4DRNdcB+f
         K1GgPjZKv0FN42qaQn0/NL2dLJ5elfFQlptnAsLJCf0ZOaeVVPv8rHvZR33hHmZriRBA
         v1QFQv4q3cVV+sdEYyCZwGSVMxtlRsgJURu2XiqxU9oAqNJ2M4qgb+62+5d/YjXk65/v
         I4lA==
X-Gm-Message-State: AOUpUlH/7MiveuAaQKGSPQ+cfBJgl/IskS/EHRMQEFgIJZ9x3LwstRbu
        SnITzxH9UuMkq1wgHkwJ+8krFQ==
X-Google-Smtp-Source: AAOMgpcEfrh2t7Xu2Cj3UxcqGCqyNL3H6KDUca5FJs+GoRGKWM72mJYiU6vQ06XWTrztpxNxN2rPig==
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr8708220wmh.116.1531730085296;
        Mon, 16 Jul 2018 01:34:45 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z3-v6sm29483104wru.27.2018.07.16.01.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 01:34:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/2] gpiolib: remove an unnecessary TODO
Date:   Mon, 16 Jul 2018 10:34:24 +0200
Message-Id: <20180716083424.11157-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716083424.11157-1-brgl@bgdev.pl>
References: <20180716083424.11157-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's actually fine to read values of output lines. This was also
allowed by the legacy sysfs interface.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 57973524360d..19d36698574b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -431,7 +431,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 	int i;
 
 	if (cmd == GPIOHANDLE_GET_LINE_VALUES_IOCTL) {
-		/* TODO: check if descriptors are really input */
+		/* NOTE: It's ok to read values of output lines. */
 		int ret = gpiod_get_array_value_complex(false,
 							true,
 							lh->numdescs,
-- 
2.17.1

