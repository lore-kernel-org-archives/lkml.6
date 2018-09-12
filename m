Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59342088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MJA9QGAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59342088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeILU3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:29:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35188 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeILU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:29:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so1243990pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l528uxAgWFSL5tVGTDhS0RKhVSftA2wtAgPpq8U72rU=;
        b=MJA9QGAiWQZyutSyrxbahF6RDzUacK+elhd03O3vyKgNbPTkejDQGj1lfl9r8t7dnn
         /c1+h/CX7yV1qV/wdu9/6Qddkn/4KUZroWTQs8qoPoaRFu6lD2Ixdrbtv95NFh7xy7XN
         N4EknBtbcdP0er1dxuUzBrTpHoDtmV68NNJobV7L5gl7vCRhcF/0I0/WY1aSyfv6ABFj
         8RqafjDvQliHEkz9m3nwkJPRDroDkHG9YnBCkaDddVrZ2b/U8j9WaSpt9YyzY4YKaoyY
         EVg4zFqMyS7hfLtj6qVHvKvTt/HSRsCxN2AZSXf8T+2gMlq+KJJQPNpaYOylnKAFPYde
         1n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l528uxAgWFSL5tVGTDhS0RKhVSftA2wtAgPpq8U72rU=;
        b=tR4WBrxuc5UnAKbqyR7aqTBpO6zKnB7JGmHOiSbHLGG2OX8GUqSkYTrg/IcO1vjQDR
         hH8EEyKiPsNkvvqzFbXEPYMwI4rfXzRmWWbR50iA2KUoE/Not+LVtlGb1oMOWj5j1u7J
         HuA8LQS1WGSJCftHEdDfJHOKTxK+g3Yo5hZIEkL8EiRQZ30Y8InoiNDm/ZJutKbayJsO
         Bv6DrRDk+DARNAihqhkojiNu32z1D8+CRkEgLuN4/C6vm+vmQITbR6guoOJyMdcpQiy0
         8PxoXH7jSXhQaGizK8vtIUCk5FSZxadpav0XVu3rwNhs2Swk/Zn+VmNgMVEnRqjJkIJq
         b/iQ==
X-Gm-Message-State: APzg51CW4PhoOJQAmx83vZgQh1qppNR3+bhAOYhZwC3T55H/PLXcrKXp
        EBXBAfXLQYr9aWc+AYawTUUmAQ==
X-Google-Smtp-Source: ANB0VdaW0mCDWoKpY2SAtil5aI7w8y5jxGnwwHnBnjszsREOGJz0CA0TS9fgOcyu/dM+CA289Lhayg==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr2927103pgb.136.1536765850802;
        Wed, 12 Sep 2018 08:24:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:9592:4a20:451a:68da? ([2601:646:c200:7429:9592:4a20:451a:68da])
        by smtp.gmail.com with ESMTPSA id t2-v6sm2563077pfj.7.2018.09.12.08.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:24:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 04/10] x86/fpu: eager switch PKRU state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
Date:   Wed, 12 Sep 2018 08:24:08 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3476ED25-96C7-4285-AF1D-7FB82E10FB6C@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-5-bigeasy@linutronix.de> <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Sep 12, 2018, at 7:18 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 12/09/2018 15:33, Sebastian Andrzej Siewior wrote:
>> From: Rik van Riel <riel@surriel.com>
>>=20
>> While most of a task's FPU state is only needed in user space,
>> the protection keys need to be in place immediately after a
>> context switch.
>>=20
>> The reason is that any accesses to userspace memory while running
>> in kernel mode also need to abide by the memory permissions
>> specified in the protection keys.
>>=20
>> The pkru info is put in its own cache line in the fpu struct because
>> that cache line is accessed anyway at context switch time, and the
>> location of the pkru info in the xsave buffer changes depending on
>> what other FPU registers are in use if the CPU uses compressed xsave
>> state (on by default).
>>=20
>> The initial state of pkru is zeroed out automatically by fpstate_init.
>>=20
>> Signed-off-by: Rik van Riel <riel@surriel.com>
>> [bigeasy: load PKRU state only if we also load FPU content]
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> arch/x86/include/asm/fpu/internal.h | 11 +++++++++--
>> arch/x86/include/asm/fpu/types.h    | 10 ++++++++++
>> arch/x86/include/asm/pgtable.h      |  6 +-----
>> arch/x86/mm/pkeys.c                 | 14 ++++++++++++++
>> 4 files changed, 34 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/f=
pu/internal.h
>> index 16c4077ffc945..57bd1576e033d 100644
>> --- a/arch/x86/include/asm/fpu/internal.h
>> +++ b/arch/x86/include/asm/fpu/internal.h
>> @@ -573,8 +573,15 @@ static inline void switch_fpu_finish(struct fpu *new=
_fpu, int cpu)
>>    bool preload =3D static_cpu_has(X86_FEATURE_FPU) &&
>>               new_fpu->initialized;
>>=20
>> -    if (preload)
>> -        __fpregs_load_activate(new_fpu, cpu);
>> +    if (!preload)
>> +        return;
>> +
>> +    __fpregs_load_activate(new_fpu, cpu);
>> +    /* Protection keys need to be in place right at context switch time.=
 */
>> +    if (boot_cpu_has(X86_FEATURE_OSPKE)) {
>> +        if (new_fpu->pkru !=3D __read_pkru())
>> +            __write_pkru(new_fpu->pkru);
>> +    }
>> }
>>=20
>> /*
>> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/=
types.h
>> index 202c53918ecfa..6fa58d37938d2 100644
>> --- a/arch/x86/include/asm/fpu/types.h
>> +++ b/arch/x86/include/asm/fpu/types.h
>> @@ -293,6 +293,16 @@ struct fpu {
>>     */
>>    unsigned int            last_cpu;
>>=20
>> +    /*
>> +     * Protection key bits. These also live inside fpu.state.xsave,
>> +     * but the location varies if the CPU uses the compressed format
>> +     * for XSAVE(OPT).
>> +     *
>> +     * The protection key needs to be switched out immediately at contex=
t
>> +     * switch time, so it is in place for things like copy_to_user.
>> +     */
>> +    unsigned int            pkru;
>> +
>>    /*
>>     * @initialized:
>>     *
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
>> index 690c0307afed0..cc36f91011ad7 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -132,11 +132,7 @@ static inline u32 read_pkru(void)
>>    return 0;
>> }
>>=20
>> -static inline void write_pkru(u32 pkru)
>> -{
>> -    if (boot_cpu_has(X86_FEATURE_OSPKE))
>> -        __write_pkru(pkru);
>> -}
>> +extern void write_pkru(u32 pkru);
>>=20
>> static inline int pte_young(pte_t pte)
>> {
>> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
>> index 6e98e0a7c9231..c7a7b6bd64009 100644
>> --- a/arch/x86/mm/pkeys.c
>> +++ b/arch/x86/mm/pkeys.c
>> @@ -18,6 +18,20 @@
>>=20
>> #include <asm/cpufeature.h>             /* boot_cpu_has, ...            *=
/
>> #include <asm/mmu_context.h>            /* vma_pkey()                   *=
/
>> +#include <asm/fpu/internal.h>
>> +
>> +void write_pkru(u32 pkru)
>> +{
>> +    if (!boot_cpu_has(X86_FEATURE_OSPKE))
>> +        return;
>> +
>> +    current->thread.fpu.pkru =3D pkru;
>> +
>> +    __fpregs_changes_begin();
>> +    __fpregs_load_activate(&current->thread.fpu, smp_processor_id());
>> +    __write_pkru(pkru);
>> +    __fpregs_changes_end();
>> +}
>>=20
>> int __execute_only_pkey(struct mm_struct *mm)
>> {
>>=20
>=20
> I think you can go a step further and exclude PKRU state from
> copy_kernel_to_fpregs altogether; you just use RDPKRU/WRPKRU.  This also
> means you don't need to call __fpregs_* functions in write_pkru.
>=20
>=20

Except that the signal ABI has PKRU in the xstate. So we=E2=80=99d need to f=
ake it or do something special for signals.=
