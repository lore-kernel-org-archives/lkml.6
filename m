Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA3C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA717224F3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbc08Y/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA717224F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeFUWmt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37533 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933714AbeFUWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16-v6so578732ljg.4;
        Thu, 21 Jun 2018 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ClkxPgg2cZgY5jCJ9+fXxslN8qhP3411BKdrQnTPFLI=;
        b=tbc08Y/SwwnQKy+mKjzaY0q36BanLdn1ECZ1umiMI/5409ZVjs9UXYG/FOEjgTg8/j
         BqMpXaY9Qd0Wf9TQoksSPC8tHjHjvm+Ubskci8o7dtDom0qdkpHqZUxzq4C4AK9ysp7a
         XrInV5lOI1WLkUrk4ehLquw7wSeeRWbGLJkbpFkOUdGoYflG2EhOJG//U7QWN2xG8y85
         RagMzvB4Tl2dchsJgwvtTNpxPVc6HRoR9z7p8oeBIAKGqwZ8uskuR31fmycqsDP5hGWP
         /pG15G7mi7lyo5F9BpiedDkzV8HGVqM+rbo8gLXHE/z4zBTL5QeW3YgTrz1DG+AZvfMm
         BFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ClkxPgg2cZgY5jCJ9+fXxslN8qhP3411BKdrQnTPFLI=;
        b=tG0Dv+SruyDwCdDEtw9WDybC51syNSAK+e0/b/nlNNgvYJAx0IZuDr68VKExd0eyCt
         af9k+eZT/SIybkA3BirbUtIPGTDH1a1Ko+SZbcKnnd7rw0DiQB/zR6cqFwTo9Alg0QJc
         V/zLOE3GybEaNoE4E1tCHzuHaLKFJomey+1NjGpOuOm96XXtT74gEDHp8uMrbHQH0QsW
         C/PuSVgo7fk40ak54e06Vy3NUpkqt4FknTUK2D9gLBdbgGeiVEoS0JxtRPYp0glUl4yx
         Ja+9Th2MeiHVxtnpGjwuKpBe0h5DyuPrdz/g1pqKZ64ycviBGfj22bpaGATZLriiYizM
         lpnQ==
X-Gm-Message-State: APt69E0izwGCvg79oyn7FDf9BKr9F31G4zpx04ONbR8zRf2of5Q6iN6h
        sNEtlvmG91XaZ7++5p05GiA=
X-Google-Smtp-Source: ADUXVKLgscNsqMifD8NGKcZ+xFWQJTEmmUTU1p0Axc0K7lsYYVVatdmn7uJOMDcQkp6hKRcMwkOjIg==
X-Received: by 2002:a2e:9516:: with SMTP id f22-v6mr17867717ljh.9.1529620962097;
        Thu, 21 Jun 2018 15:42:42 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:41 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 09/10] Input: ams_delta_serio: use IRQ resource
Date:   Fri, 22 Jun 2018 00:41:27 +0200
Message-Id: <20180621224128.17623-9-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver still obtains IRQ number from a hardcoded GPIO.  Use IRQ
resource instead.

For this to work on Amstrad Delta, add the IRQ resource to
ams-delta-serio platform device structure.  Obtain the IRQ number
assigned to "keybrd_clk" GPIO pin from FIQ initialization routine.

As a benefit, the driver no longer needs to include
<mach/board-ams-delta.h>.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: - obsolete assignment of handle_simple_irq() removed from the driver
      and replaced with a comment in the FIQ init file,
    - rebased on v4.18-rc1, no conflicts.

 arch/arm/mach-omap1/ams-delta-fiq.c   | 20 +++++++++++++++++++-
 arch/arm/mach-omap1/ams-delta-fiq.h   |  3 ++-
 arch/arm/mach-omap1/board-ams-delta.c | 17 ++++++++++++++++-
 drivers/input/serio/ams_delta_serio.c | 32 +++++++++-----------------------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index e72935034d42..82ca4246a5e4 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/platform_data/ams-delta-fiq.h>
+#include <linux/platform_device.h>
 
 #include <mach/board-ams-delta.h>
 
@@ -84,7 +85,8 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void __init ams_delta_init_fiq(struct gpio_chip *chip)
+void __init ams_delta_init_fiq(struct gpio_chip *chip,
+			       struct platform_device *serio)
 {
 	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
 	void *fiqhandler_start;
@@ -201,6 +203,22 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
 
+	/* Initialize serio device IRQ resource */
+	serio->resource[0].start = gpiod_to_irq(clk);
+	serio->resource[0].end = serio->resource[0].start;
+
+	/*
+	 * Since FIQ handler performs handling of GPIO registers for
+	 * "keybrd_clk" IRQ pin, ams_delta_serio driver used to set
+	 * handle_simple_irq() as active IRQ handler for that pin to avoid
+	 * bad interaction with gpio-omap driver.  This is no longer needed
+	 * as handle_simple_irq() is now the default handler for OMAP GPIO
+	 * edge interrupts.
+	 * This comment replaces the obsolete code which has been removed
+	 * from the ams_delta_serio driver and stands here only as a reminder
+	 * of that dependency on gpio-omap driver behavior.
+	 */
+
 	return;
 
 out_gpio:
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.h b/arch/arm/mach-omap1/ams-delta-fiq.h
index 3f691d68aa62..fd76df3cce37 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.h
+++ b/arch/arm/mach-omap1/ams-delta-fiq.h
@@ -35,7 +35,8 @@
 #ifndef __ASSEMBLER__
 extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
 
-extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
+extern void __init ams_delta_init_fiq(struct gpio_chip *chip,
+				      struct platform_device *pdev);
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index fe9a3e7cbfeb..84177ba3e39a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -504,9 +504,24 @@ static struct platform_device cx20442_codec_device = {
 	.id     = -1,
 };
 
+static struct resource ams_delta_serio_resources[] = {
+	{
+		.flags	= IORESOURCE_IRQ,
+		/*
+		 * Initialize IRQ resource with invalid IRQ number.
+		 * It will be replaced with dynamically allocated GPIO IRQ
+		 * obtained from GPIO chip as soon as the chip is available.
+		 */
+		.start	= -EINVAL,
+		.end	= -EINVAL,
+	},
+};
+
 static struct platform_device ams_delta_serio_device = {
 	.name		= "ams-delta-serio",
 	.id		= PLATFORM_DEVID_NONE,
+	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
+	.resource	= ams_delta_serio_resources,
 };
 
 static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
@@ -615,7 +630,7 @@ static void __init omap_gpio_deps_init(void)
 		return;
 	}
 
-	ams_delta_init_fiq(chip);
+	ams_delta_init_fiq(chip, &ams_delta_serio_device);
 }
 
 static void __init ams_delta_init(void)
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 2602f7cff5ae..c1f8226f172e 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -20,7 +20,6 @@
  * However, when used with the E3 mailboard that producecs non-standard
  * scancodes, a custom key table must be prepared and loaded from userspace.
  */
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
@@ -29,8 +28,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include <mach/board-ams-delta.h>
-
 #define DRIVER_NAME	"ams-delta-serio"
 
 MODULE_AUTHOR("Matt Callow");
@@ -113,7 +110,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 {
 	struct ams_delta_serio *priv;
 	struct serio *serio;
-	int err;
+	int irq, err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -139,26 +136,20 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
-			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
-			DRIVER_NAME, priv);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	err = devm_request_irq(&pdev->dev, irq, ams_delta_serio_interrupt,
+			       IRQ_TYPE_EDGE_RISING, DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
 		return err;
 	}
-	/*
-	 * Since GPIO register handling for keyboard clock pin is performed
-	 * at FIQ level, switch back from edge to simple interrupt handler
-	 * to avoid bad interaction.
-	 */
-	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
-			handle_simple_irq);
 
 	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
-	if (!serio) {
-		err = -ENOMEM;
-		goto irq;
-	}
+	if (!serio)
+		return -ENOMEM;
 
 	priv->serio = serio;
 
@@ -177,10 +168,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	dev_info(&serio->dev, "%s\n", serio->name);
 
 	return 0;
-
-irq:
-	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
-	return err;
 }
 
 static int ams_delta_serio_exit(struct platform_device *pdev)
@@ -188,7 +175,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
 	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
 
 	serio_unregister_port(priv->serio);
-	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 
 	return 0;
 }
-- 
2.16.4

