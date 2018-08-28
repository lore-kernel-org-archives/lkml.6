Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1B20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEedLcOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D1B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeH1OaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:30:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45711 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeH1OaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:30:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so1904791oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cn4s7kS6/J9j3wJ4Av4ReO0Zm+XNdNZmMNfDq8aENl8=;
        b=DEedLcOS1TNm9LbGP9QNwwGI2R5VROsW10wdRcWNsg+0taKmoLivDNe6IwpQP/+qV7
         OOd0qQKvXoJODGhs9hKeN8Ud/Cm6b5rcHBZRuyzZyv+YmHxdDb7JiCixd3PRoS+C5uN2
         vvoVmuNfzrsY1zM9ivF6pecBw6yBfjtG5RY9YQmMXS6gCIswQnZqCpmuTVY5Bb9md5xA
         eYJ4zj+wzBweUq/2pY1iaGmfoJGMuDV2s1dAaH5/WDK3yD8JS5vm0Ber7mFnKsQsnRWZ
         QU2K10QVhDG4jegCqtWUjT1SkJtj/4rReTxqn3k7KbdLEIUmLXQXtArGfe4GaeePIeWu
         oP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cn4s7kS6/J9j3wJ4Av4ReO0Zm+XNdNZmMNfDq8aENl8=;
        b=Tlivt2iRH2j0nzXyOhhETX8SUfVnpAOIpR8qQqA/JZrgc0Uts1tyJ3zq4khfA6CZZN
         0vXxYhaARli2Kvrs7F9/zlnKGvH82aUSqNb5/ar8wLUgRMQpnvvT18XT4DeKLsWpwMus
         cWGM8damjIhyRjZQ49oU4ce3TviUmMZK/tyJqxG6bdhEcFvuq+V0brvlFFvi0X4bXePK
         riCAFjNiwoRJQrS40uUGUqxeWzlSmTSJOmHyVhAjw4F1oJKlvQCqoYF5qJrBy2ukP3ZN
         F0A8TtElCTQwfNsUF3PuOhAXSMlip892zT8tspaCfkqIb8Qy6wSR0U/SIQ4HRUAXtz2R
         7YEQ==
X-Gm-Message-State: APzg51Dsa0L33TrulCANWIcn5nZqmdRJ0IpJyIPhdoNvRNm/GLtW+C+E
        hiesSzrtk6ogH/P4K7vvB6eyAL2qGtxYNk/MfhNEbg==
X-Google-Smtp-Source: ANB0VdaWoHy/4UBrMr26a3xcTXYevsHCW9VhnvV5sCFIDXY+QwHh9/eKJqvytQ8YqGRQvd6vao2eULJ93RvdCeAcXxk=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr813579oie.68.1535452759712;
 Tue, 28 Aug 2018 03:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180824235826.62741-1-jannh@google.com> <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com>
In-Reply-To: <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 12:38:53 +0200
Message-ID: <CAG48ez1zYqx8-1We3JkDBmYREksUMoUe7VBeAOv2JH98gVWcKw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in rewind_stack_do_exit()
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:04 AM Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
> On 08/25/2018 02:58 AM, Jann Horn wrote:
> > Reset the KASAN shadow state of the task stack when rewinding RSP.
> > Without this, a kernel oops will leave parts of the stack poisoned, and
> > code running under do_exit() can trip over such poisoned regions and cause
> > nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.
> >
> > This patch is 64-bit only because KASAN doesn't exist on 32-bit.
> >
> > This patch does not wipe exception stacks; if you oops on an exception
> > stack, you might get random KASAN false-positives from other tasks
> > afterwards. This is probably relatively uninteresting, since if you're
> > oopsing on an exception stack, you likely have bigger things to worry
> > about. It'd be more interesting if vmapped stacks and KASAN were
> > compatible, since then handle_stack_overflow() would oops from exception
> > stack context.
> >
> > Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I have manually tested that an oops that previously triggered this bug
> > doesn't trigger it anymore.
> >
> > It would be possible to rewrite this assembly to use fewer instructions
> > in non-KASAN builds, but I think it's clearer this way.
> >
> > If anyone thinks that this thing should also be wiping exception stacks:
> > I did write some (entirely untested) code that should take care of that
> > (before realizing that it's rather unlikely to occur in practice because
> > vmapped stacks and KASAN are mutually exclusive), but I'm not sure
> > whether it's worth complicating this code for that.
> > In case anyone's curious how that would look:
> > https://gist.github.com/thejh/c91f9b4e3cc4c58659bb3cd056c4fa40
> >
> >  arch/x86/entry/entry_64.S | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 957dfb693ecc..92d3ad5bd365 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1673,9 +1673,25 @@ ENTRY(rewind_stack_do_exit)
> >       /* Prevent any naive code from trying to unwind to our caller. */
> >       xorl    %ebp, %ebp
> >
> > +     movq    %rdi, %r14
> > +
> >       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rax
> > -     leaq    -PTREGS_SIZE(%rax), %rsp
> > +     leaq    -PTREGS_SIZE(%rax), %r15
> > +
> > +#ifdef CONFIG_KASAN
> > +     /*
> > +      * Remove stack poisons left behind by our old stack.
> > +      * Do this before updating RSP to avoid problems in case we get some
> > +      * interrupt that is not handled on an exception stack before we're done
> > +      * with the unpoisoning.
> > +      */
> > +     movq    %r15, %rdi
> > +     call    kasan_unpoison_task_stack_below
> > +#endif
>
>
> Why this has to be done in the rewind_stack_do_exit()?
> Are there any problems with calling the kasan_unpoison_task_stack(current) from oops_end(), before the rewind_stack_do_exit()?

Ooh, good point! I didn't see that KASAN instrumentation is disabled
for dumpstack.c. So I guess I'll send a new patch that does it from
oops_end().

> > +
> > +     movq    %r15, %rsp
> >       UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
> >
> > +     movq    %r14, %rdi
> >       call    do_exit
> >  END(rewind_stack_do_exit)
> >
