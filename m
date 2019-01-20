Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C343C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 06:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34152084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 06:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPU1DwTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfATGvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 01:51:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41274 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfATGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 01:51:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so13290734lfj.8;
        Sat, 19 Jan 2019 22:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLqnWhlxHpgWfGyFlH98Wn5dIRZXafa6jshw9DETldI=;
        b=fPU1DwTaeEHtMd6rcNT/EBthw/u91b0+VipKMNz5hVKIJ+hscTG2VhNvT8K3NANeGE
         sCNAd2hDiMS/b3+zxZt53nSCOiryo3tWEXPuu9tL9xkFYL1v68m/E8N2qtYgVBTOdZ5A
         6XGUppkKs800uW4jH+Z9SNQAjzipNT79M6wkKkjJOWor9mFxJDxcHhuvuZkh0euLIxG1
         sqo1wLwJMa7lS8L8yUNyNfkjkfyHFZpqQuG0PvHp9GxNmG9TV5rFdh0jz2xpTL7Wjox4
         zJqHy7mjOZ1hKKBXLpw+AQrkaD+c//YocZv/LcCwyyGvNhqVWHpbQBiYCCpO4Y/8Mmod
         M1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLqnWhlxHpgWfGyFlH98Wn5dIRZXafa6jshw9DETldI=;
        b=RBzzEwVvwgYHt1ker5FKz/Iz8xyVFvxJ9Ak9EsRCwI2jJeRH2k4JGjL5I6XXbgU/mL
         MyMWjurHj3UCsw1jUK58C7pv0JahRU37NpmDKXpMvg4SStbgue+ywjFhzjBuYQ4kV+p2
         P7tEdXAzNeeBrfjDDcPHoPoK8XGKkAxUS4p3Y0WqKBN0wnDi7ovyyRoMkz1KrqbBm/FI
         Q/z3j9BEtyaWnFrn0d2UM6crrwHax2kAOUrPDN3uuCwDKFINpMfo6uNNV8a8tjGnQq8V
         2nuXqsd60D5lqHOYtl5K7PNE4FHL6NNbNZMbjokoiv8BrwiqhISjjIAF6Om6KnHUDIg0
         QAKA==
X-Gm-Message-State: AJcUukc5K/oYGufPoNo7obo0HPoAgtqiOEiTbAIsra8PWIwme4LemXYX
        +G9Xp90SVczdybkoNR0uhKo=
X-Google-Smtp-Source: ALg8bN7FusQ65+4/XWpYeJh25SwQc1j+sg5VNJCrFbzhrwe7Qsum2CEF8Ig+5Wgt9y0MDD3s+UlThw==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr15795803lfa.40.1547967111415;
        Sat, 19 Jan 2019 22:51:51 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:7056:8bb8:4271:58c3? (dtynxhydtm6g7ttxvndbt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:7056:8bb8:4271:58c3])
        by smtp.googlemail.com with ESMTPSA id b81-v6sm1576677ljb.7.2019.01.19.22.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 22:51:50 -0800 (PST)
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <efb4e1c1-0d13-bed7-d262-284fc1a0c9ab@gmail.com>
 <4115ad75-22f7-d9ae-c38f-e0ab61fb6655@gmail.com> <20190119214606.GA4712@amd>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <eeb72aad-6ff1-4744-5c43-ab82593f5df2@gmail.com>
Date:   Sun, 20 Jan 2019 08:51:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119214606.GA4712@amd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 19/01/2019 23.46, Pavel Machek wrote:
> Hi!
> 
>>> Moreover, I think that RGB LED class with configurable
>>> brightness-model, and with possible color range adjustments via
>>> icc-profiles or something similar, is the best solution that has been
>>> proposed so far. It is just flexible.
>>>
>>> I'd like to capitalize on the ideas shared in this thread and have
>>> finally LED RGB class materialized.
>>>
>>
>> I have now updated my github code with my understanding of the discussion:
>> https://github.com/vesajaaskelainen/linux/tree/wip-multi-color-led
>>
>> Commits:
>> - dt-bindings: leds: Introduce linux,default-brightness-model for all leds
>> https://github.com/vesajaaskelainen/linux/commit/4ffb21d644056686096226bbede7c8c78b0254c2
>> - drivers: leds: Add core support for multi color element LEDs
>> https://github.com/vesajaaskelainen/linux/commit/627f38bb78cebc694b8e6d735fb088c87925435d
>> - dt-bindings: leds: leds-pwm: Introduce multi color element leds support
>> https://github.com/vesajaaskelainen/linux/commit/ef6c5730d621e79ea0b02470caa83bc39439536a
>> - WIP: drivers: leds: leds-pwm: Add multi color element LED support.
>> https://github.com/vesajaaskelainen/linux/commit/0430a27823d9162926424b32c23be1c53eb9cbe2
>>
>> First two commits are common and could be taken before I am happy with the
>> pwm led driver changes. This new conditional feature flag makes it a bit
>> harder. Of course one option would be to require it to be enabled.
>>
>> Current set of concepts:
>> - brightness-model: hardware, onoff, linear
>>    - could be extended in future with other modes like hsv if wanted
> 
> Would it be enough to tell userspace what is relation between values
> it writes and output power?
> 
> Onoff is subset of linear, I guess. We already have max_brightness in
> the API.

Btw. there is slight problem with led trigger framework which is kinda 
visible with "onoff" vs "linear" settings.

If you configure color like:

echo onoff > brightness_model
echo 32 0 32 255 > color

You get not so bright pink color. And if you then enable blinking:

echo heartbeat > trigger

Then it blinks with not so bright pink color as expected.

However if you do it:

echo linear > brightness_model
echo 255 0 255 32 > color

You once again you get not so bright pink color. However when you enable 
blinking:

echo heartbeat > trigger

Then it blinks with very bright pink color.

Reason I believe is because trigger uses either values 0 or 255 for 
brightness when controlling. To fix the issue I believe trigger 
mechanism should be adjusted to allowing one to control ON brightness level.

I would recommend fixing this trigger problem with future patches for it.

Thanks,
Vesa Jääskeläinen
