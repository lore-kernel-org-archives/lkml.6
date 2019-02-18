Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E2C10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1928F218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="avOMrMbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfBRJsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54152 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfBRJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so16683341wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=avOMrMbuCc3zQ5yDGbQl755sCnzSjr5XiNqHgwx6XCW0pzYOzowMFYmayABTwkORDq
         5c9TYUFiU/TddqQzc0CT7yrOKB/vsOckRfqjdOGexyjPucMMOFrqpiia3i7yu0ireEkI
         hs751FnCfK9qcjW1ZXGLCCWTjN0Md5ti2jCBD81L7nzsz7cK/oA/smZijQhB9P4od7nf
         E+XUOPuv2GyllGKixDC3y/yMLyyjY+ULSsZBESZfvDIVV1ux5zY3805YMZuNDvxDNCIy
         WVvICf4k2qw7rvUrov1eeZw3zQEEZTDVKxad9pL9qBzMlb3LOlZ81gp5ZVogkgU42wBi
         JPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=j2KOzYbOmBTNDieWueyBsuys9CUgcJI+nsktQ3Fmr6830DKA/Ico/KJl/m7H8OYcQm
         SAvO3mpyG9UOPwbyszTb81f3Ak6hbu1DjQUlCNiVNaauZYvPZjrA1hXWBXHK0Q/jZ/Py
         Ra/k5lrROe+xaS4iOQb8Rnhk/Neg4fbjLeIfATxvhonlgSOUEZgN9sgFEhrp7gvQ4iv3
         th+mK1wz5cYbfozZLSOMiBw7K8htR8lDVeUAaZEWpMopm3p12Q0kNg1Okeccxe3jk5vx
         dyqmJejx9lQ8iY9q2PvVwz9fzO69QnmQ27tiGp6GqA3NHeCCPbHGUkbF2oXVry/tb61h
         DwUA==
X-Gm-Message-State: AHQUAuYttrug0JORVW5061nFD6P3FyBM1XisiOxe+FG4LJvn5r8DEttK
        HuIjt0VF+E5nZEJ7rZ0mC5GqqA==
X-Google-Smtp-Source: AHgI3IYcHiIuh+bvyHmYlW6gWqYQfsUNbq/NiDtO2C+vl2Sy9ORdFCGgzqkrJA0ci3oCqKAO+slm0A==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr15432479wmb.10.1550483292067;
        Mon, 18 Feb 2019 01:48:12 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/6] gpio: mockup: don't create the debugfs link named after the label
Date:   Mon, 18 Feb 2019 10:47:56 +0100
Message-Id: <20190218094759.14545-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218094759.14545-1-brgl@bgdev.pl>
References: <20190218094759.14545-1-brgl@bgdev.pl>
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

