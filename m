Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11552C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23312642F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDxCrb1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23312642F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965220AbeFZCIO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:08:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40042 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965188AbeFZCIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:08:11 -0400
Received: by mail-ot0-f194.google.com with SMTP id f17-v6so727071otl.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cwwVmVnKR3DEkZM9t1ier25qtIX11hnesWtLLjOM3Ps=;
        b=UDxCrb1tzQuwiJJbT+kRXn1xoe2SpvBblgTDDVxm+51ZqbMCT6UoxUtLWfSusqSAqv
         IaCVZiQD/H9LJt6xelcIDlYp8AbNfQZtmBLQh4B/DLYpvRbi8MrjRrKr5eL8FSTPnByF
         qmPqk74ed6kzK4Ef2pxBxcylcwjaF4K6lb0j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cwwVmVnKR3DEkZM9t1ier25qtIX11hnesWtLLjOM3Ps=;
        b=KtG4SR7Ve2QiwwYOAY5k3YJF/K6SgFY90PdVr1qvFl6MhhE7QQ+nIjwoSRvImGqE+1
         R+EZTh2azuVh3dHgE9/Nep1V+LTtv638RMus4r43mrJubhH0nuJY0ld5WdYdnRi3M05c
         Mn9+JU5JF8uAofCLdSsbzKSeIKxw1rOVatdNstjYBLaYtMNp21O93B2croF9g9oTWeTd
         IYmTYvylOXm/v4wrH1ZCx4p5lKgNNigN9p+XtER6dgXsiSfSIMC4qAdI2CrfT8etuye6
         0O3WHOXq8iijnk+clbxUSW4YXHGkRrukPvcLo1qYDbbD3fnRTjp1GPWZI8esbn/Ab0dU
         9SeQ==
X-Gm-Message-State: APt69E3HeY62l87qTxxpq//gvgnZtqKByFQWFuFNN0ooCcKfaPXdfs21
        Nkp+k41oY3chf5x2gCg3+UZfqfjDmYB0MQVGx+qoOQ==
X-Google-Smtp-Source: ADUXVKJVfNCqQQx6zaPszJW2vzMut5RScRoG0H5jpjgMHNDj1a4qMgW7KgrdKPk357Aj4gWiEKnpgKTFFA2Frq25+oU=
X-Received: by 2002:a9d:4c0f:: with SMTP id l15-v6mr9543599otf.26.1529978890728;
 Mon, 25 Jun 2018 19:08:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 19:08:10
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 26 Jun 2018 10:08:10 +0800
Message-ID: <CAMz4kuLht0BAHdFp8+WPTanWSJCbioG+uwdoaKJCLDbcRkKXfg@mail.gmail.com>
Subject: Re: [PATCH 1/8] time: Add persistent clock support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi,
        linux@armlinux.org.uk, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        mlichvar@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 24 June 2018 at 08:14, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 13 Jun 2018, Baolin Wang wrote:
>> Moreover we can register the clocksource with CLOCK_SOURCE_SUSPEND_NONSTOP
>> to be one persistent clock, then we can simplify the suspend/resume
>> accounting by removing CLOCK_SOURCE_SUSPEND_NONSTOP timing. After that
>> we can only compensate the OS time by persistent clock or RTC.
>
> That makes sense because it adds a gazillion lines of code and removes 5?
> Not really,
>
>> +/**
>> + * persistent_clock_read_data - data required to read persistent clock
>> + * @read: Returns a cycle value from persistent clock.
>> + * @last_cycles: Clock cycle value at last update.
>> + * @last_ns: Time value (nanoseconds) at last update.
>> + * @mask: Bitmask for two's complement subtraction of non 64bit clocks.
>> + * @mult: Cycle to nanosecond multiplier.
>> + * @shift: Cycle to nanosecond divisor.
>> + */
>> +struct persistent_clock_read_data {
>> +     u64 (*read)(void);
>> +     u64 last_cycles;
>> +     u64 last_ns;
>> +     u64 mask;
>> +     u32 mult;
>> +     u32 shift;
>> +};
>> +/**
>> + * persistent_clock - represent the persistent clock
>> + * @read_data: Data required to read from persistent clock.
>> + * @seq: Sequence counter for protecting updates.
>> + * @freq: The frequency of the persistent clock.
>> + * @wrap: Duration for persistent clock can run before wrapping.
>> + * @alarm: Update timeout for persistent clock wrap.
>> + * @alarm_inited: Indicate if the alarm has been initialized.
>> + */
>> +struct persistent_clock {
>> +     struct persistent_clock_read_data read_data;
>> +     seqcount_t seq;
>> +     u32 freq;
>> +     ktime_t wrap;
>> +     struct alarm alarm;
>> +     bool alarm_inited;
>> +};
>
> NAK!
>
> There is no reason to invent yet another set of data structures and yet
> more read functions with a sequence counter. which are just a bad and
> broken copy of the existing timekeeping/clocksource code. And of course the
> stuff is not serialized against multiple registrations, etc. etc.
>
> Plus the utter nonsense that any call site has to do the same thing over
> and over:
>
>     register():
>     start_alarm_timer();
>
> Why is this required in the first place? It's not at all. The only place
> where such an alarm timer will be required is when the system actually goes
> to suspend. Starting it at registration time is pointless and even counter
> productive. Assume the clocksource wraps every 2 hours. So you start it at
> boot time and after 119 minutes uptime the system suspends. So it will
> wakeup one minute later to update the clocksource. Heck no. If the timer is
> started when the machine actually suspends it will wake up earliest in 120
> minutes.
>
> And you even add that to the TSC which does not need it at all. It will
> wrap in about 400 years on a 2GHZ machine. So you degrade the functionality
> instead of improving it.
>
> So no, this is not going anywhere.
>
> Let's look at the problem itself:
>
>    You want to use one clocksource for timekeeping during runtime which is
>    fast and accurate and another one for suspend time injection which is
>    slower and/or less accurate because the fast one stops in suspend.
>
>    Plus you need an alarmtimer which makes sure that the clocksource does
>    not wrap around during suspend.
>
> Now lets look what we have already:
>
>    Both clocksources already exist and are registered as clocksources with
>    all required data in the clocksource core.
>
> Ergo the only sane and logical conclusion is to expand the existing
> infrastructure to handle that.
>
> When a clocksource is registered, then the registration function already
> makes decisions about using it as timekeeping clocksource. So add a few
> lines of code to check whether the newly registered clocksource is suitable
> and preferred for suspend.
>
>         if (!stops_in_suspend(newcs)) {
>                 if (!suspend_cs || is_preferred_suspend_cs(newcs))
>                         suspend_cs = newcs;
>         }
>
> The is_preferred_suspend_cs() can be based on rating, the maximum suspend
> length which can be achieved or whatever is sensible. It should start of as
> a very simple decision function based on rating and not an prematurely
> overengineered monstrosity.
>
> The suspend/resume() code needs a few very simple changes:
>
> xxx_suspend():
>         clocksource_prepare_suspend();
>
>   Note, this is _NOT_ timekeeping_suspend() because that is invoked _AFTER_
>   alarmtimer_suspend(). So if an alarm timer is required it needs to be
>   armed before that. A trivial solution might be to just call it from
>   alarmtimer_suspend(), but that a minor detail to worry about.
>
> timekeeping_suspend()
> {
>         clocksource_enter_suspend();
>         ...
>
> timekeeping_resume()
> {
> ...
>         if (clocksource_leave_suspend(&nsec)) {
>                 ts_delta = ns_to_timespec64(nsec);
>                 sleeptime_injected = true;
>         } else if (......
>
>
> Now lets look at the new functions:
>
> void clocksource_prepare_suspend(void)
> {
>         if (!suspend_cs)
>                 return;
>
>         if (needs_alarmtimer(suspend_cs))
>                 start_suspend_alarm(suspend_cs);
> }
>
> void clocksource_enter_suspend(void)
> {
>         if (!suspend_cs)
>                 return;
>         suspend_start = suspend_cs->read();
> }
>
> bool clocksource_leave_suspend(u64 *nsec)
> {
>         u64 now, delta;
>
>         if (!suspend_cs)
>                 return false;
>
>         now = suspend_cs->read();
>         delta = clocksource_delta(now, suspend_start, suspend_cs->mask);
>         *nsec = mul_u64_u32_shr(delta, suspend_cs->mult, suspend_cs->shift);
>         return true;
> }
>
> See? It does not need any of this totally nonsensical stuff in your
> registration function and not any new read functions and whatever, because
> it simply can use the bog standard mult/shift values. Why? Because the
> conversion above can cope with a full 64 bit * 32 bit multiply without
> falling apart. It's already there in timekeeping_resume() otherwise
> resuming with a NONSTOP TSC would result in bogus sleep times after a few
> minutes. It's slower than the normal clocksource conversion which is
> optimized for performance, but thats completely irrelevant on resume. This
> whole blurb about requiring separate mult/shift values is just plain
> drivel.
>
> Plus any reasonably broad clocksource will not need an alarmtimer at
> all. Because the only reason it is needed is when the clocksource itself
> wraps around. And that has absolutely nothing to do with mult/shift
> values. That just depends on the frequency and the bitwidth of the counter,
>
> So it does not need an update function either because in case of broad
> enough clocksources there is absolutely no need for update and in case of
> wrapping ones the alarmtimer brings it out of suspend on time. And because
> the only interesting thing is the delta between suspend and resume this is
> all a complete non issue.
>
> The clocksource core already has all the registration/unregistration
> functionality plus an interface to reconfigure the frequency, so
> clocksources can come and go and be reconfigured and all of this just
> works.
>
> Once the extra few lines of code are in place, then you can go and cleanup
> the existing mess of homebrewn interfaces and claim that this is
> consolidation and simplification.

I am very grateful for your suggestion, and I am sorry I made a stupid
mistake that I missed the mul_u64_u32_shr() function which can avoid
introducing extra mult/shift for suspend clocksource. I will use that
and follow your other suggestions too. Thanks again.

>
> <rant>
>
> What's wrong with you people? Didn't they teach you in school that the
> first thing to do is proper problem and code analysis? If they did not, go
> back to them and ask your money back,
>
> I'm really tired of these overengineered trainwrecks which are then
> advertised with bullshit marketing like the best invention since sliced
> bread. This might work in random corporates, but not here.
>
> </rant>
>
> Thanks,
>
>         tglx



---
Baolin Wang
Best Regards
