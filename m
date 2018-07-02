Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CED24EF3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="aTcYVO8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CED24EF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeGBXiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:38:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37468 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753530AbeGBXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:38:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id n15-v6so58044pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/GlpqJerArBnCs+RJtBbeFgPa1TR0Igck37Q4ridmuM=;
        b=aTcYVO8w++liFCOz1jbfmxcbXBIpP+mgsZewH+EhLLSszW6oooOJspaLPCeI3A5spy
         NyWGVqbj5nToLmXwY6F5gl2qn3PoBCuhXIwayKE0Dc5mAeL6RxCK1sAfdgHYuMla+U4F
         JQjn8HTj9hFGDk01OoBBDiIauyjc04DbBz6gdSWPXMgBIV6fj1ZHho5MT4RTJILVeOLG
         l90raO6RMUKivWDlm4gTUiFBq3bzbYXpzB3IgY+1hNL2OXVmlHtW5JlmeLE2b460Unnk
         DnsUEYDXyjx7QaIjPABaAWMp2o6wYTzSlcrICo3tUK1ZycRXz+m31rJjSQDYstXLnYAJ
         ydaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/GlpqJerArBnCs+RJtBbeFgPa1TR0Igck37Q4ridmuM=;
        b=iuY6gSBPGpoyoVSCIUPt0cv09WGq6U1kLQZXtQiedbFKV5Xxn2oXEOXI5FfHy0r4WB
         FwtxkjldgARnaZeq57Q+l1gy1XhE2Dlr4YM/OCIK+GkVlT+YZyFhmoz9Usv1wMFeesLB
         IyaGsshQ+uZTA/YG83X3vOLMnMD5MU4Hft1kLlc5tqrgO/PzHfR6vEokmfbGM8C7ix4C
         CJ+oWjiltIyh8k+tpoFqnKjxLKGiKjRq+mdSiHDof1DJZv9nxYoJ/MI5VCW5lGouuQds
         5eP9/aUG0MTQglDD+lO4v/h3wOP3+VLCBD5S3ONfifz1RUCfIp2JelaRE6gGG2X48mni
         6Caw==
X-Gm-Message-State: APt69E0Bxe8u+KmWbStfQez+EFMr4C5X9cQaR3Yv1ud5+8bHKUMrgG4p
        SDyNOe0R9NqN5EHhruE01WTpJw==
X-Google-Smtp-Source: ADUXVKLp2UCzwSEJRnuGF/YyRYkXyFveKiiQ87BW3EWeiSZGQVmw0rzbTEH+SjaSxTybokg95To1uQ==
X-Received: by 2002:a65:5307:: with SMTP id m7-v6mr24065094pgq.431.1530574678597;
        Mon, 02 Jul 2018 16:37:58 -0700 (PDT)
Received: from ?IPv6:2600:1010:b004:108e:fd5c:4749:91b9:ac0d? ([2600:1010:b004:108e:fd5c:4749:91b9:ac0d])
        by smtp.gmail.com with ESMTPSA id b1-v6sm9514892pfc.97.2018.07.02.16.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:37:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate user inputs
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
Date:   Mon, 2 Jul 2018 16:37:55 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 2, 2018, at 4:22 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.=
com> wrote:
>=20
> ----- On Jul 2, 2018, at 7:16 PM, Mathieu Desnoyers mathieu.desnoyers@effi=
cios.com wrote:
>=20
>> ----- On Jul 2, 2018, at 7:06 PM, Linus Torvalds torvalds@linux-foundatio=
n.org
>> wrote:
>>=20
>>> On Mon, Jul 2, 2018 at 4:00 PM Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>=20
>>>> Unfortunately, that rseq->rseq_cs field needs to be updated by user-spa=
ce
>>>> with single-copy atomicity. Therefore, we want 32-bit user-space to ini=
tialize
>>>> the padding with 0, and only update the low bits with single-copy atomi=
city.
>>>=20
>>> Well... It's actually still single-copy atomicity as a 64-bit value.
>>>=20
>>> Why? Because it doesn't matter how you write the upper bits. You'll be
>>> writing the same value to them (zero) anyway.
>>>=20
>>> So who cares if the write ends up being two instructions, because the
>>> write to the upper bits doesn't actually *do* anything.
>>>=20
>>> Hmm?
>>=20
>> Are there any kind of guarantees that a __u64 update on a 32-bit architec=
ture
>> won't be torn into something daft like byte-per-byte stores when performe=
d
>> from C code ?
>>=20
>> I don't worry whether the upper bits get updated or how, but I really car=
e
>> about not having store tearing of the low bits update.
>=20
> For the records, most updates of those low bits are done in assembly
> from critical sections, for which we control exactly how the update is
> performed.
>=20
> However, there is one helper function in user-space that updates that valu=
e
> from C through a volatile store, e.g.:
>=20
> static inline void rseq_prepare_unload(void)
> {
>        __rseq_abi.rseq_cs =3D 0;
> }

How about making the field be:

union {
 __u64 rseq_cs;
 struct {
   __u32 rseq_cs_low;
   __u32 rseq_cs_high;
 };
};

32-bit user code that cares about performance can just write to rseq_cs_low b=
ecause it already knows that rseq_cs_high =3D=3D 0.

The header could even supply a static inline helper write_rseq_cs() that ato=
mically writes a pointer and just does the right thing for 64-bit, for 32-bi=
t BE, and for 32-bit LE.

I think the union really is needed because we can=E2=80=99t rely on user cod=
e being built with -fno-strict-aliasing.  Or the helper could use inline asm=
.

Anyway, the point is that we get optimal code generation (a single instructi=
on write of the correct number of bits) without any compat magic in the kern=
el.

>=20
> Thanks,
>=20
> Mathieu
>=20
>>=20
>> Thanks,
>>=20
>> Mathieu
>>=20
>>=20
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
