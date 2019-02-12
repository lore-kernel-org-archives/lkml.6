Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED61C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA90214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="X5hXNxnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfBLNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfBLNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so2869677wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=X5hXNxnDj50c74LOzFgWWBYtEXNZpCFHRbKByF8qVhS6QbBZCACrAFJEkMfrn2aDud
         mmo4BNVuiVVfwgi22bPUk3Yxi6F+xsTOnL/LeoT14ErbiJCznecYIofLU35gcftDuwNo
         /VjFg4hxQVOp8O/TvET67FLucznfVXj82JAKOHS6Tt55aV0XjnnjmJ5kz7vNLNfzdepz
         9J3w1QI1uGj4h0hBr3l3xoWOHufRlv0fvnLkixBCrMUs4dTF6CerShDwa6YSFSD54XZ4
         o9zlSY+mVbhQ4sg88YxlV7yLW3zCx/i1IaCX2lUjqYYgkIAR7sc4rEzfsLqVYMCki0zg
         zsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=pudWDQYUMfZHir528A2/dMVvs+f8RTim2Or/5K2eRzd2Pa27iUFUdu/CihmBH2VfwB
         riAtC7eCO1WCls5/wF/q0XyRhuWuTywNY87iDtvawB5Hcps5zIWZkDajDGQvQb0sPIbf
         clLhxbWYjDYQYyExQmDDrJQbM1jpm0/JTwabWLNzRaph1BK9tbfb1qZmZmTvZ8tlVQYG
         EThkAFHiZ2L4F+7y9ynnIZRvbrJjJ4/1K+Hhr0tlXjhADjtx0l3+SxW4qobdhNoel23H
         cgLKHEFpPi23a40mzWAbl8TJthywXtzsxB3cLjtJZuFGRohJCutE4RQuurLGgXWHz7NX
         hBKw==
X-Gm-Message-State: AHQUAuZD8sjoi6oAkhkR07krbpORjAknXGQeQnumu1asAW6x88MbUgdP
        6X1joRmu8CL/SeotLJjRsi6vrg==
X-Google-Smtp-Source: AHgI3IaVVoe2st0QHha7U3zkiT37/graZaxT3zmucq+CW+VBQox08//RACgvFe4lbPLxwR5sFLsNzQ==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr3041889wmm.31.1549977389481;
        Tue, 12 Feb 2019 05:16:29 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 4/7] gpio: mockup: don't create the debugfs link named after the label
Date:   Tue, 12 Feb 2019 14:15:57 +0100
Message-Id: <20190212131600.18960-5-brgl@bgdev.pl>
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

User-space tests no longer use it and we're breaking the interface
anyway.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1c945c967f60..0317917a3678 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -234,7 +234,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
 	struct gpio_mockup_dbgfs_private *priv;
-	struct dentry *evfile, *link;
+	struct dentry *evfile;
 	struct gpio_chip *gc;
 	const char *devname;
 	char *name;
@@ -247,10 +247,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	if (IS_ERR_OR_NULL(chip->dbg_dir))
 		goto err;
 
-	link = debugfs_create_symlink(gc->label, gpio_mockup_dbg_dir, devname);
-	if (IS_ERR_OR_NULL(link))
-		goto err;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-- 
2.20.1

