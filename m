Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711092084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="o4dxfANf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711092084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbeKFHSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:18:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39473 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeKFHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:18:18 -0500
Received: by mail-it1-f196.google.com with SMTP id m15so14936276itl.4;
        Mon, 05 Nov 2018 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuoEkcPaaKEoAr7kvlDP7foblHJ0VoV73clr85kZxIk=;
        b=o4dxfANf6L/+CrVm5SMrZAo8V+2nzwHMOtau02KWO8kyuPgZJOsBTewOo+E3kMQxEL
         AxST26S3bCM4edAmXmXtrTARLIXGQmGxKTg4muy5cWWcJyn2zN3AFinX6oVVOpKu/T6v
         GNbgmMclZ5S1Sp2/VKp8UgaSw6jhY4tiuPzt5OB7rr6d7hfWHr/tYP5Z0DKUhp2w+jcF
         +tK2KlZfs5ZWazW4oOtL9NTxE+n+nVup33rOxqGIaR2yZ8tVbbRU7m+LAp+6Ti0HKQuT
         Iii8t1VVqLrkJ6h3kID+BFNO+0AsqrxQ8iKjywsqWDyo6sC6ZzawvhLhZJe5JWxTcDEb
         rxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuoEkcPaaKEoAr7kvlDP7foblHJ0VoV73clr85kZxIk=;
        b=ED4+Z54/gqshrrG6fmV8pLuqx9mDbRhkNMj9thpy+ExpFAikatD3zAh5OW0sibdmxB
         oNTROFLbh0CRObzEDcumVx3lw4yeF0SI/YeusuoDmOQM+s8n+pO8K+UHbOOwNI5OXMci
         M61a4rQajfUp29Lo3OT76FK0YlPSYe7AC6lwLnhh0Js9IXdgorilI/QAtOJeqV1cGAh/
         TkXaeRqfpjLhkLlPtrBiLFXDQlgGkXvPdyExau+jFkgclDDSxSopM3RrWuoQHt46x5Cc
         TK5V6hESAHX8Td6/rqss4CA4WAiKXCH3dXIAZMCZqJS66bFcFMkyRb7unfxL9wpSZ4Yc
         ulEg==
X-Gm-Message-State: AGRZ1gIlxOyekyQpovuwtWZwRGoE+1X46s3kV5HPkAfZ7Ai0y/RXtQ8x
        d9KcyIRQ31otTJcLSFLpXon4E3+wqfSSkmmhri8=
X-Google-Smtp-Source: AJdET5dz6deNtRqrFb9saIpEVca9j4O1d75Ks2cRm43scVL/Bf352zS59X4tVV4Ja0wPSg+VMzSjxdqe5QHlWdupMnU=
X-Received: by 2002:a02:9bac:: with SMTP id p41-v6mr21338809jak.1.1541454990375;
 Mon, 05 Nov 2018 13:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20181017103432.zgv46nlu3hc7k4rq@linutronix.de> <tip-f77084d96355f5fba8e2c1fb3a51a393b1570de7@git.kernel.org>
In-Reply-To: <tip-f77084d96355f5fba8e2c1fb3a51a393b1570de7@git.kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 5 Nov 2018 13:56:18 -0800
Message-ID: <CAA9_cmf-XhG-NCX5b3J3yzF1AMunSVsaaWvU2c0=_08kcqJ9-A@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/mm/pat: Disable preemption around __flush_tlb_all()
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, bigeasy@linutronix.de,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:12 AM tip-bot for Sebastian Andrzej Siewior
<tipbot@zytor.com> wrote:
>
> Commit-ID:  f77084d96355f5fba8e2c1fb3a51a393b1570de7
> Gitweb:     https://git.kernel.org/tip/f77084d96355f5fba8e2c1fb3a51a393b1570de7
> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate: Wed, 17 Oct 2018 12:34:32 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon, 29 Oct 2018 19:04:31 +0100
>
> x86/mm/pat: Disable preemption around __flush_tlb_all()
>
> The WARN_ON_ONCE(__read_cr3() != build_cr3()) in switch_mm_irqs_off()
> triggers every once in a while during a snapshotted system upgrade.
>
> The warning triggers since commit decab0888e6e ("x86/mm: Remove
> preempt_disable/enable() from __native_flush_tlb()"). The callchain is:
>
>   get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()
>
> with CONFIG_DEBUG_PAGEALLOC enabled.
>
> Disable preemption during CR3 reset / __flush_tlb_all() and add a comment
> why preemption has to be disabled so it won't be removed accidentaly.
>
> Add another preemptible() check in __flush_tlb_all() to catch callers with
> enabled preemption when PGE is enabled, because PGE enabled does not
> trigger the warning in __native_flush_tlb(). Suggested by Andy Lutomirski.
>
> Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20181017103432.zgv46nlu3hc7k4rq@linutronix.de
> ---
>  arch/x86/include/asm/tlbflush.h | 6 ++++++
>  arch/x86/mm/pageattr.c          | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 323a313947e0..d760611cfc35 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -453,6 +453,12 @@ static inline void __native_flush_tlb_one_user(unsigned long addr)
>   */
>  static inline void __flush_tlb_all(void)
>  {
> +       /*
> +        * This is to catch users with enabled preemption and the PGE feature
> +        * and don't trigger the warning in __native_flush_tlb().
> +        */
> +       VM_WARN_ON_ONCE(preemptible());

This warning triggers 100% of the time for the pmem use case and it
seems it would also trigger for any memory hotplug use case that uses
arch_add_memory().

 WARNING: CPU: 35 PID: 911 at ./arch/x86/include/asm/tlbflush.h:460
__flush_tlb_all+0x1b/0x3a
 CPU: 35 PID: 911 Comm: systemd-udevd Tainted: G           OE
4.20.0-rc1+ #2583
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
 RIP: 0010:__flush_tlb_all+0x1b/0x3a
 [..]
 Call Trace:
  phys_pud_init+0x29c/0x2bb
  kernel_physical_mapping_init+0xfc/0x219
  init_memory_mapping+0x1a5/0x3b0
  arch_add_memory+0x2c/0x50
  devm_memremap_pages+0x3aa/0x610
  pmem_attach_disk+0x585/0x700 [nd_pmem]

...could we just move the preempt_disable() inside __flush_tlb_all()?
