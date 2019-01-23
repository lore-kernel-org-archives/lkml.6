Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF1120870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S0Yq48Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfAWOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:16:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43552 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfAWOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so2611352wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFYrT2wnMCaEZTFTRohnQPMYE3Q3Qh5QyDn+YPY7eC4=;
        b=S0Yq48Wwkiz0nDNRMwZQ+sUgdA3QpUt/wkY0HGeC1Jmnh3izX/lLJfTNmFyAj5uQIC
         X7WIF2JJLkSsj1FX3tcNDi+ibIgEVsiU1dVtS/IIqbJUcNQ7unRUPBteFRw0TOMawTeg
         0cR9j/vFK+XCaJvg1ojqzHN1B4F4F0NwzNojZlw1I7aZOeTMZ/FSycsDi9SET/qJSDta
         c5tOGjezgFH7V512uroepc1jxghEJarlpAZ88zlgbfjORb7FIQF2DS9JMU78WITrAgbO
         Wh5H821UD3WA7xsPTraD2xrVhDerhkQA/mrzrG66zMg1LW1SjDaG1okIsCpva6JOD7U2
         jp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFYrT2wnMCaEZTFTRohnQPMYE3Q3Qh5QyDn+YPY7eC4=;
        b=V1AL9YJV2BS0nYaV+SC6uozRUoSHzd+9IdH/MtIpr5v6wBb57bHw5Vd6uEOYRDpMho
         IKe6g79ke/2JIfJ7xsKJGi9aSlfMjpVdl//ovZZ8M4oZBCLxNDSyQ1H3WYDryyu6jA1f
         UePTfppH99tLQCAa1tH91PFNvALTultlKWx2gULRrmD5kHhY+9x8UAfeGEmPW1v3jLpj
         uyTkNcc46Yo8ad0i/6oLiJq62B+a0rWe1+ce9ck2x9/42cNdlvOVClEg4jtBcprBFI81
         r/dxY3zK5xFWw5/IEnAFN22tzIcbQGXmwz6caOs4y/Rn1RsoGcuUE0/r50/YGfIedyuP
         SWPQ==
X-Gm-Message-State: AJcUukcb7RjOEWr10H979TKlYY9BeNsHzH+QBmN9r8lXURa1RjWLDIAv
        HrUF3mOtUIOmTeMW/0mUERdxPg==
X-Google-Smtp-Source: ALg8bN43+Q+f31kwPkEI+sVZw6DA/sV5YjYlydvRFHM+fQ2rCw7LhV9D+yTV2V3OV4PAiQM3UelAQA==
X-Received: by 2002:adf:9542:: with SMTP id 60mr2909985wrs.60.1548252952879;
        Wed, 23 Jan 2019 06:15:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/9] gpio: mockup: don't create the debugfs link named after the label
Date:   Wed, 23 Jan 2019 15:15:35 +0100
Message-Id: <20190123141538.29408-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
References: <20190123141538.29408-1-brgl@bgdev.pl>
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

