Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726AECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C48208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PDpik4TR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C48208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbeGLU4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:56:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38741 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbeGLU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:56:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so4242096pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sp0ZEe9xEry08NpaHCB0cPGumuA0C3lQIgu4ezSHUPQ=;
        b=PDpik4TR7Uphl/n8gNYeBuqsSyyJIA24Dd3EmIQ7U99iMbyO+JrlwFIDn16Onyyejm
         WTVVfpNveILnaon1Sfc32945oh1CRBLZ/AzYaArFgPPQ5IIdT57o3Wxc7TNaFn/nGRmY
         uOO4wLAadvG8Ecdwtqrfwh2owow1s1KpnAA8B9eMGH3sJV3l/E5m5dIaACLQcFZjNpEY
         uzgBtL08a97vUaXot0kmXq9Iz6xQB2WY7YLxrPVA/UIAv/nqhyeSUo1Gw85rsvVKbBcM
         +wsrm54bSRP4lio0xtTUA/3uUxXs8JQI898viT8zq7mBGIe4fQqUbun2nEJ97Pk59G5E
         nibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sp0ZEe9xEry08NpaHCB0cPGumuA0C3lQIgu4ezSHUPQ=;
        b=J3Ptp/WrUDXdW1ZdOirLsDMGvvHWI8en2ET1Q/wXBoPXDbA/L+mF6u1TdwbFjO+usO
         pf9q4qfPmpotlY5qyulgu9cCpUwN/FeX+QpC0ZDEMAzLr/toFvKLpfLDB03y+ZZk8zW0
         CiJcDqHtZOQHKtdmBkr+apYoZ/sgsQohoKeXFI1FA3LpaMjeI8DxZma3/3qzzDy5Bppa
         LLVEblQ0bTI8JJxJDVMDCnFse0b9NUyI7TsSzuUJrBdv/QZwtr14SIxgRwGDSsmMCP7Z
         l38I6aBNPviyEjcHA6sbQayd5jwt0rvJxmsWLjMwHbsle05dXoqsLfWtBYEBogw/LYgB
         q5mg==
X-Gm-Message-State: AOUpUlF7QrJ19B4NISwPXxAA7i30+Ag2e/t3tMxk6lxMUNbXyMvL9Nel
        aoPfiLw5vAIznV5HAon+U0Wblg==
X-Google-Smtp-Source: AAOMgpe5strWJuVdv+7UyTAt1bB6Q3SDWFErCGbabOb4jh0vx6c5AG1hReuox3rODx6kWfGy+RHDng==
X-Received: by 2002:a65:60cd:: with SMTP id r13-v6mr3467138pgv.232.1531428291847;
        Thu, 12 Jul 2018 13:44:51 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id i12-v6sm34268204pgd.87.2018.07.12.13.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:44:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 01/39] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1531308586-29340-2-git-send-email-joro@8bytes.org>
Date:   Thu, 12 Jul 2018 13:44:49 -0700
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
Message-Id: <29DEB3A0-223F-4C28-920B-0C1C918F2B56@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-2-git-send-email-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> These offsets will be used in 32 bit assembly code as well,
> so make them available for all of x86 code.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

>=20
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> arch/x86/kernel/asm-offsets.c    | 4 ++++
> arch/x86/kernel/asm-offsets_64.c | 2 --
> 2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c=

> index dcb008c..a1e1628 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -103,4 +103,8 @@ void common(void) {
>    OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampolin=
e);
>    OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
>    DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
> +
> +    /* Offset for sp0 and sp1 into the tss_struct */
> +    OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
> +    OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
> }
> diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offset=
s_64.c
> index b2dcd16..3b9405e 100644
> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -65,8 +65,6 @@ int main(void)
> #undef ENTRY
>=20
>    OFFSET(TSS_ist, tss_struct, x86_tss.ist);
> -    OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
> -    OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
>    BLANK();
>=20
> #ifdef CONFIG_STACKPROTECTOR
> --=20
> 2.7.4
>=20
