Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7993ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6677E20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLquVh4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6677E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeGVRdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:33:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35978 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbeGVRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:33:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so15615122wro.3;
        Sun, 22 Jul 2018 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6idYKvEMTvQJEuXFzefixdyM5hS1c5SiJub9Sb6NZs=;
        b=NLquVh4QIjBpVQUuslsinD8+oIUL8Ye3AFCca2QC0B06+iASSAByVYfTnwrfxr1X9o
         vu0A4HWUeAh9zxX3TFwhgBT9XQA6bIMWNWdNY9R2yHZid/D9ssayjpYVzpf5mkdJLXP1
         6KZSA3GC8BjKBiTKvk3Cf0oLCV7Aou8g5NqRzPqb6ILi30NNT6L9MIzx9pR5rQKh8/Y8
         FpmYaWStbLCPJILK7RuhhcAEoSlNQA1z0BjTYmWAECcc/NdcJDT9d00E/P/YFBzwYx3H
         KRfJZ5Gu4nmkpmHlnKfvH3/DCV0f4WYZycX6OzVXd6jCQ513HuA8771ER7jmObjDxpxY
         hzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6idYKvEMTvQJEuXFzefixdyM5hS1c5SiJub9Sb6NZs=;
        b=Qv9Ersp69/YwQa7AS4J1J6MP8vCguxuQd0a5ZzVLGi2HPevg1gvxjeTG+IZ7XiYURB
         G6uRL9tP8bdIIGu3P60w17sL3SbFwfmCFWQv1Q2cfq0QX+z/8JZBeQnG0kjLGJ3aprRr
         EBm9IejJSpbalYmlf33FGTkW4ubb+x772NluAZxiuqcL2tRJlsM0CMDjj0XkLo8f6ftO
         DjOa3aP742Cu+8TSqxA7xkgRVzn7XQ9tDpYZHakbB/0XFoL24aUg7KmXE5h7AoroDWE/
         Jswa40PLOsEcg1v+NSNYdv2uhQCHKsIKrXe7le64c2OMpmrkDN/u/wj2tqhQRKkvBdsH
         vpNQ==
X-Gm-Message-State: AOUpUlGnohZPbPn0aU6uqrZ/Y+vtfJ3VkpGhuxAlzphKX+JCEXt+bQ3J
        AtyYcQsTbeunhBd3rKHvj8Tr0lS1GbeSAA==
X-Google-Smtp-Source: AAOMgpe4TsiP29ysHrmcEUAR92diZu8TC6zZ+IwYxe90IvAYX4yv2gtRr/rozdue0ghe0FTfN1A2rA==
X-Received: by 2002:adf:96c3:: with SMTP id u61-v6mr6285574wrb.72.1532277378904;
        Sun, 22 Jul 2018 09:36:18 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.37.46])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15195653wrp.54.2018.07.22.09.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 09:36:18 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 2/5] pinctrl: actions: define pad control configurtion to SoC specific
Date:   Sun, 22 Jul 2018 18:35:58 +0200
Message-Id: <20180722163601.28346-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722163601.28346-1-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pad control for s900 and s700 are differs in number of
pull control configuraions
s900 has 4 pull controls - high impedence, pull up, pull down, repeater
s700, s500 has 2 pull controls - pull up and pull down

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.c  | 64 ++++---------------------
 drivers/pinctrl/actions/pinctrl-owl.h  | 13 +++--
 drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index b5c880b50bb3..f72da7aae4ff 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -242,60 +242,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
 	return 0;
 }
 
-static int owl_pad_pinconf_arg2val(const struct owl_padinfo *info,
-				unsigned int param,
-				u32 *arg)
-{
-	switch (param) {
-	case PIN_CONFIG_BIAS_BUS_HOLD:
-		*arg = OWL_PINCONF_PULL_HOLD;
-		break;
-	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		*arg = OWL_PINCONF_PULL_HIZ;
-		break;
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		*arg = OWL_PINCONF_PULL_DOWN;
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-		*arg = OWL_PINCONF_PULL_UP;
-		break;
-	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		*arg = (*arg >= 1 ? 1 : 0);
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
-static int owl_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
-				unsigned int param,
-				u32 *arg)
-{
-	switch (param) {
-	case PIN_CONFIG_BIAS_BUS_HOLD:
-		*arg = *arg == OWL_PINCONF_PULL_HOLD;
-		break;
-	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		*arg = *arg == OWL_PINCONF_PULL_HIZ;
-		break;
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		*arg = *arg == OWL_PINCONF_PULL_DOWN;
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-		*arg = *arg == OWL_PINCONF_PULL_UP;
-		break;
-	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		*arg = *arg == 1;
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
 static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
 				unsigned int pin,
 				unsigned long *config)
@@ -314,7 +260,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
 
 	arg = owl_read_field(pctrl, reg, bit, width);
 
-	ret = owl_pad_pinconf_val2arg(info, param, &arg);
+	if (!pctrl->soc->padctl_val2arg)
+		return -ENOTSUPP;
+
+	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
 	if (ret)
 		return ret;
 
@@ -345,7 +294,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
 		if (ret)
 			return ret;
 
-		ret = owl_pad_pinconf_arg2val(info, param, &arg);
+		if (!pctrl->soc->padctl_arg2val)
+			return -ENOTSUPP;
+
+		ret = pctrl->soc->padctl_arg2val(info, param, &arg);
 		if (ret)
 			return ret;
 
diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index 42635366e68f..669591c5400e 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -139,13 +139,6 @@
 		.st = &name##_st_conf,			\
 	}
 
-enum owl_pinconf_pull {
-	OWL_PINCONF_PULL_HIZ,
-	OWL_PINCONF_PULL_DOWN,
-	OWL_PINCONF_PULL_UP,
-	OWL_PINCONF_PULL_HOLD,
-};
-
 enum owl_pinconf_drv {
 	OWL_PINCONF_DRV_2MA,
 	OWL_PINCONF_DRV_4MA,
@@ -278,6 +271,12 @@ struct owl_pinctrl_soc_data {
 	unsigned int ngpios;
 	const struct owl_gpio_port *ports;
 	unsigned int nports;
+	int (*padctl_val2arg)(const struct owl_padinfo *padinfo,
+				unsigned int param,
+				u32 *arg);
+	int (*padctl_arg2val)(const struct owl_padinfo *info,
+				unsigned int param,
+				u32 *arg);
 };
 
 int owl_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index baa2f4847418..dc7bdc1f5cde 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include "pinctrl-owl.h"
 
 /* Pinctrl registers offset */
@@ -1717,6 +1718,67 @@ static const struct owl_gpio_port s900_gpio_ports[] = {
 	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
 };
 
+enum owl_pinconf_pull {
+	OWL_PINCONF_PULL_HIZ,
+	OWL_PINCONF_PULL_DOWN,
+	OWL_PINCONF_PULL_UP,
+	OWL_PINCONF_PULL_HOLD,
+};
+
+static int owl_pad_pinconf_s900_arg2val(const struct owl_padinfo *info,
+				unsigned int param,
+				u32 *arg)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*arg = OWL_PINCONF_PULL_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*arg = OWL_PINCONF_PULL_HIZ;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*arg = OWL_PINCONF_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*arg = OWL_PINCONF_PULL_UP;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*arg = (*arg >= 1 ? 1 : 0);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static int owl_pad_pinconf_s900_val2arg(const struct owl_padinfo *padinfo,
+				unsigned int param,
+				u32 *arg)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*arg = *arg == OWL_PINCONF_PULL_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*arg = *arg == OWL_PINCONF_PULL_HIZ;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*arg = *arg == OWL_PINCONF_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*arg = *arg == OWL_PINCONF_PULL_UP;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*arg = *arg == 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.padinfo = s900_padinfo,
 	.pins = (const struct pinctrl_pin_desc *)s900_pads,
@@ -1727,7 +1789,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.ngroups = ARRAY_SIZE(s900_groups),
 	.ngpios = NUM_GPIOS,
 	.ports = s900_gpio_ports,
-	.nports = ARRAY_SIZE(s900_gpio_ports)
+	.nports = ARRAY_SIZE(s900_gpio_ports),
+	.padctl_arg2val = owl_pad_pinconf_s900_arg2val,
+	.padctl_val2arg = owl_pad_pinconf_s900_val2arg,
 };
 
 static int s900_pinctrl_probe(struct platform_device *pdev)
-- 
2.18.0

