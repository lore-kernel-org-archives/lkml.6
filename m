Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F9920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQskpJUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfBZWGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:06:47 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43635 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:06:47 -0500
Received: by mail-vk1-f193.google.com with SMTP id e131so3369876vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOoMc+RHFWBGA09XwS2pL1BaJP8tf8CR+s4qdrY5Ne4=;
        b=AQskpJUtFcL/F3Z8L1NY+K5hk3qkO5snkL/6VsIrShZ2S6jIyaRlPXMHa0C3Qdk73v
         U0WjqyMOSOdti80l55nrghwh+N8wZf7+OYIM7KKU/c54Ft/BO+dEDpVhV/1a0S+qKUzh
         kMihLf6BCsURqM9c8hARJlinTq2AmjoETe4UmKwOTqUKdHLGOGFjoqdcSzrneRwkXynr
         o35HU9KafsHnLskU8L4gPVKd7IKl/vb0VaEGgIgDtdexIvZofiF1ahsvrrFdUQ99suwb
         4+GyMAgeIVM/w98kz7XiydJaeuD80kNtlhazPL6tX/UBeFHnKfx8WcMOqEsZurZKe83a
         mWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOoMc+RHFWBGA09XwS2pL1BaJP8tf8CR+s4qdrY5Ne4=;
        b=dmVDsQby5vaBpu7kdlfesviyg486RyNYtLVXXw+0HUgP8R1nrIyAMoq1tyV5BIyMkf
         juJrVI1LYe+opcDHa6N2xv5whU4CP3OFq7yafGAiz6DpeTC2Yqe8r9Jelzhf9sgp85pS
         PUN9S9rDugPUBgA22+nQuGCd3rHjJre6Kp4mZOgEQm4AoOWCaT0CJBTdAw5Wb9r8MHMz
         2zabcIGrzOXCFsGPG2I8MvQrslyRUXloJRbuvpJFMoKDJLMCw376uONgv+riAieVkN9s
         UH/l8lekAUQhq8hN618Pr+hzFSl6/Gkk5wZbhfxLI6359VuU6yZ+ixf64bMHzR0PJNxq
         J2Nw==
X-Gm-Message-State: AHQUAub2tYvPJQpDenanUvukS60G8Qqws70BjwER4u1WBMB2rESqXwmC
        iXn9b4aTN+O5xmnBZ+TWLe2bOV0XWxFB79kE3v+mUQ==
X-Google-Smtp-Source: AHgI3IYEbprrKCKEqqJhs+OdwQp0CJViKLaDWPwMuL1W9FrZ2wLSedF5zlj3LCmYJAKdJuWcKx2PEw9JQszmk4i0Cg8=
X-Received: by 2002:a1f:3253:: with SMTP id y80mr2825850vky.17.1551218805888;
 Tue, 26 Feb 2019 14:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
 <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com> <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Feb 2019 23:06:10 +0100
Message-ID: <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
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

On Tue, 26 Feb 2019 at 22:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Changes in v11:
> > > >  - This version contains only the infrastructure changes that is needed for
> > > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > > post them separately. Still, to provide completeness, I have published a branch
> > > > containing everything to a git tree [1], feel free to have a look and test.
> > > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > > which has been replaced by a couple of new patches, whom reworks the existing
> > > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > > instead of the duration.
> > > >  - More changelogs are available per patch.
> > >
> > > NAK for patches [4-6/8].
> > >
> > > The code as is specifically avoids calling ktime_get() from the
> > > governors as that can be quite expensive, so these patches potentially
> > > make things worse.
> >
> > Yeah, good point! What do you think about folding in a patch into the
> > series, like below, and then let the cpuidle governors use it?
>
> It is not objectionable as it stands, but that also depends on what
> the new function is used for.
>
> In particular, I don't really think that the menu and teo governors
> need to call it at all.

Well, if we are going to re-work the code as suggested in the series,
then how would you suggest to get rid of the calls to ktime_get() that
is introduced in patch 4 and patch5?

BTW, at a closer look I am even tempted to squash patch3 to patch6
(including the part I attached earlier) as this part of the series is
really a re-work of tick_nohz_get_sleep_length() and its users.

>
> > One questions about when CONFIG_NO_HZ_COMMON is unset for the below
> > suggested code, does it make sense to "return -1" for that case, or
> > should I return ktime_get()? Does it matter?
>
> Again, it may or may not matter depending on what the caller is going
> to do with the value returned by it.

Well, so far this is only for teo/menu - instead of calling ktime_get().

Any other suggestions of how to move forward here is welcome, of course!

Kind regards
Uffe
