Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23CAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494B52083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KovgdnSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B52083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPTLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:11:00 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34763 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeJPTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:10:59 -0400
Received: by mail-wm1-f52.google.com with SMTP id z25-v6so25083990wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miJRYa4OC/q4RJzNHvO/FqAYiI7+VgyY9ERUymu8wS8=;
        b=KovgdnScUXuH+lsC7uQWzNq3MrgqnSVwixMgtYzN/NCPFevN8CcVIdBb1marZn+O1o
         VmY1A+6r/QOSBOdGmU7cm2J3OoPxU51FKNc+P1LLlVMdEkgDwt+BN2uy4OCktEQ1VsAT
         kK+i1owpO10aCt+DVN9Tlz1rh2Sg7Ko3y4p1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miJRYa4OC/q4RJzNHvO/FqAYiI7+VgyY9ERUymu8wS8=;
        b=TT6AhatuzdVFSRSZmuwRKomYLjOlJ0uhWXvqrzFuU08fkgmvd0G78x0Grwu6CsIM0R
         Z6xeL5f1RVWhdAcqzCWgiivbYXob3VBVL6Php+D030YUf+q7nZ8461QcA04uh+yyNZKL
         rbHMO0URfHV7l3EJmvKeYbfcmmebxsUpvg4WbsztFGa0eE9RtVn7ejzeMYBSs650HjSY
         qRQwEPCdSHVFOAdCtbOX6QNrsCBBEMyvGyvxEelA40VqJCd6pOpmqlQa3ClFI9Z/aI6C
         5d4YIcGajw4yZGsmdECzGDWVZjBZyNxJ9QN0A0WyV8WlAoz0ONEdWTuyms9HxmfJvLeS
         4DZw==
X-Gm-Message-State: ABuFfogQE6nDg2XvhgOETXbrXZ+2kbQM1Ndg3nI/ERsVKUUCUMxZ0YUE
        EGymCkFbpM5bylrAHM2DHKsBoQ==
X-Google-Smtp-Source: ACcGV61/WAm+h6wuPLZYrO2EK1yW4Zg9MIccgBiCYaW23WajJnHiVgH17RYc0nVojHR/FrFvrwBysw==
X-Received: by 2002:a1c:84cd:: with SMTP id g196-v6mr16312898wmd.38.1539688859017;
        Tue, 16 Oct 2018 04:20:59 -0700 (PDT)
Received: from [192.168.0.40] (221.56.88.92.rev.sfr.net. [92.88.56.221])
        by smtp.googlemail.com with ESMTPSA id i6-v6sm11575286wrq.4.2018.10.16.04.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 04:20:58 -0700 (PDT)
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org>
 <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
Date:   Tue, 16 Oct 2018 13:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2018 05:01, Andy Tang wrote:
> Hi Daniel,
> 
> Please see my reply inline.
> 
>> -----Original Message-----

[ ... ]

>> I'm proposing to move struct qoriq_tmu_site_regs inside the struct
>> qoriq_sensor.
>>
>>
>> We end up with:
>>
>> struct qoriq_sensor {
>>    struct thermal_zone_device *tzd;
>>    struct struct qoriq_tmu_site_regs *regs;
>>    struct qoriq_tmu_data *qdata;
>>    int id;
>> };
> [Andy] I see your point. If I add a *regs member to qoriq_sensor struct, then I can speed up the access to the register.
> But I don't think it is better. Currently I can access sensor register by: qdata->regs->site[qsensor->id].
> The whole point here is we can't MOVE struct qoriq_tmu_site_regs to the struct qoriq_sensor. We can only COPY
> it to struct qoriq_sensor. 
> 
> This is the TMU module memory map:
> struct qoriq_tmu_regs {
> ......
>         u32 tscfgr;             /* Sensor Configuration Register */
>         u8 res4[0x78];
>         struct qoriq_tmu_site_regs site[SITES_MAX];
>         u8 res5[0x9f8];
>         u32 ipbrr0;             /* IP Block Revision Register 0 */
>         u32 ipbrr1;             /* IP Block Revision Register 1 */
> .......}
> struct qoriq_tmu_site_regs site[SITES_MAX] is part of the memory
> map.
> It can't be removed or we have to define a similar struct to fill it up.

Mmh, I see. Thanks for the clarification.

A consolidation around this would have been nice but it means a DT
change (reduce the size of the map). So I guess we can leave it as it is.


>>>>> -	if (sensor_specs.args_count >= 1) {
>>>>> -		id = sensor_specs.args[0];
>>>>> -		WARN(sensor_specs.args_count > 1,
>>>>> -				"%s: too many cells in sensor specifier %d\n",
>>>>> -				sensor_specs.np->name,
>> sensor_specs.args_count);
>>>>> -	} else {
>>>>> -		id = 0;
>>>>> +		if (id > SITES_MAX)
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>>>> +		if (!qdata->sensor[id])
>>>>> +			return -ENOMEM;
>>>>> +
>>>>> +		qdata->sensor[id]->id = id;
>>>>> +		qdata->sensor[id]->qdata = qdata;
>>>>> +
>>>>> +		qdata->sensor[id]->tzd =
>>>> devm_thermal_zone_of_sensor_register(
>>>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>>>> +
>>>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>>>> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
>>>>> +			dev_err(&pdev->dev,
>>>>> +				"Failed to register thermal zone device.\n");
>>>>> +			return -ENODEV;
>>>>> +		}
>>>>> +
>>>>> +		sites |= 0x1 << (15 - id);
>>>>
>>>> The current code is reading the DT in order to get the sensor id and
>>>> initialize it. IOW, the DT gives the sensors to use.
>>>>
>>>> IMO, it would be more self contained if the driver initializes all
>>>> the sensors without taking care of the DT and let the of- code to do
>>>> the binding when the thermal zone, no ?
>>> [Andy] could you please explain more about this way? I am not sure how
>> to implement it.
>>> But one thing is for sure: we must get the sensor IDs explicitly so
>>> that we can enable them by the following command:  tmu_write(qdata,
>>> sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
>>
>> What I meant is about code separation between the driver itself and the
>> of-thermal code.
>>
>> The code above re-inspect the DT to find out the sensor ids in order to
>> enable them and somehow this is not wrong but breaks the self
>> encapsulation of the driver. I was suggesting if it isn't possible to enable all
>> the sensors without taking care of digging into the DT.
> 
> [Andy] I don't want to re-parse the DT here too. But I have to.
> This driver will be used by all our SOCs with different sensor IDs and number.
> For example: there are 2 sensors on ls1088a platform with ID 0 and 1.
> While on ls1043a there are 6 sensors with ID 0, 1, 2, 3, 4, 5.
> If we don't scan the DT we would not know how many sensors it is and what are the sensor's IDs,
> unless we hardcode it in driver.

Yes, you are not the only one in this situation IMO and the drivers
supporting multiple sensors are increasing, so this will repeat again
and again.

That could be hardcoded in the driver by using the compatible string but
it will be nicer if we can fix that in the DT.

[Cc'ing Rob]

What is missing is a description of the sensors id in the temperature
device node. We have the <thermal-sensor-cells> with 0 or 1 telling if
there is one or several sensors but we can't specify which sensor ids we
have. The only alternative is to parse the thermal zones to found out
which sensors are in use and use them to initialize the driver, an
approach which breaks the self-encapsulation: the of-thermal framework
is the one in charge of doing the link between the thermal zone and a
sensor id.

Is it acceptable to add the list of the sensors id in the temp device
node, so the driver can initialize these sensors without parsing the
thermal zone in the DT ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

