Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A11C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70002154B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JDnmKY03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70002154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeHOUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:13:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39917 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:13:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id r184-v6so1360173ywg.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WniOhK+S9+FKHSRY1zVgx6g2kWxLnHzfoZlUF6Lt5mM=;
        b=JDnmKY036tjBLlQreE5Juc26Ybfmq8/fXuU7SOoTY6YPvku6F6N9pK0214cCat9jqy
         acjG9/2r2p4+IfOhPy3obp/EQGNzruPTgtQMSSHNUJRZQ2V+maBQL2IaigFZ8LJjSB8B
         3FtY/A0pgukl+RGQRGjXM40M7MBMyzY8f6v6GF2PoEWKsc2jdE1+LmONlGfYgLdQgS9K
         3J1BdHDuRmTfxdxMu5J5nTdvOYeBw0tiUXeBjJ8s4/HNtXZCVS1OGp7v/x7kvc/tfTlR
         IxclJtIlAujEvKfmNV57K9bYDRmjibBA33u9LLNRbd4TYy0otv5HIwkPxuqI2ajjZBz6
         V1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WniOhK+S9+FKHSRY1zVgx6g2kWxLnHzfoZlUF6Lt5mM=;
        b=T8SfGpIcHfPUz51BZ2HFEY3Y3a3VrveLgWdHzvlmv/K2ykcbprGzdOQtdc1t3EycPC
         /N9M3C8lQQRHEUh4ceRJlyWcCeVhfcG+BXr3rBhksHT3llsZHjnWdBibwycr9+OLrbOn
         xop/CQV6Yt3kNDt7J5u8WzzSSSiHMWd89aaaYxxnZ5ym2B7KRr+uS6bVVd2HlbBJu2TX
         klvu26Eq7WmkMLqfvWGj/9rzE4Af3E0MKdsOnv9THfEJ9bXa90D6piFq4xxjfjkIRwer
         KexzLUowJjWxVsVJ2/zT1id9OQbvpt4AJNHK+LZRE+XzzJKCYzdz5oaoWCersIeEJG6e
         2bjA==
X-Gm-Message-State: AOUpUlHuoWF2jAnTyVfwA7lKKon6DhzqkGg5OnRU/TSF7VVaXtp/3IyB
        2RHAplQjYNbTesHcIoX6NYVeRxYrYRA=
X-Google-Smtp-Source: AA+uWPyJkdI3gNAZ/7gXh7MVepzC0L1NndVDs9mYLvtsK3/zGDW4hLds4GTp+VAFsyEcPSemXNKS1w==
X-Received: by 2002:a25:b44a:: with SMTP id c10-v6mr14442604ybg.274.1534353646159;
        Wed, 15 Aug 2018 10:20:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::9380])
        by smtp.gmail.com with ESMTPSA id f82-v6sm16252782ywf.58.2018.08.15.10.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:20:45 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:20:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815172044.GA29793@cmpxchg.org>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815165513.GA26330@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:55:17AM -0700, Roman Gushchin wrote:
> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
> > On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> > > @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> > >  		return s->addr;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Allocated stacks are cached and later reused by new threads,
> > > +	 * so memcg accounting is performed manually on assigning/releasing
> > > +	 * stacks to tasks. Drop __GFP_ACCOUNT.
> > > +	 */
> > >  	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> > >  				     VMALLOC_START, VMALLOC_END,
> > > -				     THREADINFO_GFP,
> > > +				     THREADINFO_GFP & ~__GFP_ACCOUNT,
> > >  				     PAGE_KERNEL,
> > >  				     0, node, __builtin_return_address(0));
> > >  
> > > @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> > >  #endif
> > >  }
> > >  
> > > +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> > > +{
> > > +#ifdef CONFIG_VMAP_STACK
> > > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > > +
> > > +	if (vm) {
> > > +		int i;
> > > +
> > > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > > +			memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> > > +					  compound_order(vm->pages[i]));
> > > +
> > > +		/* All stack pages belong to the same memcg. */
> > > +		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > > +				     THREAD_SIZE / 1024);
> > > +	}
> > > +#endif
> > > +}
> > 
> > Before this change, the memory limit can fail the fork, but afterwards
> > fork() can grow memory consumption unimpeded by the cgroup settings.
> > 
> > Can we continue to use try_charge() here and fail the fork?
> 
> We can, but I'm not convinced we should.
> 
> Kernel stack is relatively small, and it's already allocated at this point.
> So IMO exceeding the memcg limit for 1-2 pages isn't worse than
> adding complexity and handle this case (e.g. uncharge partially
> charged stack). Do you have an example, when it does matter?

This is completely backwards.

We respect the limits unless there is a *really* strong reason not
to. The only situations I can think of is during OOM kills to avoid
memory deadlocks and during packet reception for correctness issues
(and because the network stack has its own way to reclaim memory).

Relying on some vague future allocations in the process's lifetime to
fail in order to contain it is crappy and unreliable. And unwinding
the stack allocation isn't too much complexity to warrant breaking the
containment rules here, even if it were several steps. But it looks
like it's nothing more than a 'goto free_stack'.

Please just fix this.
