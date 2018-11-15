Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746EA208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKZE1oId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746EA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbeKPD2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:28:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46143 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeKPD2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:28:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so9281000pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ix48btnzZ2Fb/6K3M4JzBQVHw8kFHm4MAdbxCD0PrpI=;
        b=lKZE1oId7a+hg2o/hBYBescIalZ5UKpdmc2phs5X+t1kV1fsckTyqxczXxEWmZtnhV
         CcW/DAPuzzwl5iEHlFlaGbMYsHcbayEr797pNpQGzLbH7+X8m5b3Q8G7eE7ptwAjy2zP
         rHkbP3btYvQR6twMVHLaTY+5MhICxHd0n999sUOK61TsggpogPUs6I4+QhamBfDbuJNt
         Du60+pfyOgqkzbxymPuLzHQRDToRu3x+2CTCa9ZMzur/gz1WPW3qImAHcW7TeZSFvsvX
         hAmbI8Fq1A67CjDTYWJDhnEz1hYzhD1IsQCvwH1jnX4YIILVKvhhDP/WJQ3XYj2iNAqB
         zGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ix48btnzZ2Fb/6K3M4JzBQVHw8kFHm4MAdbxCD0PrpI=;
        b=qRKj1+p+LTbbiEONX6KJwzgkUhy+v6ksE6dazBJ8XUcVu3rOUsWbxnBEdXg+MzpiF9
         COLYx8N+HGjtwXIqUIj/R9DWTbYy95Tj7EOCLhskMg4udOLvxZu8t6rDb2OXqKnZCCN2
         ORK36UlFs8rtpkI/nC4tF4+JXrnxvghTuEKKelTaEPCqlmTeigZKInsnJe5OaI4UQvxY
         NhtfqKhxPSs1IozyJp0PIXGYaDlPa4TvxoSSC3doHHvQ/ijgJRdxVviG426f+XfHgUhM
         g0gVjkwUc2Pwml9RkJNeRYIHlQJiVw7WC8Rpx0g+kxpVd8oJa/eixGKhQFekkRzrcvN8
         EMHw==
X-Gm-Message-State: AGRZ1gJxEFlOV0O9HJWce7cTcrIoT8fP0EsGjl95ray9fE0BMzVbvqM7
        ogtkMqWPuj1QS2OYWLpifS3Ii0wc
X-Google-Smtp-Source: AJdET5d/PDTx2t3S03BBXSmN6lTk8NSCN+cU0FyHdkQz50gclA12zHBVZVg4zVXY4p9BBGc6XpSwLA==
X-Received: by 2002:a62:7e93:: with SMTP id z141mr6038873pfc.239.1542302358427;
        Thu, 15 Nov 2018 09:19:18 -0800 (PST)
Received: from [10.69.78.41] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e65-v6sm36169908pfa.90.2018.11.15.09.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 09:19:17 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
Date:   Thu, 15 Nov 2018 09:19:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115053836.GA7606@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2018 9:38 PM, Guenter Roeck wrote:
> On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
>>
>>
>> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
>>>> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
>>>> result in the inability for the kernel to have a valid console
>>> device,
>>>> which can be seen with:
>>>>
>>>> Warning: unable to open an initial console.
>>>>
>>>> and then:
>>>>
>>>> Run /init as init process
>>>> Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x00000100
>>>>
>>>> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
>>>> really is no drawback to defaulting this config to the value of
>>>> SERIAL_8250.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
>>> defined where it was not previously. Example mpc85xx_defconfig. This in
>>> turn results in boot failures for those configurations, with an error
>>> message of
>>>
>>> of_serial: probe of e0004500.serial failed with error -22
>>>
>>> which wasn't seen before.
>>
>> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).
>>
>>>
>>> Not sure if replacing a potential problem with a real one is really an
>>> improvement.`
>>
>> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.
> 
> Actally, never mind. I dropped the test cases. Sorry for the noise.

Why? The tests are useful, if I gave you an impression that I was just
going to walk away from this issue and not look at it, then that is not
happening. What I was objecting to is your qualification of the issue,
this is unfortunately not a potential/latent problem, it happens more
often than not.

The key difference is that most subsystems that are CONFIG_OF aware will
get that awareness enabled/active automatically, that is not the case
with the 8250 driver, which is why this you can shoot yourself in the
foot and end-up with the 8250 driver enabled, but not
CONFIG_SERIAL_OF_PLATFORM. I also suspect that for historical reasons
powerpc "manually" registers its 8250 ports and does not rely on
CONFIG_OF_SERIAL_PLATFORM.

I will try to cook a patch as quickly as possible. Thanks
-- 
Florian
