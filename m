Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77389C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1E820882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QwkMHfh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1E820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbeKHClz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:41:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54830 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbeKHCly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171037euoutp01df8d23cb9c6b86169655fcd031083910~k5rUSUyYT2205222052euoutp01t
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171037euoutp01df8d23cb9c6b86169655fcd031083910~k5rUSUyYT2205222052euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610637;
        bh=u3OQdIwMyDulwJrM1Yhs34QsfCPeLNuMuxOJylx/rhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwkMHfh7E8o/rT/KNf5gCPjlVLquhIZXsSd1EN9tnZg26uzOrA1RYkojlGQI4+q8/
         naRVj2hUaObvqmZAKLWHQhZ20Qst/cUkt2tRP5Dz1zb54xtRVJKE62Qg+CQp3VZjdb
         Uo+pb/qsHDNPOYL4kma+OUESt+M0dHZcWAx2swrY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171037eucas1p2a19a258c027e4f024cef2b47e5bc14de~k5rTnaiyh2801828018eucas1p2I;
        Wed,  7 Nov 2018 17:10:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.E9.04441.C8C13EB5; Wed,  7
        Nov 2018 17:10:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171036eucas1p13253d56b463c8f888ab8f8e418635297~k5rSx-a-s3085730857eucas1p1S;
        Wed,  7 Nov 2018 17:10:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171036eusmtrp19c67006b1d472036080cd065805b8d20~k5rSmJCax2472724727eusmtrp1g;
        Wed,  7 Nov 2018 17:10:36 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-69-5be31c8ce940
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.23.04128.B8C13EB5; Wed,  7
        Nov 2018 17:10:35 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171035eusmtip25b9724e8357b9e5dedf609decfb222dd~k5rSCDuMI0120301203eusmtip2k;
        Wed,  7 Nov 2018 17:10:35 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 02/11] thermal: add irq-mode configuration for trip point
Date:   Wed,  7 Nov 2018 18:09:44 +0100
Message-Id: <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7o9Mo+jDS7PM7LYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFufPb2C3uNUgY7HpMZC3sG0Ji8XlXXPYLD73HmG0WHr9IpNF694j
        7BZPHvaxOfB5rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUeyzum8zqcfDdHiaPvi2r
        GD0+b5IL4IrisklJzcksSy3St0vgytjf+J+pYK9KRdvPZawNjNPluhg5OSQETCQOXTnK1MXI
        xSEksIJRYt2+PWwQzhdGicfts9khnM+MEpPXPmWHadn46BtU1XJGiZb3yxFamndeZuli5OBg
        E9CT2LGqECQuIjCbUeLzvsVgo5gF7jBKnJqymBlklLCAj0TPlduMIDaLgKrE7Tdr2UBsXgEv
        ibnrPkCtk5O4ea4TrJ5TwFti3uW3YIMkBA6xS8xtfMQIUeQiMe9zLyuELSzx6vgWqGYZidOT
        e1gg7GKJsx2r2CDsGon2kzugaqwlDh+/yApyNbOApsT6XfoQYUeJG8cOs4OEJQT4JG68FQQJ
        MwOZk7ZNZ4YI80p0tAlBVGtIbOm5wARhi0ksXzMNariHROeHM9DwmccoMf/ha9YJjPKzEJYt
        YGRcxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZiYTv87/mkH49dLSYcYBTgYlXh4L2x9
        GC3EmlhWXJl7iFGCg1lJhLd39aNoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tS
        s1NTC1KLYLJMHJxSDYxz7zfef6Vr8sRV12jRBmYFxT0vZZ8e9V2s/dpszfT/cRd/CsdUH7W7
        djN9Z++y1A3vTB/MXLiNq6nKz1Ay0jZQUMz24pZP0/b3bNpzyVgxR1ebM1TKMjvt8EKHoCc2
        3bcMmq8KKBs+vMzxKvvQl5hb6V779062jjkrNv1F4ISKXXw/RC7z9SQosRRnJBpqMRcVJwIA
        l/1JKUgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rdMo+jDdbMsLHYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFufPb2C3uNUgY7HpMZC3sG0Ji8XlXXPYLD73HmG0WHr9IpNF694j
        7BZPHvaxOfB5rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUeyzum8zqcfDdHiaPvi2r
        GD0+b5IL4IrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy9jf+J+pYK9KRdvPZawNjNPluhg5OSQETCQ2PvrG1sXIxSEksJRRYumKXWwQCTGJSfu2
        s0PYwhJ/rnVBFX1ilFj9vB8owcHBJqAnsWNVIUhcRGA+o8TRTZfBipgFnjFKrJz+kgmkW1jA
        R6Lnym1GEJtFQFXi9pu1YBt4Bbwk5q77ALVBTuLmuU5mEJtTwFti3uW3YHEhoJrvs9azTWDk
        W8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwUrYd+7llB2PXu+BDjAIcjEo8vBo7HkYL
        sSaWFVfmHmKU4GBWEuHtXf0oWog3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPzgVGcVxJvaGpo
        bmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBMWf7gVkex46a1lU+NfotvH/G
        mfL6kx9/3ZnL6MO1/vXq6yUtN70SIg5WKRssz55x+L5EU1TKzH8n129x/NOo92ojp36wJy/v
        K0GjCp3wOeU8lUt8/C98LHjHdGzRxN0n2ybYH7x3M9mg/oXtFQ+FzFI1wZMdsuVhh9nDtZKL
        bmfcChNQEZ0bocRSnJFoqMVcVJwIANf16OmqAgAA
X-CMS-MailID: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support irq mode in trip point.
When that flag is set in DT, there is no need for polling
in thermal framework. Crossing the trip point will rise an IRQ.
The naming convention for tip point 'type' can be confussing
and 'passive' (whic is passive cooling) might be interpretted wrongly.

This mechanism prevents from missue and adds explicit setting
for hardware which support interrupts for pre-configured temperature
threshold.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
 drivers/thermal/thermal_core.c | 10 ++++++++--
 include/linux/thermal.h        |  5 +++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a..1a75946a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
+static int
+of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz, int trip,
+			     bool *mode)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return -EDOM;
+
+	*mode = data->trips[trip].irq_mode;
+
+	return 0;
+}
+
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int *temp)
 {
@@ -394,6 +408,7 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 	.set_mode = of_thermal_set_mode,
 
 	.get_trip_type = of_thermal_get_trip_type,
+	.get_trip_irq_mode = of_thermal_get_trip_irq_mode,
 	.get_trip_temp = of_thermal_get_trip_temp,
 	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
@@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
+	trip->irq_mode = of_property_read_bool(np, "irq-mode");
+
 	/* Required for cooling map matching */
 	trip->np = np;
 	of_node_get(np);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 39fc812..6d41e08 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -406,6 +406,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	bool irq_mode = false;
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
@@ -419,9 +420,14 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_non_critical_trips(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
+	 * So, start monitoring in polling mode if
+	 * trip is not using irq HW support.
 	 */
-	monitor_thermal_zone(tz);
+	if (tz->ops->get_trip_irq_mode)
+		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
+
+	if (!irq_mode)
+		monitor_thermal_zone(tz);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f..b064565 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
 		enum thermal_device_mode);
 	int (*get_trip_type) (struct thermal_zone_device *, int,
 		enum thermal_trip_type *);
+	int (*get_trip_irq_mode) (struct thermal_zone_device *, int, bool *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
 	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
@@ -196,6 +197,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
+	struct thermal_attr *trip_irq_mode_attrs;
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
@@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @irq_mode: to not use polling in framework set support of HW irq (which will
+ *	      be triggered when temperature reaches this level).
  */
 
 struct thermal_trip {
@@ -371,6 +375,7 @@ struct thermal_trip {
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
+	bool irq_mode;
 };
 
 /* Function declarations */
-- 
2.7.4

