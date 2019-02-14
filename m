Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23702229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405431AbfBNJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38129 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbfBNJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so3839681ljg.5;
        Thu, 14 Feb 2019 01:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hEaEVrQitaEiHCPJ7ev/yjepvXCaOjpNx837mbGc7U=;
        b=YlIP6nGivJh6UwM+McCAXeNuv9br/iNnVMyei3dFwEjlZrKWoDWQA7oqd+t7LDpSFl
         Bkql/r2XJ9VE1Bgsvry/FtLebZP4t0iSDPkqqkpJQLQacvzaqPi8LjCqvLZLD4+5uDdG
         ovRntoQrb76zP4RXqBskZlqif4AFwG7RjlYcMXEj/1J/M2VQYfbMEcXLJi6uJ/Ns8AJk
         tTyHIp+YG0n0In8dJoOGufbfCkl1SYl8fR1F0XTjlIj+qm3Ea36geBgCNoOZVA2aZXco
         mZGfBHUmGkQ09L8FwT6uVI2oIatqjQnVLAeh5OXM8lcNjDHOz9pIjFggsBGPmDmwL240
         Uy9Q==
X-Gm-Message-State: AHQUAubNa17B1BkfKsrBf12iIaXh/LNwk/2yHPxLSJ6KjQkOh8f1sy4r
        jG0kiT3y1iIm5EDF/zEwzOHMz4Ym
X-Google-Smtp-Source: AHgI3IZJEH+1q/krk9gzfYP1h2MgyVAi2TfyNEEGa7LKqEZJlZb1Y3HnaMEdc/WuhlFs/2FRxGwnvw==
X-Received: by 2002:a2e:9897:: with SMTP id b23-v6mr1867805ljj.142.1550137097670;
        Thu, 14 Feb 2019 01:38:17 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l27sm371280lfk.6.2019.02.14.01.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:38:17 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:38:05 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazzisaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: [PATCH v3 2/3] regulator: add
 regulator_desc_list_voltage_linear_range
Message-ID: <82443305a32c1e4b8a1ae383f5291ff544bcaf45.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
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
Acked-by: Mark Brown <broonie@kernel.org>
---

Mark, I converted your:
"This seems fine." from RFC patch v1 into acked-by. This should
be unchanged. Please let me know if that's not Ok.

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
