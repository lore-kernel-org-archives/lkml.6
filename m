Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BEAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B232086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="aWKgM7qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B232086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeFROnj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:43:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38107 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbeFROni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:43:38 -0400
Received: by mail-io0-f195.google.com with SMTP id l19-v6so17056344ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KZNjczx2a/tFVDQ8fQSYWCwL/022eTpuZ+zC9FYkDQA=;
        b=aWKgM7qBUUpV/AfF1JK7CO2bLkEsg6unLBQgOoN9JFRQXdPh3vIkXMfHR+9MRre/vu
         TRNLaBuIe/FVFyinQMVfxJbUnCitWyaxvmjuR89uxnt8PGoXLri8laeNBP7mbLvZmX8T
         Y0VUccKhaF2wP03LZh+LZYbGlYHYpALCdS7lz7iwemha/23VJpEuH3ZLDUCy+CFZRcea
         CcbwKR8/G4bpOpwIPuJy28RkULitDyY3RO+RzZeTMe+LcHrseWnKiijH95OXjieqqTFk
         35I7gZoikxwZBH1Mlh1ktmdqaJFc2k4OYnuY2Urf5TQtMVxy6g49YZja4rwG4vC2Ca4l
         VeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KZNjczx2a/tFVDQ8fQSYWCwL/022eTpuZ+zC9FYkDQA=;
        b=rvq0meKHuenpGalBnhmle4CXpDDOUVO4jX4LuMmU26G/Z7WtIBMVkYxNt7rAFKmKH6
         0++mo5lwzIYBZ0wVuvRCtdRu1hBs2uKPgL7TN7hG4MMSwBY8u7nGv7k0DnUbwetkGi2m
         cAUuKf2hQSVb8T6Qdx7/YERlkORhOT7gRvFPnHZpmSYX7KeN0XAv0+1grn1tggI1cxwX
         7yJ52nvrWB+/QSFVkxJZV+6/B/FEKUCNSOh3Wms8k7iXKWCNdqU7OBkzO6lAJND4fOyu
         l8ZL7fhLxpNUTqm9tZdwzrwA0kdAK7cQaG0LAbtnzMrG1Zbl102BdIUVQLqkOqStTBU0
         kcbw==
X-Gm-Message-State: APt69E2B+hqfZsNU7w2M3Wu0HM/kbobiWgudfJ3BYm52lPW9yURa8JLe
        sVwmCh+J8wPccsuJ197hco8tI32ml9dIi/bA8Y/yQQ==
X-Google-Smtp-Source: ADUXVKKvob7D7i6f7ePKBiuvFaj1f92rCN6GjOy416OHPb4A+aRlzlMtmLEtyDzA8OaAmLiq/iu/cI+rqdq5jD+LhgI=
X-Received: by 2002:a6b:cb08:: with SMTP id b8-v6mr10214102iog.128.1529333017683;
 Mon, 18 Jun 2018 07:43:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 07:42:57
 -0700 (PDT)
In-Reply-To: <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu> <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 Jun 2018 10:42:57 -0400
Message-ID: <CABV8kRwhrQ75g9y7v4Mq05CfZ9khhVQCwkp052jcNOvKs6-2Fg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

thank you for your thorough comments, replies inline:

On Mon, Jun 18, 2018 at 8:47 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 06/16/2018 05:33 PM, Keno Fischer wrote:
>> For my use case, it would be sufficient to simply disallow
>> any value of XCR0 with "holes" in it,
> But what if the hardware you are migrating to/from *has* holes?

Yes, that would be the problem ;). I'm not aware of that being the
case for user space states on current hardware, but perhaps,
I'm just missing a case.

> There's no way this is even close to viable until it has been made to
> cope with holes.

Ok, it seems to me the first decision is whether it should be allowed
to have the compacted format (with holes) in an in-memory xstate
image. Doing so seems possible, but would require more invasive
changes to the kernel, so I'm gonna ignore it for now.

If we want to keep the in-memory xstate layout constant after boot
time, I see four ways to do that for this feature.

1) Set up XCR0 in a different place, so that the kernel xsaves/xrstors
    use an XCR0 that matches the layout the kernel expects.
2) Use xsaveopt when this particular thread flag is set and have the
    kernel be able to deal with non-compressed xstate images, even
    if xsaves is available.
3) What's in this patch now, but fix up the xstate after saving it.
4) Catch the fault thrown by xsaves/xrestors in this situation, update
    XCR0, redo the xsaves/restores, put XCR0 back and continue
    execution after the faulting instruction.

Option 1) seems easiest, but it would also require adding code
somewhere on the common path, which I assume is a no-go ;).

Option 3) seems doable entirely in the slow path for this feature.
If we xsaves with the modified XCR0, we can then fix up the memory
image to match the expected layout. Similarly, we could xrestors
in the slow path (from standard layout) and rely on the
`fpregs_state_valid` mechanism to prevent the fault.

Option 4) seems also doable, but of course messing around with
traps makes things quite a bit more complicated.

> FWIW, I just don't think this is going to be viable.  I have the feeling
> that there's way too much stuff that hard-codes assumptions about XCR0
> inside the kernel and out. This is just going to make it much more fragile.
>
> Folks that want this level of container migration are probably better
> off running one of the hardware-based containers and migrating _those_.
> Or, just ensuring the places to/from they want to migrate have a
> homogeneous XCR0 mix.

Fair enough :). I figured I'd throw it out there as an RFC and see if I can
get it into an acceptable shape for you to include upstream. For my,
particular use case (replaying old traces on newer hardware),
since I control the replay hardware, I'm happy if there's a patch
for me to apply locally to solve my problem. Of course there's also
the opposite use case (recording a trace on a new machine, but
wanting to replay on an older one), which would also require the
recording machine to have this patch. The reason I make this
distinction is that we don't usually control the recording machine
(since those are our users' machines), so that tends to have a
much more varied hardware/kernel mix and it's harder to get kernel
patches applied. I'm happy to keep chipping away at this for as
long as there is feedback, but I understand if it won't make it
in at the end of the process.

>> @@ -252,6 +301,8 @@ void arch_setup_new_exec(void)
>>       /* If cpuid was previously disabled for this task, re-enable it. */
>>       if (test_thread_flag(TIF_NOCPUID))
>>               enable_cpuid();
>> +     if (test_thread_flag(TIF_MASKXCR0))
>> +             reset_xcr0_mask();
>>  }
>
> So the mask is cleared on exec().  Does that mean that *every*
> individual process using this interface has to set up its own mask
> before anything in the C library establishes its cached value of XCR0.
> I'd want to see how that's being accomplished.

Yes, that is correct. In my rr patch this is done by injecting an
arch_prctl syscall using ptrace, at the same spot that we inject
the arch_prctl syscall for enabling cpuid faulting (i.e. the interface
that sets the `TIF_NOCPUID` flag in the check prior to this one).
Since these two features would seem to make the most sense when
used together, I figured it would be best to align semantics.
Happy to entertain alternative suggestions though.

>> +static int xstate_is_initial(unsigned long mask)
>> +{
>> +     int i, j;
>> +     unsigned long max_bit = __ffs(mask);
>> +
>> +     for (i = 0; i < max_bit; ++i) {
>> +             if (mask & (1 << i)) {
>> +                     char *xfeature_addr = (char *)get_xsave_addr(
>> +                                     &current->thread.fpu.state.xsave,
>> +                                     1 << i);
>> +                     unsigned long feature_size = xfeature_size(i);
>> +
>> +                     for (j = 0; j < feature_size; ++j) {
>> +                             if (xfeature_addr[j] != 0)
>> +                                     return 0;
>> +                     }
>> +             }
>> +     }
>> +     return 1;
>> +}
>
> There is nothing architectural saying that the init state has to be 0.

True, but it was my understanding that this was true for all currently
defined state components (unless I misread 13.6 in the SDM, which
is totally possible). Since I don't currently allow setting any bits
other than the ones currently defined, I think this is ok at the moment,
but this function is certainly one of those that make this patch "RFC" ;)

>> +     case ARCH_SET_XCR0: {
>
> The interface is a mit burky.  The SET_XCR0 operation masks out the
> "set" value from the current value?  That's a bit counterintuitive.

I apologize for the confusion. The SET_XCR0, userspace ABI takes
the value of XCR0 to set, which then gets translated into a mask
for the kernel to save (I discussed this a bit in the original PATCH -
I guess this confusion further proves that I should just stick
with one or the other).

>> +             unsigned long mask = xfeatures_mask & ~arg2;
>> +
>> +             if (!use_xsave())
>> +                     return -ENODEV;
>> +
>> +             if (arg2 & ~xfeatures_mask)
>> +                     return -ENODEV;
>
> This is rather unfortunately comment-free.  "Are you trying to clear a
> bit that was not set in the first place?"
>
> Also, shouldn't this be dealing with the new task->xcr0, *not* the
> global xfeatures_mask?  What if someone calls this more than once?

The intention of this was to disallow setting any bits in xcr0, that weren't
enabled in the `xfeatures_mask` (because that means the kernel doesn't
know about them). I was fine with re-enabling xcr0 bits later, which is
why this doesn't currently look at the task's xcr0. I personally don't need
this, but it seemed like an arbitrary choice to disallow it.

>> +             if (!xcr0_is_legal(arg2))
>> +                     return -EINVAL;
>
> FWIW, I don't really get the point of disallowing some of the values
> made illegal in there.  Sure, you shoot yourself in the foot, but the
> worst you'll probably see is a general-protection-fault from the XSETBV,
> or from the first XRSTOR*.  We can cope with those, and I'd rather not
> be trying to keep a list of things you're not allowed to do with XSAVE.

That's fair. I guess I am scared of creating places in the kernel that trap,
perhaps unreasonably so ;). I should point out however, that KVM already
does keep such a list for precisely the same reason, so if I refactor
this to share such code, at least there'd be only one such list, which
may be slightly better?

> I also don't see any sign of checking for supervisor features anywhere.

At least currently, it is my understanding that `xfeatures_mask` only has
user features, am I mistaken about that?

>> +             /*
>> +              * We require that any state components being disabled by
>> +              * this prctl be currently in their initial state.
>> +              */
>> +             if (!xstate_is_initial(mask))
>> +                     return -EPERM;
>
> Aside: I would *not* refer to the "initial state", for fear that we
> could confuse it with the hardware-defined "init state".  From software,
> we really have zero control over when the hardware is in its "init state".

I meant to have this refer to the initial configuration as defined in 13.6
of the SDM, i.e. what xrestor restores when the corresponding xstate_bv
field is cleared.

> But, in any case, so how is this supposed to work?
>
>         // get features we are disabling into values matching the
>         // hardware "init state".
>         __asm__("XRSTOR %reg1,%reg2", ...);
>         prctl(PRCTL_SET_XCR0, something);
>
> ?

I was primarily thinking of the ptracer use case,

    ptrace(PTRACE_SETFPXREGS, <recorded regs>)
    <inject arch_prctl using ptrace>

in which case there isn't a problem, because the unrecorded regs
should be in the initial state.

> That would be *really* fragile code from userspace.  Adding a printk()
> between those two lines would probably break it, for instance.
>
> I'd probably just not have these checks.

Ok, that is fine with me. It also to some extent informs the possibilities
for the compacted storage question above, since not having these
checks would require us to save the current register state such that
we can re-activate it later and restore it properly.
