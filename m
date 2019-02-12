Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5417F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfBLOTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:19:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40892 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:19:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id t14so2122901lfk.7;
        Tue, 12 Feb 2019 06:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KShAM9K0RbgiOLSm3iC6zYpIfcFPVOIEak+23MAnTmA=;
        b=U2Zt4YVXDP69kdm42WyiKaN1Otagl7UqeasDUYS1pY052MYgDJg4JJ7kcD59GpBZXu
         YkiT50fi8Ja9NTllE9EJpXVz90l5TuVtnU3DWHdjWY+7j/x+3ojQJ2zWN78usiIm6tB2
         akdvkSRJwrB2oCqdzqqctym2FbyU0Kmmmqkonv2tBvBQTlRr9H5M5pxz2PmWlu6RtfbA
         d+zmUSSz4bL5grfKUoCflGWVsEo+TPfdgSGa4B/T2QuqxW3dSMsZbUQGFrxJGYbS/QSS
         2FMHko4q/K53kgTjnmn5AUJKGSm8f23SezcR8e5YnJtWf1KfJ0IOLxnE2usJHlS8s1BP
         mdng==
X-Gm-Message-State: AHQUAubQbsilHrdnOX3IInjYsf85zaxBFdUSArcprIQMm/WCJfcOaQ8l
        4UbjcU7K+dd4Oscg1IYmrRw=
X-Google-Smtp-Source: AHgI3IZ6diLqI0OysBUMB6wssgmCcSG2+3ykjdpT2AxUML/B3T2S3DuI5HaMyG/v+csctzPq6G7REg==
X-Received: by 2002:a19:6806:: with SMTP id d6mr2571782lfc.48.1549981139017;
        Tue, 12 Feb 2019 06:18:59 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p21sm2970755lfd.4.2019.02.12.06.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:18:58 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:18:46 +0200
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
Subject: [RFC PATCH v1 2/3] regulator: add
 regulator_desc_list_voltage_linear_range
Message-ID: <b07e501c84c77c59f0a2a67c43576373a140f10f.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
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

Please not apply as such. This is compile-tested only and sent
for collecting feedback. If idea is Ok I will do proper testing
and send a non RFC patch.

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
