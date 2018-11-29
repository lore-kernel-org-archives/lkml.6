Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98172C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1EE2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="v3iYlZfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1EE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeK3EFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:05:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3EFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:05:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so1206290pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lLiTtMu7ykg5/Be89p4ADj2aA76GZ2847GIo+ryVALU=;
        b=v3iYlZfG6H4StPQtKZsMJQ9refOVTxWOAcN3NiXpxEKbLsrSBXVADrWE9OPnJ54y9j
         ziQBJOhebvbK4D5GR1+XePpNZt1v8gtD3eNZGIrQm+t7BbFGqVIlwj3ftI3bboy9kipC
         PD35/FfFNLzWgkq6t8eUdj1RUsyhiiLyiqzgWtQ6wZMR2vKB3hPDRMfQvGKEpVV/w9Fh
         8KMY9rqaM3BrQmqvxkLAUuXMnUTJ4byuO/VO5oappgVOvwfic3Bv+gjyBGp37TksuA7Q
         dqmJkd4K/phy2reJLubBBWetRmtRVWhStRPGRzwcCrfrYTHaJN5mRFmiqti2AYKkhwxQ
         gW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lLiTtMu7ykg5/Be89p4ADj2aA76GZ2847GIo+ryVALU=;
        b=s3LSVLY4qQ0uEdcpI5H7kvlR4esE7ACnvu4WnoqmNjjswx6VyFi4v53ryVeo1p/L0U
         BpHJSF0uDof3qtc2AQSofuluTtCgJPRtYlEPKtGC0qVjj2aQuCEfzYKDw+EAyzFHw2gZ
         AAkgz1IA2fivVLZq+3tlHEJr2/BH4jYRpB3h6nrH+48rO5twPAKNePgNh3mimLxvug4L
         eFJnHTBPMXOcuz/LxbHPzK3MR9qNri3dM9dvxaKyanpp68O3/MUfA3lVJMnpnXa1ZKQl
         rjtEaCMZ0bDF5sBf/p+lmcmuiiVAtZrObZjNC5Ki2SamzUULyEY5v1oZCgFQaSb4zyQi
         ALzg==
X-Gm-Message-State: AA+aEWbiAyXjOcB6v6mFBf/Se6Qdw49P4Pza+EkV4NRPWxvuHnbGqE1Q
        qzrNvwmcXuw50zWT1iEuSWL1bQ==
X-Google-Smtp-Source: AFSGD/W8IC4zUZgptvEgK4kzZ5nLxmlMphPU0VK12+3/dew5qka4jt2EM8Wu0r55fjyWUAmekf0OWg==
X-Received: by 2002:a65:4142:: with SMTP id x2mr1828623pgp.356.1543510773565;
        Thu, 29 Nov 2018 08:59:33 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id g5sm7860561pgu.57.2018.11.29.08.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:59:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129164914.GA9027@hirez.programming.kicks-ass.net>
Date:   Thu, 29 Nov 2018 08:59:31 -0800
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
References: <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble> <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <20181129164914.GA9027@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 8:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Nov 29, 2018 at 10:33:42AM -0600, Josh Poimboeuf wrote:
>>> can't we 'fix' that again? The alternative is moving that IRET-frame and=

>>> fixing everything up, which is going to be fragile, ugly and such
>>> things more.
>=20
>> This seems to work...
>=20
> That's almost too easy... nice!

It is indeed too easy: you=E2=80=99re putting pt_regs in the wrong place for=
 int3 from user mode, which is probably a root hole if you arrange for a ptr=
aced process to do int3 and try to write to whatever register aliases CS.

If you make it conditional on CPL, do it for 32-bit as well, add comments, a=
nd convince yourself that there isn=E2=80=99t a better solution (like pointi=
ng IP at a stub that retpolines to the target by reading the function pointe=
r, a la the unoptimizable version), then okay, I guess, with only a small am=
ount of grumbling.

>=20
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index ce25d84023c0..184523447d35 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -876,7 +876,7 @@ apicinterrupt IRQ_WORK_VECTOR            irq_work_int=
errupt        smp_irq_work_interrupt
>>  * @paranoid =3D=3D 2 is special: the stub will never switch stacks.  Thi=
s is for
>>  * #DF: if the thread stack is somehow unusable, we'll still get a useful=
 OOPS.
>>  */
>> -.macro idtentry sym do_sym has_error_code:req paranoid=3D0 shift_ist=3D-=
1
>> +.macro idtentry sym do_sym has_error_code:req paranoid=3D0 shift_ist=3D-=
1 create_gap=3D0
>> ENTRY(\sym)
>>    UNWIND_HINT_IRET_REGS offset=3D\has_error_code*8
>>=20
>> @@ -891,6 +891,12 @@ ENTRY(\sym)
>>    pushq    $-1                /* ORIG_RAX: no syscall to restart */
>>    .endif
>>=20
>> +    .if \create_gap =3D=3D 1
>> +    .rept 6
>> +    pushq 5*8(%rsp)
>> +    .endr
>> +    .endif
>> +
>>    .if \paranoid =3D=3D 1
>>    testb    $3, CS-ORIG_RAX(%rsp)        /* If coming from userspace, swi=
tch stacks */
>>    jnz    .Lfrom_usermode_switch_stack_\@
>> @@ -1126,7 +1132,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
>> #endif /* CONFIG_HYPERV */
>>=20
>> idtentry debug            do_debug        has_error_code=3D0    paranoid=3D=
1 shift_ist=3DDEBUG_STACK
>> -idtentry int3            do_int3            has_error_code=3D0
>> +idtentry int3            do_int3            has_error_code=3D0    create=
_gap=3D1
>> idtentry stack_segment        do_stack_segment    has_error_code=3D1
>>=20
>> #ifdef CONFIG_XEN_PV
