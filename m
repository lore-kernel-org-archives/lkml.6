Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B66206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSAQfvEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B66206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503837AbeKWWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:23:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46018 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390529AbeKWWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:23:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10532816plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dliXYLFvsAtndpMkWhrb829BIrIRrLIRrGkLYB09uZQ=;
        b=dSAQfvEcYDPd5mOjwBhlkBRK+vdAliLaWZZrVqjhrVIPtKaNdHcgrFUNdb96vCGEGI
         X2BZldP9krEMiuJ6RvamECDBJcSVz7tsalzDjIAiyCTL0j5DdhiCt+lnvHaOqxbWC1AQ
         VQoCjxGKNy7NC3PiPo/GiFGZxFeH579NmQWOl9twNnADrKPvXJJLIhENC7z76f0fU3rn
         YpjJnLYhAEsE3laiq5RhSJbjvcWPxtIfC8ZiI57op2cbUkkj6nMAVWpzi5kTJi5ND+T7
         UMtWs4XES1Oof92EQgdl5cUIAY6g6VAS0/sbvL28KmJ0+orx6Z86u8tA1ISbY5Esi1wA
         0WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dliXYLFvsAtndpMkWhrb829BIrIRrLIRrGkLYB09uZQ=;
        b=myoHBo0YihcTpYRCfegPRNnNTaVsKs29d6PMrqb/kxQJSSHA7373PIUODvv+alMhzt
         i9NucbafFnH1/IuZOJsxLKDPF+M9d0xS4f+721iY4yTMZ7JrvLXJ+ZVYux6W7SzWoc+K
         Vl2TmmfL7WrNbZogDkqZuoGW4Y/zfxwh4YgGQ8B+amsCGGtDSkrHfUZ6VTI4MwwKQ7u3
         Dj1S4OWmuC800A81blFrs7bYvnXMu3TaGmTCIIfBBJwavl0pLx8n0NLRVrD+vOiE3cCO
         YSik2+avOwpVY0ufCosBSOiXybMYBivNCZqP44Dw8Nk4Q7mNxPp4N2Bv7ElgPub58Imh
         J9YA==
X-Gm-Message-State: AA+aEWak50sbNbj6ILRHL2TyNpmLAFJX9k4hF2t+HC6mD2gRSAzUWjX4
        NM3G1zfZ2ZDXK4N2D1uvPFU=
X-Google-Smtp-Source: AFSGD/VLAvxxnP51FvMnxfVDUHyzQtDJlxN0yGuUnRddW0z3fkUiyTY/prx4DPLcS8AE4iEFFDjNuQ==
X-Received: by 2002:a17:902:768b:: with SMTP id m11mr15383507pll.271.1542973180287;
        Fri, 23 Nov 2018 03:39:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-v6sm83228563pfr.55.2018.11.23.03.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 03:39:39 -0800 (PST)
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_lightbar: instantiate only
 if the EC has a lightbar.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-8-enric.balletbo@collabora.com>
 <20181122192544.GA2410@roeck-us.net>
 <5b06a19f-693f-ca9d-cb6f-06d0c3d938d9@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <71e9c484-0f42-7dfe-9d34-92b5639eae39@roeck-us.net>
Date:   Fri, 23 Nov 2018 03:39:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5b06a19f-693f-ca9d-cb6f-06d0c3d938d9@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 3:10 AM, Enric Balletbo i Serra wrote:
> Hi Guenter,
> 
> On 22/11/18 20:25, Guenter Roeck wrote:
>> On Thu, Nov 22, 2018 at 12:33:56PM +0100, Enric Balletbo i Serra wrote:
>>> Due to the way attribute groups visibility work, the function
>>> cros_ec_lightbar_attrs_are_visible is called multiple times, once per
>>> attribute, and each of these calls makes an EC transaction. For what is
>>> worth the EC log reports multiple errors on boot when the lightbar is
>>> not available. Instead, check if the EC has a lightbar in the probe
>>> function and only instantiate the device.
>>>
>>> Ideally we should have instantiate the driver only if the
>>> EC_FEATURE_LIGHTBAR is defined, but that's not possible because that flag
>>> is not in the very first Pixel Chromebook (Link), only on Samus. So, the
>>> driver is instantiated by his parent always.
>>>
>>> This patch changes a bit the actual behaviour. Before the patch if an EC
>>> doesn't have a lightbar an empty lightbar folder is created in
>>> /sys/class/chromeos/<ec device>, after the patch the empty folder is not
>>> created, so, the folder is only created if the lightbar exists.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> Guess this is the answer to the suggestion I had before. Maybe the two patches
>> should be merged together ? Or do  others think that they should be kept
>> separate ?
>>
> 
> I did in a separate patch because it changes a bit the current behaviour (i.e
> after that patch the lightbar directory will not appear if is not detected).
> Having in a separate patch will allow us to revert cleanly if for some weird
> reason we still want the old behaviour. So in general, first I moved the
> attributes and then I did a follow up patch with the probe change. This also
> happens with vbc driver.
> 

Good point, makes sense.

> Said that, I don't mind to merge the two patches.
> 
> 
>> Additional comment below.
>>
>> Thanks,
>> Guenter
>>
>>> ---
>>>
>>>   drivers/platform/chrome/cros_ec_lightbar.c | 29 +++++++++-------------
>>>   1 file changed, 12 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
>>> index 31d22f594fac..d255264eb082 100644
>>> --- a/drivers/platform/chrome/cros_ec_lightbar.c
>>> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
>>> @@ -567,37 +567,28 @@ static struct attribute *__lb_cmds_attrs[] = {
>>>   	NULL,
>>>   };
>>>   
>>> -static bool ec_has_lightbar(struct cros_ec_dev *ec)
>>> +static bool cros_ec_has_lightbar(struct cros_ec_dev *ec_dev)
>>>   {
>>> -	return !!get_lightbar_version(ec, NULL, NULL);
>>> -}
>>> -
>>> -static umode_t cros_ec_lightbar_attrs_are_visible(struct kobject *kobj,
>>> -						  struct attribute *a, int n)
>>> -{
>>> -	struct device *dev = container_of(kobj, struct device, kobj);
>>> -	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>>> -	struct platform_device *pdev = to_platform_device(ec->dev);
>>> +	struct platform_device *pdev = to_platform_device(ec_dev->dev);
>>>   	struct cros_ec_platform *pdata = pdev->dev.platform_data;
>>>   	int is_cros_ec;
>>>   
>>>   	is_cros_ec = strcmp(pdata->ec_name, CROS_EC_DEV_NAME);
>>>   
>> Can this now ever be false ?
>>
> 
> Yes, this happens for example on Samus, where there are two ECs, the first one
> is named "cros_ec" and the second one is "cros_pd", so will fail in the second
> case. Gwendal, correct me if I am wrong, but AFAIK this is a bit of hack because
> some initial versions of Samus (coded Link I guess) have no support for the
> EC_LIGHTBAR_FEATURE so we can't really use the features thing.
> 
Ok.

Thanks,
Guenter

>>>   	if (is_cros_ec != 0)
>>> -		return 0;
>>> +		return false;
>>>   
>>> -	/* Only instantiate this stuff if the EC has a lightbar */
>>> -	if (ec_has_lightbar(ec)) {
>>> -		ec_with_lightbar = ec;
>>> -		return a->mode;
>>> +	if (!!get_lightbar_version(ec_dev, NULL, NULL)) {
>>> +		ec_with_lightbar = ec_dev;
>>
>> Is this variable (and the associated check in lb_manual_suspend_ctrl)
>> still necessary ?
>>
> 
> Hmm, right, I will double check and remove in next version.
> 
>>> +		return true;
>>>   	}
>>> -	return 0;
>>> +
>>> +	return false;
>>>   }
>>>   
>>>   struct attribute_group cros_ec_lightbar_attr_group = {
>>>   	.name = "lightbar",
>>>   	.attrs = __lb_cmds_attrs,
>>> -	.is_visible = cros_ec_lightbar_attrs_are_visible,
>>>   };
>>>   
>>>   static int cros_ec_lightbar_probe(struct platform_device *pd)
>>> @@ -611,6 +602,10 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>>>   		return -EINVAL;
>>>   	}
>>>   
>>> +	/* Only instantiate this stuff if the EC has a lightbar */
>>> +	if (!cros_ec_has_lightbar(ec_dev))
>>> +		return -ENODEV;
>>> +
>>>   	/* Take control of the lightbar from the EC. */
>>>   	lb_manual_suspend_ctrl(ec_dev, 1);
>>>   
>>
> 

