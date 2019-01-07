Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB528C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26B82147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkN8Co/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfAGVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:34:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:34:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so2026585wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMMb15lGyK7S1TGau6wxghgbdXotId5FT5E0F+F0L34=;
        b=YkN8Co/dTC9+QdnFpMXdPbamnNwU2GziQuavoG7gWMhTLMMCgoBPOtRsYBv5ayeWRx
         /wVJbNc8NUd3TpowunsMp+JNwgu4u6hmDZhgLmUYWj1e4xMWYEQQ/G4gT93W4QzhJBdY
         h5SQJjJugNDIlD8fs/0xbypGSFE/JVfBBTJ+EsGXrxCy7fbede4K/P6WZ0Zn1x2ASHMQ
         4Oxe9CHR6w8LYULqFrsSL/93iBgexNnu60A6Z31NODzwwN6LlYG4TwRHFSnE8724ILUx
         wTAQ89mkNXdSxOwdLVcR9Y7L3FU9KdurFHS+CBhQTV1G3h7RpplJ1rA2T4KjqcPUIP7N
         Dv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMMb15lGyK7S1TGau6wxghgbdXotId5FT5E0F+F0L34=;
        b=i613ielQ2gMGKM/VxUsyoqDXdS05a+yWYXGBt/tiZSp3LI8sLVBN49WrCTFWVD6GaH
         19yWiADUuCpf6YZm0mAlREwEy+miFtX61zB/HWI7aEZ2yRz01pYvAjDKxsu/mYjLy9xh
         AtvKl7F8dsk+McAV7HAYO08FvAelKADVZgK2mX8H2LwqalUTLOQYrgsMnHOHYZhLKqXc
         r6CbzGZ005Z4KjXQ1cn10gx/U0vJar1nKPs14q+pMWDFCDYtOwtWcKpfII2t+FeNOByu
         25kKd+nePHOJrpN8GddASqdCzqoQECMwUsHP3WFzQK6nbGJpXpJu/joD7Y411bGQKFaD
         3OfQ==
X-Gm-Message-State: AJcUukdlew9MmwAgUpZP/ioNA46WI7csaM3h4OrkiBXl0fcD5qfFY94v
        cwvS/a+8ry7QV5l2yFXyHw==
X-Google-Smtp-Source: ALg8bN4814RKJtU/dIFcXCf7HZvSxw71LEEcmYMpqjWM58jGu9HYxchen2/VUSjTWUYJN4QEbHayQQ==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr49754411wrl.137.1546896881032;
        Mon, 07 Jan 2019 13:34:41 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id s1sm77109397wro.9.2019.01.07.13.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:34:40 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:34:39 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107213439.GD5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
 <20190107183444.GA5966@xps-13>
 <20190107142749.34231bb6@gandalf.local.home>
 <20190107195209.GB5966@xps-13>
 <20190107145918.407b851b@gandalf.local.home>
 <20190107211904.GC5966@xps-13>
 <20190107162833.1e034fc7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107162833.1e034fc7@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:28:33PM -0500, Steven Rostedt wrote:
> On Mon, 7 Jan 2019 22:19:04 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > > > If we put a kretprobe to raw_spin_lock_irqsave() it looks like
> > > > kretprobe is going to call kretprobe...  
> > > 
> > > Right, but we should be able to add some recursion protection to stop
> > > that. I have similar protection in the ftrace code.  
> > 
> > If we assume that __raw_spin_lock/unlock*() are always inlined a
> 
> I wouldn't assume that.
> 
> > possible way to prevent this recursion could be to use directly those
> > functions to do locking from the kretprobe trampoline.
> > 
> > But I'm not sure if that's a safe assumption... if not I'll see if I can
> > find a better solution.
> 
> All you need to do is have a per_cpu variable, where you just do:
> 
> 	preempt_disable_notrace();
> 	if (this_cpu_read(kprobe_recursion))
> 		goto out;
> 	this_cpu_inc(kprobe_recursion);
> 	[...]
> 	this_cpu_dec(kprobe_recursion);
> out:
> 	preempt_enable_notrace();
> 
> And then just ignore any kprobes that trigger while you are processing
> the current kprobe.
> 
> Something like that. If you want (or if it already happens) replace
> preempt_disable() with local_irq_save().

Oh.. definitely much better. I'll work on that and send a new patch.
Thanks for the suggestion!

-Andrea
