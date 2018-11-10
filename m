Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED84C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F542081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xJ6x5klF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F542081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKJKFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:05:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40581 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:05:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so1639201pfm.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Q5ys4zFJlNKzV50YgO0Wmyj2fxv5QJNxoSlhlEUWeY=;
        b=xJ6x5klFMgp40xIzzJHE5iyuQSFgMevFUAkwoFO590txhgzIInIpb0XWZw+WCEBZli
         rAB3wCsK6l1BlHJ+oWmJnntKKB0/A10FXCBJAfqAmEIp/gsjjcTcOj7aIkD5l/y178P/
         5R3/J/qEgIcCTiWlA3r07ZlyiRC+0ppbb1xxBJmks/18fqP0HvqFrdMCMsBp0pyLv7bX
         R4RypQYxiT3geddH9mU7Snbaq6pwqwuS+c3vaeESVAnlnQGKe7y1bCyPrwrA7zDL1WXi
         D5Pv1tJosVlIcL4Osy81aHpnnNoEi+p3YjMpP13pw/uh31YWF/3yzRvsmcxoBGCKrUL3
         Qrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Q5ys4zFJlNKzV50YgO0Wmyj2fxv5QJNxoSlhlEUWeY=;
        b=WOhrQpsplhCBpsD8ZWTiRII8WrbxDFg8mkCwGPCHjxuVzk8Mab4QJYtPfRwFmwoeq1
         d/OFCRt7kJmhNEcQZal7uh7LopvrCUtjpLLb0IJ9wrlxLYis+OxTuMQpQhWYeb3KFge7
         /1vAmDuUUO7DznAyfcCVAwDYyUoYQnxv/CbI+XVwWGteaIa05yl3vwzX8OARdI6HqMVu
         17n9XBleoOj3OhYKwSQyDgl+ETDeD9eHw4syrObU9RzerHsEQta1VRBRA4CAUJQY8Zg8
         ZPQ2tEHq1nthQVzvccwkVRgFeB7AxJfPB3Fy+RJY2heRtcMFs/I+2V2cmYUFvq+E15/0
         glBQ==
X-Gm-Message-State: AGRZ1gKkhsHS4p5YcZhi5RvwGgCL0sVU3gtpMyBLsKFwOq6XcH3pJI77
        /LDPbKzmvaUWd+XxTXlK2WqEiQ==
X-Google-Smtp-Source: AJdET5fIDyiZMBIum6DyDvzvOKphO+BS+LFOdvu1YlCM8ieYahuCO60dgmz2U89nndNa3fIHMNDDZg==
X-Received: by 2002:a63:104d:: with SMTP id 13mr9378612pgq.303.1541809340299;
        Fri, 09 Nov 2018 16:22:20 -0800 (PST)
Received: from ?IPv6:2600:1010:b066:994c:3d32:b841:428e:7929? ([2600:1010:b066:994c:3d32:b841:428e:7929])
        by smtp.gmail.com with ESMTPSA id q11-v6sm7444823pgp.62.2018.11.09.16.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 16:22:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/mm/pat: Fix missing preemption disable for __native_flush_tlb()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Fri, 9 Nov 2018 16:22:15 -0800
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7590EF40-B0CF-40BD-9D29-FB731A2A2E3A@amacapital.net>
References: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 4:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:=

>=20
> Commit f77084d96355 "x86/mm/pat: Disable preemption around
> __flush_tlb_all()" addressed a case where __flush_tlb_all() is called
> without preemption being disabled. It also left a warning to catch other
> cases where preemption is not disabled. That warning triggers for the
> memory hotplug path which is also used for persistent memory enabling:

I don=E2=80=99t think I agree with the patch. If you call __flush_tlb_all() i=
n a context where you might be *migrated*, then there=E2=80=99s a bug. We co=
uld change the code to allow this particular use by checking that we haven=E2=
=80=99t done SMP init yet, perhaps.

>=20
> WARNING: CPU: 35 PID: 911 at ./arch/x86/include/asm/tlbflush.h:460
> RIP: 0010:__flush_tlb_all+0x1b/0x3a
> [..]
> Call Trace:
>  phys_pud_init+0x29c/0x2bb
>  kernel_physical_mapping_init+0xfc/0x219
>  init_memory_mapping+0x1a5/0x3b0
>  arch_add_memory+0x2c/0x50
>  devm_memremap_pages+0x3aa/0x610
>  pmem_attach_disk+0x585/0x700 [nd_pmem]
>=20
> Rather than audit all __flush_tlb_all() callers to add preemption, just
> do it internally to __flush_tlb_all().
>=20
> Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_al=
l()")
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> arch/x86/include/asm/tlbflush.h |    8 ++++----
> arch/x86/mm/pageattr.c          |    6 +-----
> 2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflu=
sh.h
> index d760611cfc35..049e0aca0fb5 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -454,11 +454,10 @@ static inline void __native_flush_tlb_one_user(unsig=
ned long addr)
> static inline void __flush_tlb_all(void)
> {
>    /*
> -     * This is to catch users with enabled preemption and the PGE feature=

> -     * and don't trigger the warning in __native_flush_tlb().
> +     *  Preemption needs to be disabled around __flush_tlb* calls
> +     *  due to CR3 reload in __native_flush_tlb().
>     */
> -    VM_WARN_ON_ONCE(preemptible());
> -
> +    preempt_disable();
>    if (boot_cpu_has(X86_FEATURE_PGE)) {
>        __flush_tlb_global();
>    } else {
> @@ -467,6 +466,7 @@ static inline void __flush_tlb_all(void)
>         */
>        __flush_tlb();
>    }
> +    preempt_enable();
> }
>=20
> /*
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index db7a10082238..f799076e3d57 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -2309,13 +2309,9 @@ void __kernel_map_pages(struct page *page, int nump=
ages, int enable)
>=20
>    /*
>     * We should perform an IPI and flush all tlbs,
> -     * but that can deadlock->flush only current cpu.
> -     * Preemption needs to be disabled around __flush_tlb_all() due to
> -     * CR3 reload in __native_flush_tlb().
> +     * but that can deadlock->flush only current cpu:
>     */
> -    preempt_disable();
>    __flush_tlb_all();
> -    preempt_enable();
>=20
>    arch_flush_lazy_mmu_mode();
> }
>=20
