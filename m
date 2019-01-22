Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6B52085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kliy7H1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfAVTaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:30:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43710 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:30:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so12238728pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0svbN6i4itkKxNAdYGiwewg99TGL10PzPycLA5Tqml0=;
        b=kliy7H1dEdIGi4NgewX6L2KDp9EZdWGGzwN46i4wtvH7/AUci6vuKXYTw06vXlRUOy
         htnhEOsPLuDSaztzLQiHiZgWN8MB57wySfDSRT9nghwabyjnfjZ/3jUyQ6wMfs9AWei/
         jWoiaUx99vrD3CGC57YHBnYblizEFS0LeVXMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0svbN6i4itkKxNAdYGiwewg99TGL10PzPycLA5Tqml0=;
        b=X+jxwWWSGStZMTpkbvER/DvUsQ/8GHkxeJhMhgnnwufK1B4QyHAWV9P4c9WPfp1Ovn
         esP4oMhfzQ3vXEFh56tGGH03Iq8k/vMarLuGHY9n/9FZ2372MCl2bbYOz6oRvTRvL2SY
         sCaJJ1vGzM38HN7ZjQLhSVSY+Lp04o0j6R4B5gOS8ly87f+IFygzwXpOIIfhRJu/C+au
         SUhNEgF5uzjw58OlXF1NOFfUXgz2+8gZHgXJB6L5kTYpF8tSU1GLphcqHDuoCP7mn4n9
         u1489LLaxtuo78oe0fHY1xF+EYX8zhNJa9/nBGUv6J/rJRHJTPeg6CWtj0s3spPzcjlY
         1+nQ==
X-Gm-Message-State: AJcUukdTVJvKOLeUiVv4InMtp5mFF03Fw30qPvVJoyZTNjS8dF9MbaP9
        5agxi1wbQvBgGf4nOBUtIqIYQA==
X-Google-Smtp-Source: ALg8bN7fldKpjtuf4P1W6W4vYDi1fHwpQGWyrFaZsXaUPJSmWtApndMcC1PLIaCFvVcsaRrlQRdQDw==
X-Received: by 2002:a62:a510:: with SMTP id v16mr34480832pfm.18.1548185422745;
        Tue, 22 Jan 2019 11:30:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d6sm27033224pgc.89.2019.01.22.11.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:30:22 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:30:21 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Juri Lelli <juri.lelli@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190122193021.GG261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
 <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
 <20190118123900.GJ14385@localhost.localdomain>
 <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:10:55PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 18, 2019 at 1:39 PM Juri Lelli <juri.lelli@gmail.com> wrote:
> >
> > On 17/01/19 15:55, Rafael J. Wysocki wrote:
> > > On Thu, Jan 17, 2019 at 2:16 PM Juri Lelli <juri.lelli@gmail.com> wrote:
> > > >
> > > > On 11/01/19 10:47, Rafael J. Wysocki wrote:
> > > > > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > This commit introduces the frequency constraint infrastructure, which
> > > > > > provides a generic interface for parts of the kernel to constraint the
> > > > > > working frequency range of a device.
> > > > > >
> > > > > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > > > > cpufreq framework already implements such constraints with help of
> > > > > > notifier chains (for thermal and other constraints) and some local code
> > > > > > (for user-space constraints). The devfreq framework developers have also
> > > > > > shown interest [1] in such a framework, which may use it at a later
> > > > > > point of time.
> > > > > >
> > > > > > The idea here is to provide a generic interface and get rid of the
> > > > > > notifier based mechanism.
> > > > > >
> > > > > > Only one constraint is added for now for the cpufreq framework and the
> > > > > > rest will follow after this stuff is merged.
> > > > > >
> > > > > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > > > > this work and so I have added him as Co-author to the first patch.
> > > > > > Thanks Matthias.
> > > > > >
> > > > > > FWIW, This doesn't have anything to do with the boot-constraints
> > > > > > framework [2] I was trying to upstream earlier :)
> > > > >
> > > > > This is quite a bit of code to review, so it will take some time.
> > > > >
> > > > > One immediate observation is that it seems to do quite a bit of what
> > > > > is done in the PM QoS framework, so maybe there is an opportunity for
> > > > > some consolidation in there.
> > > >
> > > > Right, had the same impression. :-)
> > > >
> > > > I was also wondering how this new framework is dealing with
> > > > constraints/request imposed/generated by the scheduler and related
> > > > interfaces (thinking about schedutil and Patrick's util_clamp).
> > >
> > > My understanding is that it is orthogonal to them, like adding extra
> > > constraints on top of them etc.
> >
> > Mmm, ok. But, if that is indeed the case, I now wonder why and how
> > existing (or hopefully to be added soon) interfaces are not sufficient.
> > I'm not against this proposal, just trying to understand if this might
> > create unwanted, hard to manage, overlap.
> 
> That is a valid concern IMO.  Especially the utilization clamping and
> the interconnect framework seem to approach the same problem space
> from different directions.
> 
> For cpufreq this work can be regarded as a replacement for notifiers
> which are a bandaid of sorts and it would be good to get rid of them.
> They are mostly used for thermal management and I guess that devfreq
> users also may want to reduce frequency for thermal reasons and I'd
> rather not add notifiers to that framework for this purpose.

FYI: devfreq already reduces frequency for thermal reasons, however
they don't use notifiers, but directly disable OPPs in the cooling driver:

https://elixir.bootlin.com/linux/v4.20.3/source/drivers/thermal/devfreq_cooling.c#L78

The idea to have a frequency constraint framework came up in the
context of the throttler series
(https://lore.kernel.org/patchwork/project/lkml/list/?series=357937)
for non-thermal throttling. My initial approach was to copy the
notifier bandaid ...

> However, as stated previously, this resembles the PM QoS framework
> quite a bit to me and whatever thermal entity, say, sets these
> constraints, it should not work against schedutil and similar.  In
> some situations setting a max frequency limit to control thermals is
> not the most efficient way to go as it effectively turns into
> throttling and makes performance go south.  For example, it may cause
> things to run at the limit frequency all the time which may be too
> slow and it may be more efficient to allow higher frequencies to be
> used, but instead control how much of the time they can be used.  So
> we need to be careful here.
