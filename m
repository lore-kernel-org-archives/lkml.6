Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C85208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLcv5YzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C85208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGDUhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:37:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51120 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeGDUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:36:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so7900299wmc.0;
        Wed, 04 Jul 2018 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giNNzaoITV3d3w2gG1HaKrtHH8wad/nuPqTc7z7GhA4=;
        b=qLcv5YzXSBiAD35EIrdFivHV9MB/gE1tO9hfcey88jtMDOYcPH8puwH5uOEH1m32SN
         lV47kk0H5a07QMhQUT5pJGFyW75NteVP1th5k5X43TBWBFc0764i1ZoaaFLnybh/y5tt
         wxYl4xeYEL9ot59gyaIK0n1Xp+4AlkkWF2gzo82w249t/O4G32n/Q1yuWz/YPibGCz3w
         W7EK/gqFEVVp/XxEEG5wiDSHY2WwQp6va91xCU0Gw2ivHdjEKIZ9TH9hBwegeZfPvQAd
         BlxLk+Y+ftX1tiiaEWE8AiW4TmwZgOKSSGzPYJK6JgSPR1DU+Wpj+ZdGLyqsnOH+L9JM
         mTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giNNzaoITV3d3w2gG1HaKrtHH8wad/nuPqTc7z7GhA4=;
        b=rKIrSRKN1fX2BYrk6jm22ix3vR3o2lSZGzEnzKL8klFzw32gzio+xd3eNrUIQND9rB
         02RgcM0yepjWoW7IOA9wx9+RuZsMdUiZY1v7eeMrpA8kU6cO+WFM2nxkcdjCpLfzjDPQ
         +MdVtYKebXnBcSLpV/BcXqBv1DrYe62URahGY8Ho7p6dae3JzSvU23uAbTOe4nvKhDRb
         txsBMiTW8t0GV+3GSZu7PwVeG7Bv6g5iPbka/BbwL4THX3HEM6mezD4xA9rNOrdz8iY3
         aOZ1/GutFHnKsKcQ+CVra0i+/m6EzE0i+IfzV7/TvyYy97LIttxGPO08Jdo15cVKi4Xh
         5bZg==
X-Gm-Message-State: APt69E3/PVsIpj9+GKEsd3Pw6Z6qbfSpfznu6NUJh0mLvyWeftaB4YEa
        1tz0zgghXwG5NwzqoKJEVsVUCtGM
X-Google-Smtp-Source: AAOMgpd5iR7Im2EhpiTbqRC2HpbrmsrQyQa30UY0L1Q6Bs0MPrEM3rTzwjNO0FMkAlCM7yP4TaVOsQ==
X-Received: by 2002:a1c:9042:: with SMTP id s63-v6mr2307122wmd.91.1530736617850;
        Wed, 04 Jul 2018 13:36:57 -0700 (PDT)
Received: from [192.168.1.18] (chl46.neoplus.adsl.tpnet.pl. [83.31.9.46])
        by smtp.gmail.com with ESMTPSA id l17-v6sm7983613wrh.45.2018.07.04.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 13:36:57 -0700 (PDT)
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
To:     Pavel Machek <pavel@ucw.cz>, Willy Tarreau <w@1wt.eu>
Cc:     Andreas Klinger <ak@it-klinger.de>, ben.whitten@gmail.com,
        geert+renesas@glider.be, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180703155328.GA18299@arbeit> <20180704065305.GA23509@amd>
 <20180704073443.GA9388@1wt.eu> <20180704181916.GA10785@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6a24e147-f2c7-9d82-0ce6-3238adf892b0@gmail.com>
Date:   Wed, 4 Jul 2018 22:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180704181916.GA10785@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 07/04/2018 08:19 PM, Pavel Machek wrote:
> Hi!
> 
>> On Wed, Jul 04, 2018 at 08:53:05AM +0200, Pavel Machek wrote:
>>> As I stated before, I don't think morse encoder belongs in kernel.
>>
>> On the opposite, I think that the kernel needs to be a bit more autonomous
>> when it comes to reporting its own issues. Being able to report a panic
>> when userland cannot be accessed for example is the reason why we've seen
>> various features such as blinking keyboard LEDs for this.
> 
> Being able to report panics by blinking would be nice... but proposed
> patch does NOT do that.

Actually we do have already drivers/leds/trigger/ledtrig-panic.c.

>>> LED pattern trigger should be merged, instead.
>>
>> Well, just like we have LED and LED triggers in the kernel, I think having
>> a generic way to use patterns could be nice and in this case Morse could be
>> one such pattern, but if that means it's limited to userland to configure
>> it then it sadly voids all of its benefits.
> 
> Proposed patch is already limited to configuration from userland... so
> it does not have any benefits.

We could turn this piece of code into a lib and make it usable by
both kernel/panic.c (similar to panic_blink) as well by
the ledtrig-morse.c.

> If special "panic blinking" mode is wanted -- I guess that would make
> sense.
> 
> But
> 
> a) trigger may not be right infrastructure for that; triggers need
> quite a lot kernel to be working, as they run in separate threads --
> panic blinking probably should be mdelay / brightness set / mdelay,
> and probably limited to LEDs that can be accessed without sleeping.
> 
> b) we may want trigger to be used for something else (Caps lock? HDD
> activity?)  when not panicked. Thus, again, trigger is not exactly
> suitable. (It might make sense to blink many/all LEDs simultaneously
> to make it super obvious to the user).
> 
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
