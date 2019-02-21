Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC301C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860B3207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YofCyqny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfBUWIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:08:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34662 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBUWIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:08:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so163966lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wFanjEpOf9wRJE/2TXoK6Nd5+iJk15E6QWBJw3RQRU=;
        b=YofCyqnyqCvzjrckbWI7xD8xUmCj7TZt4GsSTSNeSg0nUfbYeXjn+h+PhzPsJZV2mq
         OvvggXO0wPkTaWdmzlqP+59NSsvMir0i9WOZQ7PsXq2CUg7ebP5NFmPux8RN55+nWKfh
         8oHEOCzEnxHx80nVEf6yUgeuL6gfxWfgoFV7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wFanjEpOf9wRJE/2TXoK6Nd5+iJk15E6QWBJw3RQRU=;
        b=T7TqhAATY7U3tieq0/VN0OOzorFrp5ZoCckdfyJ8RZQ+Lw9AEMc4mQxCqFM0oSBkGP
         +Drc1JKGG00/Jlt7rFT40+Kz1K/cdu0c1qAxKtK5JtaAnhLOLvqoW/h9fhtBBQKcTO/9
         XGiaxoeOxj37rXr5j6NGMYwjRANB1lWu+EkTinYE6LXdFBIru+o5mspOnl2USXdTaVpq
         Q04kaQZPbvszkNuVrbtXQqmcVpLNkbvO1t/TB0k4d0+YwLF+oC2xzNbKMUNaIlTliA7y
         en+LjoFNbuZffhkVjwnJIVvEHxnElBWr1Y5ivwF4WbQ7FQHB7KU7OSuVNAOqmpRDe8w1
         R3dw==
X-Gm-Message-State: AHQUAubmoiI1mSVcrsIQYgcVoCy/ecRNnLCTFnamYqJdJPlM97+uKwk8
        LmWM3IRox3jSfsGlKhFwj4pzcE6oRNI=
X-Google-Smtp-Source: AHgI3IY+uDfeZNvwIXHUQ6HO/2KDYjnFGlRj1exzt5h6I3D7a45BPkp/T8kOWP7bcpIO9ggHWDGsFg==
X-Received: by 2002:a2e:9dda:: with SMTP id x26mr386298ljj.53.1550786911188;
        Thu, 21 Feb 2019 14:08:31 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id p22sm9041ljb.93.2019.02.21.14.08.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:08:28 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id p1so114074lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:08:28 -0800 (PST)
X-Received: by 2002:a19:24d5:: with SMTP id k204mr405084lfk.88.1550786907565;
 Thu, 21 Feb 2019 14:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net> <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Feb 2019 14:08:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
Message-ID: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> IMNSHO any call inside a AC region is a bug lurking round the corner. The
> only thing which is tolerable is an exception of some sort.
>
> Enforce that with objtool. End of story.

Not quite that simple.

There are some use cases where you really do want a call - albeit to
special functions - inside the AC region.

The prime example of this is likely "filldir()" in fs/readdir.c, which
is actually somewhat important for some loads (eg samba).

And the whole AC thing made it horribly horribly slow because readdir
is one of those things that doesn't just copy one value (or one
structure) to user space, but writes several different things.

Kind of like signal frame setup does.

You may not realize that right now signal frame setup *does* actually
do a call with AC set. See ia32_setup_rt_frame() that does

        put_user_try {
...
                compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
...
        } put_user_catch(err);

is a macro, but inside that macro is a call to sas_ss_reset().

Now, that is an inline function, so it hopefully doesn't actually
cause a call. But it's "only" an inline function, not "always_inline".
We did already have (and I rejected, for now) patches that made those
inlines not very strong...

[ Side note: currently signal frame setup uses the absolutely
*disgusting* put_user_ex() thing, but that's actually what
unsafe_put_user() was designed for. I just never got around to getting
rid of the nasty hot mess of put_user_ex() ]

Anyway, while signal frame setup just writes individual values,
"filldir()" does *both* several individual values _and_ does a
copy_to_user().

And it's that "copy_to_user()" that I want to eventually change to a
"unsafe_copy_to_user()", along with making the individual values be
written with unsafe_put_user().

Right now "filldir()" messes with AC a total of *six* times. It sets
four field values, and then does a "copy_to_user()", all of which
set/clear AC right now. It's wasting hundreds of cycles on this,
because AC is so slow to set/clear.

If AC was cheap, this wouldn't be much of an issue. But AC is really
really expensive. I think it's microcode and serializes the pipeline
or something.

Anyway. We already have a possible call site, and there are good
reasons for future ones too. But they are hopefully all very
controlled.

                 Linus
