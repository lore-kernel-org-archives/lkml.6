Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27537C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FF420652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="coR1VsBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FF420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeJAPYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:24:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51405 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:24:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so7826217wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9CJMIeFcZ8iHn0hpKm44TFWAl3+X4CN67TLXf13aHQ=;
        b=coR1VsBEtj0kJ1mZ1jz3pdAAyyaBlxiuk2frl4y5X8VJE1LePtX7bIHldJIM/vj0g2
         QjCVjyDAZSDkDaqG0JipfD4lB//hPsl15DZKsQqi4jd0V5boaYQfWNi7xUbxGhx4ko8L
         BQNGgwijfPNRf49zwHCw6HGupZcyuI+2W5pyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9CJMIeFcZ8iHn0hpKm44TFWAl3+X4CN67TLXf13aHQ=;
        b=Kjp9azu/OE8f3CJzuK5KzhmaErnnIC9JDGzsDsThaIJUwcCWZkU4kESFK/WAMSjJJ4
         YTHn2Poxr4nHHEkUXfduwmU+8orynFv1Y2SrDAxLIrL6s6k9794AcKNRdIuVHpXy3vvL
         DiLoUKrCVYq08OlKNf4PXMY6heMuEKtHeOKz7PASJUrUj2nxuBMQSDD+RTJjktjBm+lA
         GBPaq60EUj2aemHPI4mp6QAnDxf+Ml9C0Enp+ZpNgwfsQ5fEMTLE7l/fjQocqJSviLyC
         Jqa0AvhjU2jjCoRtUGBnjVuGd3PvdSPQATEB5YtE7kmFcuhGQml7aCh0Zkf+Fe9GWfjg
         6TQg==
X-Gm-Message-State: ABuFfohPx4xZDV3Qb19hh9FXLVG9LBaGdM9dMEU1x/3Ic4doneSyzbrm
        AhM7IfvA6tC+3VptV0da+uhZow==
X-Google-Smtp-Source: ACcGV62LzPXNoNM/2l/782JIfbTjRdlJCfbQwG6SIEKlNUaGeWtwPFoB1MROs3+5LPaj+nbPeC3VeA==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr7895873wmb.29.1538383691997;
        Mon, 01 Oct 2018 01:48:11 -0700 (PDT)
Received: from [192.168.0.41] (210.183.88.92.rev.sfr.net. [92.88.183.210])
        by smtp.googlemail.com with ESMTPSA id a18sm10442301wrx.55.2018.10.01.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 01:48:11 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-5-paul@crapouillou.net>
 <20180725152105.GA6347@rob-hp-laptop>
 <1532988062.4702.2@smtp.crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfecfae5-abd0-c051-51a3-cb5d906006e9@linaro.org>
Date:   Mon, 1 Oct 2018 10:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532988062.4702.2@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2018 00:01, Paul Cercueil wrote:

[ ... ]

>>>  +- ingenic,timer-channel: Specifies the TCU channel that should be
>>> used as
>>>  +  system timer. If not provided, the TCU channel 0 is used for the
>>> system timer.
>>>  +
>>>  +- ingenic,clocksource-channel: Specifies the TCU channel that
>>> should be used
>>>  +  as clocksource and sched_clock. It must be a different channel
>>> than the one
>>>  +  used as system timer. If not provided, neither a clocksource nor a
>>>  +  sched_clock is instantiated.
>>
>> clocksource and sched_clock are Linux specific and don't belong in DT.
>> You should define properties of the hardware or use existing properties
>> like interrupts or clocks to figure out which channel to use. For
>> example, if some channels don't have an interrupt, then use them for
>> clocksource and not a clockevent. Or you could have timers that run in
>> low-power modes or not. If all the channels are identical, then it
>> shouldn't matter which ones the OS picks.

It can't work in this case because the pmw and the timer driver are not
communicating and the first one can stole a channel to the last one.


> We already talked about that. All the TCU channels can be used for PWM.
> The problem is I cannot know from the driver's scope which channels will
> be free and which channels will be requested for PWM. You suggested that I
> parse the devicetree for clients, and I did that in the V3/V4 patchset. But
> it only works for clients requesting through devicetree, not from platform
> code or even sysfs.
> 
> One thing I can try is to dynamically change the channels the system timer
> and clocksource are using when the current ones are requested for PWM. But
> that sounds hardcore...

Yes, it is :/

Sorry for letting you wasting time and effort to write an overkill code
not suitable for upstream.

A very gross thought, wouldn't be possible to "register" a channel from
the timer driver code in a shared data area (but well self-encapsulated)
and the pwm code will check such channel isn't in use ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

