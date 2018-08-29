Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD5BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55302086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjGHDcB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55302086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeH2MUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:20:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2MUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:20:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so3919444wre.10;
        Wed, 29 Aug 2018 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcQ/ygcDqmIft2aRXttpuNV6r84Doiv62GynRwOhm9U=;
        b=hjGHDcB8Z9R97M07YO+P4jCHWdOzX7lHP13yP5B0qHwPea2WjBHUnYbSbuYBeRyBhY
         GMuXiS9eS3tSkrcJ85ASWjwz5ZJRz562xeNNna7a5VE1QiDHHtI1wrRgP7027y/1rVz3
         78H7RL96PlcS0slH6oo9P1DRcjqYfBbn3S+AdpgN9/zeTp4xPmoro+WDnW5sZ/FIBotq
         +tojgxdjha7tilxak2iTbpqK1GpaZLOr+DTFnIo0AzGp2tDq6LR1y0o7o9FikznRNHnw
         C7+KZnNqeMZnQNS2x2BlKC7klZITlrPSoPii5MjKVJnDP5A1iqHK8A+lcSZeWfsLt5d8
         QDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OcQ/ygcDqmIft2aRXttpuNV6r84Doiv62GynRwOhm9U=;
        b=W6hcDlt30xdDAIDJeMCfoalPvOeRAjxy9UxMEJ7iCknwhuABOp4BdruQ4f9F95TDwG
         urK+E6M7C7hLZIXYe0O8Z5rpN7W9bK/Mc4oWRywsaiKz23pZd6Jdj0PfXwmsP9A30Ycx
         jmZHkEuFWQv1e71xPU/wCGuLXs7ZX3n3VK9EfFjBGPnfVQ/m6a8d0f9mn8uhx85dUfqb
         Au45MUSghKG4caE76yleSXQt7O5kSbnZsnwubX9oHl+5h61Iojhu3koliRX4rxWe9xi3
         gsV6gRRttmg9hD6XuxWtBNeeQQoceTn+aBVwiYoYTd4/IRwO+Oi8Kdgyd3gCal5RvPDq
         GalA==
X-Gm-Message-State: APzg51A/CxbIAHT15O/W5x2Sg3sLEjVDiPj774Iz1DTjYN1QMcnjZvcd
        EAdduuLMSXyNxYLoubgVKMs=
X-Google-Smtp-Source: ANB0Vday/6RxefAG2Eow55WaSJ+G/UT9GW5XHxVqoJF6C+rY3toj5did9UH52jXTvOldJomGdvGuvA==
X-Received: by 2002:a5d:4990:: with SMTP id r16-v6mr3715747wrq.116.1535531071483;
        Wed, 29 Aug 2018 01:24:31 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3013025wrw.30.2018.08.29.01.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 01:24:30 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 1/5] pinctrl: actions: define constructor generic to Actions Semi SoC's
Date:   Wed, 29 Aug 2018 10:24:09 +0200
Message-Id: <20180829082413.2512005-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829082413.2512005-1-sravanhome@gmail.com>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move generic defines common to the Owl family out of S900 driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.h  | 131 +++++++++++++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c | 139 ++-------------------------------
 2 files changed, 137 insertions(+), 133 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index a724d1d406d4..31cc33d7c4a5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -15,6 +15,136 @@
 #define OWL_PINCONF_SLEW_SLOW 0
 #define OWL_PINCONF_SLEW_FAST 1
 
+#define MUX_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.funcs = group_name##_funcs,				\
+		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
+		.mfpctl_reg  = MFCTL##reg,				\
+		.mfpctl_shift = shift,					\
+		.mfpctl_width = width,					\
+		.drv_reg = -1,						\
+		.drv_shift = -1,					\
+		.drv_width = -1,					\
+		.sr_reg = -1,						\
+		.sr_shift = -1,						\
+		.sr_width = -1,						\
+	}
+
+#define DRV_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.mfpctl_reg  = -1,					\
+		.mfpctl_shift = -1,					\
+		.mfpctl_width = -1,					\
+		.drv_reg = PAD_DRV##reg,				\
+		.drv_shift = shift,					\
+		.drv_width = width,					\
+		.sr_reg = -1,						\
+		.sr_shift = -1,						\
+		.sr_width = -1,						\
+	}
+
+#define SR_PG(group_name, reg, shift, width)				\
+	{								\
+		.name = #group_name,					\
+		.pads = group_name##_pads,				\
+		.npads = ARRAY_SIZE(group_name##_pads),			\
+		.mfpctl_reg  = -1,					\
+		.mfpctl_shift = -1,					\
+		.mfpctl_width = -1,					\
+		.drv_reg = -1,						\
+		.drv_shift = -1,					\
+		.drv_width = -1,					\
+		.sr_reg = PAD_SR##reg,					\
+		.sr_shift = shift,					\
+		.sr_width = width,					\
+	}
+
+#define FUNCTION(fname)					\
+	{						\
+		.name = #fname,				\
+		.groups = fname##_groups,		\
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+	}
+
+/* PAD PULL UP/DOWN CONFIGURES */
+#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
+	{						\
+		.reg = PAD_PULLCTL##pull_reg,		\
+		.shift = pull_sft,			\
+		.width = pull_wdt,			\
+	}
+
+#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
+	struct owl_pullctl pad_name##_pullctl_conf			\
+		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
+
+#define ST_CONF(st_reg, st_sft, st_wdt)			\
+	{						\
+		.reg = PAD_ST##st_reg,			\
+		.shift = st_sft,			\
+		.width = st_wdt,			\
+	}
+
+#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
+	struct owl_st pad_name##_st_conf		\
+		= ST_CONF(st_reg, st_sft, st_wdt)
+
+#define PAD_INFO(name)					\
+	{						\
+		.pad = name,				\
+		.pullctl = NULL,			\
+		.st = NULL,				\
+	}
+
+#define PAD_INFO_ST(name)				\
+	{						\
+		.pad = name,				\
+		.pullctl = NULL,			\
+		.st = &name##_st_conf,			\
+	}
+
+#define PAD_INFO_PULLCTL(name)				\
+	{						\
+		.pad = name,				\
+		.pullctl = &name##_pullctl_conf,	\
+		.st = NULL,				\
+	}
+
+#define PAD_INFO_PULLCTL_ST(name)			\
+	{						\
+		.pad = name,				\
+		.pullctl = &name##_pullctl_conf,	\
+		.st = &name##_st_conf,			\
+	}
+
+#define OWL_GPIO_PORT_A		0
+#define OWL_GPIO_PORT_B		1
+#define OWL_GPIO_PORT_C		2
+#define OWL_GPIO_PORT_D		3
+#define OWL_GPIO_PORT_E		4
+#define OWL_GPIO_PORT_F		5
+
+#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat, _intc_ctl,\
+			_intc_pd, _intc_msk, _intc_type, _share)	\
+	[OWL_GPIO_PORT_##port] = {				\
+		.offset = base,					\
+		.pins = count,					\
+		.outen = _outen,				\
+		.inen = _inen,					\
+		.dat = _dat,					\
+		.intc_ctl = _intc_ctl,				\
+		.intc_pd = _intc_pd,				\
+		.intc_msk = _intc_msk,				\
+		.intc_type = _intc_type,			\
+		.shared_ctl_offset = _share,			\
+	}
+
 enum owl_pinconf_pull {
 	OWL_PINCONF_PULL_HIZ,
 	OWL_PINCONF_PULL_DOWN,
@@ -148,6 +278,7 @@ struct owl_gpio_port {
 	unsigned int intc_pd;
 	unsigned int intc_msk;
 	unsigned int intc_type;
+	u8 shared_ctl_offset;
 };
 
 /**
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index ea67b14ef93b..0597009d8369 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -33,13 +33,6 @@
 #define PAD_SR1			(0x0274)
 #define PAD_SR2			(0x0278)
 
-#define OWL_GPIO_PORT_A		0
-#define OWL_GPIO_PORT_B		1
-#define OWL_GPIO_PORT_C		2
-#define OWL_GPIO_PORT_D		3
-#define OWL_GPIO_PORT_E		4
-#define OWL_GPIO_PORT_F		5
-
 #define _GPIOA(offset)		(offset)
 #define _GPIOB(offset)		(32 + (offset))
 #define _GPIOC(offset)		(64 + (offset))
@@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
 static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
 						    SENSOR0_CKOUT };
 
-#define MUX_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.funcs = group_name##_funcs,				\
-		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
-		.mfpctl_reg  = MFCTL##reg,				\
-		.mfpctl_shift = shift,					\
-		.mfpctl_width = width,					\
-		.drv_reg = -1,						\
-		.drv_shift = -1,					\
-		.drv_width = -1,					\
-		.sr_reg = -1,						\
-		.sr_shift = -1,						\
-		.sr_width = -1,						\
-	}
-
-#define DRV_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.mfpctl_reg  = -1,					\
-		.mfpctl_shift = -1,					\
-		.mfpctl_width = -1,					\
-		.drv_reg = PAD_DRV##reg,				\
-		.drv_shift = shift,					\
-		.drv_width = width,					\
-		.sr_reg = -1,						\
-		.sr_shift = -1,						\
-		.sr_width = -1,						\
-	}
-
-#define SR_PG(group_name, reg, shift, width)				\
-	{								\
-		.name = #group_name,					\
-		.pads = group_name##_pads,				\
-		.npads = ARRAY_SIZE(group_name##_pads),			\
-		.mfpctl_reg  = -1,					\
-		.mfpctl_shift = -1,					\
-		.mfpctl_width = -1,					\
-		.drv_reg = -1,						\
-		.drv_shift = -1,					\
-		.drv_width = -1,					\
-		.sr_reg = PAD_SR##reg,					\
-		.sr_shift = shift,					\
-		.sr_width = width,					\
-	}
 
 /* Pinctrl groups */
 static const struct owl_pingroup s900_groups[] = {
@@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
 	"sirq2_dummy",
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-		.groups = fname##_groups,		\
-		.ngroups = ARRAY_SIZE(fname##_groups),	\
-	}
-
 static const struct owl_pinmux_func s900_functions[] = {
 	[S900_MUX_ERAM] = FUNCTION(eram),
 	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
@@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
 	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
 	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
 };
-/* PAD PULL UP/DOWN CONFIGURES */
-#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
-	{								\
-		.reg = PAD_PULLCTL##pull_reg,				\
-		.shift = pull_sft,					\
-		.width = pull_wdt,					\
-	}
-
-#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
-	struct owl_pullctl pad_name##_pullctl_conf			\
-		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
-
-#define ST_CONF(st_reg, st_sft, st_wdt)					\
-	{								\
-		.reg = PAD_ST##st_reg,					\
-		.shift = st_sft,					\
-		.width = st_wdt,					\
-	}
-
-#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
-	struct owl_st pad_name##_st_conf				\
-		= ST_CONF(st_reg, st_sft, st_wdt)
 
 /* PAD_PULLCTL0 */
 static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
@@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
 static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
 static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
 
-#define PAD_INFO(name)							\
-	{								\
-		.pad = name,						\
-		.pullctl = NULL,					\
-		.st = NULL,						\
-	}
-
-#define PAD_INFO_ST(name)						\
-	{								\
-		.pad = name,						\
-		.pullctl = NULL,					\
-		.st = &name##_st_conf,					\
-	}
-
-#define PAD_INFO_PULLCTL(name)						\
-	{								\
-		.pad = name,						\
-		.pullctl = &name##_pullctl_conf,			\
-		.st = NULL,						\
-	}
-
-#define PAD_INFO_PULLCTL_ST(name)					\
-	{								\
-		.pad = name,						\
-		.pullctl = &name##_pullctl_conf,			\
-		.st = &name##_st_conf,					\
-	}
-
 /* Pad info table */
 static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
@@ -1821,27 +1708,13 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
 };
 
-#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,		\
-			_intc_ctl, _intc_pd, _intc_msk, _intc_type)	\
-	[OWL_GPIO_PORT_##port] = {					\
-		.offset = base,						\
-		.pins = count,						\
-		.outen = _outen,					\
-		.inen = _inen,						\
-		.dat = _dat,						\
-		.intc_ctl = _intc_ctl,					\
-		.intc_pd = _intc_pd,					\
-		.intc_msk = _intc_msk,					\
-		.intc_type = _intc_type,				\
-	}
-
 static const struct owl_gpio_port s900_gpio_ports[] = {
-	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
-	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
-	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
-	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
-	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
-	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
+	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240, 0),
+	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C, 0),
+	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238, 0),
+	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234, 0),
+	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230, 0),
+	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
 };
 
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
-- 
2.14.4

