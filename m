Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA70C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6C820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548069070;
	bh=vDfunosYLLFTyphuadEAlngFKRHIg6gQOH0o3RCfFQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZGKfv4iv03IShU2yATYuxeMd6+nbDOBotkBZVmkmQNo8bAnVQyWupkeMQUETXDtvD
	 UcGHKu3frSzDeiG6iF6FH+n9CXy50Dh9U8aNNhsPkGQCaFHggllMbsHgUkTS2Sa2T7
	 opXvLOes3oBuEbBPcX1jLyOHiNgSbRx+HmAIOk/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfAULLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:11:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44304 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfAULLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:11:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so14199488oig.11;
        Mon, 21 Jan 2019 03:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgkXNJd0C0ZM9MvUZG64DZtph2N/0Vkjw1NOHgSchfg=;
        b=eN3xGo82zsN3O4NqYdvRWxItEuElTQh0gr//VI0bUf+qKWKd5d3XPnxPpQFfVG2/4G
         OnceXdpgbabPUb0vxapSWyn1L8zw17+GVr8SeYUUxKRxTS0+vj82q/z0GrIQ024xG27q
         fDM+wu+2nYCmAtwCsP2URwKf1zEpHJmQTAmMH4bvQ4Jd4zIMXMXkaTz2kp5RbWPa5d+Q
         s/+6jRVefqTSA4yXppIGFQJSpPx7IFhiV7ZaFZQtHqNmjp2ij3KYug+jQxrQPbze24Kk
         ppy7TD/5KT3DQyg/XG1wW2CoIDIJQrCKyWp9zzUeg3V1zxwwqVjTkxV6JQX2pLZsK9sY
         tEDQ==
X-Gm-Message-State: AJcUukeJ8nut7Vp6Eb4lC00g2eZJvZSMSReaShtRwBdtZwzthJ+Xg8GF
        KxR24QjpUCWfuycET9Jzz6VlvekDrba1iUnplb8=
X-Google-Smtp-Source: ALg8bN54KWCUUZ2MQb8AsBcxCP9MmZAYxmcJ1rzldAULNGgOhfiD++WtU1WJgPPeEoe7ilYCLjj0NhmqOEg0DbFT1PU=
X-Received: by 2002:aca:368a:: with SMTP id d132mr5591473oia.193.1548069066819;
 Mon, 21 Jan 2019 03:11:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547197612.git.viresh.kumar@linaro.org> <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain> <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
 <20190118123900.GJ14385@localhost.localdomain>
In-Reply-To: <20190118123900.GJ14385@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Jan 2019 12:10:55 +0100
Message-ID: <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Fri, Jan 18, 2019 at 1:39 PM Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 17/01/19 15:55, Rafael J. Wysocki wrote:
> > On Thu, Jan 17, 2019 at 2:16 PM Juri Lelli <juri.lelli@gmail.com> wrote:
> > >
> > > On 11/01/19 10:47, Rafael J. Wysocki wrote:
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
> > > >
> > > > One immediate observation is that it seems to do quite a bit of what
> > > > is done in the PM QoS framework, so maybe there is an opportunity for
> > > > some consolidation in there.
> > >
> > > Right, had the same impression. :-)
> > >
> > > I was also wondering how this new framework is dealing with
> > > constraints/request imposed/generated by the scheduler and related
> > > interfaces (thinking about schedutil and Patrick's util_clamp).
> >
> > My understanding is that it is orthogonal to them, like adding extra
> > constraints on top of them etc.
>
> Mmm, ok. But, if that is indeed the case, I now wonder why and how
> existing (or hopefully to be added soon) interfaces are not sufficient.
> I'm not against this proposal, just trying to understand if this might
> create unwanted, hard to manage, overlap.

That is a valid concern IMO.  Especially the utilization clamping and
the interconnect framework seem to approach the same problem space
from different directions.

For cpufreq this work can be regarded as a replacement for notifiers
which are a bandaid of sorts and it would be good to get rid of them.
They are mostly used for thermal management and I guess that devfreq
users also may want to reduce frequency for thermal reasons and I'd
rather not add notifiers to that framework for this purpose.

However, as stated previously, this resembles the PM QoS framework
quite a bit to me and whatever thermal entity, say, sets these
constraints, it should not work against schedutil and similar.  In
some situations setting a max frequency limit to control thermals is
not the most efficient way to go as it effectively turns into
throttling and makes performance go south.  For example, it may cause
things to run at the limit frequency all the time which may be too
slow and it may be more efficient to allow higher frequencies to be
used, but instead control how much of the time they can be used.  So
we need to be careful here.
