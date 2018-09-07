Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3356C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CF120855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Y8dHiSaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CF120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeIHDEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:04:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39746 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:04:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7639492pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q7islqfOh+5ZJyMNFsPkSN7SKBhbtTChKbQYnekl0yU=;
        b=Y8dHiSaYA0dyBG0N9Fz6X1+vYaGok95F/UMNkBbevIYwP5eshJ/Nti4NgNDsDvRzOA
         QoYjqxpeB4bWj5c22Mur56D+atsUJTZ8NYbHmR8sTTNbSESoWZisoIfeqUIvmiXYPMP7
         Ly5HaOkHMQDHVZ+WQBRl9yw/MVdOG23RhDDN6TPg4D1Tx8GzKrk9WUdbGVZSt3wxf3p1
         rB4BcOYTa9OF09kGwGnydRI/cMhaQnGX7UhI2XxhZbY5Nk6fvkRkJT9mT8bNyoI6SZdf
         Y4AFuUtM2+zPWhmnkW+/ltgQ8iPKVxQais6csQwdwbysc5cLxo0sKZ5v3cfEl0BhTWxj
         w/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q7islqfOh+5ZJyMNFsPkSN7SKBhbtTChKbQYnekl0yU=;
        b=fakkitvXsADNltQaHUzJLB1sZcoZX5sRMWhDgpBsWr2B40qnJjt4rdwBGUuDN0mph7
         8nEKM3epZpTylWXY5Odtu6vsLENsx2DyPbbHYhJ7WQRof/rYhzG+vpjGTn/iNZ7tlMju
         RYRMqNDuc6kXqwvhXixPl8AOjkfPlol01lNCQxscCnnD4IKF975FCSw5t2d0EYrm2O8t
         nvZHj3CRdF6BqcOGXhNZJvvjuy8tXZzpgK+eo55GSK9wazsPTUmubdKxuhK41drlwECe
         ic5IO1TTqUTpbEC36Bjl2nJsDBsFp7kG3JjZ+e1NYvK5ukD0W4eNBBHSx43+vCV6x+ER
         VKlA==
X-Gm-Message-State: APzg51Anve4XY+C4N0M+QJ5boAE0Ef6P84QBUxKHX7DEfKMuMR9Eu4rs
        LA3CVjv6/thmFcFjes/E3fS+Hg==
X-Google-Smtp-Source: ANB0VdZ+avLLMcYHYQ8hPlf2R3rEhW+J1Cx/0Og5CspnALvIKoz0/WJ4fNTHRsZ6oUo2PPIwz3ExUg==
X-Received: by 2002:a63:de10:: with SMTP id f16-v6mr10379609pgg.97.1536358903968;
        Fri, 07 Sep 2018 15:21:43 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00f:e51c:f116:5740:3e1:4abe? ([2600:1010:b00f:e51c:f116:5740:3e1:4abe])
        by smtp.gmail.com with ESMTPSA id 70-v6sm13300258pfz.27.2018.09.07.15.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 15:21:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 2/8] x86/mm: break out kernel address space handling
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180907194855.74E03836@viggo.jf.intel.com>
Date:   Fri, 7 Sep 2018 15:21:41 -0700
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD6177E3-BDE5-443F-9A28-351EAE0BE5BA@amacapital.net>
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194855.74E03836@viggo.jf.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 7, 2018, at 12:48 PM, Dave Hansen <dave.hansen@linux.intel.com> wro=
te:
>=20
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The page fault handler (__do_page_fault())  basically has two sections:
> one for handling faults in the kernel porttion of the address space
> and another for faults in the user porttion of the address space.
>=20
> But, these two parts don't stick out that well.  Let's make that more
> clear from code separation and naming.  Pull kernel fault
> handling into its own helper, and reflect that naming by renaming
> spurious_fault() -> spurious_kernel_fault().
>=20
> Also, rewrite the vmalloc handling comment a bit.  It was a bit
> stale and also glossed over the reserved bit handling.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>=20
> b/arch/x86/mm/fault.c |   98 ++++++++++++++++++++++++++++++---------------=
-----
> 1 file changed, 59 insertions(+), 39 deletions(-)
>=20
> diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-00 arch/x86/mm/fault.c
> --- a/arch/x86/mm/fault.c~pkeys-fault-warnings-00    2018-09-07 11:21:46.1=
45751902 -0700
> +++ b/arch/x86/mm/fault.c    2018-09-07 11:23:37.643751624 -0700
> @@ -1033,7 +1033,7 @@ mm_fault_error(struct pt_regs *regs, uns
>    }
> }
>=20
> -static int spurious_fault_check(unsigned long error_code, pte_t *pte)
> +static int spurious_kernel_fault_check(unsigned long error_code, pte_t *p=
te)
> {
>    if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
>        return 0;
> @@ -1072,7 +1072,7 @@ static int spurious_fault_check(unsigned
>  * (Optional Invalidation).
>  */
> static noinline int
> -spurious_fault(unsigned long error_code, unsigned long address)
> +spurious_kernel_fault(unsigned long error_code, unsigned long address)
> {
>    pgd_t *pgd;
>    p4d_t *p4d;
> @@ -1103,27 +1103,27 @@ spurious_fault(unsigned long error_code,
>        return 0;
>=20
>    if (p4d_large(*p4d))
> -        return spurious_fault_check(error_code, (pte_t *) p4d);
> +        return spurious_kernel_fault_check(error_code, (pte_t *) p4d);
>=20
>    pud =3D pud_offset(p4d, address);
>    if (!pud_present(*pud))
>        return 0;
>=20
>    if (pud_large(*pud))
> -        return spurious_fault_check(error_code, (pte_t *) pud);
> +        return spurious_kernel_fault_check(error_code, (pte_t *) pud);
>=20
>    pmd =3D pmd_offset(pud, address);
>    if (!pmd_present(*pmd))
>        return 0;
>=20
>    if (pmd_large(*pmd))
> -        return spurious_fault_check(error_code, (pte_t *) pmd);
> +        return spurious_kernel_fault_check(error_code, (pte_t *) pmd);
>=20
>    pte =3D pte_offset_kernel(pmd, address);
>    if (!pte_present(*pte))
>        return 0;
>=20
> -    ret =3D spurious_fault_check(error_code, pte);
> +    ret =3D spurious_kernel_fault_check(error_code, pte);
>    if (!ret)
>        return 0;
>=20
> @@ -1131,12 +1131,12 @@ spurious_fault(unsigned long error_code,
>     * Make sure we have permissions in PMD.
>     * If not, then there's a bug in the page tables:
>     */
> -    ret =3D spurious_fault_check(error_code, (pte_t *) pmd);
> +    ret =3D spurious_kernel_fault_check(error_code, (pte_t *) pmd);
>    WARN_ONCE(!ret, "PMD has incorrect permission bits\n");
>=20
>    return ret;
> }
> -NOKPROBE_SYMBOL(spurious_fault);
> +NOKPROBE_SYMBOL(spurious_kernel_fault);
>=20
> int show_unhandled_signals =3D 1;
>=20
> @@ -1203,6 +1203,55 @@ static inline bool smap_violation(int er
>    return true;
> }
>=20
> +static void
> +do_kern_addr_space_fault(struct pt_regs *regs, unsigned long hw_error_cod=
e,
> +             unsigned long address)
> +{

Can you add a comment above this documenting *when* it=E2=80=99s called?  Is=
 it all faults, !user_mode faults, or !PF_USER?

> +    /*
> +     * We can fault-in kernel-space virtual memory on-demand. The
> +     * 'reference' page table is init_mm.pgd.
> +     *
> +     * NOTE! We MUST NOT take any locks for this case. We may
> +     * be in an interrupt or a critical region, and should
> +     * only copy the information from the master page table,
> +     * nothing more.
> +     *
> +     * Before doing this on-demand faulting, ensure that the
> +     * fault is not any of the following:
> +     * 1. A fault on a PTE with a reserved bit set.
> +     * 2. A fault caused by a user-mode access.  (Do not demand-
> +     *    fault kernel memory due to user-mode accesses).
> +     * 3. A fault caused by a page-level protection violation.
> +     *    (A demand fault would be on a non-present page which
> +     *     would have X86_PF_PROT=3D=3D0).
> +     */
> +    if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
> +        if (vmalloc_fault(address) >=3D 0)
> +            return;
> +    }
> +
> +    /* Was the fault spurious, caused by lazy TLB invalidation? */
> +    if (spurious_kernel_fault(hw_error_code, address))
> +        return;
> +
> +    /* kprobes don't want to hook the spurious faults: */
> +    if (kprobes_fault(regs))
> +        return;
> +
> +    /*
> +     * This is a "bad" fault in the kernel address space.  There
> +     * is no reasonable explanation for it.  We will either kill
> +     * the process for making a bad access, or oops the kernel.
> +     */

Or call an extable handler?

Maybe the wording should be less scary, e.g. =E2=80=9Cthis fault is a genuin=
e error. Send a signal, call an exception handler, or oops, as appropriate.=E2=
=80=9D

