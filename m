Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC7C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D9820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJXT4bAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D9820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeKHOSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:18:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39653 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbeKHOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:18:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id n11-v6so8744768pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIHvBPmRozViMDb1Ix2U3lmCo2p90YWjCaHPXBxW35w=;
        b=AJXT4bApIlc/tUtitc8yzL9cZ1jRPecvhSGVicQOt6zZ5SPbZSVCHWnUVFCoFHZ7aD
         KM9QpBaU2XyU2nvmX1qtQ8nSBT/LdMINgQErlZrI0CS5ng+oTNvqIxZ8vidJYs0OS2hs
         HJEWz6MtC6L1B+KK9Kp55a+/OVQ/x5InDKjY/s/BUmIKMcuLxOn5+8wSijDZSSm3tgFt
         00NTWYQwiVwGTxdMsE7oXF2PiyGNt5cjzB0JGSdYMn1WFwECazQSOS/4p+JyRrMFE22d
         RpwMo3VVlTPysNnbUVC/ndMKlOAd+nNdW+GZsH0Aj0Yc4NNJ+0J4xaUfiDqNM3w5lOBR
         4uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIHvBPmRozViMDb1Ix2U3lmCo2p90YWjCaHPXBxW35w=;
        b=JbecowJQXCHYkMU4Um90o3/uOU2TLM7JeHmV402FCdi92p13fDV4IeEH/Li/4rds/E
         z1U3NP3dNE8UZLTtUCqEKhNODqWfqslEXSzymRqsWfVDj7moNEDaiLM6+nY03GI1yvIM
         GS0iA8Q23VW6jj8TAR6FWiW9x0PTgJ6p4hzJdkyVFwaM1kBLfqMmlYWBeJC+IwpmyNO6
         Y8f73yCekn5HB1PJXNOAo8+H0T/OXAWtYTkYVvS+GAlrxUvaRTHawSR3jMuH+xR0V49/
         74jV0yt0KaaNNcWH9abimPLyEhOHcDIkEQHELatedDpuR4a0vrFzRGp+vz1pBrfkauZj
         6OGQ==
X-Gm-Message-State: AGRZ1gJ1adWNUgHBvb7b+CKigSYBHluYsVitU8Mq0SaHejnTtXo1J9W2
        IzdJzQVVjFTYypedSB1wizE=
X-Google-Smtp-Source: AJdET5craDvc+dDSRXFgy218WfWBwoD6EHymp1Z0Oh/uxdc8vUcX/1XsaC99ifsonmMFJRCxtGiQ5A==
X-Received: by 2002:a63:4745:: with SMTP id w5mr2662164pgk.377.1541652314843;
        Wed, 07 Nov 2018 20:45:14 -0800 (PST)
Received: from localhost ([39.7.58.178])
        by smtp.gmail.com with ESMTPSA id u76-v6sm2624807pfa.176.2018.11.07.20.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 20:45:13 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:45:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181108044510.GC2343@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/07/18 16:19), Petr Mladek wrote:
> > syzbot is sometimes getting mixed output like below due to concurrent
> > printk(). Mitigate such output by using line-buffered printk() API.
> > 
> > @@ -2421,18 +2458,20 @@ static void check_chain_key(struct task_struct *curr)
> >  print_usage_bug_scenario(struct held_lock *lock)
> >  {
> >  	struct lock_class *class = hlock_class(lock);
> > +	struct printk_buffer *buf = get_printk_buffer();
> >  
> >  	printk(" Possible unsafe locking scenario:\n\n");
> >  	printk("       CPU0\n");
> >  	printk("       ----\n");
> > -	printk("  lock(");
> > -	__print_lock_name(class);
> > -	printk(KERN_CONT ");\n");
> > +	printk_buffered(buf, "  lock(");
> > +	__print_lock_name(class, buf);
> > +	printk_buffered(buf, ");\n");
> >  	printk("  <Interrupt>\n");
> > -	printk("    lock(");
> > -	__print_lock_name(class);
> > -	printk(KERN_CONT ");\n");
> > +	printk_buffered(buf, "    lock(");
> > +	__print_lock_name(class, buf);
> > +	printk_buffered(buf, ");\n");
> >  	printk("\n *** DEADLOCK ***\n\n");
> > +	put_printk_buffer(buf);
> >  }
> >  
> >  static int
> 
> I really hope that the maze of pr_cont() calls in lockdep.c is the most
> complicated one that we would meet.

Hmm... Yes, buffered/seq_buf printk looks like a hard-to-use API,
when it comes to real world cases like this.

So... here is a random and wild idea.

We actually already have an easy-to-use buffered printk. And it's per-CPU.
And it makes all printk-s on this CPU to behave like as if they were called
on UP system. And it cures pr_cont(). And it doesn't require anyone to learn
any new printk API names. And it doesn't require any additional maintenance
work. And it doesn't require any printk->buffered_printk conversions. And
it's already in the kernel. And we gave it a name. And it's printk_safe.

a) lockdep reporting path should be atomic. And it's not a hot path,
   so local_irq_save/local_irq_restore will not cause a lot of trouble
   there probably.

b) We already have some lockdep reports coming via printk_safe.
   All those
	printk->console_driver->scheduler->lockdep
	printk->console_driver->timekeeping->lockdep
	etc.

   came via printk_safe path. So it's not a complete novelty.

c) printk_safe sections can nest.

d) No premature flushes. Everything looks the way it was supposed to
   look.

e) There are no out-of-line printk-s. We keep the actual order of events.

f) We flush it on panic.

g) Low maintenance costs.

So, can we just do the following? /* a sketch */

lockdep.c
	printk_safe_enter_irqsave(flags);
	lockdep_report();
	printk_safe_exit_irqrestore(flags);

	-ss
