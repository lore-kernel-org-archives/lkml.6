Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA512081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gHqHAyTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA512081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbeKHCmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54850 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbeKHCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171039euoutp012424c4b3dac7d4d8de13fb9f42cd69d0~k5rVpMkdl2252222522euoutp01V
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171039euoutp012424c4b3dac7d4d8de13fb9f42cd69d0~k5rVpMkdl2252222522euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610639;
        bh=YL3IJQwlo5YNFrxIFkhGqiDAirUyPIfzICP0/e+gE7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHqHAyTmvwvpTjRB2d9fNzoB2bGyZujVoBduhem9BTmpOgmw7KVYRyMgQBInYUziX
         7CKRDs3NAhpqPxF6uXhaQC5kJ6RkuvMGFbmuNlyns+4HOpwlWiEf6JmA0cdVR+3oAZ
         ctI65kLxexHGHFzGIiV4hAMIHUJkqDseh8hTAreA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171038eucas1p292430d46f08d158b7215189ae6ca9dce~k5rU3DtQp2736727367eucas1p2P;
        Wed,  7 Nov 2018 17:10:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0D.C9.04806.E8C13EB5; Wed,  7
        Nov 2018 17:10:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171037eucas1p1b475d186830d4401b50fcd2c16781f92~k5rUKMp8M2722727227eucas1p1o;
        Wed,  7 Nov 2018 17:10:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171037eusmtrp1849f58adcee14907f134c1a1feeb8e5f~k5rT_RLFE2472724727eusmtrp1i;
        Wed,  7 Nov 2018 17:10:37 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-07-5be31c8ee8ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.23.04128.D8C13EB5; Wed,  7
        Nov 2018 17:10:37 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171036eusmtip2ca02211d4f808bc8c04f2b37a104af99~k5rTXwDg70341103411eusmtip2G;
        Wed,  7 Nov 2018 17:10:36 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 03/11] thermal: add new sysfs file for irq-mode
Date:   Wed,  7 Nov 2018 18:09:45 +0100
Message-Id: <1541610593-28542-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29k5OxtOTrP0zcxgIVSQdvHHiaKLRJwSIoIIXFCnOqk0p+44
        u0KD0qnpWiraRbdiWbnWxWVistTMtBlumqaWi24GZVjEKnWV5jyr/j3P+z6Xj5ePxBQ1eCSZ
        qsnitBpWrSRk4rq2cc8SY9Q71dLyfildc/YWTg81GxBt9s2jLa1unLb09uG0x3NbQr/QR9GO
        d1PsUu5lMd3TUEHQvqJWRFf1d4vonPutEnrojZFYF8rYzXbE3Dv/UsJYnR9FjMOWTzDePifB
        3Ll8nLEaS3DmwWeniDHW2hDjc0RvlSXJVu/j1KnZnDZuzW5ZStlvRcaV6EMDr0pxPfoJBYgk
        gYoH1+mkAiQjFdQ1BCdv5IoE8g2BodBJCMSHwHH7q6QASacdlU3u4OIqgseDVuyfpehLuSiQ
        S1CxUG/LDMxnURcQ+BqtkgDBKC+CjtKAQ0qGUQnwbKwYD2AxFQMm1zgRMMupzXDBD0JbNDx3
        50/LpVQimHtGpnOAapOAydxMCKINYLp7VizgMBhurw0+NQqelBQG5zx05tmC+mNgcNUHNavg
        YXs3HujFqEVwqyFOuMt6sFWpBRgKAyMzA2JsChbXlWPCWA55uQohYyHUFnaJBBwOV+1lwWwG
        Ks9M4MJ1zAg++drEJjT//P+uiwjZUASn49OSOX6FhjsYy7NpvE6THLs3Pc2Bpj7Sk4n27/Wo
        8deeFkSRSBki77r7RqXA2Wz+cFoLAhJTzpIXXX+rUsj3sYePcNr0XVqdmuNb0FxSrIyQH53x
        WqWgktks7gDHZXDav1sRKY3Uo+pMiTs+yx23acG5lW87H2WG+ge3fxntSfxRcSJnZcmWpaUG
        3uwPbfJa9tfPLg033czxeX4lSGQZO73VZHdKzVhI2+jG3o5tvo7OD0bK73rv8kzy8XdeqXWP
        9SOeU3VhCk30Amx5MmufczCmw2DChyc3u5+uTTd/Y3ft+OlosCjFfAq7bDGm5dk/fmWI8UQD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7q9Mo+jDS5/k7TYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFufPb2C3uNUgY7HpMZC3sG0Ji8XlXXPYLD73HmG0WHr9IpNF694j
        7BZPHvaxOfB5rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUeyzum8zqcfDdHiaPvi2r
        GD0+b5IL4IrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy5j2V6hgmVzFjftTWBsYf0t0MXJySAiYSMzdf46ti5GLQ0hgKaPEh/Yr7BAJMYlJ+7ZD
        2cISf651QRV9YpTY9v8gSxcjBwebgJ7EjlWFIHERgfmMEkc3XQYrYhZ4xiixcvpLJpBuYQEn
        ias/JrGC2CwCqhITTv5kA2nmFfCSmP0L6go5iZvnOplBbE4Bb4l5l9+CLRYCKvk+az3bBEa+
        BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKjZNuxn1t2MHa9Cz7EKMDBqMTDq7HjYbQQ
        a2JZcWXuIUYJDmYlEd7e1Y+ihXhTEiurUovy44tKc1KLDzGaAt00kVlKNDkfGMF5JfGGpobm
        FpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoYr6pm3I/docDx/6PSugf6R/+5
        vlk35cskxu4X0f9/fy+88IpJxuv43KN6d2fZhwXeKunZ1sYm+nm59lkt5z5LIdm1d9tuhbit
        9RGzLZhxPfb6mj0rfX/01+wKCP8/SXhTxqfVMzvE7ZI/rZa4VO3Mu+fhzE3VP1Jc607yb/U1
        WTB1/+flYstMdiixFGckGmoxFxUnAgDx6PwnqAIAAA==
X-CMS-MailID: 20181107171037eucas1p1b475d186830d4401b50fcd2c16781f92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171037eucas1p1b475d186830d4401b50fcd2c16781f92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171037eucas1p1b475d186830d4401b50fcd2c16781f92
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171037eucas1p1b475d186830d4401b50fcd2c16781f92@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds show functions for irq-mode feature.
It allocates new attributes and extends the old list.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/thermal_sysfs.c | 53 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..372b439 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -21,6 +21,8 @@
 
 #include "thermal_core.h"
 
+#define TRIP_ATTR_NUM 4
+
 /* sys I/F for thermal zone */
 
 static ssize_t
@@ -167,6 +169,28 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_irq_mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	bool mode;
+
+	if (!tz->ops->get_trip_irq_mode)
+		return -EPERM;
+
+	if (sscanf(attr->attr.name, "trip_point_%d_irq", &trip) != 1)
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_irq_mode(tz, trip, &mode);
+
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", mode);
+}
+
+static ssize_t
 trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
@@ -520,10 +544,19 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
+	tz->trip_irq_mode_attrs = kcalloc(tz->trips,
+					  sizeof(*tz->trip_irq_mode_attrs),
+					  GFP_KERNEL);
+	if (!tz->trip_irq_mode_attrs) {
+		kfree(tz->trip_type_attrs);
+		return -ENOMEM;
+	}
+
 	tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_irq_mode_attrs);
 		return -ENOMEM;
 	}
 
@@ -533,14 +566,17 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 					      GFP_KERNEL);
 		if (!tz->trip_hyst_attrs) {
 			kfree(tz->trip_type_attrs);
+			kfree(tz->trip_irq_mode_attrs);
 			kfree(tz->trip_temp_attrs);
 			return -ENOMEM;
 		}
 	}
 
-	attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
+	attrs = kcalloc(tz->trips * TRIP_ATTR_NUM + 1, sizeof(*attrs),
+			GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_irq_mode_attrs);
 		kfree(tz->trip_temp_attrs);
 		if (tz->ops->get_trip_hyst)
 			kfree(tz->trip_hyst_attrs);
@@ -559,6 +595,19 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
 		attrs[indx] = &tz->trip_type_attrs[indx].attr.attr;
 
+		/* create trip irq_mode attribute */
+		snprintf(tz->trip_irq_mode_attrs[indx].name,
+			 THERMAL_NAME_LENGTH, "trip_point_%d_irq", indx);
+
+		sysfs_attr_init(&tz->trip_irq_mode_attrs[indx].attr.attr);
+		tz->trip_irq_mode_attrs[indx].attr.attr.name =
+			tz->trip_irq_mode_attrs[indx].name;
+		tz->trip_irq_mode_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_irq_mode_attrs[indx].attr.show =
+			trip_point_irq_mode_show;
+		attrs[indx + tz->trips * 3] =
+			&tz->trip_irq_mode_attrs[indx].attr.attr;
+
 		/* create trip temp attribute */
 		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_temp", indx);
@@ -595,7 +644,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		attrs[indx + tz->trips * 2] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	attrs[tz->trips * 3] = NULL;
+	attrs[tz->trips * TRIP_ATTR_NUM] = NULL;
 
 	tz->trips_attribute_group.attrs = attrs;
 
-- 
2.7.4

