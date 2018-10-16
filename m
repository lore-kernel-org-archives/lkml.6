Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7070FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386CA20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o4nqu/Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386CA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJPWrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39254 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeJPWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145644euoutp0267d52dea68ca3f1318fade82fa7d2356~eHqIxX7my0414504145euoutp02g
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145644euoutp0267d52dea68ca3f1318fade82fa7d2356~eHqIxX7my0414504145euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701804;
        bh=ZaON51JdJUOdRku3RBbdEjVhfEGCUlhxysvABCFT0aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4nqu/UdlHVcFVXjVp5JZGJ4+fy+CiTUOWlOkdPgd34YYk9j3OjEh4n51wVQFsugE
         oefnaxUQFc/xH34OseqdsCibylPScsuv0kI4Y8Eb8WDctCnhV+98edckyL9FYQVvq8
         Id6x82s6v9UYEf2i2gbJoBy4dzfc6RAk14+pRl+A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145643eucas1p20b76fcfe67c67680ebf1ec88c18222cb~eHqH3OWhp0771207712eucas1p2l;
        Tue, 16 Oct 2018 14:56:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.C2.04441.B2CF5CB5; Tue, 16
        Oct 2018 15:56:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8~eHqHE9TOU2133821338eucas1p2M;
        Tue, 16 Oct 2018 14:56:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016145642eusmtrp1d3c59afc722ee70e20b7a75b0fed2106~eHqG2E-DX1176711767eusmtrp1z;
        Tue, 16 Oct 2018 14:56:42 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c3-5bc5fc2b2857
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.D9.04284.A2CF5CB5; Tue, 16
        Oct 2018 15:56:42 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145641eusmtip23d41a8d2e82508875a1544c042728100~eHqGUckWn2834528345eusmtip2B;
        Tue, 16 Oct 2018 14:56:41 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 02/11] thermal: add irq-mode configuration for trip point
Date:   Tue, 16 Oct 2018 16:56:13 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHeXZ3766j2XVKPvgWrYRM0izDS4kZ9OFKSAV+qX3IpZcp6dRd
        NTWhle9illkavszZZtbQpuY700pnU3xfoUuttCwxNNAVLQrLeWd9+53/Of//OTw8OCJsQt3w
        WFkyLZdJ4kQYn9v+8uf4Qd/fA+JDbR0E2Xxfh5KLz/MAqbR4kjWGMZSseT2FkjMKD7Ll4ybU
        5mq45KvuKoy03DQAsm56kkPm9Bh45OJCMRYqoBqUDYDqqnjLo9T6ZQ7Voi3AqLkpPUY91Vyj
        1MWlKPXiq55DFbdqAWVp8TrLv8APjqbjYlNpuX9IJD9mdukXL7FnX9rgHxWiAOVehcABh0Qg
        VG1sgELAx4XEIwCzRucQtvgG4EC11l5YAGzsGuRuW7J7Z7lsox5AlUkD/lmMmjZeIcBxjPCD
        ndokm+5CVAJo6VXzbAVCDAE4U9/OsUU5E2Ewbz5ni7mEN2y9vmpf4QXfjBUgNnYgTsMZs2rr
        Dkj08uDK0AKwNQREKhx5vI6yhlPQaG60szP8YmzlsewBh0uL7KEMHM3XYixnwryhTvvMcdhv
        nERtVyOED9R1+7PySWidbOLYZEg4QvOqk01GNvFOeznCygKYnytkp/fD1qIJDsu7YH1DmT2c
        gjfKrBj7PkoAc9Rl2G2wu+L/MhUAWuBKpzDxUpoJkNFX/BhJPJMik/pFJcS3gM1/NLxhXO8E
        302X+gCBA9EOgXXaIBaiklQmPb4PQBwRuQikpgGxUBAtSc+g5QkX5SlxNNMH3HGuyFXwUNks
        FhJSSTJ9maYTafl2l4M7uClA5ODyZPWJY2v3onqOdnvuPH8mSdcR5vSgZNzt6tJdUbg1aSWk
        tv5cWqKPy3wNGhqkf8e9FamOiAx2RNBza5UZR6TKZ0/qGoRVI8oIUxlnT5bvB2/is3v2p87g
        ufC9E4f7rSUbuh8Zsve5Or0qej2z2ig3KwLVliV1jCio1OA3IeIyMZKAA4ickfwFn0tuDkMD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7paf45GG6x7LW2xccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLW41yFhsegxkLGxbwmJxedccNovPvUcYLZZev8hk0br3CLvFk4d9
        bA68HmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6L+yazehx8t4fJo2/LKkaPz5vk
        Arii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJu
        P//NXrBXpeLE/wXMDYzT5boYOTkkBEwkWvbdZgGxhQSWMkp878yEiItJTNq3nR3CFpb4c62L
        rYuRC6jmE6PEvY8LWbsYOTjYBPQkdqwqBImLCMxnlDi66TJYEbPAZUaJ7ml7wLqFBTwl2h+0
        MoHYLAKqElsa34Jt4xXwkth8/z8LxAY5iZvnOplBbE4Bb4lbNxYwgywQAqq5uJhxAiPfAkaG
        VYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGxse3Yz807GC9tDD7EKMDBqMTD++P6kWgh1sSy
        4srcQ4wSHMxKIrzpl45GC/GmJFZWpRblxxeV5qQWH2I0BbppIrOUaHI+MG7zSuINTQ3NLSwN
        zY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwGrrobxB/5pLzP6N3n813Kb/bjBEv
        pT6kzw+R2/CUPZMr6Pil8GvsR648C3KKT+c+o+bivFiPq3dRVPuyl46u7z/an3talCv80Fro
        Yfbyjz2ez5Im+Sc3dNQqpl48/EJcseV+Fmt1b991Nu0fWkqftXRVj4Te3+du9vSQjlbQp38X
        Zm8Pf3xSiaU4I9FQi7moOBEAmv4XAKMCAAA=
Message-Id: <20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8~eHqHE9TOU2133821338eucas1p2M@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145642eucas1p2d3cfc208d3f401bfe662d6df071cc3b8@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support irq mode in trip point.
When that flag is set in DT, there is no need for polling
int thermal framework. Crossing the trip point will rise an irq.
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
index 4f28165..db0942a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -289,6 +289,20 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
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
@@ -371,6 +385,7 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 	.set_mode = of_thermal_set_mode,
 
 	.get_trip_type = of_thermal_get_trip_type,
+	.get_trip_irq_mode = of_thermal_get_trip_irq_mode,
 	.get_trip_temp = of_thermal_get_trip_temp,
 	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
@@ -779,6 +794,8 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
+	trip->irq_mode = of_property_read_bool(np, "irq-mode");
+
 	/* Required for cooling map matching */
 	trip->np = np;
 	of_node_get(np);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2c6d72a..f569532 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -404,6 +404,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	bool irq_mode = false;
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
@@ -417,9 +418,14 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
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

