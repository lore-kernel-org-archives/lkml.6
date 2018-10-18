Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A0ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D590221470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pSBbgTkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D590221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeJRJVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:21:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43292 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:21:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so13504180plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CNKY6X6m+9meeJ9A4/sQdVN14vNuok/Vvtg+Vs6OA+s=;
        b=pSBbgTkbISgCe50RGSxPw5bY0XJDKQ3MnYzH8uFINDpCMQkuXfDYFvUJhaIeFUs5dx
         XU0iEY/clIINmUg/ZNnS63EvtPbFPcLdZcIwb/qfHiXkZ6l3fw+GRORUACxqKGYlcas2
         ep9Z9N3vFCzeRKONWVOnmoKfQsVMvaUNrD2quB4uKN4UkZt9aKsOpvP46ZsMKuL1WJVO
         Zcdg4V/u3kkq59Z2NWC4MmhQxH+XKgD/aeIzEbiYFKvLVzQfcj5j6fU13jtmDrtm2WV4
         dTKpQWrLVWjbX+cIZx0EkPOwWCdQ+zlP03Q0N/cwvIGSNpo9MI2cD72+xcgOVzp5lR0Y
         KfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CNKY6X6m+9meeJ9A4/sQdVN14vNuok/Vvtg+Vs6OA+s=;
        b=LseSb6LgaXKaqq1JKCg6MLgTu2SEPhm87NcK4Xs3HwIqlANXqD0RkXPT/hi20tdb2l
         yYIoEZu6WX4QhFkvVQvIEPL8kuc6JGSqCszIfYi1twrPa/6QkL+XzXRlr/CI3Ufm+P0k
         TIx8oK4izTTshR/J7hTcO0tvw3y7r2HHLotXMnpbkTN1xIVqs2a1BU6XgogJG7/+Bcak
         2i4v1Cyge0aVQTnR6zjFq/SuFazAPt5oAH4d1W9WLFhQpl8mv7qle38DW4uS0c16zmFS
         JxSOFvv6FDG3nwVbVlbi5TzVmxViB1ZZW5SDjygJDiDqJ3NPT6SBOb/JhuUYGdA4FEKC
         35Dw==
X-Gm-Message-State: ABuFfoiDy+2qRh/koqwnbDiimzw2QeMp97bjyOBRhbQWQHTEOqlvD3er
        2leN2hYHf6SUZ9SG3X6e5G2xWg==
X-Google-Smtp-Source: ACcGV63vwZwfgKkjxRSONNlGCjT4i8jWL4OJueKVa+l9GSAkg4+Wh8jqnyD9jEyi/uJ+eC7tqJ8VVw==
X-Received: by 2002:a17:902:104:: with SMTP id 4-v6mr28348946plb.189.1539825772117;
        Wed, 17 Oct 2018 18:22:52 -0700 (PDT)
Received: from ?IPv6:2600:1010:b055:c039:8d1c:3674:f40d:d2a1? ([2600:1010:b055:c039:8d1c:3674:f40d:d2a1])
        by smtp.gmail.com with ESMTPSA id u79-v6sm35473255pfi.104.2018.10.17.18.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 18:22:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181018005420.82993-2-namit@vmware.com>
Date:   Wed, 17 Oct 2018 18:22:48 -0700
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
> It is sometimes beneficial to prevent preemption for very few
> instructions, or prevent preemption for some instructions that precede
> a branch (this latter case will be introduced in the next patches).
>=20
> To provide such functionality on x86-64, we use an empty REX-prefix
> (opcode 0x40) as an indication that preemption is disabled for the
> following instruction.

Nifty!

That being said, I think you have a few bugs.  First, you can=E2=80=99t just=
 ignore a rescheduling interrupt, as you introduce unbounded latency when th=
is happens =E2=80=94 you=E2=80=99re effectively emulating preempt_enable_no_=
resched(), which is not a drop-in replacement for preempt_enable(). To fix t=
his, you may need to jump to a slow-path trampoline that calls schedule() at=
 the end or consider rewinding one instruction instead. Or use TF, which is o=
nly a little bit terrifying...

You also aren=E2=80=99t accounting for the case where you get an exception t=
hat is, in turn, preempted.



>=20
> It is expected that this opcode is not in common use.
>=20
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
> arch/x86/entry/entry_64.S            | 10 ++++++++++
> arch/x86/include/asm/nospec-branch.h | 12 ++++++++++++
> 2 files changed, 22 insertions(+)
>=20
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index cb8a5893fd33..31d59aad496e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -643,6 +643,16 @@ retint_kernel:
>    jnc    1f
> 0:    cmpl    $0, PER_CPU_VAR(__preempt_count)
>    jnz    1f
> +
> +    /*
> +     * Allow to use hint to prevent preemption on a certain instruction.
> +     * Consider an instruction with the first byte having REX prefix
> +     * without any bits set as an indication for preemption disabled.
> +     */
> +    movq    RIP(%rsp), %rax
> +    cmpb    $PREEMPT_DISABLE_PREFIX, (%rax)
> +    jz    1f
> +
>    call    preempt_schedule_irq
>    jmp    0b
> 1:
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/n=
ospec-branch.h
> index 80dc14422495..0267611eb247 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -52,6 +52,12 @@
>    jnz    771b;                \
>    add    $(BITS_PER_LONG/8) * nr, sp;
>=20
> +/*
> + * An empty REX-prefix is an indication that preemption should not take p=
lace on
> + * this instruction.
> + */
> +#define PREEMPT_DISABLE_PREFIX                 (0x40)
> +
> #ifdef __ASSEMBLY__
>=20
> /*
> @@ -148,6 +154,12 @@
> #endif
> .endm
>=20
> +.macro preempt_disable_prefix
> +#ifdef CONFIG_PREEMPT
> +    .byte    PREEMPT_DISABLE_PREFIX
> +#endif
> +.endm
> +
> #else /* __ASSEMBLY__ */
>=20
> #define ANNOTATE_NOSPEC_ALTERNATIVE                \
> --=20
> 2.17.1
>=20
