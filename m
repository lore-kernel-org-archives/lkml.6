Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96004C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369B220892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqo0vgEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369B220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeG2T57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:57:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40138 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeG2T56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:57:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so11190747wma.5;
        Sun, 29 Jul 2018 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mm78z/T40DJzn0utgRhIcGZWhVGOI3cJsa0dk3+yGzc=;
        b=Nqo0vgEYicdrclxpD5GJGntYU6VE5IOC0uxFRYfQIo9NLEsJgMeP9iBJFuTFkQlhT2
         cR49h6WYaerkT8rMEEGBLRR9tkguNYKVc7SfkBG829KCz6pIvKqrtAimtKcJkUMdP8yl
         Lxaw/329/wsZBoAB9iBb3OesspqBW8tsPerHiH7Cnw/zpjF+1uBBmtLrRPEphIijDK/O
         Sx3/pPZyFJs8Dq6MxJl7o9TtFtuiIbhg/SP2svJiZ1pvmKgPH2i7MTBgKc/mjsW/Zgyu
         BQ+0lZ569G6y0prD7/NMcmTZzDAlB84SnAcAcdetlipStXiPv7ycXdzBgTrkS07mXFie
         6y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mm78z/T40DJzn0utgRhIcGZWhVGOI3cJsa0dk3+yGzc=;
        b=kayqJFUeX9LkbhDNKyM828Hf5/WJKHxrIfcBLAahzzP81ZBK2IkRC8tU1ED6C7TNQg
         lfkiJsAgD0TVrKvL90gC0z5XSkEoD1bQY8Wt9GcmfbHiVNCFKaugcMgP22CedCiOE9gr
         SM8m+f6q6XYuMzeU6Np1EP9HC2uKKS+avhYRWB596fuw8g7E+EFb7hOOROAYJcYITWy4
         oM7hs8arsgGZSQfSvb8IJtIUvZY1QkTkV4cwQPorthcnICYQO3wIAn6z+cc1rVvy36qz
         /Zygrvrp8oWztZK9y/yqSTRTto9Yp07F+nqP2woCXlXAvo4LQQwIEC1bTGvB2K2oytW6
         58WQ==
X-Gm-Message-State: AOUpUlFxsno6iNHLAZt4vHmh70PqAuV4xemzID3AWK1IlPEy78AofOPK
        5Oe1Y1iMEuSZTthxxeryFx8=
X-Google-Smtp-Source: AAOMgpfLTWt3BZlpwXHpoypOf7NhsBQm2ITfgDUubs8kosgrQVxDcFXHbfQvb4asPYM0QM3j2DZulQ==
X-Received: by 2002:a1c:e904:: with SMTP id q4-v6mr12478840wmc.154.1532888797164;
        Sun, 29 Jul 2018 11:26:37 -0700 (PDT)
Received: from localhost.localdomain (p5DCFE1FB.dip0.t-ipconnect.de. [93.207.225.251])
        by smtp.gmail.com with ESMTPSA id f6-v6sm8985217wrp.30.2018.07.29.11.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:26:36 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 1/5] pinctrl: actions: define constructor generic to Actions Semi SoC's
Date:   Sun, 29 Jul 2018 20:25:47 +0200
Message-Id: <20180729182551.19383-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729182551.19383-1-sravanhome@gmail.com>
References: <20180729182551.19383-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move generic defines common to the Owl family out of S900 driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.h  | 136 ++++++++++++++++++++++--
 drivers/pinctrl/actions/pinctrl-s900.c | 139 ++-----------------------
 2 files changed, 136 insertions(+), 139 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index a724d1d406d4..a7bcacad11d5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -15,12 +15,135 @@
 #define OWL_PINCONF_SLEW_SLOW 0
 #define OWL_PINCONF_SLEW_FAST 1
 
-enum owl_pinconf_pull {
-	OWL_PINCONF_PULL_HIZ,
-	OWL_PINCONF_PULL_DOWN,
-	OWL_PINCONF_PULL_UP,
-	OWL_PINCONF_PULL_HOLD,
-};
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
 
 enum owl_pinconf_drv {
 	OWL_PINCONF_DRV_2MA,
@@ -148,6 +271,7 @@ struct owl_gpio_port {
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
2.18.0

