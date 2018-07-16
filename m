Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D125ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C05720652
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0yW6cU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C05720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeGPOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:40:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39777 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeGPOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:40:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so2713617pgs.6;
        Mon, 16 Jul 2018 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYYLYf46EJhjuvcLs7zojzsD2YMp833DK8KCj7xynjg=;
        b=h0yW6cU2jubi6P5YCBvil//C5ozCJuiypZJaYsGzAM9mR0Ld4iwqZGi/VFM89xw/l8
         ba0kA2W/k+lJ4Jw3CwpC9eTEtO+/Q6vbfq6S7dKQsC2QGgOcDDhJoLdhpnTJYCdpgZPN
         MBR9+flykdBuZ07umP/8+0ZLYAg/TExEEomjFIcyQheXGHfdqjQolGrAACFxWHDDaCZv
         QWazejcXeeTbnvROy6Q4obAHrIpkp1WY8YEzbiQW+TUhVtdRGKOa+lWZkRddhimvaY34
         pk6Oaj2Bg8YlRE+PHWFiWsCkzGhMNIESOsgW7Xsn/qSYrsRvi7XeJEExRfMZocjicw51
         Z9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYYLYf46EJhjuvcLs7zojzsD2YMp833DK8KCj7xynjg=;
        b=VAsEooijVqPbbQY7wb/eXv8Yjj5t4+q7cS/0Xb5iTHkC6pG6B3njsWix0vT7rKE+vb
         H4sf+HMp6WtE1NZkWlchBR0mWLArmAim6RppUoIvmoqpY8oc2lA6UVfdqqLQhtCLKfvE
         yY1K+ptXJdh78At6Ny2ewU3R+Gbq0MEauyJb4GN2qREcRgbt7tnkCgr+DK4K2n1oQRS+
         fcFNivXwDzeopXNXxppoUYfZ+sd/7dTy/35igetK/Cj2TPt3BQMpNfvQ9ID2Wg8CePq6
         mDJla0Xra/QxO6efglXR2Acm+Rs77n+jDL5xHmNg+qKdLMMugFbpiUCVQIJz3txQDhVG
         hN6w==
X-Gm-Message-State: AOUpUlGDxqjVea6v8BBWDxNfLAD5nhBiMbYJr3jfu3+B2ReNywX+Jnoa
        8rKZ3l0Nmy7g4uKXvX057X4=
X-Google-Smtp-Source: AAOMgpeA3vKNVln9DfBICAJ/42Q0xgln8/3oR8Pk+aGpI6HCW1yNJDNFG535dZJtIC1q39V1Ad4/yQ==
X-Received: by 2002:a65:5304:: with SMTP id m4-v6mr15433991pgq.250.1531750349874;
        Mon, 16 Jul 2018 07:12:29 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 75-v6sm6830504pfr.115.2018.07.16.07.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:12:28 -0700 (PDT)
Subject: Re: watchdog: davinci_wdt: add possibility to configure watchdog
 period
To:     Michele Dionisio <michele.dionisio@gmail.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michele Dionisio <michele.dionisio@powersoft.com>
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
 <20180716121909.4869-2-michele.dionisio@gmail.com>
 <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
 <CAFwEtmq1f6fSe0cyXeQrGjh-5O9p+DmYDp=LmKt=tNYYzNK9SQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0252e19a-acd8-90c5-85cf-4363f752d616@roeck-us.net>
Date:   Mon, 16 Jul 2018 07:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFwEtmq1f6fSe0cyXeQrGjh-5O9p+DmYDp=LmKt=tNYYzNK9SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 07:04 AM, Michele Dionisio wrote:
> I have done what are already done in:
> omap_wdt.c with parameter timer_margin
> softdog.c with parameter softMargin
> ...
> 
> the same feature is missing in davinci_wdt and I think is quite usefull.
> 
> if you NACK because I don't use watchdog_init_timeout I can rewrite
> the code but I do that to reduce the number of changes done in one
> commit

Did you read my comment ? Did you try to use the existing "heartbeat"
module parameter ?

If that doesn't work for some reason, lets fix it. Introducing another
module parameter with a different name because the first one doesn't work
simply does not make sense.

Guenter

> Il giorno lun 16 lug 2018 alle ore 15:31 Guenter Roeck
> <linux@roeck-us.net> ha scritto:
>>
>> On 07/16/2018 05:19 AM, michele.dionisio@gmail.com wrote:
>>> From: Michele Dionisio <michele.dionisio@powersoft.com>
>>>
>>> It is not possible to implement setting of watchdog period because it is
>>> not possible to stop watchdog so it is nice to have possibility to
>>> configure watchdog period at module loading.
>>>
>>> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
>>>
>>> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
>>> index 6c6594261cb7..5f95afa20fee 100644
>>> --- a/drivers/watchdog/davinci_wdt.c
>>> +++ b/drivers/watchdog/davinci_wdt.c
>>> @@ -54,6 +54,10 @@
>>>    #define WDKEY_SEQ0          (0xa5c6 << 16)
>>>    #define WDKEY_SEQ1          (0xda7e << 16)
>>>
>>> +static unsigned int init_timeout;
>>> +module_param(init_timeout, uint, 0);
>>> +MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
>>> +
>>>    static int heartbeat;
>>>
>>>    /*
>>> @@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>>>        wdd->ops                = &davinci_wdt_ops;
>>>        wdd->min_timeout        = 1;
>>>        wdd->max_timeout        = MAX_HEARTBEAT;
>>> -     wdd->timeout            = DEFAULT_HEARTBEAT;
>>> -     wdd->parent             = &pdev->dev;
>>> +     if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
>>> +             wdd->timeout = init_timeout;
>>> +     else
>>> +             wdd->timeout = DEFAULT_HEARTBEAT;
>>>
>>>        watchdog_init_timeout(wdd, heartbeat, dev);
>>>
>>
>> NACK. This is done with the 'heartbeat' module parameter already.
>>
>> Guenter
>>
>>
> 

