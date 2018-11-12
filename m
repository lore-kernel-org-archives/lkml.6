Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE27C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F4921582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdAiapz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F4921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeKLRv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:51:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeKLRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:51:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so251995pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9bJ2xvaoOjUEvCPnKtc/KLOx7auJCTWflyYQx6oZMU4=;
        b=QdAiapz3HmsjmyBkz4lpfeAHt37fGAj1nX8kkqRE1hnmMd0kScgEx0Qk33IKALLGtq
         VjuESuTRUtzqt/CBbop7qS1BkCbhRRw11vBBIfRxAc7EmTkq0/fN7ktJ33jcSCUIm//a
         pmwKFXi/ALkeQs8uouSsxuT20+/QP47JFIxLq3E2RXc3xzb9rrJk0l3ti/dVjzbiMfDO
         z0DYY8vLU9x6ebGROlVR/f20NW2w/nw2ufAwqnz4/+75dgDVvc7bUxmwTbJ5x6a0BGWb
         WsuylRaqzWO9MOvSEE3jJkg+TSD8bZBajovYOsvLuQ1MGKv5ekm1r6h9yqHWOptYyUiw
         JSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bJ2xvaoOjUEvCPnKtc/KLOx7auJCTWflyYQx6oZMU4=;
        b=lhiyoDANuoXd3eTo1O/U+59kbCVeCX+0mTsav0Kq2e9x8QwWs7QpzDRxz5drSWFitC
         p+PCeOZ0bHtuFngX05DfuCqEcGjxtQcWxhzmptsWWbkYWtGvtXEJQuqBQI3vHZQDf/+T
         dN+6RCxykz5rI+jMEZgiW+ZUkbihmrRvuvYxPiB8GGzZo+TPZo63RRKXyP6PXcZyUyTM
         nPX+Aa4ZKqITDqQmWK2s04n8medjwiI8Xa3Oji+3N66MONqw0+B1W5nF+m93Sg1OL628
         jskotdxILmJWHTg/vLzJgCmvmYz3GUQ18cEsw4p1CBWSndiZC4A2amrl8y515aE3Y4KA
         kK/g==
X-Gm-Message-State: AGRZ1gLoLddsEjwUg1mcLbdWv0miGVxkHCkZq3Nq+Z/08quiznU+qIVW
        ezc56DCqLEsktcOLjhLaTRY=
X-Google-Smtp-Source: AJdET5cq42QYjZ+Q1PV5xw9TQ4aIdmzBhOOGUaBmUg50B7wYjoBhNIw2eo7NkNMx+na3j9+T/CRPtA==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr2721754pgc.200.1542009565088;
        Sun, 11 Nov 2018 23:59:25 -0800 (PST)
Received: from localhost ([110.70.57.105])
        by smtp.gmail.com with ESMTPSA id q195sm16058791pgq.7.2018.11.11.23.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 23:59:24 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:59:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181112075920.GA497@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
 <20181108022138.GA2343@jagdpanzerIV>
 <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
 <20181108123049.GA30440@jagdpanzerIV>
 <20181109141012.accx62deekzq5gh5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109141012.accx62deekzq5gh5@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/09/18 15:10), Petr Mladek wrote:
> > 
> > If I'm not mistaken, this is for the futute "printk injection" work.
> 
> The above code only tries to push complete lines to the main log buffer
> and consoles ASAP. It sounds like a Good Idea(tm).

Probably it is. So *quite likely* I'm wrong here.

Hmm... Thinking out loud.
At the same time, splitting a single logbuf entry gives a chance to other
events to mix in. Example:
	pr_cont("Foo:");
	pr_cont("\nbar");
	pr_cont("\n");

Previously it could been stored in one logbuf entry (one logstore,
one console_trylock_spinning), which means that it could have been
printed in one go:

	call_console_drivers()
		spin_trylock_irqsave(&port->lock, flags);
		uart_console_write(.... "Foo:\nbar\n");
		spin_unlock_irqrestore(&port->lock, flags);

While with buffered printk, it will be store in two logbuf entries,
and printed in two goes:

	call_console_drivers()
		spin_trylock_irqsave(&port->lock, flags);
		uart_console_write(.... "Foo:\nbar\n");
		spin_unlock_irqrestore(&port->lock, flags);

	<< ... console driver IRQ, TX port->state->xmit chars ... >>>

	call_console_drivers()
		spin_trylock_irqsave(&port->lock, flags);
		uart_console_write(.... "Foo:\nbar\n");
		spin_unlock_irqrestore(&port->lock, flags);

So, *technically*, we now let more events to happens between printk-s.

But, let's look at some of pr_cont() usage examples.
E.g. dump() from arch/h8300/kernel/traps.c. The code in question looks
as follows:

	pr_info("\nKERNEL STACK:");
	tp = ((unsigned char *) fp) - 0x40;
	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
		if ((i % 0x10) == 0)
			pr_info("\n%08x: ", (int) (tp + i));
		pr_info("%08x ", (int) *sp++);
	}
	pr_info("\n");

dmesg

[   15.260099] 0000:    00000000  00000010  00000040  00000090
               0010:    00000100  00000190  00000240  00000310
               0020:    00000400  00000510  00000640  00000790
               0030:    00000900  00000a90  00000c40  00000e10

So we have the entire KERNEL STACK stored as a single line, in
a single logbuf entry.

cat /dev/kmsg

4,687,15260099,c;\x0a0000:    00000000  00000010  00000040  00000090  \x0a0010:    00000100  00000190  00000240  00000310  \x0a0020:    00000400  00000510  00000640  00000790  \x0a0030:    00000900  00000a90  00000c40  00000e10

Shall we consider this as a "reference" representation: data that
pr_cont(), ideally, would have stored as a single logbuf entry? And
then compare the "reference" representation and what buffered printk
does.

Buffered printk always stores this as several lines, IOW several
logbuf entries.

cat /dev/kmsg

4,690,15260152,-;0000:    00000000  00000010  00000040  00000090  
4,691,15260154,-;0010:    00000100  00000190  00000240  00000310  
4,692,15260157,-;0020:    00000400  00000510  00000640  00000790  
4,694,15260161,-;0030:    00000900  00000a90  00000c40  00000e10  

So if we will have concurrent printk()-s happening on other CPUs,
then the KERNEL STACK data block still can be a bit hard to read:

[   15.260152] 0000:    00000000  00000010  00000040  00000090  
<printk CPU1> ... foo bar foo bar
<printk CPU2> ... foo bar foo bar
...
[   15.260154] 0010:    00000100  00000190  00000240  00000310  
<printk CPU3> ... foo bar foo bar
<printk CPU2> ... foo bar foo bar
...
              ... and so on; you got the idea.

> No, please note that the for cycle searches for '\n' from the end
> of the string.

You are right, I didn't notice that. Indeed.


Tetsuo, lockdep report with buffered printks looks a bit different:

 kernel:  Possible unsafe locking scenario:
 kernel:        CPU0                    CPU1
 kernel:        ----                    ----
 kernel:   lock(bar_lock);
 kernel:                                lock(
 kernel: foo_lock);
 kernel:                                lock(bar_lock);
 kernel:   lock(foo_lock);
 kernel: 


> > 	len = vsprintf();
> > 	if (len && text[len - 1] == '\n' || overflow)
> > 		flush();
> 
> I had the same idea. Tetsuo ignored it. I looked for more arguments
> and found that '\n' is used in the middle of several pr_cont()
> calls

OK, so we probably can have that new semantics. But we might split
something that possibly was meant to be a single line with a bunch
of \n in the middle.

	-ss
