Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5473120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547496705;
	bh=G03UudH1DcO/zzPLksk+Zk8zxvkgTiarzD5/rpe6j98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u9kiLwMGhlp2aaJrX56oYhwMcOKJEXbmWw7+KrwtZZGMTemIcfFku5cjGfsDZF1iO
	 EtIkEj8CbfoEXYbmQfe+VrH2R4PV2/vcNxAUgW4P02z2PPeKQvMAQty1tjFLPdsibW
	 KS7CfMK9wE2bMZc8mOIw/Nk3xnBSlLqA1GC0pqLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfANULn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:11:43 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3104206B7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547496701;
        bh=G03UudH1DcO/zzPLksk+Zk8zxvkgTiarzD5/rpe6j98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eMWfJXfGqTbQJu97CONbZQ4IiWoNeDfFaIM7zQM2uZNLVMfiKTGx+LEE+XlUQmjGC
         SJe/Rz6S3u4BEPAuhajeGBPxoy040Fjr53VPI9aDsohTyyJGefk2qY/zIPw226cpqZ
         bgsXTO/hbpCLRkNL2Z0rqqR2P7LH91RIjnWR1Kbo=
Received: by mail-wr1-f54.google.com with SMTP id v13so367513wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:11:41 -0800 (PST)
X-Gm-Message-State: AJcUukfN7itvop+K+7HjZb+oSkX5x7w9wbZlUFmU2jUwqnQbHOTxSWrU
        MuikOXttE620aP/p/tIfMXavXj0N4ywEmo6rTkzZJQ==
X-Google-Smtp-Source: ALg8bN61ZtgTZ0mo0ECwr4X8Jx2V0Gj4P/bzY8k/Php7iSFwQkmHnDjAgS0f6VNpWnbc8OXyZPvRsk86axBARd4cxuY=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr125375wri.199.1547496700119;
 Mon, 14 Jan 2019 12:11:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com> <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com> <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
In-Reply-To: <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Jan 2019 12:11:27 -0800
X-Gmail-Original-Message-ID: <CALCETrW5cmTbmiRbkj5JNq-zYvVj+L+osEz18qggWGQ3GHWSaQ@mail.gmail.com>
Message-ID: <CALCETrW5cmTbmiRbkj5JNq-zYvVj+L+osEz18qggWGQ3GHWSaQ@mail.gmail.com>
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

On Sun, Jan 13, 2019 at 6:41 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 1/13/19 6:31 PM, H. Peter Anvin wrote:
> >
> > static cpumask_t text_poke_cpumask;
> >
> > static void text_poke_sync(void)
> > {
> >       smp_wmb();
> >       text_poke_cpumask = cpu_online_mask;
> >       smp_wmb();      /* Should be optional on x86 */
> >       cpumask_clear_cpu(&text_poke_cpumask, smp_processor_id());
> >       on_each_cpu_mask(&text_poke_cpumask, text_poke_sync_cpu, NULL, false);
> >       while (!cpumask_empty(&text_poke_cpumask)) {
> >               cpu_relax();
> >               smp_rmb();
> >       }
> > }
> >
> > static void text_poke_sync_cpu(void *dummy)
> > {
> >       (void)dummy;
> >
> >       smp_rmb();
> >       cpumask_clear_cpu(&poke_bitmask, smp_processor_id());
> >       /*
> >        * We are guaranteed to return with an IRET, either from the
> >        * IPI or the #BP handler; this provides serialization.
> >        */
> > }
> >
>
> The invariants here are:
>
> 1. The patching routine must set each bit in the cpumask after each event
>    that requires synchronization is complete.
> 2. The bit can be (atomically) cleared on the target CPU only, and only in a
>    place that guarantees a synchronizing event (e.g. IRET) before it may
>    reaching the poked instruction.
> 3. At a minimum the IPI handler and #BP handler needs to clear the bit. It
>    *is* also possible to clear it in other places, e.g. the NMI handler, if
>    necessary as long as condition 2 is satisfied.
>

I don't even think this is sufficient.  I think we also need everyone
who clears the bit to check if all bits are clear and, if so, remove
the breakpoint.  Otherwise we have a situation where, if you are in
text_poke_bp() and you take an NMI (or interrupt or MCE or whatever)
and that interrupt then hits the breakpoint, then you deadlock because
no one removes the breakpoint.

If we do this, and if we can guarantee that all CPUs make forward
progress, then maybe the problem is solved. Can we guarantee something
like all NMI handlers that might wait in a spinlock or for any other
reason will periodically check if a sync is needed while they're
spinning?

--Andy
