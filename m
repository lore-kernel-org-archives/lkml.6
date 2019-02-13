Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F7C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B03B222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dXnxlHiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfBMXTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:19:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38065 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBMXTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:19:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id j19so2759736ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgVsJUTMnnCaCQDHvEM6XpYkBOEcgxFKcSfGDRa84GY=;
        b=dXnxlHiw2i/q9AM8vmhwbkVle9HbCuDxTJD/8szwNtgM5LWwooWFjbaCwLz+oZXAqJ
         Av4s6GLuP9JdrJKrMKI8Ez3MSvPbvQGZbiFqlPwvNMTDRBD6PJlmYLqYWC5HeeIvOK+b
         gRTPxAWAdlF1buqHitCwXrupsytDHVGxyf+pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgVsJUTMnnCaCQDHvEM6XpYkBOEcgxFKcSfGDRa84GY=;
        b=ZJDaSsd5Ea/hpBSKbGGTbjB2r1iZWrs5NYMv7SL98ekpN/iRwofi/eVPXkGJziLMhK
         hDRVQltMXRPovnpS9rkypXg6NSe3JV4cs30nCGPAGTrSJyHXlCDX941e9VtJ/A7FmnpE
         54Y8k5nW/CWrdAI4yVDRcBoCXNsMMx7YM1mn8rn3s+wFDdJFzgVMK7IPRucgpjC7ZUAR
         mjbbSMZDGP48D0ZyBqhADC0ytO/eBFDVzFotl+V97LTZXAMubqB4EiThNYp2eG3VLTlD
         mkmGl07uQS3Wq07onIBBhZuiMyPyM3PaHXDYLfdwq41iRPeuHfQMYPDTkoxyoqaJIv4v
         t6jg==
X-Gm-Message-State: AHQUAuZk4O0s7ZIZKzML5kcrKZZ3O1CDI3Dp0FiOY4M7NAQK4dczutMS
        k1wKpM2feOJbknaiR6j1hEpkyBE+XjE=
X-Google-Smtp-Source: AHgI3IbyvWhIW+G6zGGz2hIg+P/a0svRsa6oaXgZqVLQSbvvN1XE3SdoSIOYEqzew2pAqASFvrB+mg==
X-Received: by 2002:a2e:974d:: with SMTP id f13-v6mr380469ljj.104.1550099968612;
        Wed, 13 Feb 2019 15:19:28 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m18sm123596lfh.43.2019.02.13.15.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 15:19:27 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id j1so3103413lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:19:26 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr338489lfe.149.1550099966013;
 Wed, 13 Feb 2019 15:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190211134527.GA121589@gmail.com> <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com> <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com> <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Feb 2019 15:19:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSqQtuudpKSa9RwEGALw-Yw7v+YFonAEcNPEbY_-0m+g@mail.gmail.com>
Message-ID: <CAHk-=wiSqQtuudpKSa9RwEGALw-Yw7v+YFonAEcNPEbY_-0m+g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, Peter Anvin <hpa@zytor.com>,
        valentin.schneider@arm.com, brgerst@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dvlasenk@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Before that, x86_64 switch_to() read like (much simplified):
>
>         asm volatile ( /* do RSP twiddle */
>           : /* output */
>           : /* input */
>           : "memory", "cc", .... "flags");
>
> (see __EXTRA_CLOBBER)
>
> Which I suppose means that GCC generates the PUSHF/POPF to preserve the
> EFLAGS, since we mark those explicitly clobbered.

No, it only means that gcc won't keep conditionals in the flags over
the asm. It doesn't make gcc save anything.

The push/pop got removed elsewhere as Andy says.

That said, I do agree that it's probably a good idea to save/restore
flags anyway when scheduling. It's not just AC, actually, now that I
look at it again I worry a bit about DF too.

We have the rule that we run with DF clear in the kernel, and all the
kernel entry points do clear it properly (so that memcpy etc don't
need to). But there are a few places that set DF temporarily because
they do something odd (backwards memmove), and those atcually have the
*exact* same issue as stac/clac has: it's ok to take a trap or
interrupt, and schedule due to that (because the trap/irq will clear
DF), but it would be a horrible bug to have a synchronous scheduling
point there.

Arguably the DF issue really isn't even remotely likely to actually be
a real issue (the code that sets DF really is very special and should
never do any kind of preemption), but it's conceptually quite
similar..

Of course, if DF is ever set, and we end up calling any C code at all,
I guess it would already be a huge problem. If the C code then does
memcpy or something, it would corrupt things quite badly.

So I guess save/restore isn't going to save us wrt DF. If we get
anywhere close to the scheduler with the DF bit set, we've already
lost.

But I still do kind of prefer saving flags. We have other sticky state
in there too, although none of it matters in the kernel currently (eg
iopl etc - only matters in user space, and user space will always
reload eflags on return).

                 Linus
