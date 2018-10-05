Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15CD2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIT98nUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15CD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJENuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:50:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41728 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJENuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:50:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id q39-v6so8571567lfi.8;
        Thu, 04 Oct 2018 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBWJIuKG25fJ3c03nNo4vLlqJ9Gh+jksa5pKMeO33sQ=;
        b=bIT98nUUew3kkIXuTPrzGSYrqTcwl3zEqkgvrfvMc0yStMYxZc2KBtR/8PYhD8/IvF
         MA5tharguvnUUPBaHO8xm2MHKKCBXhbrpC7/fNAhwkF//n5gCWxmuVcHtI0zpdoQY0N0
         d3VG2QAeXaDOcu0lP6f59W88xJ/iaClZX7+CGnm5KWykNX6z++fREgVHvUCoElLJaQQJ
         2zOSIaHUKvG1UBTx3uzqc2CdhSF8NrX1fFyllMCe9zJc0jv+JfKPgRsUVENAaJgOb2RZ
         mu/RMqlr763eJZmaurwRlH4pxcftTrQ4QTalcuVTTgdWauVDg4ViihJ5hEx704Iimwxj
         zbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xBWJIuKG25fJ3c03nNo4vLlqJ9Gh+jksa5pKMeO33sQ=;
        b=K8sKzlplVW9Z7Pp3aG4va/fHC0CGIVSlDBEOaRfDGRYcjF/uWqCMSA/MPZajxzA6bY
         SItTNFVAUecCZXXA+jSxhpMw+rCWj8nNx6VXAxZnhpJG8P42JUELjYfVxs0gkrxX9UhI
         S6EzMyZ9N1sIxy0wHHN3T1L+LHxP5FDW2iT1msaO5SA2NKTkzsS8mD0XjJIGTZPckJPQ
         IezPlvxXPzEhy28Z6RTGa0MaWLzY8qOPse9C4ChCeGc0Xpt3E7vo91PzdnicFnznfEXj
         gjHsDsw4jMWQfhddYqi73ZOzIPHaiQocPyVfRoDeRCnkC90j2zKDf6dfj6p+G6I7wBey
         aG7w==
X-Gm-Message-State: ABuFfogdns15U420ea/BNLTRFQ7b5VvTbKnYEa+Tt3WLoaWN5LsxJeL3
        Dbz50TIOGnTQHvI+Mbhlgdo=
X-Google-Smtp-Source: ACcGV61PGIBVgyyaIQ17rwnptX1GG2m2eb1Y3tg1wa1Cg9tuScS9VNuTYSbqi0rpsCiSVrvvsLYUFQ==
X-Received: by 2002:a19:169d:: with SMTP id 29-v6mr5622722lfw.151.1538722382592;
        Thu, 04 Oct 2018 23:53:02 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t21-v6sm1608871ljg.32.2018.10.04.23.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 23:53:01 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v5 1/3] gpiolib: Add init_valid_mask exported function
Date:   Fri,  5 Oct 2018 08:52:58 +0200
Message-Id: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function that allows initializing the valid_mask from
gpiochip_add_data.

This prevents race conditions during gpiochip initialization.

If the function is not exported, then the old behaviour is respected,
this is, set all gpios as valid.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c      | 16 ++++++++++++++--
 include/linux/gpio/driver.h |  7 ++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..907019b67a58 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -359,7 +359,7 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
 	return p;
 }
 
-static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
+static int gpiochip_alloc_valid_mask(struct gpio_chip *gpiochip)
 {
 #ifdef CONFIG_OF_GPIO
 	int size;
@@ -380,6 +380,14 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
 	return 0;
 }
 
+static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
+{
+	if (gpiochip->init_valid_mask)
+		return gpiochip->init_valid_mask(gpiochip);
+
+	return 0;
+}
+
 static void gpiochip_free_valid_mask(struct gpio_chip *gpiochip)
 {
 	kfree(gpiochip->valid_mask);
@@ -1367,7 +1375,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_from_list;
 
-	status = gpiochip_init_valid_mask(chip);
+	status = gpiochip_alloc_valid_mask(chip);
 	if (status)
 		goto err_remove_irqchip_mask;
 
@@ -1379,6 +1387,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_chip;
 
+	status = gpiochip_init_valid_mask(chip);
+	if (status)
+		goto err_remove_chip;
+
 	acpi_gpiochip_add(chip);
 
 	machine_gpiochip_add(chip);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0ea328e71ec9..df09749269ff 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -256,6 +256,9 @@ struct gpio_chip {
 
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *chip);
+
+	int			(*init_valid_mask)(struct gpio_chip *chip);
+
 	int			base;
 	u16			ngpio;
 	const char		*const *names;
@@ -294,7 +297,9 @@ struct gpio_chip {
 	/**
 	 * @need_valid_mask:
 	 *
-	 * If set core allocates @valid_mask with all bits set to one.
+	 * If set core allocates @valid_mask with all its values initialized
+	 * with init_valid_mask() or set to one if init_valid_mask() is not
+	 * defined
 	 */
 	bool need_valid_mask;
 
-- 
2.19.0

