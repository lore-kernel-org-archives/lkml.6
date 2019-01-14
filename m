Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE4B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547508493;
	bh=DEq14WzBxstnUexN+m7W9/GWkheN71REW6EU5LEtzEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jhsJ6OqwTugd9hXX9RQOeIzR3EQh2ztLEkjo4HC30K7rlCMfPxqODeebdNYCdjWZx
	 1Nmh0jVE9uai+pxcElAiN910LMvPTRLm+CmY+I5IzQkA3rvYuYocV0wQ/zd5J7gntV
	 ryPlpoXH/ySYOCkISF4P6yIDYlBcyUmuVhLbeqgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfANX2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbfANX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:28:11 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07400214DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547508490;
        bh=DEq14WzBxstnUexN+m7W9/GWkheN71REW6EU5LEtzEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FINHLqoL3wbXfboOSrPDwRBvpOFRUVdRBVqAAXg/n0EKlvheFGuXPm70LpGcNKFqe
         mrzupNs8DIainHQYdaPHPIN+/hS02XRv5wZoD7mm43g51O/zQfvsKz2b8AY/Eva/yW
         AEkzq1IKed+mmjJkTaFgkVXBTbZaU6VHwCxUT4ho=
Received: by mail-wr1-f47.google.com with SMTP id u4so917143wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:28:09 -0800 (PST)
X-Gm-Message-State: AJcUukeOHl11vzEHLRG1K5chK6X2JcnF4tv3Bs5OMvoWFberkX04Oefq
        bU0d3zxSuIDWqjZrlV7amRHbYVnB8WXdiSxL4b9Jbw==
X-Google-Smtp-Source: ALg8bN7eVkVXesoHGGkhEgQcZ9WUEw8fPUFhWdQsKyWmSBe9obXbPKSj4n5FlKwu4iFpRNZNNn0Bw3eLTyM6IPc1GFM=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr599212wro.77.1547508488275;
 Mon, 14 Jan 2019 15:28:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com> <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com> <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
 <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
In-Reply-To: <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Jan 2019 15:27:55 -0800
X-Gmail-Original-Message-ID: <CALCETrWE-GYr=bUF-RsSNNW5A-=jd2Oy_4yPisKTUiPZTAHm6A@mail.gmail.com>
Message-ID: <CALCETrWE-GYr=bUF-RsSNNW5A-=jd2Oy_4yPisKTUiPZTAHm6A@mail.gmail.com>
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

On Mon, Jan 14, 2019 at 2:01 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> So I was already in the middle of composing this message when Andy posted:
>
> > I don't even think this is sufficient.  I think we also need everyone
> > who clears the bit to check if all bits are clear and, if so, remove
> > the breakpoint.  Otherwise we have a situation where, if you are in
> > text_poke_bp() and you take an NMI (or interrupt or MCE or whatever)
> > and that interrupt then hits the breakpoint, then you deadlock because
> > no one removes the breakpoint.
> >
> > If we do this, and if we can guarantee that all CPUs make forward
> > progress, then maybe the problem is solved. Can we guarantee something
> > like all NMI handlers that might wait in a spinlock or for any other
> > reason will periodically check if a sync is needed while they're
> > spinning?
>
> So the really, really nasty case is when an asynchronous event on the
> *patching* processor gets stuck spinning on a resource which is
> unavailable due to another processor spinning on the #BP. We can disable
> interrupts, but we can't stop NMIs from coming in (although we could
> test in the NMI handler if we are in that condition and return
> immediately; I'm not sure we want to do that, and we still have to deal
> with #MC and what not.)
>
> The fundamental problem here is that we don't see the #BP on the
> patching processor, in which case we could simply complete the patching
> from the #BP handler on that processor.
>
> On 1/13/19 6:40 PM, H. Peter Anvin wrote:
> > On 1/13/19 6:31 PM, H. Peter Anvin wrote:
> >>
> >> static cpumask_t text_poke_cpumask;
> >>
> >> static void text_poke_sync(void)
> >> {
> >>      smp_wmb();
> >>      text_poke_cpumask = cpu_online_mask;
> >>      smp_wmb();      /* Should be optional on x86 */
> >>      cpumask_clear_cpu(&text_poke_cpumask, smp_processor_id());
> >>      on_each_cpu_mask(&text_poke_cpumask, text_poke_sync_cpu, NULL, false);
> >>      while (!cpumask_empty(&text_poke_cpumask)) {
> >>              cpu_relax();
> >>              smp_rmb();
> >>      }
> >> }
> >>
> >> static void text_poke_sync_cpu(void *dummy)
> >> {
> >>      (void)dummy;
> >>
> >>      smp_rmb();
> >>      cpumask_clear_cpu(&poke_bitmask, smp_processor_id());
> >>      /*
> >>       * We are guaranteed to return with an IRET, either from the
> >>       * IPI or the #BP handler; this provides serialization.
> >>       */
> >> }
> >>
> >
> > The invariants here are:
> >
> > 1. The patching routine must set each bit in the cpumask after each event
> >    that requires synchronization is complete.
> > 2. The bit can be (atomically) cleared on the target CPU only, and only in a
> >    place that guarantees a synchronizing event (e.g. IRET) before it may
> >    reaching the poked instruction.
> > 3. At a minimum the IPI handler and #BP handler needs to clear the bit. It
> >    *is* also possible to clear it in other places, e.g. the NMI handler, if
> >    necessary as long as condition 2 is satisfied.
> >
>
> OK, so with interrupts enabled *on the processor doing the patching* we
> still have a problem if it takes an interrupt which in turn takes a #BP.
>  Disabling interrupts would not help, because but an NMI and #MC could
> still cause problems unless we can guarantee that no path which may be
> invoked by NMI/#MC can do text_poke, which seems to be a very aggressive
> assumption.
>
> Note: I am assuming preemption is disabled.
>
> The easiest/sanest way to deal with this might be to switch the IDT (or
> provide a hook in the generic exception entry code) on the patching
> processor, such that if an asynchronous event comes in, we either roll
> forward or revert. This is doable because the second sync we currently
> do is not actually necessary per the hardware guys.

This is IMO insanely complicated.  I much prefer the kind of
complexity that is more or less deterministic and easy to test to the
kind of complexity (like this) that only happens in corner cases.

I see two solutions here:

1. Just suck it up and emulate the CALL.  And find a way to write a
test case so we know it works.

2. Find a non-deadlocky way to make the breakpoint handler wait for
the breakpoint to get removed, without any mucking at all with the
entry code.  And find a way to write a test case so we know it works.
(E.g. stick an actual static_call call site *in text_poke_bp()* that
fires once on boot so that the really awful recursive case gets
exercised all the time.

But if we're going to do any mucking with the entry code, let's just
do the simple mucking to make emulating CALL work.

--Andy
