Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2136C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826F92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="l+x1fghW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826F92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966466AbeFSOuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:50:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42123 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965688AbeFSOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:50:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so11096105pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lf19E8nnSI1FTM5pLlVNkItdBq7YEfccMGTXXhi1QBE=;
        b=l+x1fghWbk88x5ZOrthXJA5gXOGRn4NcuWnDrmuqQQR9kTzcosXzWZztuS1RWkjswR
         MB/742ul/3KFoumEhHuhi7LzSevs+0o6Fhl08q3CHR/9BxzA+k6YUoGvWqp5ZIYnsZ3A
         nOKf8prEN4t0vFeOXhPS6SWn+yU033P+Tqri7JJZS87WN5TbraK2a5nIfq9m/D1hm5Mj
         GeErfiwzyVd5WMIPTtpDyqMxYWwX5idN4XTUeh9iRHg/bwa85WEp/ixg3pEy5tcm3vw+
         mUYdlOFT041MHXWb91eKcmLJBEIxyGu6Umx7STh7bNGt2wbITWWi+nSd2InLA6GaUel5
         vJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lf19E8nnSI1FTM5pLlVNkItdBq7YEfccMGTXXhi1QBE=;
        b=N5gpr5tNjAEvBerJsRlz9MHSBUlA1XYi15o5UTGvETLwCva6iQ4I+qw2n1u17NkB4a
         G8BvGOlbmeIeWrAG1ByENrK2iQx2E/5w1TwT6V/VhfJkkfUY0y90D6wME2ofrUU5R29L
         Fov64V58omPaBILpTPA4Hdvobzr94Zb7MH56H9q0suCg6HQzrzm4T8kgtFULSBhyxMOA
         trhleTr20/0eq7XQRaYKMIOTYUTC1HBWUyGbQ403AVK3ZgrnPdLN3VOAfvAH7X9Zbqnm
         q1KDOERH1qsYSLP/NZj/d+lb4br7Molk7fbhRhy7AXth33TODUWUHRTMNxRuIGKoAXRk
         Qq/A==
X-Gm-Message-State: APt69E0HJK+4WOw+SatnUoPS2pxh7geQJVT0lAB3khniS/mCjz8cmdC+
        1ebBe8IhU/SrwWo4+IHk1z73jQ==
X-Google-Smtp-Source: ADUXVKJEDS60Q1Em+bLtONwdtQRNHE29pH9WpJMJBDnHUVwEj8+eOaiy8f1TmHlI79smY8yxk2tnHQ==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr19531864pls.161.1529419846763;
        Tue, 19 Jun 2018 07:50:46 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:c12a:9165:dc8d:85a7:914? ([2600:1010:b023:c12a:9165:dc8d:85a7:914])
        by smtp.gmail.com with ESMTPSA id a20-v6sm25585909pfo.55.2018.06.19.07.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 07:50:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
Date:   Tue, 19 Jun 2018 07:50:43 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com, Florian Weimer <fweimer@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com> <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2018, at 5:52 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Mon, Jun 18, 2018 at 3:03 PM, Andy Lutomirski <luto@kernel.org> wrote:=

>>> On Tue, Jun 12, 2018 at 12:34 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>>=20
>>>> On Tue, Jun 12, 2018 at 11:59 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>>>>> On Tue, 12 Jun 2018, H.J. Lu wrote:
>>>>>> On Tue, Jun 12, 2018 at 9:34 AM, Andy Lutomirski <luto@kernel.org> wr=
ote:
>>>>>>> On Tue, Jun 12, 2018 at 9:05 AM H.J. Lu <hjl.tools@gmail.com> wrote:=

>>>>>>>> On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> w=
rote:
>>>>>>>>> On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrot=
e:
>>>>>>>>>> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>>>>>>>>> That works for stuff which loads all libraries at start time, but=
 what
>>>>>>>>>> happens if the program uses dlopen() later on? If CET is force lo=
cked and
>>>>>>>>>> the library is not CET enabled, it will fail.
>>>>>>>>>=20
>>>>>>>>> That is to prevent disabling CET by dlopening a legacy shared libr=
ary.
>>>>>>>>>=20
>>>>>>>>>> I don't see the point of trying to support CET by magic. It adds c=
omplexity
>>>>>>>>>> and you'll never be able to handle all corner cases correctly. dl=
open() is
>>>>>>>>>> not even a corner case.
>>>>>>>>>=20
>>>>>>>>> That is a price we pay for security.  To enable CET, especially sh=
adow
>>>>>>>>> shack, the program and all of shared libraries it uses should be C=
ET
>>>>>>>>> enabled.  Most of programs can be enabled with CET by compiling th=
em
>>>>>>>>> with -fcf-protection.
>>>>>>>>=20
>>>>>>>> If you charge too high a price for security, people may turn it off=
.
>>>>>>>> I think we're going to need a mode where a program says "I want to u=
se
>>>>>>>> the CET, but turn it off if I dlopen an unsupported library".  Ther=
e
>>>>>>>> are programs that load binary-only plugins.
>>>>>>>=20
>>>>>>> You can do
>>>>>>>=20
>>>>>>> # export GLIBC_TUNABLES=3Dglibc.tune.hwcaps=3D-SHSTK
>>>>>>>=20
>>>>>>> which turns off shadow stack.
>>>>>>>=20
>>>>>>=20
>>>>>> Which exactly illustrates my point.  By making your security story to=
o
>>>>>> absolute, you'll force people to turn it off when they don't need to.=

>>>>>> If I'm using a fully CET-ified distro and I'm using a CET-aware
>>>>>> program that loads binary plugins, and I may or may not have an old
>>>>>> (binary-only, perhaps) plugin that doesn't support CET, then the
>>>>>> behavior I want is for CET to be on until I dlopen() a program that
>>>>>> doesn't support it.  Unless there's some ABI reason why that can't be=

>>>>>> done, but I don't think there is.
>>>>>=20
>>>>> We can make it opt-in via GLIBC_TUNABLES.  But by default, the legacy
>>>>> shared object is disallowed when CET is enabled.
>>>>=20
>>>> That's a bad idea. Stuff has launchers which people might not be able t=
o
>>>> change. So they will simply turn of CET completely or it makes them hac=
k
>>>> horrible crap into init, e.g. the above export.
>>>>=20
>>>> Give them sane kernel options:
>>>>=20
>>>>     cet =3D off, relaxed, forced
>>>>=20
>>>> where relaxed allows to run binary plugins. Then let dlopen() call into=
 the
>>>> kernel with the filepath of the library to check for CET and that will t=
ell
>>>> you whether its ok or or not and do the necessary magic in the kernel w=
hen
>>>> CET has to be disabled due to a !CET library/application.
>>>>=20
>>>> That's also making the whole thing independent of magic glibc environme=
nt
>>>> options and allows it to be used all over the place in the same way.
>>>=20
>>> This is very similar to our ARCH_CET_EXEC proposal which controls how
>>> CET should be enforced.   But Andy thinks it is a bad idea.
>>=20
>> I do think it's a bad idea to have a new piece of state that survives
>> across exec().  It's going to have nasty usability problems and nasty
>> security problems.
>>=20
>> We may need a mode by which glibc can turn CET *back off* even after a
>> program had it on if it dlopens() an old binary.  Or maybe there won't
>> be demand.  I can certainly understand why the CET_LOCK feature is
>> there, although I think we need a way to override it using something
>> like ptrace().  I'm not convinced that CET_LOCK is really needed, but
>> someone who understand the thread model should chime in.
>>=20
>> Kees, do you know anyone who has a good enough understanding of
>> usermode exploits and how they'll interact with CET?
>=20
> Adding Florian to CC, but if something gets CET enabled, it really
> shouldn't have a way to turn it off. If there's a way to turn it off,
> all the ROP research will suddenly turn to exactly one gadget before
> doing the rest of the ROP: turning off CET. Right now ROP is: use
> stack-pivot gadget, do everything else. Allowed CET to turn off will
> just add one step: use CET-off gadget, use stack-pivot gadget, do
> everything else. :P

Fair enough=20

>=20
> Following Linus's request for "slow introduction" of new security
> features, likely the best approach is to default to "relaxed" (with a
> warning about down-grades), and allow distros/end-users to pick
> "forced" if they know their libraries are all CET-enabled.

I still don=E2=80=99t get what =E2=80=9Crelaxed=E2=80=9D is for.  I think th=
e right design is:

Processes start with CET on or off depending on the ELF note, but they start=
 with CET unlocked no matter what. They can freely switch CET on and off (su=
bject to being clever enough not to crash if they turn it on and then return=
 right off the end of the shadow stack) until they call ARCH_CET_LOCK.

Ptrace gets new APIs to turn CET on and off and to lock and unlock it.  If a=
n attacker finds a =E2=80=9Cptrace me and turn off CET=E2=80=9D gadget, then=
 they might as well just do =E2=80=9Cptrace me and write shell code=E2=80=9D=
 instead. It=E2=80=99s basically the same gadget. Keep in mind that the actu=
al sequence of syscalls to do this is incredibly complicated.

It=E2=80=99s unclear to me that forcing CET on belongs in the kernel at all.=
  By the time an attacker can find a non-CET ELF binary and can exec it in a=
 context where it does their bidding, the attacker is far beyond what CET ca=
n even try to help. At this point we=E2=80=99re talking about an attacker wh=
o can effectively invoke system(3) with arbitrary parameters, and attackers w=
ith *that* power don=E2=80=99t need ROP and the like.

There is a new feature I=E2=80=99d like to see, though: add an ELF note to b=
less a binary as being an ELF interpreter. And add an LSM callback to valida=
te an ELF interpreter.  Let=E2=80=99s minimize the shenanigans that people w=
ho control containers can get up to. (Obviously the ELF note part would need=
 to be opt-in.)=
