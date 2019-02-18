Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC63EC10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93339217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E7HARg7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfBRJsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbfBRJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so16349410wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNa1+Y3e29LgXf9Sg+UQJ7nxkfwnmvmk8nMAATc6xHA=;
        b=E7HARg7xiDrenHJX9EVYcHx986a4+dE7vlP74ETAyIE8bdZ2lEa+kRu9Y8kfHfACFY
         WvYaKoYH6Pl29gd/T6NT8yyTb8yXlpPPk8TT3J7xcVnRlxRNLgzDScR/Olv1sGOak9KM
         xctSrNI/ywmDZ7E22ImuxGJbCHoch7iJiRxJZxIhNLnrRv5iPK5mUhPjqNm460WarhZU
         2MZ1j57LNiK5C8tH1UBSyzKAqBITSYz9BHWS6WRtg8J0863WDmdbIrCfPSfpN8JUNeWK
         JslsCwJXN6wq09vA6Y64ldX6QRV6KO4cfJWsfYxlGlQMGeP3qUGuo/3M9hvW2DFHDEJI
         pWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNa1+Y3e29LgXf9Sg+UQJ7nxkfwnmvmk8nMAATc6xHA=;
        b=mgL5kxaoQQwJwWaCQclNZQ+RzYf7nVshlLstSvcxI64+9e5MwntSFzKf+lJtUprNhf
         wP/D/KgqjM33WzAQ8rgN29KrmGtZ1GETLmT4j8RdYG6JZrhDYGtNC6DSnDtm1cTRDq42
         wyPz7lKyla1Abvb7qEOKO7+L2KaMu6FkdOYdpPSRXuVDlBlDgwcyoUJQTZjXECPMKbzX
         UbnAV+g7PRtzE0Nsi3ARewB6EM8M/PpejCIag0XNt5Ya5ArCpSBlsq46nmBwGYcnyH+f
         1GW4DoybQnXal4VPdIafG323PjAiJIprfmOrsVcGbZI6VYpeycJWAZeoS6HjDERGeqee
         t5Ow==
X-Gm-Message-State: AHQUAuZWvdOxkwO5epGjqxqaNqsu6/5bqP7unJlbrcnVKuxSD3mPB0PI
        XBACz4s+tsHqUHsmE/eGFrzDTA==
X-Google-Smtp-Source: AHgI3IY/FeRocp7ctvq7eqRCVMpA58GnSJMcF++yGrO7jH2xBH1isgztIY4h8Pb6RuIqAJanXSeGTw==
X-Received: by 2002:a1c:1c4:: with SMTP id 187mr16134318wmb.6.1550483295609;
        Mon, 18 Feb 2019 01:48:15 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/6] gpio: mockup: rework debugfs interface
Date:   Mon, 18 Feb 2019 10:47:59 +0100
Message-Id: <20190218094759.14545-7-brgl@bgdev.pl>
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

Modify the way the debugfs interface works in gpio-mockup. Introduce
the concept of dummy pull config which will keep the mockup lines in
known state. The pull values can be modified by writing to the debugfs
files corresponding to lines. Lines in input mode always report the
current pull value, lines in output mode change the line value but
it will revert back to the one specified by current pull when released.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 116 ++++++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c498b0fbbec8..72f5c07c4219 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -47,6 +47,7 @@ enum {
 struct gpio_mockup_line_status {
 	int dir;
 	int value;
+	int pull;
 };
 
 struct gpio_mockup_chip {
@@ -188,15 +189,56 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_sim_irqnum(&chip->irqsim, offset);
 }
 
-static ssize_t gpio_mockup_event_write(struct file *file,
-				       const char __user *usr_buf,
-				       size_t size, loff_t *ppos)
+static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+
+	__gpio_mockup_set(chip, offset, chip->lines[offset].pull);
+}
+
+static ssize_t gpio_mockup_debugfs_read(struct file *file,
+					char __user *usr_buf,
+					size_t size, loff_t *ppos)
+{
+	struct gpio_mockup_dbgfs_private *priv;
+	struct gpio_mockup_chip *chip;
+	struct seq_file *sfile;
+	struct gpio_chip *gc;
+	char buf[3];
+	int val, rv;
+
+	if (*ppos != 0)
+		return 0;
+
+	sfile = file->private_data;
+	priv = sfile->private;
+	chip = priv->chip;
+	gc = &chip->gc;
+
+	val = gpio_mockup_get(gc, priv->offset);
+	snprintf(buf, sizeof(buf), "%d\n", val);
+
+	rv = copy_to_user(usr_buf, buf, sizeof(buf));
+	if (rv)
+		return rv;
+
+	return sizeof(buf) - 1;
+}
+
+static ssize_t gpio_mockup_debugfs_write(struct file *file,
+					 const char __user *usr_buf,
+					 size_t size, loff_t *ppos)
 {
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_mockup_chip *chip;
 	struct seq_file *sfile;
 	struct gpio_desc *desc;
-	int rv, val;
+	struct gpio_chip *gc;
+	struct irq_sim *sim;
+	int rv, val, curr;
+
+	if (*ppos != 0)
+		return -EINVAL;
 
 	rv = kstrtoint_from_user(usr_buf, size, 0, &val);
 	if (rv)
@@ -206,24 +248,69 @@ static ssize_t gpio_mockup_event_write(struct file *file,
 
 	sfile = file->private_data;
 	priv = sfile->private;
-	desc = priv->desc;
 	chip = priv->chip;
+	gc = &chip->gc;
+	desc = &gc->gpiodev->descs[priv->offset];
+	sim = &chip->irqsim;
+
+	mutex_lock(&chip->lock);
+
+	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
+	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+		curr = __gpio_mockup_get(chip, priv->offset);
+		if (curr == val)
+			goto out;
+
+		/*
+		 * FIXME: fire edge interrupts according to the type
+		 * configuration once irq_sim supports this.
+		 */
+		irq_sim_fire(&chip->irqsim, priv->offset);
+	}
 
-	gpiod_set_value_cansleep(desc, val);
-	irq_sim_fire(&chip->irqsim, priv->offset);
+	/* Change the value unless we're actively driving the line. */
+	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
+	    !test_bit(FLAG_IS_OUT, &desc->flags))
+		__gpio_mockup_set(chip, priv->offset, val);
+
+out:
+	chip->lines[priv->offset].pull = val;
+	mutex_unlock(&chip->lock);
 
 	return size;
 }
 
-static int gpio_mockup_event_open(struct inode *inode, struct file *file)
+static int gpio_mockup_debugfs_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, NULL, inode->i_private);
 }
 
-static const struct file_operations gpio_mockup_event_ops = {
+/*
+ * Each mockup chip is represented by a directory named after the chip's device
+ * name under /sys/kernel/debug/gpio-mockup/. Each line is represented by
+ * a file using the line's offset as the name under the chip's directory.
+ *
+ * Reading from the line's file yields the current *value*, writing to the
+ * line's file changes the current *pull*. Default pull for mockup lines is
+ * down.
+ *
+ * Examples:
+ * - when a line pulled down is requested in output mode and driven high, its
+ *   value will return to 0 once it's released
+ * - when the line is requested in output mode and driven high, writing 0 to
+ *   the corresponding debugfs file will change the pull to down but the
+ *   reported value will still be 1 until the line is released
+ * - line requested in input mode always reports the same value as its pull
+ *   configuration
+ * - when the line is requested in input mode and monitored for events, writing
+ *   the same value to the debugfs file will be a noop, while writing the
+ *   opposite value will generate a dummy interrupt with an appropriate edge
+ */
+static const struct file_operations gpio_mockup_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.open = gpio_mockup_event_open,
-	.write = gpio_mockup_event_write,
+	.open = gpio_mockup_debugfs_open,
+	.read = gpio_mockup_debugfs_read,
+	.write = gpio_mockup_debugfs_write,
 	.llseek = no_llseek,
 };
 
@@ -258,7 +345,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		priv->desc = &gc->gpiodev->descs[i];
 
 		evfile = debugfs_create_file(name, 0200, chip->dbg_dir, priv,
-					     &gpio_mockup_event_ops);
+					     &gpio_mockup_debugfs_ops);
 		if (IS_ERR_OR_NULL(evfile))
 			goto err;
 	}
@@ -266,7 +353,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	return;
 
 err:
-	dev_err(dev, "error creating debugfs event files\n");
+	dev_err(dev, "error creating debugfs files\n");
 }
 
 static int gpio_mockup_name_lines(struct device *dev,
@@ -342,6 +429,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->direction_input = gpio_mockup_dirin;
 	gc->get_direction = gpio_mockup_get_direction;
 	gc->to_irq = gpio_mockup_to_irq;
+	gc->free = gpio_mockup_free;
 
 	chip->lines = devm_kcalloc(dev, gc->ngpio,
 				   sizeof(*chip->lines), GFP_KERNEL);
@@ -415,7 +503,7 @@ static int __init gpio_mockup_init(void)
 			return -EINVAL;
 	}
 
-	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup-event", NULL);
+	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
 	if (IS_ERR_OR_NULL(gpio_mockup_dbg_dir))
 		gpio_mockup_err("error creating debugfs directory\n");
 
-- 
2.20.1

