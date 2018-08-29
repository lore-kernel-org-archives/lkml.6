Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3419C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592812086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak4Yz3vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592812086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeH2MUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:20:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeH2MUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:20:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so4577828wmq.4;
        Wed, 29 Aug 2018 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMZGexqTlM7KHt+rw4sXqq+/NFDspsYdWBO7WcWx8AE=;
        b=ak4Yz3vMpUYwTjIr5e6mYT/0r5z9R9+kvyxpT8e2U4QjgyWxr09n7HqgdiTM8WdVkW
         CzvQ2r3pYF/46unzGyxMnDCjqvKghSKVxnf3zARVB8U+xJSA3/PvooIXmqfHMg0Zh5Vz
         ePqlOIjOmFKRMfvdrvXN7PBIlWfly+yWx5ZdqO9WDWROa7OX8vNCjovgK2MLr1yf95rV
         MG3WKwZUIrK3BhO0vf7+60tBlw1NZJm1BkCWw0kcY7y/MD9wh9XvKGDQ7F/bfXIvih8R
         1kXWEEUwDlP1Dlm0qPVeymmbJEAG05aDZGIAymss1vxTymkDhPUeHbfkv7mCexJ2X35S
         dUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMZGexqTlM7KHt+rw4sXqq+/NFDspsYdWBO7WcWx8AE=;
        b=Giu5Oo4V1ONWTxnZJV54rBi+/gVUHNrPfte6YQov78ESrlJzKHg3WM1T2I0DRp9cvW
         V0wJkYN8g3qVzh6n5ZU21ge4mZEEvH+XkgXeVtkSmVeoz1MLLbXvGb/sOfh2ys+fmtDs
         rpFjqMHd5hj7nlRurKmdyXJM/P164PHEycS0Mkwt6pKKFAF1pfOSFEhiPd0MKocEr4yQ
         I0hVy48fl1oVp3wggzMuCpi1GLIa32+naI6OM1vjFKOqbPUMsWbYINk2O3Q41EAy7Fkz
         /Cdsy9w+g9pWHzZOSc3T0O4pDB5d/zy2LrDj6/PpJtf2rmyeMBvk2PJ9sMYPcwQZb7pJ
         fQmg==
X-Gm-Message-State: APzg51BSeBhekZytUH1rFdzpPy8MhqpgDjvpHK19uGQKIcJOpxbjKget
        4HPwZ9A1INE9mfwS/TFtdSc=
X-Google-Smtp-Source: ANB0VdZ/mDvDu5Uhz/gAXG9RZIQTosCH8WApKvA+lJnozQywUcGRmT6fToYb7rbbCeqy3PmrR7F8pA==
X-Received: by 2002:a1c:752:: with SMTP id 79-v6mr3755333wmh.59.1535531072700;
        Wed, 29 Aug 2018 01:24:32 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3013025wrw.30.2018.08.29.01.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 01:24:32 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 2/5] pinctrl: actions: define pad control configurtion to SoC specific
Date:   Wed, 29 Aug 2018 10:24:10 +0200
Message-Id: <20180829082413.2512005-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829082413.2512005-1-sravanhome@gmail.com>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
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
 drivers/pinctrl/actions/pinctrl-owl.c  | 64 +++++----------------------------
 drivers/pinctrl/actions/pinctrl-owl.h  | 13 ++++---
 drivers/pinctrl/actions/pinctrl-s900.c | 66 +++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 9d18c02f192b..cc242d6a47c3 100644
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
2.14.4

