Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C8C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8B20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549622130;
	bh=BTNM4OSgPw0aPA8zl/Yl7WJgEFxl9DKiQCtMgXx46TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r6lJfqYeDKbjBAJX3CGzvEDPniAllyS9bj9exOwZCBKbFxXWruRB53XH4wCTLMCyK
	 mKAM5jvgJaZYbPpCALF7daji9q8TFJ7W6I1l7qBEEN040z2dr5rC8UvT+y6wB9DsiK
	 ZFludM1HcPzn5NKUSH91c+7PiIXXYEqwV6+ELB80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBHKf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:35:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35130 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfBHKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:35:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so1013277otm.2;
        Fri, 08 Feb 2019 02:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJA4oBQW3H3CehjYV9j61O4YMjUk5a6LBQziyx0qEGI=;
        b=sjvuPk9w+Jea/U17sO0SwTHKloP2p4knpxFHaIuXLwogU6+OVe/XiFr1i5nsPLKpvM
         n0F3rLz9XQoL6djJNeIm3Wk726n/x/Jj+D21meLp0aK42+syusZ6L2wWOPBhrclpS5d+
         r4Aq7j09soy2e4vJY0f02b5hrolWWjsX5K7WsXGozADtMmBIMKyOTu5bwa739EilnHtY
         uBEqV9dx01JALGpcs4bNEIDlMNk0xLyl6wbk0Uz0uttuBkjFGp1Qm0L7eCFuZ+fVFYLr
         MPsBH/rX1an/mJISQVCwe7Q7zdv9MnxW4+z639kMq7uVFDXSqgD9PFGdkEPIJsDByU/z
         Pnow==
X-Gm-Message-State: AHQUAub1Hn4bMR/JGK4Lai9Gns1fNGjz6BtUeMetSMMIBq8EHTzu9Aw6
        4MhqBv2P5xzG0n650wWP62Ix6iKUzkhbKA0D6ik=
X-Google-Smtp-Source: AHgI3IacHbQ/lWmO2VLbaUhVFCU/lPKkV5hafX1Ioytr/3mE5oYp7r9O5RA1eVbpS5Sgd17vwsutPZJKg3dJoz4At0k=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr12823805otl.343.1549622126442;
 Fri, 08 Feb 2019 02:35:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547197612.git.viresh.kumar@linaro.org> <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7> <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
 <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
In-Reply-To: <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 11:35:15 +0100
Message-ID: <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 10:53, Rafael J. Wysocki wrote:
> > On Fri, Feb 8, 2019 at 10:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 11-01-19, 10:47, Rafael J. Wysocki wrote:
> > > > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This commit introduces the frequency constraint infrastructure, which
> > > > > provides a generic interface for parts of the kernel to constraint the
> > > > > working frequency range of a device.
> > > > >
> > > > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > > > cpufreq framework already implements such constraints with help of
> > > > > notifier chains (for thermal and other constraints) and some local code
> > > > > (for user-space constraints). The devfreq framework developers have also
> > > > > shown interest [1] in such a framework, which may use it at a later
> > > > > point of time.
> > > > >
> > > > > The idea here is to provide a generic interface and get rid of the
> > > > > notifier based mechanism.
> > > > >
> > > > > Only one constraint is added for now for the cpufreq framework and the
> > > > > rest will follow after this stuff is merged.
> > > > >
> > > > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > > > this work and so I have added him as Co-author to the first patch.
> > > > > Thanks Matthias.
> > > > >
> > > > > FWIW, This doesn't have anything to do with the boot-constraints
> > > > > framework [2] I was trying to upstream earlier :)
> > > >
> > > > This is quite a bit of code to review, so it will take some time.
> > >
> > > @Rafael: You are going to provide some more feedback here, right ?
> >
> > I think I've said something already.
> >
> > TLDR: I'm not convinced.
> >
> > PM QoS does similar things in a similar way.  Why does it have to be a
> > different framework?
>
> I did it because no one objected to the initial proposal [1]. But you
> weren't directly cc'd (but only PM list) so can't blame you either :)
>
> Maybe we can make it work with PM QoS as well, I will see that aspect.

At least some of the underlying mechanics seem to be very similar.
You have priority lists, addition and removal of requests etc.

Arguably, PM QoS may be regarded as a bit overly complicated, but
maybe they both can use a common library underneath?

> > Using freq constraints for thermal reasons without coordinating it
> > with scheduling is questionable in general, because thermal control
> > may work against scheduling then.
>
> Sure, I agree but all we are talking about here is the mechanism with
> which the constraints should be put and it doesn't make things bad
> than they already are. With the notifiers in place currently, thermal
> core doesn't talk to scheduler.
>
> I think a different set of people are trying to fix that by issuing
> some calls to scheduler from thermal core, or something like that but
> I still consider that work orthogonal to the way constraints should be
> added instead of notifiers.
>
> Will implementing it the QoS way would be fine from thermal-scheduler
> standpoint ?

As I said I like the idea of replacing cpufreq notifiers with
something nicer, so if you can avoid doing almost-the-same-ting in two
different frameworks, it would be fine by me.
