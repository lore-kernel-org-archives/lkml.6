Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE39C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C2220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/peedcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C2220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeINMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:21:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35729 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:21:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so6609508edq.2;
        Fri, 14 Sep 2018 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8yNP+JxRFnZBfKqIuPnkwG1FT1w7tmRFz4KB2VwboKk=;
        b=n/peedccgoSRjPHkssR2gD/2KpzDbYWKKf17b11eQ5qBaIBvoaYXp2dqzjXTQFhzBV
         Z3sJ32YJuJzQh86de5EEm6SHui6WDKH6GB4DaRV5X3iw5NCpoLjfa+8GVWrg2DdeYxwi
         25qA5D7Jt6BryaBefBn94vKseGGb8vtbkjAmX/EIdPVlrcitNFwEYg99C+/MpoBgFyDL
         q72S+Avdp4sT8tHbeUZQOgmpzSwloZAqQFaM9NUW0GV5d4dOoom2waabGtLhEAHrbfwi
         nsVwNB9Utp71+6PAIpWPUIE5QPPbWiW0UZxo4eE162TXl0o2m7l9fYQCv6EBSBhMIWIQ
         holg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8yNP+JxRFnZBfKqIuPnkwG1FT1w7tmRFz4KB2VwboKk=;
        b=nPrSQdPMQMC2uSwM7AJCJGhC3QhkCwegA3O8Rv8U+0ytlQrvn7ZWTRznVDxTa79O41
         3lZwR3vOBu33nVOUvsStL8aaWpdi1865UGB4RQxQf+vJ/damVqYiYVlWU7n3HuEb9+kQ
         lzmqqkXossSMs8zLI7gZKNqyIPkd13/X8gjw/HjLpYHFP3mcki4zykcB2WriDnlp3vek
         HWsUUsQJGKSAxyB0xuU8FLSRrhoTxvlMIQ2z+9bHvtiG4awGbOEOrFJxNoKGA6Vc0v5e
         7IFAqlaGhRnERsXnBa/EunQXa5qpXXgVC//PmpoWZEdor/12AkBMoEf6wCZTVD7yxCl3
         akow==
X-Gm-Message-State: APzg51Cc6HE31j4PAvrs6GQCrYctts1uRGptuVLHRhr3jueKYVhLD+Qs
        qo8UIQmsazOn+X6z1vZluOu6F8yZ
X-Google-Smtp-Source: ANB0VdZfHktenZuZVY9asz1mqVNxd1pUo1N7fav0CFVbEx6uxJ3AKgVFTqITyXvZDcCXf5qiKYqj3Q==
X-Received: by 2002:a05:6402:1652:: with SMTP id s18mr17602703edx.35.1536908923074;
        Fri, 14 Sep 2018 00:08:43 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id x48-v6sm4186111edm.18.2018.09.14.00.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 00:08:41 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [RFC] gpiolib: Fix gpio_direction_* for single direction GPIOs
Date:   Fri, 14 Sep 2018 09:08:38 +0200
Message-Id: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs with no programmable direction are not required to implement
direction_output nor direction_input.

If we try to set an output direction on an output-only GPIO or input
direction on an input-only GPIO simply return 0.

This allows this single direction GPIO to be used by libgpiod.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index af853749e0bb..3c09bf70e7ab 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2517,19 +2517,27 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
 int gpiod_direction_input(struct gpio_desc *desc)
 {
 	struct gpio_chip	*chip;
-	int			status = -EINVAL;
+	int			status = 0;
 
 	VALIDATE_DESC(desc);
 	chip = desc->gdev->chip;
 
-	if (!chip->get || !chip->direction_input) {
+	if (!chip->get && chip->direction_input) {
 		gpiod_warn(desc,
-			"%s: missing get() or direction_input() operations\n",
+			"%s: missing get() and direction_input() operations\n",
 			__func__);
 		return -EIO;
 	}
 
-	status = chip->direction_input(chip, gpio_chip_hwgpio(desc));
+	if (chip->direction_input) {
+		status = chip->direction_input(chip, gpio_chip_hwgpio(desc));
+	} else if (chip->get_direction &&
+		  (chip->get_direction(chip, gpio_chip_hwgpio(desc)) != 1)) {
+		gpiod_warn(desc,
+			"%s: missing direction_input() operation\n",
+			__func__);
+		return -EIO;
+	}
 	if (status == 0)
 		clear_bit(FLAG_IS_OUT, &desc->flags);
 
@@ -2551,16 +2559,28 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
 	int val = !!value;
-	int ret;
+	int ret = 0;
 
-	if (!gc->set || !gc->direction_output) {
+	if (!gc->set && !gc->direction_output) {
 		gpiod_warn(desc,
-		       "%s: missing set() or direction_output() operations\n",
+		       "%s: missing set() and direction_output() operations\n",
 		       __func__);
 		return -EIO;
 	}
 
-	ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+	if (gc->direction_output) {
+		ret = gc->direction_output(gc, gpio_chip_hwgpio(desc), val);
+	} else {
+		if (gc->get_direction &&
+		    gc->get_direction(gc, gpio_chip_hwgpio(desc))) {
+			gpiod_warn(desc,
+				"%s: missing direction_output() operation\n",
+				__func__);
+			return -EIO;
+		}
+		gc->set(gc, gpio_chip_hwgpio(desc), val);
+	}
+
 	if (!ret)
 		set_bit(FLAG_IS_OUT, &desc->flags);
 	trace_gpio_value(desc_to_gpio(desc), 0, val);
-- 
2.18.0

