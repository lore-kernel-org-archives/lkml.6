Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8478C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AD220693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="v4yCpz/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AD220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeFTAu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:50:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38626 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeFTAuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:50:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so644527pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xMmIINNOshv7J1JN/QMQSaEjdcTPZZ/1wcz0rcuD+K0=;
        b=v4yCpz/VUn+yx7MyGG4hudE1EssIKpZconmmvSjYY6AWX6G5U3+7BZY6klsgX98JoZ
         cx1cYr02PMqSvTLPDdN0p5H8QMKNd9TUpaOy+GaKPRgnDTgPGN5d5QjlsDf+MrlC94YI
         1u3qEGJyy28Eh2v8uYWSlfsFsmy15b01aez69P2DXJMBZowqTM4zvK8T4QvW52JhIlxe
         qiKdC5u8p3fnU/BqgkKu0A1jfPKqzDExKQXbJijde4rUbjdGJ3vKtuu2cajVsc0/nB/k
         A9Pmf1h5iFLw8jfkx/yj+oGlrq37GIVOl2KI2DfhC4DyF3nCEK6afW4D9jGhzxfiSBlF
         GJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xMmIINNOshv7J1JN/QMQSaEjdcTPZZ/1wcz0rcuD+K0=;
        b=uS0RDzRxz6NB6505arn86/pupcYrWz3fvltIx08DXyLU6dn35o3HCK1J3rKoYHUl29
         OhqYXYZ/PL/yfCys5RcZNiaVp1Bho/vsa2wsJ29IE308Y+L8znHfNhidavY6j/vlJP1T
         QminNs8Jj6Sn7puUK79e35yk0K5zad+S/JaflJoLBoZRXsv5t9djtDcsmJCp+NAt2GEr
         sA25XpVV1PFosb81T3qV+8cVNYkrWd5nZDmcpqc4r1BZ7iAPLSNGVSicWhgyk3mb4zBY
         Tbo2I8aBt3dXG1jPpJwhUR5tOkHb9siuV+WN/2v83CFCs8+PO/VXCqH+MsrS8o5lXxpS
         9ErA==
X-Gm-Message-State: APt69E16uUnKmxscH+8eePJsCqNkjdLQ9NL4tovtQL4QnoTpp87Wf7hB
        VITYFjcSs9492yfrZmd7FaqB4g==
X-Google-Smtp-Source: ADUXVKLmdMPEJr3PDMbAN+5PvhB6/PQNo73dmi22NUQcac9U6q1PcD0hCTb8GM0UyMgl7gAM9XixPQ==
X-Received: by 2002:a62:444c:: with SMTP id r73-v6mr20358832pfa.255.1529455852061;
        Tue, 19 Jun 2018 17:50:52 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:c12a:9165:dc8d:85a7:914? ([2600:1010:b023:c12a:9165:dc8d:85a7:914])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1196348pfr.172.2018.06.19.17.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 17:50:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1529447937.27370.33.camel@intel.com>
Date:   Tue, 19 Jun 2018 17:50:49 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-Id: <13E3C29A-3295-4A7F-90EC-A84CF34F3E1A@amacapital.net>
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
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
 <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net> <CAGXu5jJNgu4bW_Zthqjfpe9gLxK0zxG8QFEqqK+pJNebz6tUaw@mail.gmail.com>
 <1529427588.23068.7.camel@intel.com> <CAGXu5jJ4ivrvi-kG0iY=4C0mQQXBDXwPdfY36Dk+JqOpX19n0w@mail.gmail.com>
 <0AF8B71E-B6CC-42DE-B95C-93896196C3D7@amacapital.net> <CAGXu5jLEMy_T_5OtXLT+pUCt=Nk53nBbuRvrUgJBhq-4RZ=yCA@mail.gmail.com>
 <446EB18D-EF06-4A04-AF62-E72C68D96A84@amacapital.net> <1529447937.27370.33.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 19, 2018, at 3:38 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
> On Tue, 2018-06-19 at 13:47 -0700, Andy Lutomirski wrote:
>>>=20
>>> On Jun 19, 2018, at 1:12 PM, Kees Cook <keescook@chromium.org>
>>> wrote:
>>>=20
>>>>=20
>>>> On Tue, Jun 19, 2018 at 10:20 AM, Andy Lutomirski <luto@amacapita
>>>> l.net> wrote:
>>>>=20
>>>>>=20
>>>>> On Jun 19, 2018, at 10:07 AM, Kees Cook <keescook@chromium.org>
>>>>> wrote:
>>>>>=20
>>>>> Does it provide anything beyond what PR_DUMPABLE does?
>>>> What do you mean?
>>> I was just going by the name of it. I wasn't sure what "ptrace CET
>>> lock" meant, so I was trying to understand if it was another "you
>>> can't ptrace me" toggle, and if so, wouldn't it be redundant with
>>> PR_SET_DUMPABLE =3D 0, etc.
>>>=20
>> No, other way around. The valid CET states are on/unlocked,
>> off/unlocked, on/locked, off/locked. arch_prctl can freely the state
>> unless locked. ptrace can change it no matter what.  The lock is to
>> prevent the existence of a gadget to disable CET (unless the gadget
>> involves ptrace, but I don=E2=80=99t think that=E2=80=99s a real concern)=
.
>=20
> We have the arch_prctl now and only need to add ptrace lock/unlock.
>=20
> Back to the dlopen() "relaxed" mode. Would the following work?
>=20
> If the lib being loaded does not use setjmp/getcontext families (the
> loader knows?), then the loader leaves shstk on. =20

Will that actually work?  Are there libs that do something like longjmp with=
out actually using the glibc longjmp routine?  What about compilers that sta=
tically match a throw to a catch and try to return through several frames at=
 once?


> Otherwise, if the
> system-wide setting is "relaxed", the loader turns off shstk and issues
> a warning.  In addition, if (dlopen =3D=3D relaxed), then cet is not locke=
d
> in any time.
>=20
> The system-wide setting (somewhere in /etc?) can be:
>=20
>    dlopen=3Dforce|relaxed /* controls dlopen of non-cet libs */
>    exec=3Dforce|relaxed /* controls exec of non-cet apps */
>=20
>=20

Why do we need a whole new mechanism here?  Can=E2=80=99t all this use regul=
ar glibc tunables?=
