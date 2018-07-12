Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A182DECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2E5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vl+ZUkvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbeGLVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:21:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33177 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbeGLVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:21:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so21309987pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C9oAAN6d0KQttB3PlqRW7XEAiEavtht8apfJgwDSfXY=;
        b=vl+ZUkvq0Xs4OaJFSP9Nf3BEPU/kaM5gA89kl5MpLQCsohCo1KE0P44yBMpwBmwADE
         EsqmbcHPlJFWmsKvZp4JaS6zcu31L5Hmw7Pvnr51MekQTqKigabMum744wNDglsy8JSl
         IFHL4laQUffn/E8cPoswx1VENHzHOkSBuqVRSHDlSd5UmN0UnMjtnFBEuIEh5kMz5d/f
         LisDo+K+pgA/fjqKGDBLHzwE6bOoOuv18rr8BPMnmxwb8+pNkw2vSVNj2kDX2ukKbZEW
         fmWS2QelQSUGlZlpc978rwptUP8VyJNhaCJ5OCiAQNesanluKQqvIx95Ry824VqbY8Ea
         Ef4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C9oAAN6d0KQttB3PlqRW7XEAiEavtht8apfJgwDSfXY=;
        b=dL6RPt76f777oRn0V7Y568Mv3oNMgaZF8GrQbhEaBTM4390gvmb2TTNytDcN7FmfuW
         KTZ6Jtr8QlcxjorZWEpah31nJv03GhVBbJAbwl3gaFdx3bRd4BSO7N+v8O7iG9fJ1wOg
         aBUnTQMxlU0GLZ4JLIrYNoKGjzCWjkKiRH4KNse3oGTQCpVWAIcWEcbWDzEGgv06Qash
         sWxuxM4r1jzUPieb/ouiOM/Lk2Ko1yYUkbK3SCIMTgZdwvl+pBLQwPs1W6WKxm4bBDOL
         2Ubl/M1C8gBx2OCMkcJvrOLt+4raRUV5ApLOZRRsgiWcBzQesPvOc+ro6T+kBXpEymX6
         zfAg==
X-Gm-Message-State: AOUpUlEVbEg9MmbqL3kVIMEcclmdo+Sl2AP7dOKArbqGqdxQUJWglx3k
        QLi7GjL4Vr/9OFvL9lSJujuGdQ==
X-Google-Smtp-Source: AAOMgpeEjwB7mSMrEjYvqtcjaryrK/5btJhCASwlIVcnLAJJGRT8H/n5rmPajEEhlg+fQoM2+HTdMQ==
X-Received: by 2002:a62:3d41:: with SMTP id k62-v6mr4054180pfa.35.1531429787820;
        Thu, 12 Jul 2018 14:09:47 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id p26-v6sm42889968pfi.164.2018.07.12.14.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 14:09:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1531308586-29340-8-git-send-email-joro@8bytes.org>
Date:   Thu, 12 Jul 2018 14:09:45 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A66D58A6-3DC6-4CF3-B2A5-433C6E974060@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-8-git-send-email-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Use the entry-stack as a trampoline to enter the kernel. The
> entry-stack is already in the cpu_entry_area and will be
> mapped to userspace when PTI is enabled.
>=20
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> arch/x86/entry/entry_32.S        | 136 +++++++++++++++++++++++++++++++----=
----
> arch/x86/include/asm/switch_to.h |   6 +-
> arch/x86/kernel/asm-offsets.c    |   1 +
> arch/x86/kernel/cpu/common.c     |   5 +-
> arch/x86/kernel/process.c        |   2 -
> arch/x86/kernel/process_32.c     |  10 +--
> 6 files changed, 121 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 61303fa..528db7d 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -154,25 +154,36 @@
>=20
> #endif /* CONFIG_X86_32_LAZY_GS */
>=20
> -.macro SAVE_ALL pt_regs_ax=3D%eax
> +.macro SAVE_ALL pt_regs_ax=3D%eax switch_stacks=3D0
>    cld
> +    /* Push segment registers and %eax */
>    PUSH_GS
>    pushl    %fs
>    pushl    %es
>    pushl    %ds
>    pushl    \pt_regs_ax
> +
> +    /* Load kernel segments */
> +    movl    $(__USER_DS), %eax

If \pt_regs_ax !=3D %eax, then this will behave oddly. Maybe it=E2=80=99s ok=
ay. But I don=E2=80=99t see why this change was needed at all.

> +    movl    %eax, %ds
> +    movl    %eax, %es
> +    movl    $(__KERNEL_PERCPU), %eax
> +    movl    %eax, %fs
> +    SET_KERNEL_GS %eax
> +
> +    /* Push integer registers and complete PT_REGS */
>    pushl    %ebp
>    pushl    %edi
>    pushl    %esi
>    pushl    %edx
>    pushl    %ecx
>    pushl    %ebx
> -    movl    $(__USER_DS), %edx
> -    movl    %edx, %ds
> -    movl    %edx, %es
> -    movl    $(__KERNEL_PERCPU), %edx
> -    movl    %edx, %fs
> -    SET_KERNEL_GS %edx
> +
> +    /* Switch to kernel stack if necessary */
> +.if \switch_stacks > 0
> +    SWITCH_TO_KERNEL_STACK
> +.endif
> +
> .endm
>=20
> /*
> @@ -269,6 +280,72 @@
> .Lend_\@:
> #endif /* CONFIG_X86_ESPFIX32 */
> .endm
> +
> +
> +/*
> + * Called with pt_regs fully populated and kernel segments loaded,
> + * so we can access PER_CPU and use the integer registers.
> + *
> + * We need to be very careful here with the %esp switch, because an NMI
> + * can happen everywhere. If the NMI handler finds itself on the
> + * entry-stack, it will overwrite the task-stack and everything we
> + * copied there. So allocate the stack-frame on the task-stack and
> + * switch to it before we do any copying.

Ick, right. Same with machine check, though. You could alternatively fix it b=
y running NMIs on an irq stack if the irq count is zero.  How confident are y=
ou that you got #MC right?

> + */
> +.macro SWITCH_TO_KERNEL_STACK
> +
> +    ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
> +
> +    /* Are we on the entry stack? Bail out if not! */
> +    movl    PER_CPU_VAR(cpu_entry_area), %edi
> +    addl    $CPU_ENTRY_AREA_entry_stack, %edi
> +    cmpl    %esp, %edi
> +    jae    .Lend_\@

That=E2=80=99s an alarming assumption about the address space layout. How ab=
out an xor and an and instead of cmpl?  As it stands, if the address layout e=
ver changes, the failure may be rather subtle.

Anyway, wouldn=E2=80=99t it be easier to solve this by just not switching st=
acks on entries from kernel mode and making the entry stack bigger?  Stick a=
n assertion in the scheduling code that we=E2=80=99re not on an entry stack,=
 perhaps.

