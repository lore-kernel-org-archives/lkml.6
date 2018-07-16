Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD51ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4224220B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGum3KFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224220B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeGPJfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:35:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37388 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeGPJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:35:39 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so73364582oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0hjmIEb4Vp26fAEhcWur+eAoGWLgTBDtv1WwDF3w0HU=;
        b=dGum3KFNRXGJNjfMSZ/ZvOpFsDYrcTeac1GBYjOG0Bzhy1ieTP0H1F73H8lxT6vxYU
         k07qN7Qb0TO8QE7KP7lL57Xt//kKAi8DNIqS0gUo5GfBcRsHlXsBadWH0RugjHyQKse0
         kZUmF6hx/4gKHusVsd92sFtabKPqDMIcG7Uow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0hjmIEb4Vp26fAEhcWur+eAoGWLgTBDtv1WwDF3w0HU=;
        b=TGTfIGUcttthJBcARJZSO4PRDwt0PPsSS5h3dWH7e1F5xTDvbmTJKX2nHAr0IiNcIf
         JzeQ8ar/mBpq9GkRsh9OSNJhyIpjuZLzvms993XX1ik+cf/2ZRzXP3cdrf5tUWrBfU7G
         it9smrCcRKq2rMwL6yzZlZa46p2klKK/QtDJWHj07q49Qx7JoPI750IqbKKEqRqwdX3x
         pRtFsjWUEAs92PSlADYYjuldCsq3+El7FgpkRBEOu2h9MKo1zR+HxPI2bzroblXek/hq
         RzjryXuGFUJsTv9YTd288xiXRchOI6ZildJm48yEy6eIQxrmlYXfK9869Re6ASyhvXPm
         5LQA==
X-Gm-Message-State: AOUpUlE38MssmOlhccsyUmn3789mb0oVzHujU5BqM8w9UnWCZ7ny4Rvs
        J0qgVyY5EgGkl200D2rkTL+++gAcgaCgUx0ziZVTVQ==
X-Google-Smtp-Source: AAOMgpehGs5gQQhnGMECv0kFEA0SapKU60ixiIimr7vfN9rfotmbIpJMDG43G2KGKj00GX1+wQ5pW2bIsKDRCzSeIwQ=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr18300088oie.168.1531732153510;
 Mon, 16 Jul 2018 02:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 02:09:13
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807161010390.2644@nanos.tec.linutronix.de>
References: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1807161010390.2644@nanos.tec.linutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 16 Jul 2018 17:09:13 +0800
Message-ID: <CAMz4kuLoBkEAFozKt2ji=-FEyG6epH0g4afZA1sOZDp-vBWbGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] time: Introduce one suspend clocksource to
 compensate the suspend time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 16 July 2018 at 16:28, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 12 Jul 2018, Baolin Wang wrote:
>> On some hardware with multiple clocksources, we have course grained
>> clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
>> which are less ideal for timekeeping then other clocksources which
>> halt in suspend.
>>
>> Currently, the timekeeping core only supports timing suspend using
>> CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
>> current clocksource for timekeeping.
>>
>> As a result, some architectures try to implement read_persisitent_clock64()
>> using those non-stop clocksources, but isn't really ideal. Thus this
>> patch provides logic to allow a registered SUSPEND_NONSTOP clocksource,
>
> Please see Documentation/process/submitting-patches.rst and search for
> 'This patch...'

OK, I will try to improve the commit message.

>
>> +/**
>> + * clocksource_suspend_select - Select the best clocksource for suspend timing
>> + * @fallback:        if select a fallback clocksource
>> + */
>> +static void clocksource_suspend_select(bool fallback)
>> +{
>> +     struct clocksource *cs, *old_suspend;
>> +
>> +     old_suspend = suspend_clocksource;
>> +     if (fallback)
>> +             suspend_clocksource = NULL;
>> +
>> +     list_for_each_entry(cs, &clocksource_list, list) {
>> +             /* Skip current if we were requested for a fallback. */
>> +             if (fallback && cs == old_suspend)
>> +                     continue;
>> +
>> +             __clocksource_suspend_select(cs);
>> +     }
>> +
>> +     /* If we failed to find a fallback restore the old one. */
>> +     if (!suspend_clocksource)
>> +             suspend_clocksource = old_suspend;
>
> That's for the case where something tries to remove a clocksource, right?

Yes.

> The logic here looks odd as the calling code for the fallback case has to
> check whether the clocksource which is about to be removed is the suspend
> clocksource. Why not just returning -EBUSY/0 for the fallback case?
>
> The other question is whether this should be enforced. We might as well
> decide to just let the clocksource go and have no suspend clocksource.

OK.

>
>> +/**
>> + * clocksource_start_suspend_timing - Start measuring the suspend timing
>> + * @cs:                      current clocksource from timekeeping
>> + * @start_cycles:    current cycles from timekeeping
>> + *
>> + * This function will save the start cycle values of suspend timer to calculate
>> + * the suspend time when resuming system.
>> + *
>> + * This function is called late in the suspend process from timekeeping_suspend(),
>> + * that means processes are freezed, non-boot cpus and interrupts are disabled
>> + * now. It is therefore possible to start the suspend timer without taking the
>> + * clocksource mutex.
>> + */
>> +void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
>> +{
>> +     if (!suspend_clocksource)
>> +             return;
>> +
>> +     /*
>> +      * If current clocksource is the suspend timer, we should use the
>> +      * tkr_mono.cycle_last value as suspend_start to avoid same reading
>> +      * from suspend timer.
>> +      */
>> +     if (clocksource_is_suspend(cs)) {
>> +             suspend_start = start_cycles;
>> +             return;
>> +     }
>> +
>> +     if (suspend_clocksource->enable &&
>> +         WARN_ON_ONCE(suspend_clocksource->enable(suspend_clocksource))) {
>> +             pr_warn_once("Failed to enable the non-suspend-able clocksource.\n");
>> +             return;
>
> This is horrible to read and the WARN is really not helpful because
> the bracktrace is already known.

Sure, will remove the WARN_ON_ONCE().

>
>> @@ -779,6 +910,16 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
>>  {
>>       unsigned long flags;
>>
>> +     /*
>> +      * The nonstop clocksource can be selected as the suspend clocksource to
>> +      * calculate the suspend time, so it should not supply suspend/resume
>> +      * interfaces to suspend the nonstop clocksource when system suspends.
>> +      */
>> +     if ((cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
>> +         (cs->suspend || cs->resume))
>> +             pr_warn("Nonstop clocksource %s should not supply suspend/resume interfaces\n",
>> +                     cs->name);
>
> Lacks braces.
>
> See https://lkml.kernel.org/r/alpine.DEB.2.20.1701171956290.3645@nanos

OK. I will add braces in next version. Thanks for your comments.

>
> Othar that the few nits this looks good. Nice work!
>
> Thanks,
>
>         tglx



-- 
Baolin Wang
Best Regards
