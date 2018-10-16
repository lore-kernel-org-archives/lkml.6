Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FF5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FF5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJPX1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:27:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPX1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:27:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id l14-v6so12802036edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMwVivKnYTJZn41LIhLhei8kG5cQW1CKVdW3eGMkEFs=;
        b=lVwL3xF1oE3FBDPieb4tRaDg1yTQAkvKU7ELw2py2sYQfb6zSPB/8CwcW9xPGo0ZoL
         cQL5Ks/LBU3cRa0YbZBkbd386kuG9YrbXR2Gh/QQKrjGfBVb4/1wFzCqZjWJcrEE90I+
         TlvkAnFiq8ktO68tZwybcg27/xmGsi1CVO5n5bmKFeE0VChD2MbIAC5kVWWdBS1BPZLs
         bRB1F240X8dBFY7lRQXm8f8UPs6kMUwShQovW9N0OkCNKmqYm28n6S2ahvuKO/ykZw8m
         j11f4P97kEPuSEY0GR+gownlsrzHgK0qqb4A15o+7adov6xu+O6CHnvrtGQUM3wNOz6T
         1PJQ==
X-Gm-Message-State: ABuFfoiw2vXIo7nxGM8poLdyhAJBqaJwS6Fcu5OQx/8auuE0df3db6hP
        FGzrWmuTFhCS2XURaqp9JcDIqzvLFdxsaA==
X-Google-Smtp-Source: ACcGV61auh7eNJ6OKIEiWywtS/Zb5Pr1mo9pSkrEgG37lsHYURYRNpdxvGlRuwZh9EWBp9aG6W4ELg==
X-Received: by 2002:a50:a643:: with SMTP id d61-v6mr31757776edc.281.1539704171439;
        Tue, 16 Oct 2018 08:36:11 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD0F03569FD0D231D8C2067.dip0.t-ipconnect.de. [2003:ef:2bd0:f035:69fd:d23:1d8c:2067])
        by smtp.gmail.com with ESMTPSA id o13-v6sm2946124ejb.34.2018.10.16.08.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:36:10 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:36:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181016153608.GH9130@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 16:45, Thomas Gleixner wrote:
> On Tue, 16 Oct 2018, Juri Lelli wrote:
> > On 16/10/18 16:03, Peter Zijlstra wrote:
> > > On Tue, Oct 16, 2018 at 03:24:06PM +0200, Thomas Gleixner wrote:
> > > > It does reproduce here but with a kworker stall. Looking at the reproducer:
> > > > 
> > > >   *(uint32_t*)0x20000000 = 0;
> > > >   *(uint32_t*)0x20000004 = 6;
> > > >   *(uint64_t*)0x20000008 = 0;
> > > >   *(uint32_t*)0x20000010 = 0;
> > > >   *(uint32_t*)0x20000014 = 0;
> > > >   *(uint64_t*)0x20000018 = 0x9917;
> > > >   *(uint64_t*)0x20000020 = 0xffff;
> > > >   *(uint64_t*)0x20000028 = 0;
> > > >   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
> > > > 
> > > > which means:
> > > > 
> > > >   struct sched_attr {
> > > >   	 .size		= 0,
> > > > 	 .policy	= 6,
> > > > 	 .flags		= 0,
> > > > 	 .nice		= 0,
> > > > 	 .priority	= 0,
> > > > 	 .deadline	= 0x9917,
> > > > 	 .runtime	= 0xffff,
> > > > 	 .period	= 0,
> > > >   }
> > > > 
> > > > policy 6 is SCHED_DEADLINE
> > > > 
> > > > That makes the thread hog the CPU and prevents all kind of stuff to run.
> > > > 
> > > > Peter, is that expected behaviour?
> > > 
> > > Sorta, just like FIFO-99 while(1);. Except we should be rejecting the
> > > above configuration, because of the rule:
> > > 
> > >   runtime <= deadline <= period
> > > 
> > > Juri, where were we supposed to check that?
> > 
> > Not if period == 0.
> > 
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2632
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L2515
> > 
> > Now, maybe we should be checking also against the default 95% cap?
> 
> If the cap is active, then yes. But you want to use the actual
> configuration not the default.

Sure.

Although DEADLINE bandwidth is "replicated" across the CPUs of a domain,
so we can still admit a while(1) on multi-CPUs domains. Mmm, guess we
should be able to fix this however if we limit also the per-task maximum
bandwidth considering rt_runtime/rt_period.
