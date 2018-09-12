Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F51C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vNr0mSCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE5D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeILUZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:25:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:25:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so1165711pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WmLrXk+E+zE56CjuEPdDv8xIv1SWae8ROpdOG1IWbgI=;
        b=vNr0mSCl5aok/ExmleNx/HLCmE/2BNUI08zVli+S0k7QRECY6+RlsDx84Gs1YID5f/
         v6N2Yetq0IakzBabNkZ54SO8I658enOgb7BqTzOLCx33GKMOfJqfWkObw46PQmW8QdHY
         x7pb3vI5xuUpmkIJ5vh5+Vah+cdzMcgMPhrl13Q2an58G4xFVVOek5Iob2tXnpcBTNhY
         GLjSel1bP+W/2urQvL9w8RgHxQv0j8ImP8tRZ0bQXfKRUDuhvOgTUQtXjZfzwHyUzlgK
         yxeQPVnx7GY8phyDHl7xCAEa/dKB5lttN0ocpfyMh1LUg7bhbdwqgvVydtktQuqzjrIN
         2NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WmLrXk+E+zE56CjuEPdDv8xIv1SWae8ROpdOG1IWbgI=;
        b=dcG3vR4m1awjQkMv3QQ+vLwQAiNVDfvqBPKshhUPErTFNKQH8Inh/D+AXB1vbE/AMK
         YpK42yF4sUWKwrU3GEs76QeJoppzxPYbes1Ifvm1lgpmJC/3YpcS2IBPAakMv9+mSllp
         biVIurhO2JQzEx3LuWMBfyCe7n+RPesF8b9dcMV29SGB487LaXgqafSf0o3qIBf+vXSU
         98zRP5mbSicKS5tOQt2/j+qw8+ZNwcs2PoayqA+owa0yGMcj6q40bD4TbFdc/rC+T2/W
         O0kwZLs9kUyHMzdNgwGsQGdm0o0+X2SkKpTqChAh0G/5z/a1ED4DRDU3oI8natEUOfoi
         w5AQ==
X-Gm-Message-State: APzg51CpKMcuMpZ1jCk7hqt/lt5+yAbTUyIioOwaqIsbqzNcwR1hALwX
        KcMOZkppPcSx5cTUm//CCWHtNA==
X-Google-Smtp-Source: ANB0VdYMQcZ5J6G2+JnZTtshlmp8ERQTFcARi3alP60VlFBpG6ba2YpSIvaExlLz/9+zsqE3tjLQcQ==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr2917464pge.325.1536765650228;
        Wed, 12 Sep 2018 08:20:50 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:9592:4a20:451a:68da? ([2601:646:c200:7429:9592:4a20:451a:68da])
        by smtp.gmail.com with ESMTPSA id v23-v6sm2471089pfm.80.2018.09.12.08.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:20:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 04/10] x86/fpu: eager switch PKRU state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180912133353.20595-5-bigeasy@linutronix.de>
Date:   Wed, 12 Sep 2018 08:20:48 -0700
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <181B4EB8-9FEB-415C-8069-192FB8A5B418@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-5-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 12, 2018, at 6:33 AM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> From: Rik van Riel <riel@surriel.com>
>=20
> While most of a task's FPU state is only needed in user space,
> the protection keys need to be in place immediately after a
> context switch.
>=20
> The reason is that any accesses to userspace memory while running
> in kernel mode also need to abide by the memory permissions
> specified in the protection keys.
>=20
> The pkru info is put in its own cache line in the fpu struct because
> that cache line is accessed anyway at context switch time, and the
> location of the pkru info in the xsave buffer changes depending on
> what other FPU registers are in use if the CPU uses compressed xsave
> state (on by default).
>=20
> The initial state of pkru is zeroed out automatically by fpstate_init.
>=20
> Signed-off-by: Rik van Riel <riel@surriel.com>
> [bigeasy: load PKRU state only if we also load FPU content]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/x86/include/asm/fpu/internal.h | 11 +++++++++--
> arch/x86/include/asm/fpu/types.h    | 10 ++++++++++
> arch/x86/include/asm/pgtable.h      |  6 +-----
> arch/x86/mm/pkeys.c                 | 14 ++++++++++++++
> 4 files changed, 34 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fp=
u/internal.h
> index 16c4077ffc945..57bd1576e033d 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -573,8 +573,15 @@ static inline void switch_fpu_finish(struct fpu *new_=
fpu, int cpu)
>    bool preload =3D static_cpu_has(X86_FEATURE_FPU) &&
>               new_fpu->initialized;
>=20
> -    if (preload)
> -        __fpregs_load_activate(new_fpu, cpu);
> +    if (!preload)
> +        return;
> +
> +    __fpregs_load_activate(new_fpu, cpu);
> +    /* Protection keys need to be in place right at context switch time. *=
/
> +    if (boot_cpu_has(X86_FEATURE_OSPKE)) {
> +        if (new_fpu->pkru !=3D __read_pkru())
> +            __write_pkru(new_fpu->pkru);
> +    }
> }
>=20
> /*
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/t=
ypes.h
> index 202c53918ecfa..6fa58d37938d2 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -293,6 +293,16 @@ struct fpu {
>     */
>    unsigned int            last_cpu;
>=20
> +    /*
> +     * Protection key bits. These also live inside fpu.state.xsave,
> +     * but the location varies if the CPU uses the compressed format
> +     * for XSAVE(OPT).
> +     *
> +     * The protection key needs to be switched out immediately at context=

> +     * switch time, so it is in place for things like copy_to_user.
> +     */
> +    unsigned int            pkru;
> +
>    /*
>     * @initialized:
>     *
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable=
.h
> index 690c0307afed0..cc36f91011ad7 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -132,11 +132,7 @@ static inline u32 read_pkru(void)
>    return 0;
> }
>=20
> -static inline void write_pkru(u32 pkru)
> -{
> -    if (boot_cpu_has(X86_FEATURE_OSPKE))
> -        __write_pkru(pkru);
> -}
> +extern void write_pkru(u32 pkru);
>=20
> static inline int pte_young(pte_t pte)
> {
> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 6e98e0a7c9231..c7a7b6bd64009 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -18,6 +18,20 @@
>=20
> #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */=

> #include <asm/mmu_context.h>            /* vma_pkey()                   */=

> +#include <asm/fpu/internal.h>
> +
> +void write_pkru(u32 pkru)
> +{
> +    if (!boot_cpu_has(X86_FEATURE_OSPKE))
> +        return;
> +
> +    current->thread.fpu.pkru =3D pkru;
> +

I thought that the offset of PKRU in the xstate was fixed after boot.

Anyway, as written, this needs a lockdep assertion that we=E2=80=99re not pr=
eemptible, an explicit preempt_disable(), or a comment explaining why it=E2=80=
=99s okay if we get preempted in this function.

> +    __fpregs_changes_begin();
> +    __fpregs_load_activate(&current->thread.fpu, smp_processor_id());
> +    __write_pkru(pkru);
> +    __fpregs_changes_end();
> +}
>=20
> int __execute_only_pkey(struct mm_struct *mm)
> {
> --=20
> 2.19.0
>=20
