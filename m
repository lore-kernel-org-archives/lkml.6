Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454CEC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEDC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544640647;
	bh=tLTZL75cjM73TG58rvf9vbqeJpQNMAZEGvUCBpbzC2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ol6Hoe4uXNogKwMFz6ejksm2sALf1DfODfwz3vUItNLHsaTPx8NDxRAjBkVT1eKie
	 GBIGZOtwVmO+XhyPrrDF63RJ/X2cvquCtXdDTRQO3Xzsw1hwKZpiPfrsg46FLGUDfV
	 pIvNIneEH/3t5E/qeaclh8pqqC9WtRL11G3JjD9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEDC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeLLSuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbeLLSup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:50:45 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2591F20870
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544640644;
        bh=tLTZL75cjM73TG58rvf9vbqeJpQNMAZEGvUCBpbzC2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qxUDi6HjcC5qz5OeKqU36Q/2jW7T7aLOf7WvVBLCtH7YufXrVCmMK5roOTOlCER8s
         2XXt5nbYJKtjnvHMzU0uOckdKWqmxNFDoK08ucyCdE6bdYP/F4ptlYdiBQT1Pl8CAJ
         /QQm66N77C9P1JPOo/VOvlYR1fnIMBcBsy7PMh7s=
Received: by mail-wr1-f46.google.com with SMTP id p4so18743520wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:50:44 -0800 (PST)
X-Gm-Message-State: AA+aEWZxJpJYLAyOQQ1avumIRibQnqNEiabY/Olks8sLRlQ64m4Ab2Vk
        hG3SHRorzViawOq89MMMQtILp73iCSM2+1ZG9qBajg==
X-Google-Smtp-Source: AFSGD/WACc2ZXTcHFjOVKQE0LocvTuOH2wnKQ42vQNGItMlE8k9w2ObFYU8H0z2tb3uSMwfdwGr9IeI+jNNRcJziv48=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr17518695wro.77.1544640642617;
 Wed, 12 Dec 2018 10:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com> <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic> <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic>
In-Reply-To: <20181212184459.GE6653@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 10:50:30 -0800
X-Gmail-Original-Message-ID: <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
Message-ID: <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
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

On Wed, Dec 12, 2018 at 10:45 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 12, 2018 at 10:07:03AM -0800, Andy Lutomirski wrote:
> > You're proving my point, I think.  CPUID, IRET, MOV to CR, etc are
> > "serializing".  LFENCE, on many CPUd and depending on MSRs, is a
> > different kind of serializing.  MFENCE is something else.  All LOCK
> > instructions are some kind of barrier, but I don't think anyone calls
> > them "serializing".
>
> Yeah, peterz and I hashed it out a bit today on IRC about the different
> meanings of serializing. I see your point now.
>
> > The uaccess users of barrier_nospec() are presumably looking for a
> > speculation barrier in the sense of "CPU, please don't execute the
> > code after this until you're sure that this code should be executed
> > for real and until all inputs are known, not guessed."
>
> Yeah, I believe AMD's paper has this nicely written:
>
> "MITIGATION G-2
>
> Description: Set an MSR in the processor so that LFENCE is a dispatch
> serializing instruction and then use LFENCE in code streams to
> serialize dispatch (LFENCE is faster than RDTSCP which is also dispatch
> serializing). This mode of LFENCE may be enabled by setting MSR
> C001_1029[1]=1.
>
> Effect: Upon encountering an LFENCE when the MSR bit is set, dispatch
> will stop until the LFENCE instruction becomes the oldest instruction in
> the machine."
>
> https://developer.amd.com/wp-content/resources/90343-B_SoftwareTechniquesforManagingSpeculation_WP_7-18Update_FNL.pdf
>
> which is basically what you want for the whole mitigation crap if you
> want to kill speculation - you simply hold dispatch until the LFENCE
> retires.
>
> > The property I want for RDTSC ordering is much weaker: I want it to be
> > ordered like a load.  Imagine that, instead of an on-chip TSC, the TSC
> > is literally a location in main memory that gets incremented by an
> > extra dedicated CPU every nanosecond or so.  I want users of RDTSC to
> > work as if they were reading such a location in memory using an
> > ordinary load.  I believe this gives the real desired property that it
> > should be impossible to observe the TSC going backwards.  This is a
> > much weaker form of serialization.
>
> Well, in that case you need something new.
>
> Because, the moment you have a RDTSC in flight and a second RDTSC comes
> in and that second RDTSC must *not* bypass the first one and execute
> earlier due to OoO, you need to impose some ordering. And that's pretty
> much uarch-dependent, I'd say.
>
> And I guess on AMD the way to do that is to stop dispatch until the
> first RDTSC retires.
>
> Can it be done faster? Sure. And I'm pretty sure there's a lot of pesky
> little hw details we're not even hearing of, which get in the way.
>

As far as I know, RDTSCP gets the job done, as does LFENCE, RDTSC on
Intel.  There was a big discussion a few years ago where we changed it
from LFENCE;RDTSC;LFENCE to just LFENCE;RDTSC after everyone was
reasonably convinced that the uarch would not dispatch two RDTSCs
backwards if the first one was immediately preceeded by LFENCE.
