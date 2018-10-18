Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24201C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1021476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA1021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJRUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:22:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41792 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJRUWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:22:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so28026934edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 05:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHXiamgtc3gQ61d0Sjup3LRYv8DSliHqb+x2lYIk5oA=;
        b=RGoBNM9/UT07ZgXEmps6UPTsedOH5jpxNUM46K+ap3xcj8sSXD0fLHjS9HRAKHUzOh
         k0RJa0GiQKpKiITMuJxu+lmnsCDKJw8sIJ0ffj5JTf2tGU5sW8HjaYJTIq05xkyBmq6A
         XPZDRVC6aBjM3g9oHSjtUnZGtsCP8cKJivVzr66YV2yq3+OxrJKTuQcETPh0ekLH6mte
         GuYDfYQSg8S1OSzcfxphErA3wVOOajCivlRVDjIRkBa7XOhXpvMAAEfE9DLpaNDi+lZ8
         vAHkN5VS50IhNsynIsehjjDQ/uS63ZTcLafTukvQ/6/gkiRin58sim96oLdEhhFlgd9z
         Kmfw==
X-Gm-Message-State: ABuFfojlkM3502+6jeOwypTWW9Lwuo/Unv5Wjlz4hWN85AMsO2ELeQob
        sBJspsDytVd2PPdspGKWuMXBBg==
X-Google-Smtp-Source: ACcGV638i6BdeiXGQCaYiD3SQHomu0dqsaQxqtMuH1yYXuIaNa+kyO4FJfvdxLjKfElbmsXMU6Ipxw==
X-Received: by 2002:a05:6402:150f:: with SMTP id f15mr3307157edw.222.1539865306203;
        Thu, 18 Oct 2018 05:21:46 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD1D76FE429868C6209AAF5.dip0.t-ipconnect.de. [2003:ef:2bd1:d76f:e429:868c:6209:aaf5])
        by smtp.gmail.com with ESMTPSA id s12-v6sm9402927edd.39.2018.10.18.05.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 05:21:45 -0700 (PDT)
Date:   Thu, 18 Oct 2018 14:21:42 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181018122142.GF21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018130811.61337932@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/18 13:08, luca abeni wrote:
> On Thu, 18 Oct 2018 12:47:13 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Hi,
> > 
> > On 18/10/18 12:23, luca abeni wrote:
> > > Hi Juri,
> > > 
> > > On Thu, 18 Oct 2018 10:28:38 +0200
> > > Juri Lelli <juri.lelli@redhat.com> wrote:
> > > [...]  
> > > >  struct sched_attr {
> > > >     .size	= 0,
> > > >     .policy	= 6,
> > > >     .flags	= 0,
> > > >     .nice	= 0,
> > > >     .priority	= 0,
> > > >     .runtime	= 0x9917,
> > > >     .deadline	= 0xffff,
> > > >     .period	= 0,
> > > >  }
> > > > 
> > > > So, we seem to be correctly (in theory, see below) accepting the
> > > > task.
> > > > 
> > > > What seems to generate the problem here is that CONFIG_HZ=100 and
> > > > reproducer task has "tiny" runtime (~40us) and deadline (~66us)
> > > > parameters, combination that "bypasses" the enforcing mechanism
> > > > (performed at each tick).  
> > > 
> > > Ok, so the task can execute for at most 1 tick before being
> > > throttled... Which does not look too bad.
> > > 
> > > I missed the original emails, but maybe the issue is that the task
> > > blocks before the tick, and when it wakes up again something goes
> > > wrong with the deadline and runtime assignment? (maybe because the
> > > deadline is in the past?)  
> > 
> > No, the problem is that the task won't be throttled at all, because
> > its replenishing instant is always way in the past when tick
> > occurs. :-/
> 
> Ok, I see the issue now: the problem is that the "while (dl_se->runtime
> <= 0)" loop is executed at replenishment time, but the deadline should
> be postponed at enforcement time.
> 
> I mean: in update_curr_dl() we do:
> 	dl_se->runtime -= scaled_delta_exec;
> 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> 		...
> 		enqueue replenishment timer at dl_next_period(dl_se)
> But dl_next_period() is based on a "wrong" deadline!
> 
> 
> I think that inserting a
>         while (dl_se->runtime <= -pi_se->dl_runtime) {
>                 dl_se->deadline += pi_se->dl_period;
>                 dl_se->runtime += pi_se->dl_runtime;
>         }
> immediately after "dl_se->runtime -= scaled_delta_exec;" would fix the
> problem, no?

Mmm, I also thought of letting the task "pay back" its overrunning. But,
doesn't this get us quite far from what one would expect. I mean,
enforcement granularity will be way different from task period, no?
