Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D2B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547521520;
	bh=ntsRCJJSsqDcFItqrFELvZQxlnXnRfx9nI02zcHtLGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M0dqnJq54dS3U1L/6G1rkOnG+zVulx1q6Q17ACLZLz0AwpcSAQrdOn6Q6fNgNpUpk
	 yvVOhxvjE/0rRSVWQvJYeBVDWXD32BC3x/Qhkoa8Lpa5DulVpp7y7MByVbnUdM+zC5
	 wRe9k09wLBqkvMAQ9WzNQZB0GtxbHuvQMqFZMy7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfAODFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAODFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:05:16 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7285820859
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 03:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547521514;
        bh=ntsRCJJSsqDcFItqrFELvZQxlnXnRfx9nI02zcHtLGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=acOLb3l8KwiyB9zkBRKcVUUPabcsYVPr7d9gkabzyDjZcqSbPdA6WSoZ5ux0kqxWU
         euZPbWX4hIJ4A/3gn++DnsyLSNCM9Jw4VgNXc1pgx1B4C8TULm/VuenLLPAVC34Zy4
         ReKyX96mYdbDCFshSG0ultTscbURAsKFcFWI7LBA=
Received: by mail-wr1-f45.google.com with SMTP id r10so1236246wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:05:14 -0800 (PST)
X-Gm-Message-State: AJcUukcFV6K6869GR4B2HRwKQsKl7YUccaKCKcVT3B475f5Ryni/5NtS
        55taDsrNWj/D4XrkGOHRugj09auUdSg/yJ5F/PzsmQ==
X-Google-Smtp-Source: ALg8bN6mvpj/9DlVaUOnE8JrNpLy2jfsOi3AaXAA5BP5zneCNO+XtXlePOzZDkopa4icAhSK9T6QL9fux6v5BhOWay4=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr1026166wrm.309.1547521512886;
 Mon, 14 Jan 2019 19:05:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com> <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com> <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
 <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com> <8ca16cca-101d-1d1b-b3da-c9727665fec8@zytor.com>
In-Reply-To: <8ca16cca-101d-1d1b-b3da-c9727665fec8@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Jan 2019 19:05:01 -0800
X-Gmail-Original-Message-ID: <CALCETrVGoVbToA7Dw_mo_gojvFnS=vB=UJxQgDi_R00skSX8pg@mail.gmail.com>
Message-ID: <CALCETrVGoVbToA7Dw_mo_gojvFnS=vB=UJxQgDi_R00skSX8pg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 2:55 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> I think this sequence ought to work (keep in mind we are already under a
> mutex, so the global data is safe even if we are preempted):

I'm trying to wrap my head around this.  The states are:

0: normal operation
1: writing 0xcc, can be canceled
2: writing final instruction.  The 0xcc was definitely synced to all CPUs.
3: patch is definitely installed but maybe not sync_cored.

>
>         set up page table entries
>         invlpg
>         set up bp patching global data
>
>         cpu = get_cpu()
>
So we're assuming that the state is

>         bp_old_value = atomic_read(bp_write_addr)
>
>         do {

So we're assuming that the state is 0 here.  A WARN_ON_ONCE to check
that would be nice.

>                 atomic_write(&bp_poke_state, 1)
>
>                 atomic_write(bp_write_addr, 0xcc)
>
>                 mask <- online_cpu_mask - self
>                 send IPIs
>                 wait for mask = 0
>
>         } while (cmpxchg(&bp_poke_state, 1, 2) != 1);
>
>         patch sites, remove breakpoints after patching each one

Not sure what you mean by patch *sites*.  As written, this only
supports one patch site at a time, since there's only one
bp_write_addr, and fixing that may be complicated.  Not fixing it
might also be a scalability problem.

>
>         atomic_write(&bp_poke_state, 3);
>
>         mask <- online_cpu_mask - self
>         send IPIs
>         wait for mask = 0
>
>         atomic_write(&bp_poke_state, 0);
>
>         tear down patching global data
>         tear down page table entries
>
>
>
> The #BP handler would then look like:
>
>         state = cmpxchg(&bp_poke_state, 1, 4);
>         switch (state) {
>                 case 1:
>                 case 4:

What is state 4?

>                         invlpg
>                         cmpxchg(bp_write_addr, 0xcc, bp_old_value)
>                         break;
>                 case 2:
>                         invlpg
>                         complete patch sequence
>                         remove breakpoint
>                         break;

ISTM you might as well change state to 3 here, but it's arguably unnecessary.

>                 case 3:
>                         /* If we are here, the #BP will go away on its own */
>                         break;
>                 case 0:
>                         /* No patching in progress!!! */
>                         return 0;
>         }
>
>         clear bit in mask
>         return 1;
>
> The IPI handler:
>
>         clear bit in mask
>         sync_core       /* Needed if multiple IPI events are chained */

I really like that this doesn't require fixups -- text_poke_bp() just
works.  But I'm nervous about livelocks or maybe just extreme slowness
under nasty loads.  Suppose some perf NMI code does a static call or
uses a static call.  Now there's a situation where, under high
frequency perf sampling, the patch process might almost always hit the
breakpoint while in state 1.  It'll get reversed and done again, and
we get stuck.  It would be neat if we could get the same "no
deadlocks" property while significantly reducing the chance of a
rollback.

This is why I proposed something where we try to guarantee forward
progress by making sure that any NMI code that might spin and wait for
other CPUs is guaranteed to eventually sync_core(), clear its bit, and
possibly finish a patch.  But this is a bit gross.
