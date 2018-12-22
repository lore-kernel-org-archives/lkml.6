Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D160BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76C21A4B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj5KeFvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392602AbeLVRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:37:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44750 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbeLVRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:37:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so3912662plt.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KW6fsZf9+OCqL4Xg+K2v5CtkOaYpqhd0HfSHrj5fc4g=;
        b=Bj5KeFvw3UoLqAA6f26Tyw23BoNXt9omxm2Oj8vdM2lYQNuNqNf560S3q25w9iuvlR
         KIRJ72rDACfSg9CfSJvBR8/BouQbZxpwdmB3amBVRS20XnBUpgfFznRCrfmNNRrRYOjE
         rLjuoy7+Ceo9lVsoiyxvzZRCRcRL/vyLqbxecYxghUkcNAGv8MbEtQGQ8MV8WrtFySe9
         6iexwMIonKDH+tDSWiIrr2YIfb+QDOaghi2U9y6MY3lyZvpPXtwDEvg+eOGclhThWtyA
         CEXR0/PHl9u46Q+HRhLHtMZ0yXqZNOrFEekRqayP2vjhjDGcPqrwxhIenRQI6muVLDrO
         6WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KW6fsZf9+OCqL4Xg+K2v5CtkOaYpqhd0HfSHrj5fc4g=;
        b=r0LDW18U8//jgnVu0pN9qa+gMPwRD86IT1/rgHFxy3wSkOBQtJVyyiun/kSHoyqZ27
         Z0UgVK8XlrfniTb9g2rnA1J6hAAEGG/3TVb5UFfIXfUg5SjYaqKvm7XngoHZJTZ8FyfE
         cn624M4NqfrW3/LUbCG/92xLDY5nVoqS8aG3TutC9uzl0AbD5rbCXA/6eLRCeQ3uETUL
         Zmg60IdNGYgM5g/nJsTwoE2Cb7/1G270294Eqeqko36toCp14+L2INgDi2fSMRqOhqP4
         aS/yFNO3rPhGhcKtGELF/+LyKXcG4BIdGOmpeGUXXyjClQ/jOF39bJoBxC+wPfqEbkbJ
         ylWw==
X-Gm-Message-State: AJcUukdOYDNRxpBC11VeepS9FcEyTW8RlutpfJR9nlZiY7ZRGIHJhZFf
        KOcjjN2DXHZB5b+sCBx42M8hBlDch6s=
X-Google-Smtp-Source: ALg8bN4QUG3a08fnwMcL5g+NP0iVlM2nCua74Z75YtGNJB0ptV/CLmpf65HgN6GM3bwd9PW9WNrxbQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr6793025plk.291.1545490267427;
        Sat, 22 Dec 2018 06:51:07 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id r187sm52819066pfc.63.2018.12.22.06.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:51:06 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:21:00 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 2/4] staging: greybus: gpio: Use gpiochip_get_data() in
 place of gpio_chip_to_gb_gpio_controller()
Message-ID: <03b274a2b5777d67e9d9b6318b5b2f13ce5c2b66.1545488665.git.nishadkamdar@gmail.com>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops gpio_chip_to_gb_gpio_controller(),
and uses gpiochip_get_data() to retrieve the container
of struct gpio_chip.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v4:
 - Introduce this change as a new patch.
---
 drivers/staging/greybus/gpio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 1af291aa1b6e..2dd04682cbc6 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -40,8 +40,6 @@ struct gb_gpio_controller {
 	struct gpio_chip	chip;
 	struct mutex		irq_lock;
 };
-#define gpio_chip_to_gb_gpio_controller(chip) \
-	container_of(chip, struct gb_gpio_controller, chip)
 #define irq_data_to_gpio_chip(d) (d->domain->host_data)
 
 static int gb_gpio_line_count_operation(struct gb_gpio_controller *ggc)
@@ -270,7 +268,7 @@ static void _gb_gpio_irq_set_type(struct gb_gpio_controller *ggc,
 static void gb_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = true;
@@ -280,7 +278,7 @@ static void gb_gpio_irq_mask(struct irq_data *d)
 static void gb_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = false;
@@ -290,7 +288,7 @@ static void gb_gpio_irq_unmask(struct irq_data *d)
 static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 	struct device *dev = &ggc->gbphy_dev->dev;
 	u8 irq_type;
@@ -328,7 +326,7 @@ static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 static void gb_gpio_irq_bus_lock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	mutex_lock(&ggc->irq_lock);
 }
@@ -336,7 +334,7 @@ static void gb_gpio_irq_bus_lock(struct irq_data *d)
 static void gb_gpio_irq_bus_sync_unlock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	if (line->irq_type_pending) {
@@ -405,21 +403,21 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 
 static int gb_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_activate_operation(ggc, (u8)offset);
 }
 
 static void gb_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_deactivate_operation(ggc, (u8)offset);
 }
 
 static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -433,7 +431,7 @@ static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_in_operation(ggc, (u8)offset);
 }
@@ -441,14 +439,14 @@ static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 static int gb_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				    int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_out_operation(ggc, (u8)offset, !!value);
 }
 
 static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -462,7 +460,7 @@ static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_set_value_operation(ggc, (u8)offset, !!value);
 }
@@ -470,7 +468,7 @@ static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 static int gb_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			      unsigned long config)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u32 debounce;
 
 	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-- 
2.17.1

