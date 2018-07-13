Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C57ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FE20854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HM/UrYUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeGMRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:37:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37431 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbeGMRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:37:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so10122162wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kC+g3gkKf1tO+YCO0MGSlPgytCWr21BdCs3bhHAjC2Y=;
        b=HM/UrYUjGC0zgsWZBLBtunVPySrL9p94DJ+3Ut+JPitbdEVyOFyDBwCBEYklur4zsQ
         KwRLw9UntSHy29SpXJZPzVqNxafBczHLhZsqL2YlV3fLmURShJnZxrdoKh9RyWtLMvRF
         EAiNH90WUW3o3j8XMKgKGYf2+u5uafvMt2SBGHrM9wme1kcczFSMmIRRMhDZh8qJKKeN
         HKB2Ef+lutSF0SSygtPmLtTDwb37zzorbDHb78S/yD6FgeEo+R7aA9PEpdMjM5n9UTRx
         6IYQ/PgYYEGLwb8RmWDyEaUaEHxJ0te/BvQVg8M0lUFszHuEE2CS3COVvGdQa/Gg+qxP
         N73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kC+g3gkKf1tO+YCO0MGSlPgytCWr21BdCs3bhHAjC2Y=;
        b=ZXcFfAW4cqdxPp5WW2JJ4zLTPUjFdJbFztyGr00VDDnRTmAt18VR4TIyEqdFZxfxtF
         Fu1EXN6GQru8rh3wrEyj1vBp9lEE3wiJg0GGBNF/qiADgbb2s9368h8WbGrC1sMJKl5p
         origZaAcuYi1yAb2x2tdA76G1mykI2/OY6M1okngs0gaGpkftnjWj8IRoYp/anQFQTZG
         kjlvpnEMM0Q06dbQiAnmUQgXfGLXdmC8zckKicvM6GMPa6ng9Y5udA1fweOUCzEwhDax
         NoYtCMaOg9Emvo8n0MjK4ydb0VA/uWL4MDdRHaxMbj2p0dIX8LYlSpUGVmVt/Fafp0/e
         vfQA==
X-Gm-Message-State: AOUpUlFYK7ks8gQoU/Gi/7MLqb9/Ak3vAwTIp6J66Q8K0loZJS8N66TQ
        x6Ey+XC9bu047ry5iuYbmHlow49EAwnqYHdXMzgn+A==
X-Google-Smtp-Source: AAOMgpfndWSuw5X+m/8vEmCObUK98MZddCHm2vH8G0CMmLcaqb4rq2Lt87PWiKTQo9m2lrh4tUmGZji2ByofUWV0XPY=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr4165854wmd.46.1531502519799;
 Fri, 13 Jul 2018 10:21:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:21:39
 -0700 (PDT)
In-Reply-To: <20180713105620.z6bjhqzfez2hll6r@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-8-git-send-email-joro@8bytes.org> <A66D58A6-3DC6-4CF3-B2A5-433C6E974060@amacapital.net>
 <20180713105620.z6bjhqzfez2hll6r@8bytes.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 13 Jul 2018 10:21:39 -0700
Message-ID: <CALCETrW4XMD9TSTxK3h-3p5ZE5Z=DupiUBtiXnMmSprbXtJr3g@mail.gmail.com>
Subject: Re: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline stack
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:56 AM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi Andy,
>
> thanks for you valuable feedback.
>
> On Thu, Jul 12, 2018 at 02:09:45PM -0700, Andy Lutomirski wrote:
>> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> > -.macro SAVE_ALL pt_regs_ax=3D%eax
>> > +.macro SAVE_ALL pt_regs_ax=3D%eax switch_stacks=3D0
>> >    cld
>> > +    /* Push segment registers and %eax */
>> >    PUSH_GS
>> >    pushl    %fs
>> >    pushl    %es
>> >    pushl    %ds
>> >    pushl    \pt_regs_ax
>> > +
>> > +    /* Load kernel segments */
>> > +    movl    $(__USER_DS), %eax
>>
>> If \pt_regs_ax !=3D %eax, then this will behave oddly. Maybe it=E2=80=99=
s okay.
>> But I don=E2=80=99t see why this change was needed at all.
>
> This is a left-over from a previous approach I tried and then abandoned
> later. You are right, it is not needed.
>
>> > +/*
>> > + * Called with pt_regs fully populated and kernel segments loaded,
>> > + * so we can access PER_CPU and use the integer registers.
>> > + *
>> > + * We need to be very careful here with the %esp switch, because an N=
MI
>> > + * can happen everywhere. If the NMI handler finds itself on the
>> > + * entry-stack, it will overwrite the task-stack and everything we
>> > + * copied there. So allocate the stack-frame on the task-stack and
>> > + * switch to it before we do any copying.
>>
>> Ick, right. Same with machine check, though. You could alternatively
>> fix it by running NMIs on an irq stack if the irq count is zero.  How
>> confident are you that you got #MC right?
>
> Pretty confident, #MC uses the exception entry path which also handles
> entry-stack and user-cr3 correctly. It might go through through the slow
> paranoid exit path, but that's okay for #MC I guess.
>
> And when the #MC happens while we switch to the task stack and do the
> copying the same precautions as for NMI apply.
>
>> > + */
>> > +.macro SWITCH_TO_KERNEL_STACK
>> > +
>> > +    ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
>> > +
>> > +    /* Are we on the entry stack? Bail out if not! */
>> > +    movl    PER_CPU_VAR(cpu_entry_area), %edi
>> > +    addl    $CPU_ENTRY_AREA_entry_stack, %edi
>> > +    cmpl    %esp, %edi
>> > +    jae    .Lend_\@
>>
>> That=E2=80=99s an alarming assumption about the address space layout. Ho=
w
>> about an xor and an and instead of cmpl?  As it stands, if the address
>> layout ever changes, the failure may be rather subtle.
>
> Right, I implement a more restrictive check.

But the check needs to be correct or we'll mess up, right?  I think
the code will be much more robust and easier to review if you check
"on the entry stack" instead of ">=3D the entry stack".  (Or <=3D -- I can
never remember how this works in AT&T syntax.)

>
>> Anyway, wouldn=E2=80=99t it be easier to solve this by just not switchin=
g
>> stacks on entries from kernel mode and making the entry stack bigger?
>> Stick an assertion in the scheduling code that we=E2=80=99re not on an e=
ntry
>> stack, perhaps.
>
> That'll save us the check whether we are on the entry stack and replace
> it with a check whether we are coming from user/vm86 mode. I don't think
> that this will simplify things much and I am a bit afraid that it'll
> break unwritten assumptions elsewhere. It is probably something we can
> look into later separatly from the basic pti-x32 enablement.
>

Fair enough.  There's also the issue that NMI still has to switch CR3
if it hits with the wrong CR3.

I personally much prefer checking whether you came from user mode
rather than the stack address, but I'm okay with either approach here.
