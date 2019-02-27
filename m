Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D788C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9A218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldoOAqeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfB0AIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:08:16 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34014 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfB0AIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:08:16 -0500
Received: by mail-vk1-f196.google.com with SMTP id k64so3450218vke.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gz3WVXcko/jr6moLk0tMcJhOoECoPiEwbK1uAm8C2Zo=;
        b=ldoOAqehLlnSNgnMYgeoEwFp27pfYgtCTMiITBb/lBj1YzL+HQnTYCsIHolI4oX3PU
         RyPCzVjmXf5WTFimQ6ljY9WbGj3JckKPEJAd2B+lYZjd9iuUaf+td+Z2jNnnLj71hhKW
         Gjk+mMSIsH1TxBuU3pmGSqSi1vRi2jw1SRX6DzUordijgNglRZRFIivSW5v1tpEyTZkc
         Uaqud3XjeP8fxSeomcCQzdw9o3OHU02jKW3+I5AwWlwjQD6u0q4M1m0lHZM9lrlzrLbz
         6nxyvxlEl2X1eLPgoiADAn9zegFXCbFebXPIQXDjlpPnmgaiRnr7aYZ4LX24zn0am4XJ
         3VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gz3WVXcko/jr6moLk0tMcJhOoECoPiEwbK1uAm8C2Zo=;
        b=nsv01hJp/I/xOfCGqZE9wip6L+2gzSmYLaaK9QrEPOMTmkM5FNdsQEiblODgHgGBiS
         cmynrb5/wMPROuNQq/3e5UkEGsiean+4/tlUgLvuseAipaAlx34c5ffbXTI7IH1vxs6c
         KRmW1pNQ8w6SNY5B8A0X9iQxRBbdZuyRgow8cQBUZhjC24FAdQrq+GigxqYcbdlA5f9w
         Q2rWQYpaTEqUqU/H7CWzQ2q7VVTnx0DSGS2hdsiREM/ZjnQlR62hR4g03WwO2fq82+Ti
         FrTTIM1MQWKKO04GHNtJoe8zd+hukL8scj8VQ3EkS/Nyyww9sAuesu9iQHECc3HkiRD3
         uddA==
X-Gm-Message-State: AHQUAuYB+RXqG8MH1blqvxm/zJaqZTnCKERv9SsHkLRzUAs5om3x8sja
        JqTZYlPvdk6oLZlzUMX0wRi4O0dU0jqbHxxFLuDQwg==
X-Google-Smtp-Source: AHgI3IaZ1ZQDjqhvFCY5BBaJBaJrJlVI7mH5lxh93eMSGYrakuI6TVdwSw2x/2qO5nrS1dCi4PDdIZdPX09KVwAjvm0=
X-Received: by 2002:a1f:3253:: with SMTP id y80mr3077923vky.17.1551226095107;
 Tue, 26 Feb 2019 16:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org> <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
 <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com> <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 01:07:39 +0100
Message-ID: <CAPDyKFoNJhfxMEa+HpjupUWaT3-JQ2dUgy6iBwqjxFergUzPaw@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 at 00:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 27, 2019 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > A common piece of data used by cpuidle governors, is the information about
> > > > when the next timer/tick is going to fire. Rather than having each governor
> > > > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > > > the code by calling these functions before invoking the ->select() callback
> > > > of the governor - and store the output data in the struct cpuidle_device.
> > >
> > > That misses the point IMO.
> > >
> > > You don't need to store two values in struct cpuidle_device, but just
> > > one, and not before running ->select(), but before invoking the
> > > driver's ->enter() callback.
> >
> > Okay! Thanks for letting me know!
> >
> > >
> > > At that point, the decision on whether or not to stop the scheduler
> > > tick has been made already and it should be sufficient to store the
> > > return value of tick_nohz_get_next_hrtimer() introduced by patch
> > > [3/8], because that value represents the next timer regardless of what
> > > has been decided with respect to the tick.
> >
> > Just to make sure I get this correctly, because it seems like I have
> > missed a few points here....
> >
> > If we decided to keep the tick running, then
> > tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
> > whatever that comes first. There are no other timer that can expire
> > earlier than this, right!?
> >
> > If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
> > give us the next hrtimer. Again, then there are no other timer that
> > can't expire earlier than this, right!?
>
> Right in both cases.
>
> IOW, that is the event that will wake up the CPU unless any other
> (non-timer) interrupts (or equivalent events) occur in the meantime.
>
> > >
> > > And you won't need the tick_nohz_get_next_timer() any more then.
> >
> > Alright, this kind of brings this hole thing back closer to v10 - and
> > then we should stick to use tick_nohz_get_sleep_length() as is for the
> > cpuidle governors. That is what you are saying?
>
> For the menu and teo governors - yes.  IMO
> tick_nohz_get_sleep_length() is as good as it gets in there.

Okay, got it! Thanks for your helpful answers!

I will post a v12 as soon as I can, so we can look into the other
parts of the series.

Kind regards
Uffe
