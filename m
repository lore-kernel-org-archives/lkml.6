Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11588C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgutgf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeGaVan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:30:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40066 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbeGaVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:30:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so17828984wrs.7;
        Tue, 31 Jul 2018 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIzsYNTblUGRSRBF+KQjqSRwijHZZ8m9W32BQz0Kni0=;
        b=ZCgutgf1jL31iG3h2Gi+QFEfFjFx5sspi/8U+3/Bh/C4JmwBaSCSj2KaG366Plqs1l
         2T84hC/gFTDgtexAsFoKZL2Q7ijmmycFNt+aX9LpwgFrvW0R5Id1Vu99kO6E1dX2VYNN
         dpMUUhATUp09l3gxYYvpo4t0VZuQ1cWaEQCJJkUJZ1oLMJPk9fz5Z6MJ10Nq3ufc9l1E
         +jVe5PDeUUKbb00D77f6ZEfRhY19oiPuc45/5eISDMGGMGQ+OhjFyPQXBcsx8wLacjTx
         dXQsjjfklKvrTuPEX7utRir1wYnsBsoKl86u9sbZ6GjQYVCzjU1hJQJJTozX/YbbI0En
         PJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIzsYNTblUGRSRBF+KQjqSRwijHZZ8m9W32BQz0Kni0=;
        b=Bylp95erH+R8MTbJRmDxUMlhPNCD8LHkslCSqYi0yZjHgrQ/SyGgelB4km2x0E1zs7
         /FgqWWkFynDuZc2sBwqSeU/LpypSd38pa/yU78Irpfh4AociC3OwdvZE+Mc2+9iBTuU2
         o7FrHAnzaVGoy+6FnPR5svfzsybuxFxYuijKKs3OvKtqSGyc9QynFYRO72rEyOSLb2R8
         9Swn8DXtuFiLn0fYJGbC7XihUdsw0um1bWnkKZNMyLPovV0IYaKmxLRiTYbKbb8l+MlQ
         7qjfV3MBEpf4WmcxAizrzSXN0WO+ljODLYNVUB4H69V2s+D263REqR6x6vJLraiODJSe
         5C2w==
X-Gm-Message-State: AOUpUlHgvlyDacWSB5H1kpXIX/hHRHGZLskup7f+Xx4UL9pa4CqJSe1G
        4TVm2VLMuw14bdqfkjVTOfM=
X-Google-Smtp-Source: AAOMgpcS6Och4ir2A5aBnn8Vt/YK2yRFiIgJzoieT7c0x/BmVmc/I4Z2XiepGvUH7NnKfu1wIgLOtA==
X-Received: by 2002:adf:f001:: with SMTP id j1-v6mr21027383wro.260.1533066504491;
        Tue, 31 Jul 2018 12:48:24 -0700 (PDT)
Received: from localhost.localdomain (p5B3F73FD.dip0.t-ipconnect.de. [91.63.115.253])
        by smtp.gmail.com with ESMTPSA id z1-v6sm2444829wmf.5.2018.07.31.12.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 12:48:23 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 2/5] pinctrl: actions: define pad control configurtion to SoC specific
Date:   Tue, 31 Jul 2018 21:47:40 +0200
Message-Id: <20180731194743.13678-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731194743.13678-1-sravanhome@gmail.com>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pad control for s900 and s700 are differs in number of
pull control configuraions
s900 has 4 pull controls - high impedence, pull up, pull down, repeater
s700, s500 has 2 pull controls - pull up and pull down

so pad control configuration has to SoC specific, moved out from pinctrl
common to s700, s900 specific.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/pinctrl/actions/pinctrl-owl.c  | 64 ++++---------------------
 drivers/pinctrl/actions/pinctrl-owl.h  | 13 +++--
 drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 4fa9cc377b3b..004bdc66e158 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -246,60 +246,6 @@ static int owl_pad_pinconf_reg(const struct owl_padinfo *info,
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
@@ -318,7 +264,10 @@ static int owl_pin_config_get(struct pinctrl_dev *pctrldev,
 
 	arg = owl_read_field(pctrl, reg, bit, width);
 
-	ret = owl_pad_pinconf_val2arg(info, param, &arg);
+	if (!pctrl->soc->padctl_val2arg)
+		return -ENOTSUPP;
+
+	ret = pctrl->soc->padctl_val2arg(info, param, &arg);
 	if (ret)
 		return ret;
 
@@ -349,7 +298,10 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
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
index 31cc33d7c4a5..dae2e8363fd5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -145,13 +145,6 @@
 		.shared_ctl_offset = _share,			\
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
@@ -305,6 +298,12 @@ struct owl_pinctrl_soc_data {
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
index 0597009d8369..2e19fecbe5e9 100644
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
 	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178, 0)
 };
 
+enum owl_pinconf_pull {
+	OWL_PINCONF_PULL_HIZ,
+	OWL_PINCONF_PULL_DOWN,
+	OWL_PINCONF_PULL_UP,
+	OWL_PINCONF_PULL_HOLD,
+};
+
+static int s900_pad_pinconf_arg2val(const struct owl_padinfo *info,
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
+static int s900_pad_pinconf_val2arg(const struct owl_padinfo *padinfo,
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
+	.padctl_arg2val = s900_pad_pinconf_arg2val,
+	.padctl_val2arg = s900_pad_pinconf_val2arg,
 };
 
 static int s900_pinctrl_probe(struct platform_device *pdev)
-- 
2.18.0

