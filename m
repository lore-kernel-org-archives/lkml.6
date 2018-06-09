Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yvuMGireG1uIUgAAmS7hNA
	; Sat, 09 Jun 2018 14:03:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B538C608CA; Sat,  9 Jun 2018 14:03:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo0lbknO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B232A6090F;
	Sat,  9 Jun 2018 14:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B232A6090F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeFIODg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:03:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39865 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeFIOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:03:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so24194328lff.6;
        Sat, 09 Jun 2018 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=djSnsPBRAqn84tARJhTa0m7NEna6Za9l4TCMdj3DMCQ=;
        b=qo0lbknOc4CU3V0flBUX9rkduwMFaM7tM01hZqZweTwmDXrdipxwaiw76Si4G3Sjpy
         cQGTz3yKi9rUozkdAOpsUFkyAYVj5IgmM4bhq9WU1qJs5mMboKVUZ4MFxQfju69HpHPK
         +vtmpYni6LMLyu0ktnGfBFp7khbHIzp0/DB7840nHaYVQLq2RiGXug5DFsoRZ5JJEi/y
         sd8SA70CijQLwSANpcDLiEDa8/upg+Q0pNtfyS+KEkZBSUx1Si57XXL3isZDbVkZxaFg
         GNIzDvwdr3MI/8CavwYM9tckNL0H2AmMYLeM/85g4H+uHhvFpyIag5pMJ1d0TWzHKOfq
         hpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=djSnsPBRAqn84tARJhTa0m7NEna6Za9l4TCMdj3DMCQ=;
        b=t2lOOAOKWjRtd47CB/0gqCU+WOV+xrFCPVzfFzEBX+ThFNwbx/foAQFdHOXSCSWV0u
         80iQNDU/Jqn/7FJuLP8il/RwVHnnVoOyBrWSFqleQ87mYRMjBnZY3s3qW5zOWCyTgr29
         dcqsXRgXFpLz6Cm5+c+5tth5WA/979D6So4bfkX1Q9K91F9swXacJjmJ+zhi42OiP8gj
         yrr5Nt4QqKhbT8vnM1vB1PKxcnO7z8Vzjv+lZaputONWQVasqGUJlBT02KCDAXCvzaNB
         gl+98HEqVbLGGq/bYgDiqXujjCbfZqu3dOP6kJ2FloUa16MdxJDQ6j3hCSLRCfk6GjM3
         2kbA==
X-Gm-Message-State: APt69E3KX2NkOR+VUVxCStzGxht54dM5+Zm3Po9m/fEgdcwhOxsuzmsv
        OmbTBbHAJHXmhG2U96HHLgE=
X-Google-Smtp-Source: ADUXVKI5O7/TQxE4+uhsdskTYROYkzTZSTVVSSHY9D2F/x/fVELWR/4qVGq9CHHH/s2NIjqFQo9hfg==
X-Received: by 2002:a2e:1092:: with SMTP id 18-v6mr7540444ljq.115.1528553005489;
        Sat, 09 Jun 2018 07:03:25 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:03:24 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 10/10] Input: ams_delta_serio: Get FIQ buffer from platform_data
Date: Sat,  9 Jun 2018 16:02:24 +0200
Message-Id: <20180609140224.32606-10-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exporting the FIQ buffer symbol to be used in
ams-delta-serio driver, pass it to the driver as platform_data.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c         |  6 +++---
 arch/arm/mach-omap1/board-ams-delta.c       |  8 ++++++++
 drivers/input/serio/ams_delta_serio.c       | 20 +++++++++++++-------
 include/linux/platform_data/ams-delta-fiq.h |  4 ----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index e9d350117240..983638994bd4 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -40,8 +40,7 @@ static struct fiq_handler fh = {
  * keystrokes received from the qwerty keyboard.  See
  * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
  */
-unsigned int fiq_buffer[1024];
-EXPORT_SYMBOL(fiq_buffer);
+static unsigned int fiq_buffer[1024];
 
 static struct irq_chip *irq_chip;
 static struct irq_data *irq_data[16];
@@ -203,9 +202,10 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
 
-	/* Initialize serio device IRQ resource */
+	/* Initialize serio device IRQ resource and platform_data */
 	serio->resource[0].start = gpiod_to_irq(clk);
 	serio->resource[0].end = serio->resource[0].start;
+	serio->dev.platform_data = fiq_buffer;
 
 	return;
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 84177ba3e39a..772892487827 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -520,6 +520,14 @@ static struct resource ams_delta_serio_resources[] = {
 static struct platform_device ams_delta_serio_device = {
 	.name		= "ams-delta-serio",
 	.id		= PLATFORM_DEVID_NONE,
+	.dev		= {
+		/*
+		 * Initialize .platform_data explicitly with NULL to
+		 * indicate it is going to be used.  It will be replaced
+		 * with FIQ buffer address as soon as FIQ is initialized.
+		 */
+		.platform_data = NULL,
+	},
 	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
 	.resource	= ams_delta_serio_resources,
 };
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 03640b171516..ee38c5140f43 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
 struct ams_delta_serio {
 	struct serio *serio;
 	struct regulator *vcc;
+	unsigned int *fiq_buffer;
 };
 
 static int check_data(struct serio *serio, int data)
@@ -66,22 +67,23 @@ static int check_data(struct serio *serio, int data)
 static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 {
 	struct ams_delta_serio *priv = dev_id;
-	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
+	int *circ_buff = &priv->fiq_buffer[FIQ_CIRC_BUFF];
 	int data, dfl;
 	u8 scancode;
 
-	fiq_buffer[FIQ_IRQ_PEND] = 0;
+	priv->fiq_buffer[FIQ_IRQ_PEND] = 0;
 
 	/*
 	 * Read data from the circular buffer, check it
 	 * and then pass it on the serio
 	 */
-	while (fiq_buffer[FIQ_KEYS_CNT] > 0) {
+	while (priv->fiq_buffer[FIQ_KEYS_CNT] > 0) {
 
-		data = circ_buff[fiq_buffer[FIQ_HEAD_OFFSET]++];
-		fiq_buffer[FIQ_KEYS_CNT]--;
-		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
-			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
+		data = circ_buff[priv->fiq_buffer[FIQ_HEAD_OFFSET]++];
+		priv->fiq_buffer[FIQ_KEYS_CNT]--;
+		if (priv->fiq_buffer[FIQ_HEAD_OFFSET] ==
+		    priv->fiq_buffer[FIQ_BUF_LEN])
+			priv->fiq_buffer[FIQ_HEAD_OFFSET] = 0;
 
 		dfl = check_data(priv->serio, data);
 		scancode = (u8) (data >> 1) & 0xFF;
@@ -116,6 +118,10 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->fiq_buffer = pdev->dev.platform_data;
+	if (!priv->fiq_buffer)
+		return -EINVAL;
+
 	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	if (IS_ERR(priv->vcc)) {
 		err = PTR_ERR(priv->vcc);
diff --git a/include/linux/platform_data/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
index dc0f835ea918..cf4589ccb720 100644
--- a/include/linux/platform_data/ams-delta-fiq.h
+++ b/include/linux/platform_data/ams-delta-fiq.h
@@ -55,8 +55,4 @@
 
 #define FIQ_CIRC_BUFF		30      /*Start of circular buffer */
 
-#ifndef __ASSEMBLER__
-extern unsigned int fiq_buffer[];
-#endif
-
 #endif
-- 
2.16.1
