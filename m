Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02D20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Se9ZWs84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeKFF1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:27:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51097 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeKFF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:27:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so4705126wmw.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4R/Wwwjs8rY8MEqGZo56oET3PhbZnLa492nRzAUtCjc=;
        b=Se9ZWs84hanYqydF/uOCEcUbclxGLdqBp3sQeVBeDyQqq7dhOKOUoW8SNZCMt1By5o
         gCDfNpyqjf8Q+DWxBHDw0znQITfo5Ffz1r02Xe5+N3XkoqNlrgsoeBWvyowiBhT+PiUU
         xCBXUhYNgMzwj/86QlWnyg+PD91LBIfBi+awtD/+AlVppHJAuOzdE5HghYYSKsVgkrep
         M6N09Mimb/9exa6tjBx3BpofUvT1PDuD6OUCxv3drAIpASeHg7V8L0f0p8pu30xxIBeX
         3qb0MP2ZPIa32565zskU3KqnOPhYzKQ5G6nsbhRc8kR3Kwj2CLL/Gj0uIiVlHZ5r+D0a
         PGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4R/Wwwjs8rY8MEqGZo56oET3PhbZnLa492nRzAUtCjc=;
        b=JJMz/8iLpWDrQf732PgCKvgqEfEOoliPR/2jtp0tAO7NHQ/INT8+/NxMZJPdVHa81X
         Kl4mOfXEMzOvYS7yJ/ZVT4tPpgz9OJY1gYLKzGecTvS/qz6W+zZRrNiKrAqKXHvTeGEw
         WDL0RhYfh8tms1Loq/CIiWZjWTBFscG1ZfPJSX9rXgKBGHfZAzjnFUWWKxi+3jhyQOVT
         /eV23UNEFF3tVvLNj//e00CtAGXe/s3UDmpKzelCQmQufvowRcSFqrQegchX6mgoImI2
         ay4kyW0AGdRbciM62v4mFgH2MsW/uYbnDx+lwK6Cw4RkASd62N4jrd/fU9aGCxyiEIT3
         A3Ow==
X-Gm-Message-State: AGRZ1gKcNhp6FHbSYlIjS81NB1v2pjPz4blU4Obx7ICberudb7gXgOS2
        qDuIgr4IaFsyV+gKqQEuNK0q5dhCVoQyawYulzMtwdr/
X-Google-Smtp-Source: AJdET5f+JFp8gUNqV/+FMqfyA9Z0P4+QPT2kwMAlPhepPkJl+RrPw7MoLfvQf53eBqw6tC3EiA+RPgDAtexnB6MrHf8=
X-Received: by 2002:a1c:954b:: with SMTP id x72-v6mr1342790wmd.14.1541448369296;
 Mon, 05 Nov 2018 12:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net> <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
 <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com> <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net>
 <8DF7BED8-F1B2-4102-9452-46437D3E4FC6@vmware.com>
In-Reply-To: <8DF7BED8-F1B2-4102-9452-46437D3E4FC6@vmware.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 5 Nov 2018 12:05:57 -0800
Message-ID: <CALCETrXwci8L=53UTq8=LEs+5yPgdHnidFf6iz3wZ0SkZwd1Eg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during early_init
To:     Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 11:25 AM Nadav Amit <namit@vmware.com> wrote:
>
> From: Andy Lutomirski
> Sent: November 5, 2018 at 7:03:49 PM GMT
> > To: Nadav Amit <namit@vmware.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.co=
m>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, H. Peter =
Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petko=
v <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirsk=
i <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.h=
ansen@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
> > Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() durin=
g early_init
> >
> >
> >
> >
> >> On Nov 5, 2018, at 9:49 AM, Nadav Amit <namit@vmware.com> wrote:
> >>
> >> From: Andy Lutomirski
> >> Sent: November 5, 2018 at 5:22:32 PM GMT
> >>> To: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, li=
nux-kernel@vger.kernel.org, x86@kernel.org, H. Peter Anvin <hpa@zytor.com>,=
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave=
 Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, K=
ees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Masa=
mi Hiramatsu <mhiramat@kernel.org>
> >>> Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() dur=
ing early_init
> >>>
> >>>
> >>>
> >>>>> On Nov 5, 2018, at 6:09 AM, Peter Zijlstra <peterz@infradead.org> w=
rote:
> >>>>>
> >>>>> On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
> >>>>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_la=
bel.c
> >>>>> index aac0c1f7e354..367c1d0c20a3 100644
> >>>>> --- a/arch/x86/kernel/jump_label.c
> >>>>> +++ b/arch/x86/kernel/jump_label.c
> >>>>> @@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct =
jump_entry *entry,
> >>>>> jmp.offset =3D jump_entry_target(entry) -
> >>>>>          (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> >>>>>
> >>>>> -    if (early_boot_irqs_disabled)
> >>>>> +    /*
> >>>>> +     * As long as we are in early boot, we can use text_poke_early=
(), which
> >>>>> +     * is more efficient: the memory was still not marked as read-=
only (it
> >>>>> +     * is only marked after poking_init()). This also prevents us =
from using
> >>>>> +     * text_poke() before poking_init() is called.
> >>>>> +     */
> >>>>> +    if (!early_boot_done)
> >>>>>     poker =3D text_poke_early;
> >>>>>
> >>>>> if (type =3D=3D JUMP_LABEL_JMP) {
> >>>>
> >>>> It took me a while to untangle init/maze^H^Hin.c... but I think this
> >>>> is all we need:
> >>>>
> >>>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_lab=
el.c
> >>>> index aac0c1f7e354..ed5fe274a7d8 100644
> >>>> --- a/arch/x86/kernel/jump_label.c
> >>>> +++ b/arch/x86/kernel/jump_label.c
> >>>> @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct j=
ump_entry *entry,
> >>>> jmp.offset =3D jump_entry_target(entry) -
> >>>>          (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> >>>>
> >>>> -    if (early_boot_irqs_disabled)
> >>>> +    /*
> >>>> +     * As long as we're UP and not yet marked RO, we can use
> >>>> +     * text_poke_early; SYSTEM_BOOTING guarantees both, as we switc=
h to
> >>>> +     * SYSTEM_SCHEDULING before going either.
> >>>> +     */
> >>>> +    if (system_state =3D=3D SYSTEM_BOOTING)
> >>>>     poker =3D text_poke_early;
> >>>>
> >>>> if (type =3D=3D JUMP_LABEL_JMP) {
> >>>
> >>> Can we move this logic into text_poke() and get rid of text_poke_earl=
y()?
> >>
> >> This will negatively affect poking of modules doing module loading, e.=
g.,
> >> apply_paravirt(). This can be resolved by keeping track when the modul=
e is
> >> write-protected and giving a module parameter to text_poke(). Does it =
worth
> >> the complexity?
> >
> > Probably not.
> >
> > OTOH, why does alternative patching need text_poke() at all? Can=E2=80=
=99t it just
> > write to the text?
>
> Good question. According to my understanding, these games of
> text_poke_early() are not needed, at least for modules (on Intel).
>
> Intel SDM 11.6 "SELF-MODIFYING CODE=E2=80=9D says:
>
> "A write to a memory location in a code segment that is currently cached =
in
> the processor causes the associated cache line (or lines) to be invalidat=
ed.
> This check is based on the physical address of the instruction.=E2=80=9D
>
> Then the manual talks about prefetched instructions, but the modules code=
 is
> presumably not be =E2=80=9Cprefetchable=E2=80=9D at this point. So I thin=
k it should be
> safe, but I guess that you reviewed Intel/AMD manuals better when you wro=
te
> sync_core().

Beats the heck out of me.

Linus, hpa, or Dave, a question for you: suppose I map some page
writably, write to it, then upgrade permissions to allow execute.
Must I force all CPUs that might execute from it without first
serializing to serialize?  I suspect this doesn't really affect user
code, but it may affect the module loader.

To be safe, shouldn't the module loader broadcast an IPI to
sync_core() everywhere after loading a module and before making it
runnable, regardless of alternative patching?

IOW, the right sequence of events probably ought to me:

1. Allocate the memory and map it.
2. Copy in the text.
3. Patch alternatives, etc.  This is logically just like (2) from an
architectural perspective -- we're just writing to memory that won't
be executed.
4. Serialize everything.
5. Run it!

>
> Anyhow, there should be a function that wraps the memcpy() to keep track
> when someone changes the text (for potential future use).
>
> Does it make sense? Do you want me to give it a spin?

Sure, I guess.  Linus, what do you think?

>
> Thanks,
> Nadav



--=20
Andy Lutomirski
AMA Capital Management, LLC
