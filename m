Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2ACC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B490208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1/ymuEzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B490208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbeHALpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:45:31 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40692 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388985AbeHALpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:45:30 -0400
Received: by mail-wr1-f41.google.com with SMTP id h15-v6so19474127wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuBO+lRjS+AQcV6hL+v/rpCD0Zo/OVQAPDSiaaqeuys=;
        b=1/ymuEzKs6beJ9HR6UhbZuVnV+OZt1sRGMMs+/QL1apP+tnCEk/ZlfdlHUWOuIq8eH
         d1MLuXyFfyxJDEL0a+tkn/e2lBZaY+Gnd6/c+J5gEuV33ybwIeIuTQfWlnp6qz/FJAbx
         qDeKi4Q2fDOCvQRwg2JyFW5VCqFkUgduDCE3QUPy8qAP0EPa1zMrt56bml7ZQZp4M9oa
         bph+fy9ff7f7DaQf47F5mTQTVbRi/5p6qSqy7Wx+RJeLTo1jtkEjvvER9Mj1I75EzKNP
         E4M0C5ZtGb3XQ9vEJxZyO+AHa1/HmjpqhyJ+T/lIUVxfrbaWt76q44kHGOywuGT35CpO
         rEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuBO+lRjS+AQcV6hL+v/rpCD0Zo/OVQAPDSiaaqeuys=;
        b=ozOAzbgt5Bho6lf0hZJXIXDmtMgtYexZCOGSaiCb1zZ7dYLKzJWS+M2k3l9ybw3eXc
         HpeLJru34kSfQn6PyhhsNtUahLxOTntJDYbedpo9Xrrcu6fM73CXMAK50P+XonJu/mar
         sTQjlFeKbVa8BVSWpZ5HQgAb51m7HC3TgpkAHU5wql97gI8+61NbYwC3r3FlZYHEL7BK
         mUpVlVPL1VPUEqpVRnfmFpqiSt28huXs/SwO0X70f9kvfCdOrM5/PCcEkACBT4bOxrxi
         ZwzWI0sGycptlZlrJO5MLG0CLVt0DYWibWHXHlstW7WyWLq61M0yqgcKF6yjer62Tprk
         Eg2g==
X-Gm-Message-State: AOUpUlGitU72F/7dKngKgjqWtA22unD43DSPu2a0AAmCnDdQtNQ/zqJH
        YHjJ2mkePI1wItW70X/Yww65zA==
X-Google-Smtp-Source: AAOMgpfmEnPY2ZnCtLVp6HPIOnf2hnSolmMk9pcPCXg7zFYN08OSREUoQbbF91hCn3NNMsk9Qk4u7Q==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr24607182wra.90.1533117630927;
        Wed, 01 Aug 2018 03:00:30 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6317067wmd.46.2018.08.01.03.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:00:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pinctrl: meson: Add support to set direction with a secure monitor call
Date:   Wed,  1 Aug 2018 12:00:20 +0200
Message-Id: <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
set the TEST_N pin direction.
This patch adds a "smc" boolean to the bank structure to differentiate
the TEST_N bank and call the Secure Monitor in the _input/_output functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/Kconfig         |  1 +
 drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index c80951d..1b90470 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
 	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
+	select MESON_SM
 
 if PINCTRL_MESON
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 29a458d..8e445aa 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -54,6 +54,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/firmware/meson/meson_sm.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
@@ -99,8 +100,14 @@ static void meson_calc_reg_and_bit(struct meson_bank *bank, unsigned int pin,
 {
 	struct meson_reg_desc *desc = &bank->regs[reg_type];
 
-	*reg = desc->reg * 4;
-	*bit = desc->bit + pin - bank->first;
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (reg_type == REG_DIR && bank->smc) {
+		*reg = desc->reg;
+		*bit = desc->bit;
+	} else {
+		*reg = desc->reg * 4;
+		*bit = desc->bit + pin - bank->first;
+	}
 }
 
 static int meson_get_groups_count(struct pinctrl_dev *pcdev)
@@ -342,6 +349,12 @@ static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 
 	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
 
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (bank->smc) {
+		u32 smc_ret = 0;
+		return meson_sm_call(reg, &smc_ret, 0, 0, 0, 0, 0);
+	}
+
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit), BIT(bit));
 }
 
@@ -358,9 +371,17 @@ static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 		return ret;
 
 	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
-	ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
-	if (ret)
-		return ret;
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (bank->smc) {
+		u32 smc_ret = 0;
+		ret = meson_sm_call(reg, &smc_ret, bit, 0, 0, 0, 0);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
+		if (ret)
+			return ret;
+	}
 
 	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 12a39110..d32e9a9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -92,6 +92,7 @@ struct meson_bank {
 	const char *name;
 	unsigned int first;
 	unsigned int last;
+	bool smc; /* Direction needs to use a Secure Monitor call */
 	int irq_first;
 	int irq_last;
 	struct meson_reg_desc regs[NUM_REG];
@@ -131,11 +132,12 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)	\
+#define __BANK(n, f, l, sm, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
 	{								\
 		.name		= n,					\
 		.first		= f,					\
 		.last		= l,					\
+		.smc		= sm,					\
 		.irq_first	= fi,					\
 		.irq_last	= li,					\
 		.regs = {						\
@@ -147,6 +149,12 @@ struct meson_pinctrl {
 		},							\
 	 }
 
+#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	__BANK(n, f, l, false, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)
+
+#define BANK_SMC(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	__BANK(n, f, l, true, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)
+
 #define MESON_PIN(x) PINCTRL_PIN(x, #x)
 
 /* Common pmx functions */
-- 
2.7.4

