Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0956BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7C520863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sjl/CJGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7C520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeK2O2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:28:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33990 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2O2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:28:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so274273pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e1PNIcFe0dKJw/lW6KgoEhzj0qR2kUlKsSGsessAVpE=;
        b=sjl/CJGNQeu6Bs/P8TqKXD+F8B9fWPpdobEFG7Paykf0HdE53GNlPCHL6GJQgSyC3R
         5ITy/18CgARnsSd+6ZFV3L+TP20K8ynyuIubbll6Ze3Hcbubi/jhWZSoT4H9diVR3M6J
         Cs4AnkccAzKlkjAW9TUqAaIAV6XNyFISBlTbhE7cF+CXGoVsLhwByvVbB9gczAi14BQw
         JoqGkLtNzFtKTftxL/zvyfoVv4yuQE+zmlo/4yxPUuDb0SAtdTHEVo2+ozAVMzFE0pEQ
         Y+EirTRHCHP+9AFEO/ydZ2KilMfpNARUVVlo56+0vCpGW0zAtf1Jrh3H7OYMfIfny87R
         +dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e1PNIcFe0dKJw/lW6KgoEhzj0qR2kUlKsSGsessAVpE=;
        b=cNfsU78qAdlMMoG5m3FCX+JcSJLB/Yz8XN2GPys+W6S07D0xVINMY2/aSrNbxR6GSO
         2MksxvOQvUJDQotl4VZRYMeMphQ1lTaP31Z1wW7Ig8jkfKQO4sEQOG9uCM7iXsMPZlZh
         kCZ9UdJLt28aYjxxNAiPEFNIbozpXxpWJPm+amxp6a/6aKbDoaH+/2ZnTCjGc6Bfo+qE
         RTkKQahwk27JZLPpje9S3nuuqaUB+8XiOEGStx7F0/27xoCHqzOqZ0JaUKKj0rWrphKz
         FLNkQDRQhp441+MlIC5iCNIwdmm6NSyv+tgngAXfjkSSugXgi0U1HZd8QIavCxRhrYQr
         lIKA==
X-Gm-Message-State: AA+aEWa6zM5toI1BEWUXEIlIfw0CAK8Q+tXypbWU7O3L+/zHU57jLwiW
        mKF7d0bDWoa/TOYiAA5xBCgtDw==
X-Google-Smtp-Source: AFSGD/XgWgBTRh7G0Vju1oHI5t7YM8DzFS6FFVSjain1jrJWJqi+TqdTphasW828ZdV88jDQwEXxAA==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr35657227pgd.416.1543461851388;
        Wed, 28 Nov 2018 19:24:11 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id a4sm371395pgv.70.2018.11.28.19.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 19:24:09 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com>
Date:   Wed, 28 Nov 2018 19:24:08 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CD1975E-3B15-4B9C-B2A9-2E5F72E1D95F@amacapital.net>
References: <20181018005420.82993-1-namit@vmware.com> <20181128160849.epmoto4o5jaxxxol@treble> <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com> <20181129003837.6lgxsnhoyipkebmz@treble> <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com> <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 28, 2018, at 6:06 PM, Nadav Amit <namit@vmware.com> wrote:

>> On Nov 28, 2018, at 5:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> On Wed, Nov 28, 2018 at 4:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wro=
te:
>>> On Wed, Nov 28, 2018 at 07:34:52PM +0000, Nadav Amit wrote:
>>>>> On Nov 28, 2018, at 8:08 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
>>>>>=20
>>>>>> On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
>>>>>> This RFC introduces indirect call promotion in runtime, which for the=

>>>>>> matter of simplification (and branding) will be called here "relpolin=
es"
>>>>>> (relative call + trampoline). Relpolines are mainly intended as a way=

>>>>>> of reducing retpoline overheads due to Spectre v2.
>>>>>>=20
>>>>>> Unlike indirect call promotion through profile guided optimization, t=
he
>>>>>> proposed approach does not require a profiling stage, works well with=

>>>>>> modules whose address is unknown and can adapt to changing workloads.=

>>>>>>=20
>>>>>> The main idea is simple: for every indirect call, we inject a piece o=
f
>>>>>> code with fast- and slow-path calls. The fast path is used if the tar=
get
>>>>>> matches the expected (hot) target. The slow-path uses a retpoline.
>>>>>> During training, the slow-path is set to call a function that saves t=
he
>>>>>> call source and target in a hash-table and keep count for call
>>>>>> frequency. The most common target is then patched into the hot path.
>>>>>>=20
>>>>>> The patching is done on-the-fly by patching the conditional branch
>>>>>> (opcode and offset) that is used to compare the target to the hot
>>>>>> target. This allows to direct all cores to the fast-path, while patch=
ing
>>>>>> the slow-path and vice-versa. Patching follows 2 more rules: (1) Only=

>>>>>> patch a single byte when the code might be executed by any core. (2)
>>>>>> When patching more than one byte, ensure that all cores do not run th=
e
>>>>>> to-be-patched-code by preventing this code from being preempted, and
>>>>>> using synchronize_sched() after patching the branch that jumps over t=
his
>>>>>> code.
>>>>>>=20
>>>>>> Changing all the indirect calls to use relpolines is done using assem=
bly
>>>>>> macro magic. There are alternative solutions, but this one is
>>>>>> relatively simple and transparent. There is also logic to retrain the=

>>>>>> software predictor, but the policy it uses may need to be refined.
>>>>>>=20
>>>>>> Eventually the results are not bad (2 VCPU VM, throughput reported):
>>>>>>=20
>>>>>>          base            relpoline
>>>>>>          ----            ---------
>>>>>> nginx      22898           25178 (+10%)
>>>>>> redis-ycsb 24523           25486 (+4%)
>>>>>> dbench     2144            2103 (+2%)
>>>>>>=20
>>>>>> When retpolines are disabled, and if retraining is off, performance
>>>>>> benefits are up to 2% (nginx), but are much less impressive.
>>>>>=20
>>>>> Hi Nadav,
>>>>>=20
>>>>> Peter pointed me to these patches during a discussion about retpoline
>>>>> profiling.  Personally, I think this is brilliant.  This could help
>>>>> networking and filesystem intensive workloads a lot.
>>>>=20
>>>> Thanks! I was a bit held-back by the relatively limited number of respo=
nses.
>>>=20
>>> It is a rather, erm, ambitious idea, maybe they were speechless :-)
>>>=20
>>>> I finished another version two weeks ago, and every day I think: "shoul=
d it
>>>> be RFCv2 or v1=E2=80=9D, ending up not sending it=E2=80=A6
>>>>=20
>>>> There is one issue that I realized while working on the new version: I=E2=
=80=99m not
>>>> sure it is well-defined what an outline retpoline is allowed to do. The=

>>>> indirect branch promotion code can change rflags, which might cause
>>>> correction issues. In practice, using gcc, it is not a problem.
>>>=20
>>> Callees can clobber flags, so it seems fine to me.
>>=20
>> Just to check I understand your approach right: you made a macro
>> called "call", and you're therefore causing all instances of "call" to
>> become magic?  This is... terrifying.  It's even plausibly worse than
>> "#define if" :)  The scariest bit is that it will impact inline asm as
>> well.  Maybe a gcc plugin would be less alarming?
>=20
> It is likely to look less alarming. When I looked at the inline retpoline
> implementation of gcc, it didn=E2=80=99t look much better than what I did -=
 it
> basically just emits assembly instructions.

To be clear, that wasn=E2=80=99t a NAK.  It was merely a =E2=80=9Cthis is al=
arming.=E2=80=9D

Hey Josh - you could potentially do the same hack to generate the static cal=
l tables. Take that, objtool.

>=20
> Anyhow, I look (again) into using gcc-plugins.
>=20
>>>> 1. An indirect branch inside the BP handler might be the one we patch
>>>=20
>>> I _think_ nested INT3s should be doable, because they don't use IST.
>>> Maybe Andy can clarify.
>>=20
>> int3 should survive recursion these days.  Although I admit I'm
>> currently wondering what happens if one thread puts a kprobe on an
>> address that another thread tries to text_poke.
>=20
> The issue I regarded is having an indirect call *inside* the the handler.
> For example, you try to patch the call to bp_int3_handler and then get an
> int3. They can be annotated to prevent them from being patched. Then again=
,
> I need to see how gcc plugins can get these annotations.

We could move the relevant code to a separate object file that disables the w=
hole mess.

>=20
>>=20
>> Also, this relpoline magic is likely to start patching text at runtime
>> on a semi-regular basis.  This type of patching is *slow*.  Is it a
>> problem?
>=20
> It didn=E2=80=99t appear so. Although there are >10000 indirect branches i=
n the
> kernel, you don=E2=80=99t patch too many of them even you are doing relear=
ning.
>=20
>>=20
>>>> 2. An indirect branch inside an interrupt or NMI handler might be the
>>>>  one we patch
>>>=20
>>> But INT3s just use the existing stack, and NMIs support nesting, so I'm
>>> thinking that should also be doable.  Andy?
>>=20
>> In principle, as long as the code isn't NOKPROBE_SYMBOL-ified, we
>> should be fine, right?  I'd be a little nervous if we get an int3 in
>> the C code that handles the early part of an NMI from user mode.  It's
>> *probably* okay, but one of the alarming issues is that the int3
>> return path will implicitly unmask NMI, which isn't fantastic.  Maybe
>> we finally need to dust off my old "return using RET" code to get rid
>> of that problem.
>=20
> So it may be possible. It would require having a new text_poke_bp() varian=
t
> for multiple instructions. text_poke_bp() might be slower though.
>=20
>=20

Can you outline how the patching works at all?  You=E2=80=99re getting rid o=
f preempt disabling, right?  What=E2=80=99s the actual sequence and how does=
 it work?=
