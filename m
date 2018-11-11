Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQChXBh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7818220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeKLHGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:06:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39032 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeKLHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:06:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so5858284ljh.6;
        Sun, 11 Nov 2018 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UBRQcHu2wCIasigydnF3lcVLdWutqDBurLzGU/B694=;
        b=LQChXBh3i/8dbNJRKcE0qvoHCoWxFsAxpbImUliSDK2QJeusf4m4XXR1QkhzEZnbIQ
         NmmNbL3O3jHn/CYGTG2wM/Ts8sJkGabDuoj842T9yhRvNzTfjWwSmpmX3/Fy+kQPszzP
         7vAy4NYj5Nto7M1WHfueJCbO+fG7mr+peOLxNWDOICTzfyH7FQ+HHLcBw+6EWlY4avef
         Bn+vXDXJg8YgYGRczTIgxf8Z7JhdrIlvnCiDL7DFe1SXy4tU0eUfZ/yXrCKh/Bbwhhou
         R4FvEtBxF05coevGx6Oz6B8m/PjYipY/ZgiWrGNZ7/SqHGX+FkVGFtpomoRrInEox/hp
         t2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UBRQcHu2wCIasigydnF3lcVLdWutqDBurLzGU/B694=;
        b=NZ6KdHuPABrg2fzLR7xAtclctV7M2e2oNg2b6HMzvxBheZUkXtAcbSFytjtPBnb/GV
         Ms6TIGLypAHh/oyKCROaWp/Le3WvLCzs3apmQ8EICdZqGjnqGLaX8xFuFtGKIIS4IA8r
         53qXp5xhwSglLQ4DqlISxfuUI2D50eGf8mWL3uklEP+Wg4wjY8QNJBqMKAdvNAj+eVMC
         3N/22v+uWhICO5R7JhJg1bbW+X7vfb/e9mwXOzCT0mzr+FsK9TChTNm5xnHocPDmwoZR
         WPDP0hz9tIEbSTIvoKhBKBrB3qmpq3qyygBWWZwXHaprV4DBFIYRwejLEbzTucft9c2V
         xPXQ==
X-Gm-Message-State: AGRZ1gL9kD49Wn//Zhd8jaGGq+KCfseRo+BA1XDnjfxZf3SHWj5I4JtG
        wwSUWZfxYy84VP4CFjk+J0g=
X-Google-Smtp-Source: AJdET5f7DpBDqxpW703Ax/AKUs9NlhZyv5+TsUqZ3AU30IaypLspbX+Fn0tYkpPJq7tY6CPmYXoZ3g==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr10081704ljg.125.1541971017832;
        Sun, 11 Nov 2018 13:16:57 -0800 (PST)
Received: from [192.168.1.18] (cjk171.neoplus.adsl.tpnet.pl. [83.31.60.171])
        by smtp.gmail.com with ESMTPSA id 10sm2650293lff.62.2018.11.11.13.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 13:16:57 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <20181111113157.GK27666@amd> <96296b4d-d49e-2b08-4306-196605a9f5dc@gmail.com>
 <20181111202056.GB20160@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b4314757-51b7-62da-d7bc-f27980248797@gmail.com>
Date:   Sun, 11 Nov 2018 22:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181111202056.GB20160@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2018 09:20 PM, Pavel Machek wrote:
> Hi!
> 
>>>> +#define LED_FUNCTION_BACKLIGHT "backlight"
>>>> +#define LED_FUNCTION_BACKLIGHT_CLUSTER "backlight_cluster"
>>>
>>> Sounds like one of backlight and backlight_cluster should be deprecated?
>>
>> I think so.
> 
> Agreed.
> 
>>>> +#define LED_FUNCTION_DEBUG "debug"
>>>> +#define LED_FUNCTION_DIA "dia"
>>>
>>> What does this one do?
>>
>> I'd opt for something like "diagnostics", but this is a blind shot.
>> Let's remove it then and, and let people add more meaningful
>> definition in case it is needed.
>>
>>>> +#define LED_FUNCTION_DISK "disk"
>>>
>>> We have disk, hd, hdd and sata. Deprecate some?
>>
>> Disk should be the best choice, especially given that we have
>> identically named trigger.
> 
> Ok.
> 
>>>> +#define LED_FUNCTION_HD "hd"
>>>> +#define LED_FUNCTION_HDD "hdd"
>>>> +#define LED_FUNCTION_HDDERR "hdderr"
>>>
>>> Ok, I'll 
>>
>> Hmm?
> 
> I was going to say that I'll bring it up in different email.
> 
> I believe we should have disk:green:activity and disk:red:error, not
> "green:hdd" and "red:hdderr".

How would you propose to name the section corresponding to "disk",
if "function" is occupied by "activity"? Should it deserve a separate
DT property?

>>>> +#define LED_FUNCTION_HEALTH "health"
>>>> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
>>>
>>> Sounds same as alive, deprecate alive?
>>
>> Heartbeat may be designated specifically for registration
>> for events from the trigger with the same name.
> 
> Ok. What is "alive" then?

Tells whether something is active or not?
In this case it seems to overlap with "pwr" probably.

>>>> +#define LED_FUNCTION_WIFI "wifi"
>>>> +#define LED_FUNCTION_WIRELESS "wireless"
>>>> +#define LED_FUNCTION_WLAN "wlan"
>>>
>>> Same as wifi and wireless, I guess, deprecate some?
>>
>> I'd remove "wireless" and "wlan".
> 
> Actually I'd keep wlan, but... :-).

It may depend of the regional preferences.

> We may want to do add some comments there, and sort it "most
> common/recommended first" or something.
> 
> Best regards (and thanks for doing the work),

I'm doing it also for myself to avoid extra lines for
explaining the LED naming quirks every time a new driver
is submitted :-)

-- 
Best regards,
Jacek Anaszewski
