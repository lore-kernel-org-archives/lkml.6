Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C82C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AB02145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AB02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJRSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:47:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34614 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeJRSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:47:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so27778783eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=//L/I5lmgOgqM2I4QXduD5ofZVyUUXQVGKqFsU5ffBU=;
        b=OGDmexmt3lpCK1vNa/BOm4oRY15PBkMyXkqUvn/1FmnvGrmY3wFqBXVzFabOObOeM4
         20nt1CdSS1GAye/WvQkPs+l8EdyEkvG7G0mCS5+tb4O8xOemGwWh6iaWCYVFRFBNGrbQ
         o+1BPKyVyfJAYOQU4DgMznDuYyrkuc1vL4hIMMykDw9mKE6ZxkaQ0F9iJS6DhiKv6DrI
         jMld13RA8/Uie7yd69hYNmVvGj8zZ8oVlyqFqi7IGJ5UwoDtPfq+/WCZISJr6J0WFxDu
         NI3pkUSkcJuD9L4zHWVQszrGUL2IC8NyfF2pn2GATuwIFWGwldnnyHPiR5pljlRIFw1H
         1vtg==
X-Gm-Message-State: ABuFfojiZ1HNQmMADtqB8TFRadneadeDWV99Iyc/ZzpGqWq/uVTWAEG8
        ihOoRVxfMOYf+1HLZbs19Z2TwA==
X-Google-Smtp-Source: ACcGV634nUcfU7smpfK6xFoB6GluJeWTuI9o5RV+xz6ULl0/XqFuldEnvxNqwDjIR42WwwPA5zZ/bA==
X-Received: by 2002:a50:ec89:: with SMTP id e9-v6mr3147923edr.134.1539859637187;
        Thu, 18 Oct 2018 03:47:17 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD1D76FE429868C6209AAF5.dip0.t-ipconnect.de. [2003:ef:2bd1:d76f:e429:868c:6209:aaf5])
        by smtp.gmail.com with ESMTPSA id b36-v6sm9184332edb.5.2018.10.18.03.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 03:47:16 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:47:13 +0200
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
Message-ID: <20181018104713.GC21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018122331.50ed3212@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/10/18 12:23, luca abeni wrote:
> Hi Juri,
> 
> On Thu, 18 Oct 2018 10:28:38 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> >  struct sched_attr {
> >     .size	= 0,
> >     .policy	= 6,
> >     .flags	= 0,
> >     .nice	= 0,
> >     .priority	= 0,
> >     .runtime	= 0x9917,
> >     .deadline	= 0xffff,
> >     .period	= 0,
> >  }
> > 
> > So, we seem to be correctly (in theory, see below) accepting the task.
> > 
> > What seems to generate the problem here is that CONFIG_HZ=100 and
> > reproducer task has "tiny" runtime (~40us) and deadline (~66us)
> > parameters, combination that "bypasses" the enforcing mechanism
> > (performed at each tick).
> 
> Ok, so the task can execute for at most 1 tick before being throttled...
> Which does not look too bad.
> 
> I missed the original emails, but maybe the issue is that the task
> blocks before the tick, and when it wakes up again something goes wrong
> with the deadline and runtime assignment? (maybe because the deadline
> is in the past?)

No, the problem is that the task won't be throttled at all, because its
replenishing instant is always way in the past when tick occurs. :-/

> > Another side problem seems also to be that with such tiny parameters
> > we spend lot of time in the while (dl_se->runtime <= 0) loop of
> > replenish_dl_ entity() (actually uselessly, as deadline is most
> > probably going to still be in the past when eventually runtime
> > becomes positive again), as delta_exec is huge w.r.t. runtime and
> > runtime has to keep up with tiny increments of dl_runtime. I guess we
> > could ameliorate things here by limiting the number of time we
> > execute the loop before bailing out.
> 
> Actually, I think the loop will iterate at most 10ms / 39us times, which
> is about 256 times, right? If this is too much (I do not know how much
> time it is spent executing the loop), then the solution is (as you
> suggest) to increase the minimum allowed runtime.

Yeah, it's maybe not a big issue (and fixing it won't change anything
regarding the real problem at hand). Just thought I'd mention what I was
seeing; and having the loop limit won't harm anyway I guess.

> [...]
> > So, I tend to think that we might want to play safe and put some
> > higher minimum value for dl_runtime (it's currently at 1ULL <<
> > DL_SCALE). Guess the problem is to pick a reasonable value, though.
> > Maybe link it someway to HZ?
> 
> Yes, a value dependent on HZ looks like a good idea. I would propose
> HZ / N, where N is the maximum number of times you want the loop above
> to be executed.

Mmm, it's not really about the loop, but about the granularity at which
we do enforcement.

> > Then we might add a sysctl (or similar)
> > thing with which knowledgeable users can do whatever they think their
> > platform/config can support?
> 
> I guess this can be related to the utilization limits we were
> discussing some time ago... I would propose a cgroup-based interface to
> set all of these limits.

Guess we can go that path as well. But I'd leave it for a later stage.

Thanks,

- Juri
