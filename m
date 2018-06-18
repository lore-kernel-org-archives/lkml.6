Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E0D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hduZZ1Lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E0D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936035AbeFRKKw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:10:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47058 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeFRKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:07:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so7906271pff.13;
        Mon, 18 Jun 2018 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKSpzZQJUR2AJr6anRCZermxAfzilNdVcM8VSOxuVjE=;
        b=hduZZ1LouvWllMduUr0QTHmYUjbNCxbGx1KCVqR6systfYP2rxJezv3+vBvtrW7I9U
         pJDuxAj0XVX9u4MpW/jfqqfLjpzr6amGQWH3vt2AwPNX0JOzFsRkCi/7is9AQeL9C5Qz
         Od4M7G++9GLczoZ9aoIu2Z+D35nhuAE7gA22RjFpZvaa5m9FksYHR37yAnkKJ6GTCjgD
         FQyaIqH4G0Wv228t2fVllB+eFc6HO5ub4RDP/LOjsuZi1QlwjYJwe7Riq4sXZ5MB10E3
         omjPCZNXE544tDBTgzyYtGzKilGeHZCVh3esrNpPw0ZiB1zSI6v4mE7p5W/P4kAfuWML
         niLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKSpzZQJUR2AJr6anRCZermxAfzilNdVcM8VSOxuVjE=;
        b=gvuQCHmtvsS3+GR3LOt1b4/w3QEYzO2NG6qDbd6iVv/CtJEEZmI2CjKKLn7Gy9JnZ0
         oOnxgHKJ91xRA8dLmpZq4wRUSy26gCwpy+SrzXrl87b9l/gK38hm6nUYWu5PbjifixzM
         /lWPo/oy8HLkacolXcEVxZQhAREhf2U2eozQ/OzZcHJ25giSthPUJk6H5PHbKzvxojcp
         Dy2BjwY5HWWK10XXozxj9gp4LJLPon1vbfJlw1HGDwhc11l/ImYAKWr1jFXL8MTkf1tR
         GxzOXe/d0pdfLmN3/Zv6/b6NXSBShgxNyh2yv4beAwDGWOQYFSQ+Hpbtm41rBXy79QCw
         XmlQ==
X-Gm-Message-State: APt69E2XSkcR7fPyb+NejAIexawpcTM/ZmhJ2FP+3/FO2jvlvvuwdVa4
        jCvXnFMLe5+TZyBt3MRgw/0=
X-Google-Smtp-Source: ADUXVKK6LqNGinJqvkOGlwMYCfhY/z5PSb7tAH4K8GhlGlNzy7R2/gqhMFgZveoYBCYidU4PFsZFUw==
X-Received: by 2002:a63:b505:: with SMTP id y5-v6mr10646457pge.213.1529316442954;
        Mon, 18 Jun 2018 03:07:22 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id f9-v6sm15648316pgt.79.2018.06.18.03.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 03:07:21 -0700 (PDT)
Date:   Mon, 18 Jun 2018 19:07:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180618100718.GA555@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
 <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/18/18 11:39), Petr Mladek wrote:
[..]
> > >  extern void printk_nmi_enter(void);
> > >  extern void printk_nmi_exit(void);
> > > +extern void printk_nmi_direct_enter(void);
> > > +extern void printk_nmi_direct_exit(void);
> > >  #else
> > >  static inline void printk_nmi_enter(void) { }
> > >  static inline void printk_nmi_exit(void) { }
> > > +static void printk_nmi_direct_enter(void) { }
> > > +static void printk_nmi_direct_exit(void) { }
> > 
> > Can we have better names may be? Since direct printk_nmi is not
> > in fact always `direct'.
> 
> What about printk_chatty_nmi_enter(), printk_large_nmi_enter()
> or something similar?

Hmm. Can't answer right now :)

> > > +#ifdef CONFIG_PRINTK_NMI
> > > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args);
> > > +#else
> > > +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args) { return 0; }
> > > +#endif
> > 
> > Hmm, printk_safe.c knows about printk.c, printk.c knows about
> > printk_safe.c.
> 
> I am sorry but I do not understand the problem. The function is
> defined in printk_safe.c and we need to call it also from printk.c.
> It seems reasonable to declare it in kernel/printk/internal.h.

Just wanted to suggest to keep printk_safe/printk_nmi stuff in printk_safe.c.
We already have everything we need there, so let's just add the vprintk_nmi()
fallback, avoiding spreading printk_safe/printk_nmi logic and details across
printk.c and printk_safe.c

> > OK... Can we do this in vprintk_func()? The race window should be super
> > tiny [if matters at all], but in exchange we don't have to mix nmi, printk,
> > printk_mni, etc.
> 
> You are right that it would still solve the main risk (NMI comes
> inside logbuf_lock critical section).
> 
> In fact, the only real risk would be another lock serializing NMIs
> and printk() called with that lock. This patch removes one in
> nmi_backtrace() and I am not aware of any other.
> 
> The less hairy code really might be worth the rather theoretical risk.
> 
> > So over all I understand why you did it this way. May be I'd prefer to
> > have less universal but shorter solution (e.g. modify only nmi_backtrace
> > function and put there "printk_nmi_restricted_buffer"), but I won't really
> > object your patch [unless I see some real issues with it].
> 
> Thanks in advance. I'll send v2 once we have a conclusion on
> the function names and includes.

Does this mean that we agreed to handle the printk_nmi per-CPU buffer
fallback in printk_safe.c?

	-ss
