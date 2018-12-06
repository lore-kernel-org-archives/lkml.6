Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF69C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D694321479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PqDWW3yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D694321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLFTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56152 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeLFTSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:18:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181206191852euoutp0116adbd85d0e6e896fe5cc2249ccb4af5~t1Ij9aIRJ3009330093euoutp01Y
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 19:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181206191852euoutp0116adbd85d0e6e896fe5cc2249ccb4af5~t1Ij9aIRJ3009330093euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544123932;
        bh=Cfo2FZpUqDbKqKH9MnfZkSnSDIOe6Omv8v04bMROTLo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PqDWW3yErPeTEPBngPiXcPubBrNhgkAnyBUppxE0AKc/xQpIszIyBzW+hpsMnP1Zw
         YlCM7MR47SldvdQecUnCMNJDzNWO4VA8XQ38FuGWHFoQppo0Ib/1vYUb86nFUOsf+I
         sXoG/co2q2k2x1AuJektNEcRdyG6iwQNUQ4uX9yA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206191850eucas1p2f7a8aadf4e78a436601be81c9c1510b7~t1IiNv0Wz2829628296eucas1p2o;
        Thu,  6 Dec 2018 19:18:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.33.04806.916790C5; Thu,  6
        Dec 2018 19:18:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181206191848eucas1p1d07a1e8d0bf86fddcdde5905cb1c4188~t1IhBuM2k1940619406eucas1p1k;
        Thu,  6 Dec 2018 19:18:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181206191848eusmtrp260913c44d7c99d69c719a035987be6e8~t1Igy8aEC2847028470eusmtrp2L;
        Thu,  6 Dec 2018 19:18:48 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-15-5c0976195f2d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D7.CC.04128.816790C5; Thu,  6
        Dec 2018 19:18:48 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181206191847eusmtip1355fa5fb4af9da01a315a47e05797ab3~t1IgE3zNM3262032620eusmtip1l;
        Thu,  6 Dec 2018 19:18:47 +0000 (GMT)
Subject: Re: [PATCH v2 02/11] thermal: add irq-mode configuration for trip
 point
To:     Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <2ac425fc-7c32-6e2f-7086-c14f85b0bbfd@partner.samsung.com>
Date:   Thu, 6 Dec 2018 20:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544022595.2841.45.camel@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3ZfJ928TcuTZcmw1EjNErq9YEkRlz5E1IfEolx5cZJv7fpa
        gfamTspeFpWzXKUyWYJlZrM0xK2WlS3JTFPJagSafslEhaXteo389jv/83+e8z9waEzVQ/jT
        SakZgi5Vk6wmvfCGl5POsCVZyoNrT09v4B7erCU4V0sh4spHAziT/R3BmTq7CM7pfEBxdd89
        dLegEuc+PL1FcqMX7Yir+tSh4M432ynO9bWE3MbwNeU1iG809lN8RdOggq+z6Em+r6uJ5B9V
        5vEVJQaCL6m3IH60bvkeZZzXlgQhOSlL0EVEx3tpm9oH8fT8dTk1r+7h+WgypBgpaWCjoPmO
        gZBYxVYjsLvxYuTl4d8Iqg02hVyMIqi0XyT+vXgxrsfkhhmB2T1BycUIAkf5A0xy+bB7obd7
        jJTYl21C4BxfI5kwtgxBsfm251+aJtlwsFqOSx6G3QkFwyMzfpwNgnaHhZJ4ERsLRV/uk7Jn
        IbSVunCJlWwkDE6ZZhJhrB98dpkUMq+As4/LZtIB+4cCm7WNkmPvgIHWCoXMPjDkqJ/Vl8F0
        o2lWF6G9yELKfAoK26yzns1gc3QQUmaMDYXapxGyHAPdL22UJAO7ALpHFsoRFsDVhhuYLDNQ
        VKCS3SFQf+H97KDFYK65Tl1GauOcxYxzljHOWcb4f+4dhFuQn5AppiQK4vpUITtc1KSImamJ
        4UfTUuqQ5+DeTDnGrOi5+0grYmmkns/kbFMeVBGaLDE3pRUBjal9GZ3WIzEJmtwTgi7tsC4z
        WRBb0VIaV/sxJ+cNHFCxiZoM4ZggpAu6f10FrfTPR9rOKz+sG0OCA8fCVkbH66ciep+N+27X
        uOP3Heu4lrHq3c/hsLjd8XsmLFtXPIs6N0RVX9J/M3zcZXAmtT2x1bZseh3IFBL8Y3NsQ1Vp
        fnFY7IuAir7+66EufYn+LaMOntj/sOha3rLtMd49QQfK3//al/Zh3l7vvDNuxY5DgqMqW6vG
        Ra0mcjWmEzV/AWeJjXNsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7oSZZwxBrvXSllsnLGe1eLJgXZG
        i3mfZS3mHznHajH/yjVWi/PnN7BbbHoMZC1sW8JicXnXHDaLz71HGC2WXr/IZNG69wi7xZOH
        fWwOvB5r5q1h9Ng56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUei/sms3r0bVnF6PF5k1wAZ5Se
        TVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexp6zL1kK
        Gowq1pxYxNLA+FOji5GTQ0LAROLo907mLkYuDiGBpYwSN59fYYJIiElM2redHcIWlvhzrYsN
        oug1o0T3tyawhLBAkMTtG1/ZQGwRgT2MEo9Wa4IUMQvMZpT48OooE0RHG5PExn/zGbsYOTjY
        BPQkdqwqBGngFXCTaHvzFqyZRUBF4uzxVWBDRQUiJM6+XMcIUSMocXLmExYQm1PAUOLlv/ms
        IDazgJnEvM0PmSFscYlbT+YzQdjyEs1bZzNPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9
        t9hIrzgxt7g0L10vOT93EyMwrrcd+7llB2PXu+BDjAIcjEo8vBUOnDFCrIllxZW5hxglOJiV
        RHiLMoBCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MOXkl8YamhuYWlobmxubGZhZK4rzn
        DSqjhATSE0tSs1NTC1KLYPqYODilGhhr9rpMW7f8NuvPFXzXe2+53RSpWDGl1GEBZ8a6AFv1
        IskI6eXtT10+XD7ZIuyz9ZcHo9PJvcxCNdH1r/klmb3SqhZbBOY+W/SOcQvPZu6SVb2yk87/
        1J3Ov2drscCqud0CkoWWK2ZzhXmXf5m4dIYo95mQmOmK28uffdj+cUPV5uT1Ik6Hna4psRRn
        JBpqMRcVJwIA8rub6gEDAAA=
X-CMS-MailID: 20181206191848eucas1p1d07a1e8d0bf86fddcdde5905cb1c4188
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
        <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
        <1544022595.2841.45.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 12/5/18 4:09 PM, Zhang Rui wrote:
> On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
>> This patch adds support irq mode in trip point.
>> When that flag is set in DT, there is no need for polling
>> in thermal framework. Crossing the trip point will rise an IRQ.
>> The naming convention for tip point 'type' can be confussing
>> and 'passive' (whic is passive cooling) might be interpretted
>> wrongly.
>>
>> This mechanism prevents from missue and adds explicit setting
>> for hardware which support interrupts for pre-configured temperature
>> threshold.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
>>   drivers/thermal/thermal_core.c | 10 ++++++++--
>>   include/linux/thermal.h        |  5 +++++
>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
>> thermal.c
>> index 4bfdb4a..1a75946a 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct
>> thermal_zone_device *tz, int trip,
>>   	return 0;
>>   }
>>   
>> +static int
>> +of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz, int
>> trip,
>> +			     bool *mode)
>> +{
>> +	struct __thermal_zone *data = tz->devdata;
>> +
>> +	if (trip >= data->ntrips || trip < 0)
>> +		return -EDOM;
>> +
>> +	*mode = data->trips[trip].irq_mode;
>> +
>> +	return 0;
>> +}
>> +
>>   static int of_thermal_get_trip_temp(struct thermal_zone_device *tz,
>> int trip,
>>   				    int *temp)
>>   {
>> @@ -394,6 +408,7 @@ static struct thermal_zone_device_ops
>> of_thermal_ops = {
>>   	.set_mode = of_thermal_set_mode,
>>   
>>   	.get_trip_type = of_thermal_get_trip_type,
>> +	.get_trip_irq_mode = of_thermal_get_trip_irq_mode,
>>   	.get_trip_temp = of_thermal_get_trip_temp,
>>   	.set_trip_temp = of_thermal_set_trip_temp,
>>   	.get_trip_hyst = of_thermal_get_trip_hyst,
>> @@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct
>> device_node *np,
>>   		return ret;
>>   	}
>>   
>> +	trip->irq_mode = of_property_read_bool(np, "irq-mode");
>> +
>>   	/* Required for cooling map matching */
>>   	trip->np = np;
>>   	of_node_get(np);
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 39fc812..6d41e08 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -406,6 +406,7 @@ static void handle_critical_trips(struct
>> thermal_zone_device *tz,
>>   static void handle_thermal_trip(struct thermal_zone_device *tz, int
>> trip)
>>   {
>>   	enum thermal_trip_type type;
>> +	bool irq_mode = false;
>>   
>>   	/* Ignore disabled trip points */
>>   	if (test_bit(trip, &tz->trips_disabled))
>> @@ -419,9 +420,14 @@ static void handle_thermal_trip(struct
>> thermal_zone_device *tz, int trip)
>>   		handle_non_critical_trips(tz, trip);
>>   	/*
>>   	 * Alright, we handled this trip successfully.
>> -	 * So, start monitoring again.
>> +	 * So, start monitoring in polling mode if
>> +	 * trip is not using irq HW support.
>>   	 */
>> -	monitor_thermal_zone(tz);
>> +	if (tz->ops->get_trip_irq_mode)
>> +		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
>> +
>> +	if (!irq_mode)
>> +		monitor_thermal_zone(tz);
>>   }
>>   
> handle_thermal_trip() is called from thermal_zone_device_update(), and
> it is invoked for every trip points.
> say, you have a passive trip point 1 that supports irq_mode, and
> another passive trip point 2 that does not support irq_mode,
> monitor_thermal_zone() is still called in handle_thermal_trip(tz, 2),
> and the passive timer will be activated anyway, do I miss something?
Yes, the passive timer will be activated in your example. It is correct
behavior and does not break anything.
case 1: there is 'k' passive trip points which have irq_mode and 1
additional which does not have 'irq_mode', the framework will start
polling but skip check for those 'k' trip points.
case 2: all of the passive trip points have irq_mode set, the framework
will not register 'scheduled_work' because it will not call 
'monitor_thermal_zone()'.
This is the case of most Exynos platforms, but there is one exception 
which has 'case 1' with 2 trip points not supporting irq_mode.

Regards,
Lukasz

> 
> thanks,
> rui
> 
>>   static void update_temperature(struct thermal_zone_device *tz)
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f..b064565 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
>>   		enum thermal_device_mode);
>>   	int (*get_trip_type) (struct thermal_zone_device *, int,
>>   		enum thermal_trip_type *);
>> +	int (*get_trip_irq_mode) (struct thermal_zone_device *, int,
>> bool *);
>>   	int (*get_trip_temp) (struct thermal_zone_device *, int, int
>> *);
>>   	int (*set_trip_temp) (struct thermal_zone_device *, int,
>> int);
>>   	int (*get_trip_hyst) (struct thermal_zone_device *, int, int
>> *);
>> @@ -196,6 +197,7 @@ struct thermal_zone_device {
>>   	struct thermal_attr *trip_temp_attrs;
>>   	struct thermal_attr *trip_type_attrs;
>>   	struct thermal_attr *trip_hyst_attrs;
>> +	struct thermal_attr *trip_irq_mode_attrs;
>>   	void *devdata;
>>   	int trips;
>>   	unsigned long trips_disabled;	/* bitmap for disabled
>> trips */
>> @@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
>>    * @temperature: temperature value in miliCelsius
>>    * @hysteresis: relative hysteresis in miliCelsius
>>    * @type: trip point type
>> + * @irq_mode: to not use polling in framework set support of HW irq
>> (which will
>> + *	      be triggered when temperature reaches this level).
>>    */
>>   
>>   struct thermal_trip {
>> @@ -371,6 +375,7 @@ struct thermal_trip {
>>   	int temperature;
>>   	int hysteresis;
>>   	enum thermal_trip_type type;
>> +	bool irq_mode;
>>   };
>>   
>>   /* Function declarations */
> 
> 
