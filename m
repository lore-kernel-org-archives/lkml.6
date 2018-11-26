Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A4C20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEOhmuwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4C20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKZP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:27:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40127 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKZP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:27:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5543198pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=peDXVT5mY5Yf5+sTmHvdVOFS/quXlo0JqDfFo5WInfo=;
        b=LEOhmuweJlcBBK4tF9RD64W9RzgVxVvZ5RhiWucp/hQzeraFu1/hjyEbMtSg5ENSP7
         N1UeYrLD94L4SPbOBDuAviUBozDphkONK40fo2m5FHqZ7SBbfRGLlHFUKWdxkW7PDwD1
         PoguJE/4uy7kyo9oiST2KPnGpHj0Jsy+H2DI6hmJlrc2Ymh+KWRZsIfaFDIjQNVC1kwQ
         vDXHc3NHrKL9pARXZfYiKMWlKV72N7zJjaJPmY3LNuK+ms2hh4rOWjZ0UrxAS+d0qwJm
         GzZlQ5RquErhjd7IHUiJTNRKNjJWD0EoCVc6HbXG92D4fiaqWGiA9jLXg0HUp/wy1NSD
         RIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=peDXVT5mY5Yf5+sTmHvdVOFS/quXlo0JqDfFo5WInfo=;
        b=VUCY0z8iTmEbOLOfw8HYUt5aGYoTrqAMSw+22ru8gECyM2f2YBxHdbh+Akk+hBPADp
         p7cIJIndQ6K1wVcJZgUesn8ZzmoWePyaQaRnncY9VJ8jh29ej1ZgTPhSSsMu23HhzY+r
         UifniqKXjiCS2E7ccxdeA2hUiDSQ0WujUopI+ODTmuG9QCo3tq8pMjdrYYA86rPXY2J/
         j3z2PyB0qKH+fgPDQrjWRsmkfwe17eyoa8KiVxB026C09AZq8DQwEcQH2r8CTFBcDL3s
         GklovcqVKXLEGGqtYvQP7AK315hCBI1Cmhb5+P+QHc4AYR2+h38eB9sP8RFNqZF6BPu3
         yQ8g==
X-Gm-Message-State: AA+aEWbF53RCD3MxQ2HCibTVG5U9II39EnJPy4gYbo5hSgQL83uNgQaN
        VUccLzH0E4hlWXHTLCBkDI0=
X-Google-Smtp-Source: AFSGD/UMxIMpY73wuji9c0rrT1yfFGS+6Jgd21LQ7N0EsjKfZW56qiduL4W88TPIWBGCZwTpOs/COQ==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr23691504pgc.3.1543206890582;
        Sun, 25 Nov 2018 20:34:50 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id c23sm42449633pfi.83.2018.11.25.20.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 20:34:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 13:34:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181126043445.GB540@jagdpanzerIV>
References: <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
 <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
 <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
 <20181123105634.4956c255@vmware.local.home>
 <6422717f-db27-8ba8-1183-ccb9f0400fc3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6422717f-db27-8ba8-1183-ccb9f0400fc3@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/24/18 09:24), Tetsuo Handa wrote:
> >> Steven told me on Plumbers conference that even few initial
> >> characters saved him a day few times.
> > 
> > Yes, and that has happened more than once. I would reboot and retest
> > code that is crashing, and due to a triple fault, the machine would
> > reboot because of some race, and the little output I get from the
> > console would help tremendously.
> > 
> > Remember, debugging the kernel is a lot like forensics, especially when
> > it's from a customer's site. You look at all the evidence that you can
> > get, and sometimes it's just 10 characters in the output that gives you
> > an idea of where things went wrong. I'm really not liking the buffering
> > idea because of this.
> 
> Then, we should not enforce buffering in a way that requires modification of
> printk() callers. That is, we should not ask printk() callers to use their
> private buffer. What we can do is to enable/disable line buffering inside
> printk() depending on the problem the user wants to debug.

Right; overall I tend to agree with what you guys are saying and
I like Petr's "I am more and more wondering if the buffered printk
is worth the effort" comment; and I like Steven's comment on flushes;
and admire Tetsuo's efforts.

I think that printk_seq_buf/printk_buffer was never going to replace
pr_cont() and I never liked the idea. The printk_safe proposal for
lockdep had one OK thing about it - it would pass our normal marshaling
before it would reach the buffering stage. Which means - no buffering
for people who "detest" printk buffering.

This looks better:
	printk->vprint_func->{early_printk/printk_safe/vprintk_emit}->buffering

Than this:
	pr_buffer->buffering->vprintk_func->{early_printk/printk_safe/vprintk_emit}

Another thing is - printk seq_buf/printk_buffer doesn't really solve any
problem. People, who can use seq_buf/char buf[256]/etc. buffering, already
can do so; people who cannot - won't switch to a new buffering printk
anyway.

The bad thing about printk_safe proposal is that it's per-CPU; which
is OK for some paths (like lockdep), but not OK in general (e.g. OOM).

IMO, try_buffered_printk() attempts to solve the problem at the right
place - printk. And it does not break our normal marshaling, so we don't
"fix" printk users and we keep people, who does vprintk_func->early_printk
thing, happy. So I don't dislike try_buffered_printk() approach. And unlike
before, now we are talking about a single line buffering.

If we'd walk this way, I would prefer to NOT introduce any structs and
any new code, or any new "split and log_store() in the middle" rules. Just
a bunch of "struct cont" buffers:

	static struct cont conts[N];

and cont_add()/cont_flush() to handle pr_cont, with all the flushes it
does; but on a per-context basis.
conts[0] should serve as a fallback cont buffer, in case if there are
no available cont buffers left. flush_on_panic() is still miserable,
for sure; probably we can do something about it.

Or... Instead.
We can just leave pr_cont() alone for now. And make it possible to
reconstruct messages - IOW, inject some info to printk messages. We
do this at Samsung (inject CPU number at the beginning of every
message. `cat serial.0 | grep "\[1\]"` to grep for all messages from
CPU1). Probably this would be the simplest thing.

> Also, we should allow disabling "struct cont" depending on the problem (in
> order to allow flushing the 10 characters in the "cont" buffer).
>
> By the way, is the comment
>
>   /*
>    * Continuation lines are buffered, and not committed to the record buffer
>    * until the line is complete, or a race forces it. The line fragments
>    * though, are printed immediately to the consoles to ensure everything has
>    * reached the console in case of a kernel crash.
>    */

printk does not do this anymore; you are right.

> appropriate despite we don't call cont_flush() upon a kernel crash?

I tend to count on flush_on_panic more than on a "last moment"
pr_cont->cont_flush(), which was guaranteed to happen immediately
only with early_con.

A kernel crash usually has enough pr_emerg/printk-s to force cont flush.
Even pr_info() will do. We look at the loglevel much later; so even
messages which never make it to the consoles still flush cont buffer.

	-ss
