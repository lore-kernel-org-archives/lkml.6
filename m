Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF27C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD487222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ApVZHJ0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395287AbfBNNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40025 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbfBNNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:43:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so6132588wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHEGtWQDJDJbv5unGb3dQCc3YvaLBb+lnM8n1qgpdn4=;
        b=ApVZHJ0is3WajH6JNVEIGlqSMsRegARewDFyajfi6Nj49CdnbiLYXCCj8izWCHe4ag
         NvQIZxvajeaXPoKTXKTx/priLfDn1Ka4e0+KuKM4tnS5XuggibFBsSifokPwx9mTQrma
         uNk1s/WMdtNqM6B0U4JyIkOsezUcMTpHCpswLROYQOZYuw0zd06XQJdOt/ZfxMzqy1eH
         K/k/jgRLV+9PbAFhavIk5x5/nnrTRdLbKqobVjt2CoYZtvtURQMHSuwjGcVvHiB0aEPL
         tYcu/B8dqFdpz0w7b0wIftJ3eDowtTA498XcZFIkYwsyHeOVNcWo1W6+CRpgr+phrqLw
         nktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHEGtWQDJDJbv5unGb3dQCc3YvaLBb+lnM8n1qgpdn4=;
        b=Me5IQVNVeSEAn83ojRPiaAlH0n2W8oLonNfF5Jy7Yy1hY/m4x6QISVCsHHYgayaiV3
         Uf+TgcgfxTHFFknvZ9LQRyYuSt5ZHCeOdX5xEDT/Y3mr3D/otl3qycxQP7k8PUTuK9xp
         4fbPhYAgJh8PYklmjgjRkau2PyjfV4LkRLZbCtJbfZ7s9tZkCWuaV0vvFB3sKXRL1jUu
         Sq3t6fyE2j9bcl+OZBEJ9Af7fUfQ/9hZcWzWxyglowHMbDOoSsc6NTxDPyD2N8tVmVKG
         GboAule+1BD5fZ0hOD2vDF8ySgCCvqL2B2NJ6wpY1t0HoiJ8uW+LkWBQJ7eQeylJMMDf
         LX8A==
X-Gm-Message-State: AHQUAuacyr9SgP7Ii0+A64MTks1ZnQs8i3pZPdqS90JXu+Xi9nF3K9YD
        VLuIwoXfFBxvfOsIc1c4b9vHjQ==
X-Google-Smtp-Source: AHgI3IYTfleacXs1UGUNtBJRJ1stlx64NS8UYAJnGvcxDLXSq0rc9/g01caHzcubUwHubrhFfA7pCA==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr2924926wmd.36.1550151779297;
        Thu, 14 Feb 2019 05:42:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:42:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/7] gpio: mockup: implement get_multiple()
Date:   Thu, 14 Feb 2019 14:42:28 +0100
Message-Id: <20190214134232.3821-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
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
index 9697bf622284..6deed33dbbef 100644
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
+	spin_lock(&chip->lock);
+	for_each_set_bit(bit, mask, gc->ngpio) {
+		val = __gpio_mockup_get(gc, bit);
+		__assign_bit(bit, bits, val);
+	}
+	spin_unlock(&chip->lock);
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

