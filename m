Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1377FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D827A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544900028;
	bh=8fjHdiviQM8t0qPTBk97mam23ufHd+C9CyqHumwsP9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iOyEfHO6x/240//JMBvSdxife0UD0DXrZ8jxC1rUChFbE8LOkMUyqfWGDbi4tKcQt
	 yNNOwzXpHaG2tG/MZbAO2y84P7Do+JgNH5jAYjDaVWUP4Btls5ZEYwIKsNl89Fzeqt
	 EXx56qDnbvIiSGac1dJguhOFLgUtqvns6Wzz4wYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeLOSxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeLOSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 13:53:47 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004692084D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544900026;
        bh=8fjHdiviQM8t0qPTBk97mam23ufHd+C9CyqHumwsP9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xA44NsJmInFg8tWu2y27kNSXUyPLfbTrI0kNeRPWtBX1j1gqINcZ/ICksaM3MhAed
         PpK7LyBq9smtWMYeHepiZDPZu1VWJe6ib/g5K1CVn7uvGGlYHKjDbz/jxoOXFDCS75
         tbQfbGrQv6WT/+fK6tpcfJ/OD3j7gmHnZMc/ND2A=
Received: by mail-wm1-f46.google.com with SMTP id y1so8596970wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 10:53:45 -0800 (PST)
X-Gm-Message-State: AA+aEWaM+7r1mJBvpPwYsH9+HluXq47yLtYqBCOIGw6IOEhTvwi5xJ1D
        KSNaZg1TkSTyLD/YSVHy6n3TS1qbtvbPyh3slOtpXg==
X-Google-Smtp-Source: AFSGD/XbCF9dKU6r9cNA/ZJIA8NrOcFUL00YzAWAkMcYZXTVODjKTyK5QOdZ87HEETu7r3xQYSqVhZ10P2ghpOgF5pU=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr7338555wmc.74.1544900024477;
 Sat, 15 Dec 2018 10:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com> <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic> <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic> <d7d04973d6d54a969c9324ab3240b401@AcuMS.aculab.com>
In-Reply-To: <d7d04973d6d54a969c9324ab3240b401@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 15 Dec 2018 10:53:32 -0800
X-Gmail-Original-Message-ID: <CALCETrW6QgD4SLo7S+b+MgX4X4w1wAv1oJoi8px_q4+XGydyOQ@mail.gmail.com>
Message-ID: <CALCETrW6QgD4SLo7S+b+MgX4X4w1wAv1oJoi8px_q4+XGydyOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     David Laight <David.Laight@aculab.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 5:39 AM David Laight <David.Laight@aculab.com> wrote:
>
> From:  Borislav Petkov
> > Sent: 12 December 2018 18:45
> ...
> > > The property I want for RDTSC ordering is much weaker: I want it to be
> > > ordered like a load.  Imagine that, instead of an on-chip TSC, the TSC
> > > is literally a location in main memory that gets incremented by an
> > > extra dedicated CPU every nanosecond or so.  I want users of RDTSC to
> > > work as if they were reading such a location in memory using an
> > > ordinary load.  I believe this gives the real desired property that it
> > > should be impossible to observe the TSC going backwards.  This is a
> > > much weaker form of serialization.
> >
> > Well, in that case you need something new.
> >
> > Because, the moment you have a RDTSC in flight and a second RDTSC comes
> > in and that second RDTSC must *not* bypass the first one and execute
> > earlier due to OoO, you need to impose some ordering. And that's pretty
> > much uarch-dependent, I'd say.
> >
> > And I guess on AMD the way to do that is to stop dispatch until the
> > first RDTSC retires.
> >
> > Can it be done faster? Sure. And I'm pretty sure there's a lot of pesky
> > little hw details we're not even hearing of, which get in the way.
>
> ISTR one of the problems with RDTSC serialising is that it is used
> for micro-benchmarks.

If you're benchmarking with that level of detail, you're probably
doing RDTSC directly instead of using the vDSO.  Or, even better,
RDPMC.
