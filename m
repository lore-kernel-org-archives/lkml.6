Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE81C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB3218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJgTRYKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfBZXQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:16:26 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46985 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfBZXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:16:26 -0500
Received: by mail-ua1-f67.google.com with SMTP id j8so13536575uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41Zrub4wVCT2G5PoRjJrsqTrwu869H7N7bztR4hcKg0=;
        b=BJgTRYKae0hazHS7A+jTV1eciLuFR/4pqeUdbnWljFo3HuMV04RmQy6NWsL2fap/tb
         HbWRib++4tUot+OW5VNSiMWISvpejsf6L5iTa5R5v2XW9h72VO2lkxOfh3nsn72Kkd3M
         7WfobJaM7IXwnGpFr1mbsyCKvgJO+M0ojE5NPKigSBEGjabmACUIIYvh3r89ONfd8D9c
         xGn5wCB02L8ZOpL/3UV46X4bHQlqayb3IiaUdrUiGzQHi4A+m+kPcl9CloaFZBEE/f/1
         LS5vm9htKPTtweH1Cqsxkosyk0Pd+oXaD4bPLron08K45cILgtfjjW25ZyrBDKwrPgp4
         aWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41Zrub4wVCT2G5PoRjJrsqTrwu869H7N7bztR4hcKg0=;
        b=E3SFWaDYOB5vkgbUsIyWCMR2h08JlLH2qgApKkrxufJMY4mL7jGUumGBg9nALUnopv
         TZyVlXZDXVD6MAdq7rxBPHMFk9QEKmCJ7OAvM/m3NEwd5PSVkw7tK8MJzgkop7dPv6KU
         QV3T/QnQA1ZzZKuDb/Sz8/bzB6jxT91FFtpua+WJdw1yolBVi5z+mH8Ihonqf5p3A2tO
         en1M8w7yTAoFRbLc+SNDhPokzy7DUK9KCbnFxIMn3Z7TG2CNCos5BWjvSUF6rZGs5AQ+
         Lq150tBfmK7DdAeuMnwnyaVMPx0lr2Cyzx6DBBO2aChsqQliIvsqbN9mg9gyYRl5fp2x
         w6/w==
X-Gm-Message-State: AHQUAuakBi3au6//kJIWVE6lDJJonWUmadW7RgvJ9Y5rWNMofAt/Pefu
        a91HCGhfDA3mZimntjD2mV34YiAjl6f+0jZOoGwFpQ==
X-Google-Smtp-Source: AHgI3Ib3BonZnsqURTfnizR+OnA7jsVz4uaePaJyJHnVGM39c7hyRdd1BPvj5mDyKs8J1Npu8e/W8s3Iemj9XwkliUA=
X-Received: by 2002:a67:8055:: with SMTP id b82mr172508vsd.200.1551222984686;
 Tue, 26 Feb 2019 15:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org> <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 00:15:48 +0100
Message-ID: <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
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

On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > A common piece of data used by cpuidle governors, is the information about
> > when the next timer/tick is going to fire. Rather than having each governor
> > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > the code by calling these functions before invoking the ->select() callback
> > of the governor - and store the output data in the struct cpuidle_device.
>
> That misses the point IMO.
>
> You don't need to store two values in struct cpuidle_device, but just
> one, and not before running ->select(), but before invoking the
> driver's ->enter() callback.

Okay! Thanks for letting me know!

>
> At that point, the decision on whether or not to stop the scheduler
> tick has been made already and it should be sufficient to store the
> return value of tick_nohz_get_next_hrtimer() introduced by patch
> [3/8], because that value represents the next timer regardless of what
> has been decided with respect to the tick.

Just to make sure I get this correctly, because it seems like I have
missed a few points here....

If we decided to keep the tick running, then
tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
whatever that comes first. There are no other timer that can expire
earlier than this, right!?

If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
give us the next hrtimer. Again, then there are no other timer that
can't expire earlier than this, right!?

>
> And you won't need the tick_nohz_get_next_timer() any more then.

Alright, this kind of brings this hole thing back closer to v10 - and
then we should stick to use tick_nohz_get_sleep_length() as is for the
cpuidle governors. That is what you are saying?

Kind regards
Uffe
