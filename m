Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268AAECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19D12086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf6sEKHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19D12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeIORsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 13:48:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIORsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 13:48:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so12968537wrw.6;
        Sat, 15 Sep 2018 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oe7Fkcn3Yz15kBey6S3i5Yh1tH0T4neRdkYk3Vtn+e0=;
        b=Gf6sEKHxSWhL7+VPsFhBLskQqZH5ssLCttzidCSdOLvmYEnCEWqDtO33JgEGKnm0bg
         6pH3EmB4s61SeiOh97vqVYSAfvwPZ7ml6pZbV2UYxDishhjd0xy+yY55sbh+VDn7Riic
         uI/sMYEwicv9CPTgZR/HaMUcL6V5ij00B/lm1LqujmNdlBa8+DRJn/k8FVe2hhBTJD2L
         cEFyouOotp9tRSrTbDR/OpTcn67Mmh+rorrMCL2d4D6cUsStkiKHStZtu1UZ3bN5wQVF
         06D6EQyIGlsQLy2T8eHd1Jcl9ozfqNYFoWTDLZmQWS1HmYoLcwQYCo+MFQ/zXytZwVbr
         Ohcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oe7Fkcn3Yz15kBey6S3i5Yh1tH0T4neRdkYk3Vtn+e0=;
        b=CGuSxKM6khsVXB0icFZZMagGYMxnrd1ayCSEQxuJxVafqMWDuguxAO4kzqcrev5q/K
         vf/eaFBnkJZqGctn62BVTEc0GzmhA5HBr7I3ionHUx/VBOcc9HTGoBRal9vKeBSFtIND
         F7xXjAz23fG043XBY+C+PGHrU/qcyhEqLDcEvDCOQhOFWps+csY1Q72/4yo+EOnQrnz3
         MCEFcoZniKZQer/T6uSaWKHvd6nxjQPONcZ5CBfzpPfGDwEolcf7YFRXp6sQo/R4JWJu
         I8On2j63X4mMDw54LnbVGoy4dbJiRgmf8DM2NaeuZaSBmSw/wmJDUCP3trn22NfMaMsN
         9Adw==
X-Gm-Message-State: APzg51C0re7kaQnAWcarbtcioHuzflEp9Ri+1JF1LaD3wrTO628pBEkw
        5qb36HR/p8cV7xz0nev3NCrzQ4fr
X-Google-Smtp-Source: ANB0VdaUNwbpHcCqQkBrpyCwfQCo6T+KzbyehQym9yURJWB0kKf1e/aPq474DBlOBe69vtZo6INB4w==
X-Received: by 2002:adf:8504:: with SMTP id 4-v6mr12279022wrh.72.1537014599596;
        Sat, 15 Sep 2018 05:29:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v133-v6sm1578719wma.36.2018.09.15.05.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 05:29:58 -0700 (PDT)
Date:   Sat, 15 Sep 2018 14:29:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [tip:sched/core] sched/fair: Remove #ifdefs from
 scale_rt_capacity()
Message-ID: <20180915122956.GA12378@gmail.com>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
 <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
 <20180915114657.GA63704@gmail.com>
 <CAKfTPtD-vAw9=aDS83eEB56JOPV74R-oG1LAKKPXkDfxPDt1vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD-vAw9=aDS83eEB56JOPV74R-oG1LAKKPXkDfxPDt1vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Hi Ingo,
> 
> On Sat, 15 Sep 2018 at 13:47, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * tip-bot for Vincent Guittot <tipbot@zytor.com> wrote:
> >
> > > Commit-ID:  2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > > Gitweb:     https://git.kernel.org/tip/2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > > Author:     Vincent Guittot <vincent.guittot@linaro.org>
> > > AuthorDate: Thu, 19 Jul 2018 14:00:06 +0200
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Wed, 25 Jul 2018 11:41:05 +0200
> > >
> > > sched/fair: Remove #ifdefs from scale_rt_capacity()
> > >
> > > Reuse cpu_util_irq() that has been defined for schedutil and set irq util
> > > to 0 when !CONFIG_IRQ_TIME_ACCOUNTING.
> > >
> > > But the compiler is not able to optimize the sequence (at least with
> > > aarch64 GCC 7.2.1):
> > >
> > >       free *= (max - irq);
> > >       free /= max;
> > >
> > > when irq is fixed to 0
> > >
> > > Add a new inline function scale_irq_capacity() that will scale utilization
> > > when irq is accounted. Reuse this funciton in schedutil which applies
> > > similar formula.
> > >
> > > Suggested-by: Ingo Molnar <mingo@redhat.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: rjw@rjwysocki.net
> > > Link: http://lkml.kernel.org/r/1532001606-6689-1-git-send-email-vincent.guittot@linaro.org
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > ---
> > >  kernel/sched/core.c              |  2 +-
> > >  kernel/sched/cpufreq_schedutil.c |  3 +--
> > >  kernel/sched/fair.c              | 13 +++----------
> > >  kernel/sched/sched.h             | 20 ++++++++++++++++++--
> > >  4 files changed, 23 insertions(+), 15 deletions(-)
> >
> > This commit introduced a build warning in the SMP=n case, could we please fix that? (Probably
> > the best to maintain variant would be to mark it as __maybe_unused.)
> 
> Dou sent a fix for this warning
> https://lkml.org/lkml/2018/8/10/22
> This one remove one HAVE_SCHED_AVG_IRQ which is at the opposite of
> what yyou propose below

Yeah, that's a bad patch because it moves one step back, beyond also having an obvious typo in 
the title and overall atrocious spelling that shows that not much thought must have gone into 
the patch - yet you acked it, which makes me unhappy as a maintainer: please don't ack 
obviously triple-flawed patches!

> and Miguel also made a proposal:
> https://lkml.org/lkml/2018/9/8/215
> based on __maybe_unused

That solution is probably better, but:

> >
> > Also, while at it, there's a number of other places that use this pattern:
> >
> > > -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > > +#ifdef HAVE_SCHED_AVG_IRQ
> >
> > Could we convert those to HAVE_SCHED_AVG_IRQ as well?
> 
> I'm not sure that we can convert all to HAVE_SCHED_AVG_IRQ
> 
> >
> > dagon:~/tip> git grep 'defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)' kernel/sched/
> > kernel/sched/core.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> 
> we can't replace one because the variables can be used when
> HAVE_SCHED_AVG_IRQ is undefined

Well, firstly, why is HAVE_SCHED_AVG_IRQ defined in a header and not in the Kconfig space as I 
originally suggested?

Secondly, HAVE_SCHED_AVG_IRQ is defined poorly AFAICS, it should be 0/1 so it can be used as a 
replacement pattern in #if sequences - not in #ifdef sequences as your patch did.

I.e. this needs to be sorted out and done properly, the concerns you voice are simply a side 
effect of this having been done badly.

Thanks,

	Ingo
