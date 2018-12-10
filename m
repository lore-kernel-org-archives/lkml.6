Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9452081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="InMYU2Xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9452081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeLJGz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:55:58 -0500
Received: from [80.88.177.70] ([80.88.177.70]:53302 "EHLO mail2.kuutio.org"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJGz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:55:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail2.kuutio.org (Postfix) with ESMTP id 300114D1F52;
        Mon, 10 Dec 2018 08:55:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=dkim; t=1544424947; x=1547016948; bh=+gbn97yV/CYpLr
        L0nP3X8fbkMIjGu7Scgx/e4BVDhoI=; b=InMYU2Xsq0zJ0M9vW2qVcV/i23e7cc
        Voq4gn9zTf6984AS143zNevcc+aaDtA7/rWhfkwqplCWIpUOk2lDgmE7XmxKOZsB
        jKHSAWq3aqoljS/HOxiOXvwiDsLLn2ZolXoOz7w1adEYAFLloMqiMhLjUeN3WiLR
        dhE471aZ+S5UurMqJnNcSW/FdS+sH9d+HHUZFdPh6xrTNT3CSBFdUo5nqSJ47lFa
        jH5e2Dno/X4w4fOUEXeQE2AjlEaxJfkOtoHG3ol9bNM+528zlu71Fs64F3Tc69E8
        yJJBFLrg041o4HrOwIkopDwn8LqFbixwx2CRHEODtfzVgY1zMWFzdCG2eFt2vfSW
        HIaddkWLB1dPgBei8n3DpizlL0jZzkZtEUsWx9Bbsfs2YkiWQLeO5b9hVNsBVZuT
        dBqZ8m8MsmCYQmiyEAZ2OdsdjUUxRbomISy3fPJkIU4vKU4AuiJbGIeWVhUn9kK8
        eM77/GaOtntLxqHD9oPuQ0wZNEg8Wqf79o2npctPib6vr+6sq63TZZedUHI0KQCS
        uH5nS6bfQoPH4BIUwlvWhCUq3buwYyyDjW+4++gQqwgj4iwEG9FkbtajljxTlGki
        dkZVMBLt/T+KAUDt36IjrNiG0XbN1MFLHsQJLlxGv5zG6Uyc/VZl/xV5+Vrv6v8Y
        l+bom4F1HkWrM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
        by localhost (mail2.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Z56O8pZAWHAp; Mon, 10 Dec 2018 08:55:47 +0200 (EET)
Received: from [IPv6:2001:998:13:e1::139] (unknown [IPv6:2001:998:13:e1::139])
        by mail2.kuutio.org (Postfix) with ESMTPSA id 7098E4D1F51;
        Mon, 10 Dec 2018 08:55:47 +0200 (EET)
Subject: Re: [PATCH v8 1/2] mfd: axp20x: Re-align mfd cell entries
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-2-oskari@lemmela.net> <20181210063642.GT26661@dell>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Message-ID: <c77951e6-46d9-d48a-b5bb-33bb9d00a929@lemmela.net>
Date:   Mon, 10 Dec 2018 08:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210063642.GT26661@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10.12.2018 8.36, Lee Jones wrote:
> On Sat, 08 Dec 2018, Oskari Lemmela wrote:
>
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> In the axp20x driver, the various mfd_cell lists had varying amounts
>> of indentation, sometimes even within the same list. For the axp288,
>> there's no alignment at all.
>>
>> Re-align the right hand side of the assignments with the least amount
>> of tabs possible. Also collapse the closing bracket and the opening
>> bracket of the next entry onto the same line for the axp288, to be
>> consistent with all the other mfd_cell lists.
>>
>> This patch is whitespace change only. No functionality is modified.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Why is Oskari Lemmela's SoB here?
>
> You both authored this alignment patch?
I picked up Chen-Yu's patch from
https://github.com/wens/linux/commit/b99cec26bae2835a0374463570ea9ea26b034afa.
I should have mentioned it cover letter.

Chen-Yu is correct author. I'm just sending his patch.

>
>> ---
>>  drivers/mfd/axp20x.c | 107 +++++++++++++++++++++----------------------
>>  1 file changed, 51 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index dfc3cff1d08b..8037b4e01ed6 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -640,9 +640,9 @@ static const struct mfd_cell axp221_cells[] = {
>>  
>>  static const struct mfd_cell axp223_cells[] = {
>>  	{
>> -		.name			= "axp221-pek",
>> -		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
>> -		.resources		= axp22x_pek_resources,
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
>> +		.resources	= axp22x_pek_resources,
>>  	}, {
>>  		.name		= "axp22x-adc",
>>  		.of_compatible	= "x-powers,axp221-adc",
>> @@ -650,7 +650,7 @@ static const struct mfd_cell axp223_cells[] = {
>>  		.name		= "axp20x-battery-power-supply",
>>  		.of_compatible	= "x-powers,axp221-battery-power-supply",
>>  	}, {
>> -		.name			= "axp20x-regulator",
>> +		.name		= "axp20x-regulator",
>>  	}, {
>>  		.name		= "axp20x-ac-power-supply",
>>  		.of_compatible	= "x-powers,axp221-ac-power-supply",
>> @@ -666,9 +666,9 @@ static const struct mfd_cell axp223_cells[] = {
>>  
>>  static const struct mfd_cell axp152_cells[] = {
>>  	{
>> -		.name			= "axp20x-pek",
>> -		.num_resources		= ARRAY_SIZE(axp152_pek_resources),
>> -		.resources		= axp152_pek_resources,
>> +		.name		= "axp20x-pek",
>> +		.num_resources	= ARRAY_SIZE(axp152_pek_resources),
>> +		.resources	= axp152_pek_resources,
>>  	},
>>  };
>>  
>> @@ -697,84 +697,79 @@ static const struct resource axp288_charger_resources[] = {
>>  
>>  static const struct mfd_cell axp288_cells[] = {
>>  	{
>> -		.name = "axp288_adc",
>> -		.num_resources = ARRAY_SIZE(axp288_adc_resources),
>> -		.resources = axp288_adc_resources,
>> -	},
>> -	{
>> -		.name = "axp288_extcon",
>> -		.num_resources = ARRAY_SIZE(axp288_extcon_resources),
>> -		.resources = axp288_extcon_resources,
>> -	},
>> -	{
>> -		.name = "axp288_charger",
>> -		.num_resources = ARRAY_SIZE(axp288_charger_resources),
>> -		.resources = axp288_charger_resources,
>> -	},
>> -	{
>> -		.name = "axp288_fuel_gauge",
>> -		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
>> -		.resources = axp288_fuel_gauge_resources,
>> -	},
>> -	{
>> -		.name = "axp221-pek",
>> -		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
>> -		.resources = axp288_power_button_resources,
>> -	},
>> -	{
>> -		.name = "axp288_pmic_acpi",
>> +		.name		= "axp288_adc",
>> +		.num_resources	= ARRAY_SIZE(axp288_adc_resources),
>> +		.resources	= axp288_adc_resources,
>> +	}, {
>> +		.name		= "axp288_extcon",
>> +		.num_resources	= ARRAY_SIZE(axp288_extcon_resources),
>> +		.resources	= axp288_extcon_resources,
>> +	}, {
>> +		.name		= "axp288_charger",
>> +		.num_resources	= ARRAY_SIZE(axp288_charger_resources),
>> +		.resources	= axp288_charger_resources,
>> +	}, {
>> +		.name		= "axp288_fuel_gauge",
>> +		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
>> +		.resources	= axp288_fuel_gauge_resources,
>> +	}, {
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
>> +		.resources	= axp288_power_button_resources,
>> +	}, {
>> +		.name		= "axp288_pmic_acpi",
>>  	},
>>  };
>>  
>>  static const struct mfd_cell axp803_cells[] = {
>>  	{
>> -		.name			= "axp221-pek",
>> -		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>> -		.resources		= axp803_pek_resources,
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
>> +		.resources	= axp803_pek_resources,
>>  	},
>> -	{	.name			= "axp20x-regulator" },
>> +	{	.name		= "axp20x-regulator" },
>>  };
>>  
>>  static const struct mfd_cell axp806_self_working_cells[] = {
>>  	{
>> -		.name			= "axp221-pek",
>> -		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
>> -		.resources		= axp806_pek_resources,
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp806_pek_resources),
>> +		.resources	= axp806_pek_resources,
>>  	},
>> -	{	.name			= "axp20x-regulator" },
>> +	{	.name		= "axp20x-regulator" },
>>  };
>>  
>>  static const struct mfd_cell axp806_cells[] = {
>>  	{
>> -		.id			= 2,
>> -		.name			= "axp20x-regulator",
>> +		.id		= 2,
>> +		.name		= "axp20x-regulator",
>>  	},
>>  };
>>  
>>  static const struct mfd_cell axp809_cells[] = {
>>  	{
>> -		.name			= "axp221-pek",
>> -		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
>> -		.resources		= axp809_pek_resources,
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
>> +		.resources	= axp809_pek_resources,
>>  	}, {
>> -		.id			= 1,
>> -		.name			= "axp20x-regulator",
>> +		.id		= 1,
>> +		.name		= "axp20x-regulator",
>>  	},
>>  };
>>  
>>  static const struct mfd_cell axp813_cells[] = {
>>  	{
>> -		.name			= "axp221-pek",
>> -		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>> -		.resources		= axp803_pek_resources,
>> +		.name		= "axp221-pek",
>> +		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
>> +		.resources	= axp803_pek_resources,
>>  	}, {
>> -		.name			= "axp20x-regulator",
>> +		.name		= "axp20x-regulator",
>>  	}, {
>> -		.name			= "axp20x-gpio",
>> -		.of_compatible		= "x-powers,axp813-gpio",
>> +		.name		= "axp20x-gpio",
>> +		.of_compatible	= "x-powers,axp813-gpio",
>>  	}, {
>> -		.name			= "axp813-adc",
>> -		.of_compatible		= "x-powers,axp813-adc",
>> +		.name		= "axp813-adc",
>> +		.of_compatible	= "x-powers,axp813-adc",
>>  	}, {
>>  		.name		= "axp20x-battery-power-supply",
>>  		.of_compatible	= "x-powers,axp813-battery-power-supply",
Thanks,
Oskari
