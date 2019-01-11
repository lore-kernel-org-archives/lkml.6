Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FE52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QvrQ4pdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbfAKTDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:03:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42216 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbfAKTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:03:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so11515799lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bIKY9XJ4pG/qcANdIzVx0oJCX5ZR/IkDhtqeLlKlUTg=;
        b=QvrQ4pdMe9wS+KIGMg5SVqitQNyH74iDrZZqiql2UUCcxcacpWR72vUtv64jvLTbFL
         p8TFLNz1CBqF5lYwD+fmnNXD7F6vHT6ngz2epcA92vNBPZjNLekflTo6WtMg+QmUGMdY
         Rx1h24NSveLVYDTpo6WndCeOTXb/friQWXxWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bIKY9XJ4pG/qcANdIzVx0oJCX5ZR/IkDhtqeLlKlUTg=;
        b=oAMyY5HTBiotmW8jyTjaDtdDgHcEET3cCutKMVQVPnFaZZGLFCGcukyRVzE3rHiilH
         JVOP8Z+U4i+aHpl3TI/yckgtb+1EnYKSRlWrnLuZ1WM53XeAWor/0+va3vJsAb7nPrIK
         ze6lLGJQxmdehSPAUFhz+g1eZKrEqyjSxF7H087jfcsgQFyx374tlnRA3NAPKxLKNB7I
         5Ip5PL2KIy7FkSzREeo9D64xeqi4Iv3+ROQH065zXln0uHVwffeb96K9s9UGRWgQyuoI
         It9zlukCyZM0LcoLc1fVVceffTC5wSJpXFrz+rBIseMuH3+rZSKmGYZSBAnxEcLztOt7
         6uSw==
X-Gm-Message-State: AJcUukeQS76hzXP6JQGNpDRn6FywiyI9MNvq7OW97fHzG7TJ/wf3cVoW
        W2mU4TwOIGy5Us4H+vwL+uRQWDfOa4U=
X-Google-Smtp-Source: ALg8bN66IaozTKehJLxqCcDFRIgDg5XDOby6A1GAGnn5cUTZeJi7kHurE3X8J/g4x5op0v0AB9EaQQ==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr9231752lfg.117.1547233429211;
        Fri, 11 Jan 2019 11:03:49 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e14-v6sm16005474ljl.43.2019.01.11.11.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 11:03:47 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id s5-v6so13826041ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:03:46 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr8184989ljj.120.1547233426145;
 Fri, 11 Jan 2019 11:03:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
In-Reply-To: <20190111151525.tf7lhuycyyvjjxez@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 11:03:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
Message-ID: <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 7:15 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> >
> > Now, in the int3 handler can you take the faulting RIP and search for i=
t in
> > the =E2=80=9Cstatic-calls=E2=80=9D table, writing the RIP+5 (offset) in=
to R10 (return
> > address) and the target into R11. You make the int3 handler to divert t=
he
> > code execution by changing pt_regs->rip to point to a new function that=
 does:
> >
> >       push R10
> >       jmp __x86_indirect_thunk_r11
> >
> > And then you are done. No?
>
> IIUC, that sounds pretty much like what Steven proposed:
>
>   https://lkml.kernel.org/r/20181129122000.7fb4fb04@gandalf.local.home
>
> I liked the idea, BUT, how would it work for callee-saved PV ops?  In
> that case there's only one clobbered register to work with (rax).

Actually, there's a much simpler model now that I think about it.

The BP fixup just fixes up %rip to to point to "bp_int3_handler".

And that's just a random text address set up by "text_poke_bp()".

So how about the static call rewriting simply do this:

 - for each static call:

 1)   create a fixup code stub that does

        push $returnaddressforTHIScall
        jmp targetforTHIScall

 2) do

        on_each_cpu(do_sync_core, NULL, 1);

     to make sure all CPU's see this generated code

  3) do

        text_poke_bp(addr, newcode, newlen, generatedcode);

Ta-daa! Done.

In fact, it turns out that even the extra "do_sync_core()" in #2 is
unnecessary, because taking the BP will be serializing on the CPU that
takes it, so we can skip it.

End result: the text_poke_bp() function will do the two do_sync_core
IPI's that guarantee that by the time it returns, no other CPU is
using the generated code any more, so it can be re-used for the next
static call fixup.

Notice? No odd emulation, no need to adjust the stack in the BP
handler, just the regular "return to a different IP".

Now, there is a nasty special case with that stub, though.

So nasty thing with the whole "generate a stub for each call" case:
because it's dynamic and because of the re-use of the stub, you could
be in the situation where:

  CPU1                  CPU2
  ----                  ----

  generate a stub
  on_each_cpu(do_sync_core..)
  text_poke_bp()
  ...

  rewrite to BP
                        trigger the BP
                        return to the stub
                        fun the first instruction of the stub
                        *INTERRUPT causes rescheduling*

  on_each_cpu(do_sync_core..)
  rewrite to good instruction
  on_each_cpu(do_sync_core..)

  free or re-generate the stub

                        !! The stub is still in use !!

So that simple "just generate the stub dynamically" isn't so simple after a=
ll.

But it turns out that that is really simple to handle too. How do we do tha=
t?

We do that by giving the BP handler *two* code sequences, and we make
the BP handler pick one depending on whether it is returning to a
"interrupts disabled" or "interrupts enabled" case.

So the BP handler does this:

 - if we're returning with interrupts disabled, pick the simple stub

 - if we're returning with interrupts enabled, clkear IF in the return
%rflags, and pick a *slightly* more complex stub:

        push $returnaddressforTHIScall
        sti
        jmp targetforTHIScall

and now the STI shadow will mean that this sequence is uninterruptible.

So we'd not do complex emulation of the call instruction at BP time,
but we'd do that *trivial* change at BP time.

This seems simple, doesn't need any temporary registers at all, and
doesn't need any extra stack magic. It literally needs just a trivial
sequence in poke_int3_handler().

The we'd change the end of poke_int3_handler() to do something like
this instead:

        void *newip =3D bp_int3_handler;
        ..
        if (new =3D=3D magic_static_call_bp_int3_handler) {
                if (regs->flags &X86_FLAGS_IF) {
                        newip =3D magic_static_call_bp_int3_handler_sti;
                        regs->flags &=3D ~X86_FLAGS_IF;
        }
        regs->ip =3D (unsigned long) newip;
        return 1;

AAND now we're *really* done.

Does anybody see any issues in this?

              Linus
