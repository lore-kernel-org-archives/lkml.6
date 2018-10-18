Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14058214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14058214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJRSKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:10:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37014 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:10:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so27699244edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7E0dkRK11RNn7ysnlvgsaF1hIhZQEgcUevKDa/GhHaU=;
        b=jAWwhyebb1lmSRsC78c65MyxX6XUnn/+T1oE0213Adr3qPsUKBZZSuOhIYRBMoBxD/
         IZAryr3xnRRy7soLy/C7oTevkc6GH01tJrpfzOrQ5IsSUeFsOvviTLGCSsnuLjkh0yPG
         Zb+Kvf4gymTy+GqTAobeYQVOdGXqC26lKcBWGz81nCK4tv1XFadc3UuSN40ciRV+uL0x
         5LdyDerEWPfe9j6wkzgLlLw2NV3AbrXNuTHanpaps7byH3PyVQpTJRArcPzVDXv+Djze
         sn/WMeLVxcTQ6W+ob6uFGt+956rExcYUUWfI6KNV5XqcUVlBA+07Yz/1mHDE6ubNZt6I
         EyIw==
X-Gm-Message-State: ABuFfoiaQEB4ZoG6ysNfxXYCwp80oOVTbwmqirePXGh/Ol5ifA6LW261
        0ybAEbFyr7ZBSr4nljdGme47qA==
X-Google-Smtp-Source: ACcGV60mCJ/b3xJQfSSNT9lVGx2quJXVsz9CUQ128RrzRQAayDE7lAuqeJKG4wkJelEvCD12HHdSuA==
X-Received: by 2002:a50:89ab:: with SMTP id g40-v6mr2782629edg.257.1539857411965;
        Thu, 18 Oct 2018 03:10:11 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD1D76FE429868C6209AAF5.dip0.t-ipconnect.de. [2003:ef:2bd1:d76f:e429:868c:6209:aaf5])
        by smtp.gmail.com with ESMTPSA id c40-v6sm7086401edb.41.2018.10.18.03.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 03:10:11 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:10:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        Luca Abeni <luca.abeni@santannapisa.it>, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181018101008.GB21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018094850.GW3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018094850.GW3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/18 11:48, Peter Zijlstra wrote:
> On Thu, Oct 18, 2018 at 10:28:38AM +0200, Juri Lelli wrote:
> 
> > Another side problem seems also to be that with such tiny parameters we
> > spend lot of time in the while (dl_se->runtime <= 0) loop of replenish_dl_
> > entity() (actually uselessly, as deadline is most probably going to
> > still be in the past when eventually runtime becomes positive again), as
> > delta_exec is huge w.r.t. runtime and runtime has to keep up with tiny
> > increments of dl_runtime. I guess we could ameliorate things here by
> > limiting the number of time we execute the loop before bailing out.
> 
> That's the "DL replenish lagged too much" case, right? Yeah, there is
> only so much we can recover from.

Right.

> Funny that GCC actually emits that loop; sometimes we've had to fight
> GCC not to turn that into a division.
> 
> But yes, I suppose we can put a limit on how many periods we can lag
> before just giving up.

OK.

> > So, I tend to think that we might want to play safe and put some higher
> > minimum value for dl_runtime (it's currently at 1ULL << DL_SCALE).
> > Guess the problem is to pick a reasonable value, though. Maybe link it
> > someway to HZ? Then we might add a sysctl (or similar) thing with which
> > knowledgeable users can do whatever they think their platform/config can
> > support?
> 
> Yes, a HZ related limit sounds like something we'd want. But if we're
> going to do a minimum sysctl, we should also consider adding a maximum,
> if you set a massive period/deadline, you can, even with a relatively
> low u, incur significant delays.
> 
> And do we want to put the limit on runtime or on period ?
> 
> That is, something like:
> 
>   TICK_NSEC/2 < period < 10*TICK_NSEC
> 
> and/or
> 
>   TICK_NSEC/2 < runtime < 10*TICK_NSEC
> 
> Hmm, for HZ=1000 that ends up with a max period of 10ms, that's far too
> low, 24Hz needs ~41ms. We can of course also limit the runtime by
> capping u for users (as we should anyway).

I also thought of TICK_NSEC/2 as a reasonably safe lower limit, that
will implicitly limit period as well since

   runtime <= deadline <= period

Not sure about the upper limit, though. Lower limit is something related
to the inherent granularity of the platform/config, upper limit is more
to do with highest prio stuff with huge period delaying everything else;
doesn't seem to be related to HZ?

Maybe we could just pick something that seems reasonably big to handle
SCHED_DEADLINE users needs and not too big to jeopardize everyone else,
say 0.5s?
