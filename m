Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E12084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxs6+VXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfASWoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:44:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37703 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbfASWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:44:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so13000505lfj.4;
        Sat, 19 Jan 2019 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0YOTIMsx7Tz+0+MhwsFS0SOqJvKIQRQut62VGkLkHc=;
        b=Jxs6+VXJML5Fx9X+DS7ccW1KqkjrBYoWTOj2L1ydlVcDJHFdivvIkSbXdkMRMBFUFu
         0LuxfP9bFTF+2Zja8O+WJCjP+Tl+EIACVTRRT9QdIzuocAU8tS5UtH5dV9QgMTtNQ4Ke
         gsvAizRr8g+x7+3yXww14bpkRk7EMnsXicQuwcJP5A8beJYNF7+GCHLjiBGXhFFsKR/J
         lCgTAsYrHxxOMdHLCrgFJgAZ0FOEBgNJC6Y04oYc1cuogtiTw3aH9rLeag3XMf7XTjfV
         qMFyPF/BSQT85I9n9k+K8GPQV05HTrBIp9phd9CnGrcTTgrDCSrZNEN6PIojym2PDNhj
         jExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0YOTIMsx7Tz+0+MhwsFS0SOqJvKIQRQut62VGkLkHc=;
        b=fbmGeLs0wAFOziaTy6LnVcHmwAJHBKKL3W+bPIW7AwViDO1ywDE+HosrXcXZTA7MX0
         iW9MFXQeJyAJVskSb6sNaiP0fg4QkBw+snG9zRhpRknpuxj7l+2xvfiOYjzTXxd5kmtf
         VrGLR5Y0ugio9tlXdzpPvuvDcsYjTvzYO8u1bGwhzOmbO9peUQzBoVf3DCC/aOI4UVQt
         1dZAW8kofnksVnhFa+Eo+QnzcOGm4rGXDL3xCuTCvRc4L8pitJpqZFka7eK6Sd13hh1/
         ZBLOvHLys211/C1KafqlW6I/SOqdzOflvSCBg1qsRo7lYu2mnvTUSfxOC5Nd/FaBE1K3
         niig==
X-Gm-Message-State: AJcUukdoaLZf95ZQHR5hqT3aeK2v0w3RxdXFLuIYTCYuUZ013WrguJkW
        yj1E8DTVffF31hTaEep3pe0=
X-Google-Smtp-Source: ALg8bN4zcMdoTOdmTw+L/7y8hc9/VH2We7K2h457+G3DgF/96Kn65/1vGkq+1t39gqvSxEoxQJqZpg==
X-Received: by 2002:a19:c014:: with SMTP id q20mr14492527lff.16.1547937857606;
        Sat, 19 Jan 2019 14:44:17 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:7056:8bb8:4271:58c3? (dtynxhydtm6g7ttxvndbt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:7056:8bb8:4271:58c3])
        by smtp.googlemail.com with ESMTPSA id j25-v6sm1436651lji.77.2019.01.19.14.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 14:44:17 -0800 (PST)
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
Message-ID: <90b9a3f3-c42b-ac65-a6bf-08f94fdff47c@gmail.com>
Date:   Sun, 20 Jan 2019 00:44:15 +0200
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
> 
>> # Setting up color to not so bright purple with brightness set to 255
>> $ echo "32 0 32 255" > color
> 
>> # Setting up color to a bit brighter purple with brightness
>> $ echo "128 0 128 255" > color
> 
> This would require colorspace conversion in kernel. I have:
> 
>      	    scales = (1., 0.39, 0.11) # for n900
>              val = map(lambda x: int((x**2.2)*255), val)
> 	    (r, g, b) = val
> 
> 	    (r_, g_, b_) = m.scales
> 	    red = r*r_
> 	    ...
> 
> x**2.2 is simplified, real expression is more complex. But it is
> floating point math...
> 
> Do we want to do that?

If we would have range in user space let say 0..255 for components and 
then in devicetree we could define ramp for each of the element like 
what is done for backlight pwm [1] [2].

I believe this would generate same result and user space interface would 
be a bit easier than writing direct pwm/power values.

You could then tune this ramp based on properties of your led. And if 
you ran your software in another device it could behave similarly only 
requiring tuning in devicetree.

For some of our lcd backlights we had generate non-linear ramp 
definition in devicetree to have linearly looking response when user 
configures brightness values from 0-100.

Definition could be something like this in devicetree:

element-red {
	pwms = <&ehrpwm0 0 100000 0>;
	
	brightness-levels = <0 128 256 1024 2048 4096 8192 16384 65535>;
	num-interpolated-steps = <32>;
};

Don't know if better name would actually be in this case "ramp-levels" 
or such. Used pwm-backlights terminology in this example.

[1] 
https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/backlight/pwm_bl.c?h=v5.0-rc2#n253

Thanks,
Vesa Jääskeläinen
