Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85904C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C9222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391357AbfBMJul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:50:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42920 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:50:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so1258362lfh.9;
        Wed, 13 Feb 2019 01:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vby/KXk/K2ZPiHebL7irRKAaE1+p4RLHAkNGPjfVtaY=;
        b=ApgshUCYZu8mzs4V2GnZNN0fCievpjIFnIWy4Lik0lUHmnlcnRlLXKhFMw1prH+IJI
         hvWVaBQduMMlvlB7oLNXXTc+QIWfGuEEm7JxI/2p8RePLWDhxBPIySvdZdtz8AG4HTV7
         8ukvMJRZ0np9nAloHFy5krG80RdJkV4evwBBvB1O0Qw6losiJPxj4nDkFb5GOc1nUvKd
         65HII09Whu8AeaSub1DWEnWHC8fzZi3kx4UZgxMYdPXkoWwqKC2eTjqZMrix94mOiabo
         ujjOyuJDTTgtS5aq+V3P0K4K2N4QuzDCD8N74bO3eH/2uMKTM9N9bBo6uwQpbJqVhZY+
         cEGg==
X-Gm-Message-State: AHQUAubeOPy2q2H9WiN7BaOeLDzBAbdN29OMMrSE0Dgcko0wdlzpNaie
        wZ0jueqwQvd9miHp7fzikpE=
X-Google-Smtp-Source: AHgI3IZACV2qflHmPDmoDsRXazAnkLZ6GPVxjUhtE0WrQuD2jl21kJqXopOCqlxuAvU2AhkPNWTh7A==
X-Received: by 2002:a19:f517:: with SMTP id j23mr4335583lfb.118.1550051438822;
        Wed, 13 Feb 2019 01:50:38 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m191sm3661956lfe.92.2019.02.13.01.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:50:38 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:50:26 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Robin Gong =?utf-8?B?4oCO?= <yibin.gong@nxp.com>,
        Elven Wang =?utf-8?B?4oCO?= <elven.wang@nxp.com>,
        Anson Huang =?utf-8?B?4oCO?= <anson.huang@nxp.com>
Subject: [PATCH v2 2/3] regulator: add
 regulator_desc_list_voltage_linear_range
Message-ID: <18b84e8a85b3ba9464dd145233122444c3f9e5eb.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator_desc_list_voltage_linear_range which can be used
by drivers for getting the voltages before regulator is registered.
This may be useful for drivers which need to fetch the voltage
selectors at device-tree parsing callback.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/helpers.c      | 39 +++++++++++++++++++++++++++++----------
 include/linux/regulator/driver.h |  6 ++++++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 5686a1335bd3..68ac6017ef28 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -594,28 +594,30 @@ int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
 EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
 
 /**
- * regulator_list_voltage_linear_range - List voltages for linear ranges
+ * regulator_desc_list_voltage_linear_range - List voltages for linear ranges
  *
- * @rdev: Regulator device
+ * @desc: Regulator desc for regulator which volatges are to be listed
  * @selector: Selector to convert into a voltage
  *
  * Regulators with a series of simple linear mappings between voltages
- * and selectors can set linear_ranges in the regulator descriptor and
- * then use this function as their list_voltage() operation,
+ * and selectors who have set linear_ranges in the regulator descriptor
+ * can use this function prior regulator registration to list voltages.
+ * This is useful when voltages need to be listed during device-tree
+ * parsing.
  */
-int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
-					unsigned int selector)
+int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
+					     unsigned int selector)
 {
 	const struct regulator_linear_range *range;
 	int i;
 
-	if (!rdev->desc->n_linear_ranges) {
-		BUG_ON(!rdev->desc->n_linear_ranges);
+	if (!desc->n_linear_ranges) {
+		BUG_ON(!desc->n_linear_ranges);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
-		range = &rdev->desc->linear_ranges[i];
+	for (i = 0; i < desc->n_linear_ranges; i++) {
+		range = &desc->linear_ranges[i];
 
 		if (!(selector >= range->min_sel &&
 		      selector <= range->max_sel))
@@ -628,6 +630,23 @@ int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(regulator_desc_list_voltage_linear_range);
+
+/**
+ * regulator_list_voltage_linear_range - List voltages for linear ranges
+ *
+ * @rdev: Regulator device
+ * @selector: Selector to convert into a voltage
+ *
+ * Regulators with a series of simple linear mappings between voltages
+ * and selectors can set linear_ranges in the regulator descriptor and
+ * then use this function as their list_voltage() operation,
+ */
+int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
+					unsigned int selector)
+{
+	return regulator_desc_list_voltage_linear_range(rdev->desc, selector);
+}
 EXPORT_SYMBOL_GPL(regulator_list_voltage_linear_range);
 
 /**
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7f8345bff4e1..05efe2b057c1 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -539,4 +539,10 @@ void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 void regulator_lock(struct regulator_dev *rdev);
 void regulator_unlock(struct regulator_dev *rdev);
 
+/*
+ * Helper functions intended to be used by regulator drivers prior registering
+ * their regulators.
+ */
+int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
+					     unsigned int selector);
 #endif
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
