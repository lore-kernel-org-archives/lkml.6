Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592CE20675
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJDHhoEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfAINKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:10:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36878 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfAINKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:10:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so8136052wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 05:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uz5uxYxK1HuWkuq4WBIHZmJOqodHSuI5mPRxhWnPbgM=;
        b=fJDHhoEwxPxjrYsMBPF7tACoNaPdKphvgbdh1qXkMwn+sQpY12OIuKdXqCRpFrLVHx
         9wl56/qjFtY0GxSqG8yVxMW1AePvmau/fNzLK/m+DS1fx7OEr9y0Ip+JhcUL99+fXW48
         Sfy0ENz7ThgEYU7nNcilFGzcRVOGyUnJ4abhlaCQDEe01mToKrcQiS5LNAoleZR/logS
         9oyxCWCJz82nstoWJ2MH1ttEIAOmZNzMExnNIIgJyCffjdqgwiqQhIZRpkSXioQnAxcU
         GAMZaOopDxR8asG7erQldVvyowEKgYwRFI+6MFFbM1Q9DhcLHlYvYru5Kr//UM9Wbyf0
         ap+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uz5uxYxK1HuWkuq4WBIHZmJOqodHSuI5mPRxhWnPbgM=;
        b=DxdEeWA+s0RWJ1Cx6F2AhqzXa8uJTWs53NLQEkZ0g6mOmPNoJ0kfjNa8uEdFEHZi8i
         jo6H4PM4JHGnkPI93j7J1WzFD8PRsMtXm4N1g7j1Qk9n6njboSkw8+/1Q8VXab3N3zKR
         6/QeNZWfkR3t3Z831fWFAiXDGcSjkLVxihtqYp1UXdRJtHti6CzTbyE46tiGS+4MdMKc
         GWxNQCSoBhLbV2+gZV1+eQcA8OmkkD5y6TIqAy4qYToLROKVVtDGuXkeFQb6v12E2ZOn
         GhptYP8HGhVKEGb6KOmjt/Cib2Bllv7+mQ893HXii4zWCUJhekndUwz0UyVHk7m79Hrx
         Nruw==
X-Gm-Message-State: AJcUukf3/fbKvCyOHvtsrb1cM2jIyicCAYF7MWYyQGwb6qksBFJlQnkY
        ZcrooBYA09KKaeYV8fGEjTHyhIsAtgY=
X-Google-Smtp-Source: ALg8bN4R+FHjIPrlkq8KO/kNJbC2NvKZ7AJoeV7Cdv2Des0nwdLU4vhKYU5I5T9uvLpuFU4POf+KQQ==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr5888247wml.102.1547039436239;
        Wed, 09 Jan 2019 05:10:36 -0800 (PST)
Received: from [192.168.0.59] ([195.238.85.143])
        by smtp.gmail.com with ESMTPSA id g16sm57950040wru.41.2019.01.09.05.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 05:10:35 -0800 (PST)
Subject: Re: [PATCH 1/1] mfd: rk808: Prepare rk805 for poweroff
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Stefan Mavrodiev <stefan@olimex.com>
Cc:     linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1538465910-27233-1-git-send-email-stefan@olimex.com>
 <1917869.4NZ4yPfKWV@diego>
From:   Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
Message-ID: <489e70a8-dbe7-e248-972e-c7de4e0f2c1a@gmail.com>
Date:   Wed, 9 Jan 2019 15:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1917869.4NZ4yPfKWV@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: bg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/19 3:07 PM, Heiko Stübner wrote:
> Hi Stefan, Lee,
>
> Am Dienstag, 2. Oktober 2018, 09:38:29 CET schrieb Stefan Mavrodiev:
>> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
>> mode. The default is SLEEP mode.
>>
>> However, when the kernel performs power-off (actually the ATF) the
>> device will not go fully off and this will result in higher power
>> consumption and inability to wake the device with RTC alarm.
>>
>> The solution is to enable pm_power_off_prepare function, which will
>> configure SLEEP pin for OFF function.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> just found this while cleaning my inbox and this change looks
> significant and it seems hasn't been applied yet.
>
> I guess this is still relevant, right?

Yes, but I guess it's out-of-sync with the latest kernel.

>
>
> Heiko
>
>> ---
>>   drivers/mfd/rk808.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>> index 216fbf6..50f3f78 100644
>> --- a/drivers/mfd/rk808.c
>> +++ b/drivers/mfd/rk808.c
>> @@ -387,6 +387,25 @@ static void rk805_device_shutdown(void)
>>   		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>   }
>>
>> +static void rk805_device_shutdown_prepare(void)
>> +{
>> +	int ret;
>> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>> +
>> +	if (!rk808) {
>> +		dev_warn(&rk808_i2c_client->dev,
>> +			 "have no rk805, so do nothing here\n");
>> +
>> +		return;
>> +	}
>> +
>> +	ret = regmap_update_bits(rk808->regmap,
>> +				 RK805_GPIO_IO_POL_REG,
>> +				 SLP_SD_MSK, SHUTDOWN_FUN);
>> +	if (ret)
>> +		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>> +}
>> +
>>   static void rk808_device_shutdown(void)
>>   {
>>   	int ret;
>> @@ -549,6 +568,10 @@ static int rk808_probe(struct i2c_client *client,
>>   	if (pm_off && !pm_power_off) {
>>   		rk808_i2c_client = client;
>>   		pm_power_off = pm_pwroff_fn;
>> +	} else if (pm_off && !pm_power_off_prepare &&
>> +		   rk808->variant == RK805_ID) {
>> +		rk808_i2c_client = client;
>> +		pm_power_off_prepare = rk805_device_shutdown_prepare;
>>   	}
>>
>>   	return 0;
>> @@ -564,6 +587,7 @@ static int rk808_remove(struct i2c_client *client)
>>
>>   	regmap_del_irq_chip(client->irq, rk808->irq_data);
>>   	pm_power_off = NULL;
>> +	pm_power_off_prepare = NULL;
>>
>>   	return 0;
>>   }
>
>
>
