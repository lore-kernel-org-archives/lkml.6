Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B4C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E632075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjnmdfV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E632075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJXQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:56:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50921 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:56:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so4389342wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MdFD4e72FFmwZ7wvKEg0G5lZXwuMW0V9JVo4DKcbigk=;
        b=CjnmdfV0WRmQSFlcicOafmCTCedLPlr7XwLrAMOdViL77df9wxnbPwB1tzF4s+b8+O
         7nkgWILTkJZn9A/Wi9kFfo3NiNJgWIOGeX4vYvAXZ/XWd/tug5PMtcwF5j1eJ83uKCsH
         G5HLrsno+5SKvymvj+k0fHkpFmind68aVLEK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdFD4e72FFmwZ7wvKEg0G5lZXwuMW0V9JVo4DKcbigk=;
        b=dNcCB2bP9I3ZdbxUM3VaGOENUq0pt1K/HV4G9fjwFEhbtA2+54Lr3uj1ZkGQZ673Wt
         L2ooN+rUbDkMTOjjHABIlqH+aCeXKwU8+zCloyP2/FX//g9wf+PnYpWo3rlEjAyq3h73
         2mDrJOT0Qu47l109jeKnLwLG5S6vsLAuOMCiR7+rRL6FU5KKlDvJFmPf5Z+ch7QzjHHE
         jQzTmqeiog9mJL24XvLiSCNr2eSht7NmT+Eeh6ub98axpZV+vc6zHXD4Vp6phVsr2eVu
         1LUgL0EPhTI05ZXBGFGMRLIpUAsCuJ1zys+wbNODMooVYN0WLDDsmAGzb9j2XSv/iokJ
         ofGg==
X-Gm-Message-State: AGRZ1gJP/dlJ9WRBLmgbdWrTkLzDnSf1pWDfOvwwz4JLO12N+vzhUh2r
        yF7ADxJbuoumS+HkM5o19hcFCQ==
X-Google-Smtp-Source: AJdET5d168IWTwWcK2uC1hfBXr4PAz0x5Lg+orGGepI0kgFvI3gKsXDrE3CCGijLlKtFubqucOlO6g==
X-Received: by 2002:a1c:1b91:: with SMTP id b139-v6mr1590742wmb.147.1540369751480;
        Wed, 24 Oct 2018 01:29:11 -0700 (PDT)
Received: from [192.168.0.40] (157.132.88.92.rev.sfr.net. [92.88.132.157])
        by smtp.googlemail.com with ESMTPSA id 77-v6sm6578974wmv.6.2018.10.24.01.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 01:29:10 -0700 (PDT)
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
 <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
 <DB5PR0401MB221381AD65417D17AAD7B16DF3F60@DB5PR0401MB2213.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <86739c2a-3027-0ac0-e4d1-8257f00effc6@linaro.org>
Date:   Wed, 24 Oct 2018 10:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB221381AD65417D17AAD7B16DF3F60@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2018 04:48, Andy Tang wrote:
> Hi Daniel,
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2018年10月16日 19:21
>> To: Andy Tang <andy.tang@nxp.com>; rui.zhang@intel.com
>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Rob Herring <robh+dt@kernel.org>
>> Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
>>
>>>>>> The current code is reading the DT in order to get the sensor id
>>>>>> and initialize it. IOW, the DT gives the sensors to use.
>>>>>>
>>>>>> IMO, it would be more self contained if the driver initializes all
>>>>>> the sensors without taking care of the DT and let the of- code to
>>>>>> do the binding when the thermal zone, no ?
>>>>> [Andy] could you please explain more about this way? I am not sure
>>>>> how
>>>> to implement it.
>>>>> But one thing is for sure: we must get the sensor IDs explicitly so
>>>>> that we can enable them by the following command:
>> tmu_write(qdata,
>>>>> sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
>>>>
>>>> What I meant is about code separation between the driver itself and
>>>> the of-thermal code.
>>>>
>>>> The code above re-inspect the DT to find out the sensor ids in order
>>>> to enable them and somehow this is not wrong but breaks the self
>>>> encapsulation of the driver. I was suggesting if it isn't possible to
>>>> enable all the sensors without taking care of digging into the DT.
>>>
>>> [Andy] I don't want to re-parse the DT here too. But I have to.
>>> This driver will be used by all our SOCs with different sensor IDs and
>> number.
>>> For example: there are 2 sensors on ls1088a platform with ID 0 and 1.
>>> While on ls1043a there are 6 sensors with ID 0, 1, 2, 3, 4, 5.
>>> If we don't scan the DT we would not know how many sensors it is and
>>> what are the sensor's IDs, unless we hardcode it in driver.
>>
>> Yes, you are not the only one in this situation IMO and the drivers
>> supporting multiple sensors are increasing, so this will repeat again and
>> again.
>>
>> That could be hardcoded in the driver by using the compatible string but it
>> will be nicer if we can fix that in the DT.
>>
>> [Cc'ing Rob]
>>
>> What is missing is a description of the sensors id in the temperature
>> device node. We have the <thermal-sensor-cells> with 0 or 1 telling if
>> there is one or several sensors but we can't specify which sensor ids we
>> have. The only alternative is to parse the thermal zones to found out which
>> sensors are in use and use them to initialize the driver, an approach which
>> breaks the self-encapsulation: the of-thermal framework is the one in
>> charge of doing the link between the thermal zone and a sensor id.
>>
>> Is it acceptable to add the list of the sensors id in the temp device node, so
>> the driver can initialize these sensors without parsing the thermal zone in
>> the DT ?
>>
> Have you got any conclusion yet?
> When can I send the next version of this patch?


Let's give an opportunity to Rob to answer.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

