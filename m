Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF72C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C453420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtBcOpWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C453420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJBQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:38:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44100 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJBQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:38:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so1435737wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FpHbMoWWsNR+8OF36JCZI/cedQhCwTaoUNjf9sTHGks=;
        b=JtBcOpWnjvjsAxfRUx3hscM51Ds7SO1zVxg7Rcbm83edviF8D8tYPIKxxXD+AJNtvu
         kUfnXe/evoN9wkRTptp5okAiKO4Mus0KO2SGCQUbw6zQ/RScym3fhqPHQ/9fmdtJ7O4+
         q286ftpUZ9GUpWb++DgledRxOig/Skk2TLiQwbVGAsJP7s+JZAISixKL5d8fVb+AzTWo
         n4Q2DNeK4b5NqefhMpxHba6abzbmBEndyZBVBAe60FGDZsjfaYyQVNxOyqSr1jMs5kU8
         35oK0gguaCX5Mf28Zww8DaZxWKAuhFkMnH5jvyn2pIUcvY0gK2/8AiWcYB0MdDmQphZ4
         l5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpHbMoWWsNR+8OF36JCZI/cedQhCwTaoUNjf9sTHGks=;
        b=DDfqeqlfpYpCp2H4F1xC+7Ue2jTjpol+CJyZeXhPB2zUofbi3pT9eNidu/i2t5/TSt
         oE6TDqmtwkwFbfZFVIQCiCn0DRed0n94cwqvWN77Pkhz4FCja9Ih6X8kf3YJcKyZ5PQY
         6m7Nhx8supukeYpWOqq5n+P0JDstD0bNowK8LOvJNs7VTKpXTs+URtpRLE7MRXsCbeW1
         990D9TS2EgSnkgUoJ/s1x87X0L03s+14GDwa/FIxHlObmOadLiu1Rtj+GnGx/jHnU8Gh
         c9I7H6/DmNG/aY7z+uLnJ8qSi2mMpjSqUq5LYtKCe71M9IYDhphKa2tLLhvy4ELzucDP
         dyvA==
X-Gm-Message-State: ABuFfogtICUMPRDe1Zpt5vH5Y8ix6bgdipJYYagetyDDpqp3LwawLh3T
        CatukxxpRTG7goHPkrqoj9p+QSl6
X-Google-Smtp-Source: ACcGV62vidjdukBZt3tpV2ZqxRDMQp3XHQeuL4MzB83g2JBi1EXcGcpxmzyXxqYziPeZ/QfYUr/tAQ==
X-Received: by 2002:adf:a1dd:: with SMTP id v29-v6mr9679920wrv.50.1538474146482;
        Tue, 02 Oct 2018 02:55:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u5-v6sm6359306wru.16.2018.10.02.02.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:55:45 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:55:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181002095543.GA55344@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-5-git-send-email-longman@redhat.com>
 <20181002093907.GV3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002093907.GV3439@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 28, 2018 at 01:53:20PM -0400, Waiman Long wrote:
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index ca002c0..7a0ed1d 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -139,6 +139,7 @@ static inline int debug_locks_off_graph_unlock(void)
> >   */
> >  unsigned long nr_lock_classes;
> >  static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
> > +static DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
> 
> > @@ -1387,11 +1391,15 @@ static inline int usage_match(struct lock_list *entry, void *bit)
> >  
> >  static void print_lock_class_header(struct lock_class *class, int depth)
> >  {
> > -	int bit;
> > +	int bit, cpu;
> > +	unsigned long ops = 0UL;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		ops += *per_cpu(class->pops, cpu);
> >  
> >  	printk("%*s->", depth, "");
> >  	print_lock_name(class);
> > -	printk(KERN_CONT " ops: %lu", class->ops);
> > +	printk(KERN_CONT " ops: %lu", ops);
> >  	printk(KERN_CONT " {\n");
> >  
> >  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
> 
> That is an aweful lot of storage for a stupid number. Some archs
> (sparc64) are bzImage size constrained and this will hurt them.
> 
> Ingo, do you happen to remember what that number was good for?

Just a spur of the moment statistics to satisfy curiousity, and it's useful to see how 'busy' a 
particular class is, right?

> Can't we simply ditch it?

We certainly could. Do we have roughly equivalent metrics to arrive at this number via other 
methods?

Thanks,

	Ingo
