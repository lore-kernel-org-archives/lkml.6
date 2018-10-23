Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2EBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0F52075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpQ3hvz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F52075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJWPLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:11:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43658 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJWPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:11:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id q1-v6so187201pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VEL8NGCX26YMWuOF6kPKplHgOkj/akorRDar1Ylbxd4=;
        b=qpQ3hvz1LKiYe0C9891nqdTM4gtgsUpuQUH/8NNCRhazdYtPVxD9/NuML1WPsClgz3
         3Qill82dDJJOU5pXYkRVMWS+r7txo5mY1FmollvwKpHbMWXASbedZbkPEOdjRwO+n1Op
         HHjTXNIJZsBk1OQ3pXrjTLYliWZu2+sFpJyeM7JmkYbZANCCZs/0etKBLrq0M/htLpZg
         dBPdgbAPCGf1J3pBaGRiZ4Te7rdRoLSqY3HkbTMsdXlfgvR8pEjMeoRTmiBpyhQwQZf2
         84NrcMi8E2Ve2PkSnL/L0TwaqgBfmznJjB3Yh7dt77joBKUmJT+5YZrdy7NgUjdF8YiO
         CFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VEL8NGCX26YMWuOF6kPKplHgOkj/akorRDar1Ylbxd4=;
        b=V9TI1IGFuHTFKYcF4+zW64+rnrnIrGQpAY96YBFUULlaYBWWCpJrRgbKHqoSO4l90J
         yaXviKsDSk0/ihfVZ3VdUfyJYuvi64spuTZjww9KkM5AUEFj7kTfDN8+fS8zyh5FI1xm
         aM1jPI0H+9AkG+8uz4r329FQ16igD8neiLkDUvD5u8SuWdz6AslIn3zymLoSploXZvuS
         YDCG1wSRC2B8fKdMBTfjCS9MqPqdX6sZDhY5+AqZN270cEB1SAzMu0JNLsTp0wPx3Uwk
         gT94NJNr8jgfDrDIfNXAsymQ5Rl7d0Hs3MHQlUHrz95QmvH1MIqI3qZdXFvVbBFg3Tsw
         q1lA==
X-Gm-Message-State: ABuFfohbXLR5kjWX2NeFi/E/EEGZlRIEGbCQwvjm8Yqc2Gx9/MsS3miK
        5YHSkpVL0++XT+5xH+sAoik=
X-Google-Smtp-Source: ACcGV60ZabuJfjufdoVKmSkT435hsZdu6QbvSKm32OMfv2b9ZQrILL3TMnyyJYhYnAEB99mtesUlog==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr46521420pgf.140.1540277348694;
        Mon, 22 Oct 2018 23:49:08 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id i4-v6sm587580pgt.4.2018.10.22.23.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 23:49:07 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:49:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: NMI watchdog dump does not print on hard lockup
Message-ID: <20181023064904.GB504@jagdpanzerIV>
References: <20171012121658.187c5af6@gandalf.local.home>
 <20171013111444.GB2795@pathway.suse.cz>
 <20171013091857.4afe8a7a@gandalf.local.home>
 <CA+55aFxCnmd8+9qYs1pBG+N3ULQjMOV5S6yZCjA-w_pwc6kXyA@mail.gmail.com>
 <20171016111239.GK2795@pathway.suse.cz>
 <20171016131305.GE6316@tigerII.localdomain>
 <20171016101547.27b4aa11@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016101547.27b4aa11@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/17 10:15), Steven Rostedt wrote:
> On Mon, 16 Oct 2017 22:13:05 +0900
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > just "brainstorming" it... with some silly ideas.
> > 
> > pushing the data from NMI panic might look like we are replacing one
> > deadlock scenario with another deadlock scenario. some of the console
> > drivers are soooo complex internally. so I have been thinking about...
> > may be we can extend struct console and add ->write_on_panic() and that
> > handler must be as lockless as possible; so lockless that calling it
> > from anything that is not panic() is a severe bug.
> 
> This may not be a bad idea. And make it so it can't be called unless we
> are in panic mode (or at least "oops in progress").
> 
> If oops_in_progress is set, and the console has a "write_on_panic"
> handler, then just call that.

Good news Steven.

It turned out that some of serial consoles already have this
write_on_panic() mechanism enabled. Such consoles have the following
thing is their usual ->write() callbacks (which we call from printk()):

static void serial_console_write(struct console *co, const char *s,
                                 unsigned count)
{
...
        if (port->sysrq)
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&port->lock, flags);
        else
                spin_lock_irqsave(&port->lock, flags);
...

        uart_console_write(port, s, count, serial_console_putchar);
...
        if (locked)
                spin_unlock_irqrestore(&port->lock, flags);
}

Notice the special handling of port->sysrq and oops_in_progress cases.

So we, basically, already have "lockless on panic" serial consoles.
The problem is - it seems that panic() does not always let lockless
consoles to be lockless. I'm trying to address this in [1].

[1] lkml.kernel.org/r/20181016050428.17966-2-sergey.senozhatsky@gmail.com

	-ss
