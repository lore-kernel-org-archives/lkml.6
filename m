Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF91C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E96E20823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549619651;
	bh=NgopAKlV3yAZFfu9l2ekqNSVVXiqkV1sF49ACTXXNFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZDWsnhEdgqu7epcBlcEIQqoPHtHpQWziFt5Rv83Mgmw3GFqP4EeJ0udrvcuTrL9Hx
	 AwDfpn+N03OTZjZLBBPSXa4T4GqLpvNsR3zpjPUYAx64gf30/1LLqE2Htmfh4BkBIq
	 sGiwMWZfy/0t4B3eVD9kMZ41Srq2DWyhPSK3n6Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfBHJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:54:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35525 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:54:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so851028otm.2;
        Fri, 08 Feb 2019 01:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VfsE/dzYczCUfX/n2vKlNRBDnNnPyv4tAwRHXUAldQ=;
        b=c/hSIgShEa2qIVG2Gj5RNpmijhLgpTOhskdxCMnQSsJEOIHOfeLarW1k8Iy7dbZlsf
         cHfB/aghLkdlKQa2I9iCtVZ2jjiqW9MoVgaUhqB8LAquFCQFpGWXe+isJVjdZ4WYWfoT
         j8AaCGVP10TiFvbMo+L7vzgHwLcBCw9bu+ukfw3pgicsBkK8hTDnhHRLYUkQ1oe4AQPP
         RJTz/cybe3r88mzuos2FeGDkiDpNffutlRe/ivZo01D5/wXL7VlCukrTykmbQ82cAu89
         635A/bXrEoqKH00qkyTGFfbG/kxyBd5635JNsx9aE/kGnpzwV3yzDoPzg4vNSmezKefy
         czpA==
X-Gm-Message-State: AHQUAubc7Zq2txruNYhi2iC3un1lqwm48pTWSMtImkHmqd5MgpTkRNvn
        z5R5ZWTLVa1W0UYANU0YPoOTmPjhdxMxOxIGfZw=
X-Google-Smtp-Source: AHgI3IajVzFgWCoKQVSUfYA32BGpvovq0M2Y4leaXECJG9tw48W5QJzvsdjY7uSau46x6I/qAkNIfQmqwMUxSYufhQQ=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr11325264otl.119.1549619648139;
 Fri, 08 Feb 2019 01:54:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547197612.git.viresh.kumar@linaro.org> <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7>
In-Reply-To: <20190208090912.43aao5kny42iirum@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 10:53:55 +0100
Message-ID: <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
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

On Fri, Feb 8, 2019 at 10:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-01-19, 10:47, Rafael J. Wysocki wrote:
> > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > This commit introduces the frequency constraint infrastructure, which
> > > provides a generic interface for parts of the kernel to constraint the
> > > working frequency range of a device.
> > >
> > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > cpufreq framework already implements such constraints with help of
> > > notifier chains (for thermal and other constraints) and some local code
> > > (for user-space constraints). The devfreq framework developers have also
> > > shown interest [1] in such a framework, which may use it at a later
> > > point of time.
> > >
> > > The idea here is to provide a generic interface and get rid of the
> > > notifier based mechanism.
> > >
> > > Only one constraint is added for now for the cpufreq framework and the
> > > rest will follow after this stuff is merged.
> > >
> > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > this work and so I have added him as Co-author to the first patch.
> > > Thanks Matthias.
> > >
> > > FWIW, This doesn't have anything to do with the boot-constraints
> > > framework [2] I was trying to upstream earlier :)
> >
> > This is quite a bit of code to review, so it will take some time.
>
> @Rafael: You are going to provide some more feedback here, right ?

I think I've said something already.

TLDR: I'm not convinced.

PM QoS does similar things in a similar way.  Why does it have to be a
different framework?

Using freq constraints for thermal reasons without coordinating it
with scheduling is questionable in general, because thermal control
may work against scheduling then.

AFAICS, the original reason for notifiers in cpufreq was to avoid
drawing too much power (and frequency was a proxy of power then) and
they allowed the firmware to set the additional limit when going from
AC to battery, for example.  That appears to be a different goal,
though.
