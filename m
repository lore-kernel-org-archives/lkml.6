Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34861C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01783214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="luLynmjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfA2Iod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52405 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfA2Io2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so16828729wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFYrT2wnMCaEZTFTRohnQPMYE3Q3Qh5QyDn+YPY7eC4=;
        b=luLynmjSgmxhjno+ghspWTDkEw4fn3ucg4QWzyQSRZgMJUXCVFXp/jx+TPHborJqUW
         YoUZlaJtpHdZnVh2f5oagC06B5RsojUpskYnsjBJE55/z4V1V3tZL1VkA0QN0gccjc2e
         q/vbGtK4H+RMs9y/n9adtV5RFBMGqCE4ynsjUFZHBtucDKCWb9toqXGJuzug0LM5H4gW
         lPRDwiDhQgX2a2OxEKUmdtdp4GL4dTR6GVXTmOvJOib+PY6M3mQdCCIDhz7Jr7icS+Dh
         mo/Ckt7K0Kw2NGV624Dk3z1zTXiI8+tjcV1JklNaJieuy5+ywzeCTWtUr0i0f7+cYSDg
         Ttrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFYrT2wnMCaEZTFTRohnQPMYE3Q3Qh5QyDn+YPY7eC4=;
        b=tjc6Rj8Ka1e9t0VhbSCQdgNOqL4spSQkV2wEsZjhd1bAmlgmJ2F0RBvAfAiIstLFdB
         hmB5nX3+9iSUOtFv4hlDoxRnCeSlxOR0eP/QPOv5VsIn/g2Hj471UWLH1ws3l755cH9M
         I7SlLq7jOJzrtB+3TutwIbrvAI/0hlm+yAyeZslnCUBePzrv9zwANrT8rXy8WzBqlvoe
         wr9uTGYVA8BxNoUcAVNjXanGcMGUU9g4Ps+nGfUcXizO7cJWaJpQICNOBu3Z/sZ67SY2
         y/oNQUaEdHnNXuwjdGQk1fotW6FKPd/DeTyWHiLlzO7SV9rqyNsOs+1p/Np5AyWhjm5o
         nyMw==
X-Gm-Message-State: AJcUukfxgepBuzcphzlEdZ164vnPOPrijPYJEBAomrJe4j77yntOdZ3u
        otocZlBeVjkD4f4UZV+YfLz2kg==
X-Google-Smtp-Source: ALg8bN7A1Sc1cfxBCtiCvPa6pMMq1FAWwAEjKba+JVQvJtpGDEZsLLL1h7wiIbO1I0xjJ35JVp2tCw==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr21301315wmf.32.1548751465616;
        Tue, 29 Jan 2019 00:44:25 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/9] gpio: mockup: don't create the debugfs link named after the label
Date:   Tue, 29 Jan 2019 09:44:08 +0100
Message-Id: <20190129084411.30495-7-brgl@bgdev.pl>
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
2.19.1

