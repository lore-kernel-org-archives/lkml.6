Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F955C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F819205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dl51satm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F819205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJPWsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:48:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39262 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeJPWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145645euoutp02330ff82909d365488a816b1ddd4f6930~eHqJwjFTB0360503605euoutp028
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145645euoutp02330ff82909d365488a816b1ddd4f6930~eHqJwjFTB0360503605euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701805;
        bh=YL3IJQwlo5YNFrxIFkhGqiDAirUyPIfzICP0/e+gE7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dl51satmR1c3w+yAdbiNRmZgcA3uNndkqCTcuY867OOOoqn3Un7413tSX/VCNZ7DO
         0DS0K8HHRuuvgL3LmWxapMBqptDCknB/kphkw8J46NhkvyYwJwxc106VwFic2b3wwV
         q9fPDOe+SeBUFtvjBwgBNTEjNAol+Ju8nBb216Dg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016145644eucas1p1ebaa178971e16d75ece84cba3035817a~eHqJDSr863104931049eucas1p1k;
        Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.21.04806.C2CF5CB5; Tue, 16
        Oct 2018 15:56:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145644eucas1p2755acef5196e01799d5704fac9766547~eHqIWySvH0770707707eucas1p2z;
        Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016145643eusmtrp18e14c3b9e80dd8c900577fdbfa20e6fe~eHqICmBmk1176711767eusmtrp12;
        Tue, 16 Oct 2018 14:56:43 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-81-5bc5fc2c8184
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.D9.04284.B2CF5CB5; Tue, 16
        Oct 2018 15:56:43 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145643eusmtip203b1a7dcf3f34716276b899e65d7f1d3~eHqHeJKpU2834528345eusmtip2D;
        Tue, 16 Oct 2018 14:56:43 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 03/11] thermal: add new sysfs file for irq-mode
Date:   Tue, 16 Oct 2018 16:56:14 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxVcRjH97vnnnuPO1fHIZ55rdustKKmP86qVVZbZ6LZxMIfujhheese
        lNakP7wOWUSoi7zuzmZedkNcb1felryNSxKRllGrmy2Rch3Vf5/n+3yflz17CIyqwa2IsMgY
        VhEpD5eJJEL1y/XXR49s9vgfezDjQNc9rsXpxY4URCv1tnSxdgini8cncHo60YauX9iG0uRy
        IT3W8kRE6zO1iK6YHBHQSW1aMb04nyU6J2VqlDWIaS58K2bKWj8JmHpVmoiZmWgVMQ3l95iy
        rByc6fzcKmCyGlWI0dfbeUr8JKeD2fCwOFbhfOaaJDTvFxVdaXdb9y4XT0QbkI4IAsgTsNHo
        l44kBEVWI3gzt4T44DsC3eRHIR/oEfRVr2HpyGinom1iS8QnqhBUFk5i/0oyf5aJDX1FpBM0
        qW4adHOyCIFeY9AlBEb2I5iuUgsMrczIszC2Pis0sJB0gJV8XgfSDqaG0nbGGZGXYFpXsjMB
        SI0YljsLcENCSsbBYP7YbsEFGHw2IOLZDJZ7G8U828BgToaQZw5epap2PXchpb9p13MKuntH
        cMPWGOkItS3O/GFcYUpD8WgCulVTgxnbxofqfIyXpZCaTPE9DkFjxvDuLhZQVZMn5i0MDIwm
        8NdRImgb6MaykX3h/1ElCKmQJRvLRYSwnEske8uJk0dwsZEhTkFREfVo+4cGt3rXmpBmM7AL
        kQSSGUt/TGr9KVwex8VHdCEgMJm5NGS0x5+SBsvj77CKqABFbDjLdSFrQiizlFYq6/wpMkQe
        w95g2WhW8TcrIIysEpFgfPiKm/eBxYzcPftKV4wfXbetnffivsYV+3ywwkejXsxdNvPYWrpo
        49KQd3I2pj1oUxPskemli5Y9FSyj4VCLBeXvaecYx299FYpoU1/v/dYJTyHA0fP56lW3qTEf
        9/fGgfezC1zdM+zbeyt9E6jmQAv13kTXIpPz6o4v4+tJB2VCLlR+/DCm4OR/AMx1tSE/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7raf45GG0xapmWxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLW41yFhsegxkLGxbwmJxedccNovPvUcYLZZev8hk0br3CLvFk4d9
        bA68HmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6L+yazehx8t4fJo2/LKkaPz5vk
        Arii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKm
        /RUqWCZXceP+FNYGxt8SXYycHBICJhJ7r/1j62Lk4hASWMoo0fl+NzNEQkxi0r7t7BC2sMSf
        a11QRZ8YJdq+LWfsYuTgYBPQk9ixqhAkLiIwn1Hi6KbLYEXMApcZJbqn7QHrFhawl7j88x4L
        iM0ioCrxZvo2JhCbV8BLYvn1SYwQG+Qkbp7rBNvMKeAtcevGAmaQBUJANRcXM05g5FvAyLCK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMDa2Hfu5eQfjpY3BhxgFOBiVeHh/XD8SLcSaWFZc
        mXuIUYKDWUmEN/3S0Wgh3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgfGbV5JvKGpobmFpaG5
        sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkZHxp578lorgubryc8wP2b+wSFu/YzJ
        js7zVvg/nDuVa6V2Z8LkY7P4K+xZ9uWd9nQ76J7+fbWp/eZJRgv/NB2zPBR1g/GPFHtTulzs
        9V5ZBf/3VTt+CNzNXlzTcaGVZ2/T65afrY5zClV+Ven1PDn56PwOy7/R7/ZfO7o+0P/KxU9B
        Jv4XVeKVWIozEg21mIuKEwFlciBYowIAAA==
Message-Id: <20181016145644eucas1p2755acef5196e01799d5704fac9766547~eHqIWySvH0770707707eucas1p2z@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145644eucas1p2755acef5196e01799d5704fac9766547
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145644eucas1p2755acef5196e01799d5704fac9766547
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145644eucas1p2755acef5196e01799d5704fac9766547
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145644eucas1p2755acef5196e01799d5704fac9766547@eucas1p2.samsung.com>
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

