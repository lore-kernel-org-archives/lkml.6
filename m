Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B78C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5EC24037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="D5tWSn6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5EC24037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGEN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:27:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45123 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeGEN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:27:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id g15-v6so6348962edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpOq+MYuW1+0odr2YalybUI/Z4hJwGOuXfyVJFs5yRQ=;
        b=D5tWSn6A2wC8hyrXOUaRBuNpCMaaJy4w/MKlE4jnmgp6No0cEsp4iUxwDQT+tdu+gc
         DY89OYRd3STAE/m0LfkuZ8YuWqePL9fh114iQRQWAwYn5RugACD8lAoER7/1TjqkFSy0
         pWrVXjW6rYbZ0qQ5kcdF6nH+5M+yfJySdLbuYnuMiyF2EvjDkJK3HAXbw3fu04qgyfmE
         nSsbOtfLTbdiZJPuckcwKYDS0RLm1qMpRDBG3qWQnHBpWFu4Lm3AuiT0kn8Dbs75F5jl
         ZCsVmVjqHHwnGK2Q5vjvU9Wjg2wWZX/MTJI94HXZnTNQarxMQS4xJBDzFN9+IEC3LwUL
         /xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpOq+MYuW1+0odr2YalybUI/Z4hJwGOuXfyVJFs5yRQ=;
        b=ujZcayX3UppUOi1ZQJwGkOILZN6Oi4uLX80e9aLVOuAzCRLg/AOr52i5GzDGcROXN5
         OLsUhbDRaUCIBkexeN9LepXpjAbBumeh7zmBPz5l4Lm6lwylSGzjvfXAq/1Iu1bKPEGD
         e06RuQMAoJJhDe2HZXGzC4miBRn+sYejeH2srWGpoSUvOIWM6lpijzeId6D8nOEMRtDQ
         FeuoSPE+K1pVdkqRdRKd6lQqJnkDkqGdtl8d08I+1WLM0ErqaCfC3K+Fa2wa//Q7L9bS
         o+F2Q/MFbU8O8UJSqFEmTX7oq2Zc/e6U8lMh/L2uvZoKxHYhzJEA7KoMmNJgduC+azAx
         oY9g==
X-Gm-Message-State: APt69E30lSsMuNyBmkk8WyHIuvW4cJbpiMDJcPmIops/mWY6HMk+GjYP
        iRZ6EyLFt+YexbffZ0a3ePkkUw==
X-Google-Smtp-Source: AAOMgpf+cx/immFzBSKruXW7RB8LjQmKGv9lob2rcADzRHdi55Wk8qMGStSkMe+u6Qw+SRGREJTIiA==
X-Received: by 2002:a50:9935:: with SMTP id k50-v6mr6534511edb.45.1530797247607;
        Thu, 05 Jul 2018 06:27:27 -0700 (PDT)
Received: from localhost ([2a02:c7f:9214:6300:de53:60ff:fe39:5599])
        by smtp.gmail.com with ESMTPSA id x11-v6sm7055115edb.39.2018.07.05.06.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:27:26 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:27:26 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] sched/fair: Avoid divide by zero when rebalancing domains
Message-ID: <20180705132726.GB3864@codeblueprint.co.uk>
References: <20180704142455.16035-1-matt@codeblueprint.co.uk>
 <55afee27-4143-e08c-b254-0d68a05d5ee6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55afee27-4143-e08c-b254-0d68a05d5ee6@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul, at 11:10:42AM, Valentin Schneider wrote:
> Hi,
> 
> On 04/07/18 15:24, Matt Fleming wrote:
> > It's possible that the CPU doing nohz idle balance hasn't had its own
> > load updated for many seconds. This can lead to huge deltas between
> > rq->avg_stamp and rq->clock when rebalancing, and has been seen to
> > cause the following crash:
> > 
> >  divide error: 0000 [#1] SMP
> >  Call Trace:
> >   [<ffffffff810bcba8>] update_sd_lb_stats+0xe8/0x560
> >   [<ffffffff810bd04d>] find_busiest_group+0x2d/0x4b0
> >   [<ffffffff810bd640>] load_balance+0x170/0x950
> >   [<ffffffff810be3ff>] rebalance_domains+0x13f/0x290
> >   [<ffffffff810852bc>] __do_softirq+0xec/0x300
> >   [<ffffffff8108578a>] irq_exit+0xfa/0x110
> >   [<ffffffff816167d9>] reschedule_interrupt+0xc9/0xd0
> > 
> 
> Do you have some sort of reproducer for that crash? If not I guess I can cook
> something up with a quiet userspace & rt-app, though I've never seen that one
> on arm64.
 
Unfortunately no, I don't have a reproduction case. Would love to have
one to verify the patch though.

> > Make sure we update the rq clock and load before balancing.
> > 
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> > ---
> >  kernel/sched/fair.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2f0a0be4d344..2c81662c858a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9597,6 +9597,16 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >  	 */
> >  	smp_mb();
> >  
> > +	/*
> > +	 * Ensure this_rq's clock and load are up-to-date before we
> > +	 * rebalance since it's possible that they haven't been
> > +	 * updated for multiple schedule periods, i.e. many seconds.
> > +	 */
> > +	raw_spin_lock_irq(&this_rq->lock);
> > +	update_rq_clock(this_rq);
> > +	cpu_load_update_idle(this_rq);
> > +	raw_spin_unlock_irq(&this_rq->lock);
> > +
> 
> I'm failing to understand why the updates further down below are seemingly
> not enough. After we've potentially done 
> 
>     update_rq_clock(rq);
>     cpu_load_update_idle(rq);
> 
> for all nohz cpus != this_cpu, we still end up doing:
> 
>     if (idle != CPU_NEWLY_IDLE) {
> 	    update_blocked_averages(this_cpu);
> 	    has_blocked_load |= this_rq->has_blocked_load;
>     }
> 
> which should properly update this_rq's clock and load before we attempt to do
> any balancing on it.
 
But cpu_load_update_idle() and update_blocked_averages() are not the same
thing.
