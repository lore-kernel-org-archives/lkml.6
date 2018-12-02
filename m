Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8907920892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mAPp1tvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8907920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbeLBRFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:05:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42086 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:05:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so8873264oiw.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sODZiGKX6kmDRaOjcnSpgyd1Nlzv8ZJBp3deK8uxCU8=;
        b=mAPp1tvStC6wU77GSAJAuTeGFtjDCyHaoe+IBQSR5jwzwOIY1G8zKDFJl9sZ6g/IOu
         Apd+DfUHDkUh1plEJGfAZ6DqoDY2K4LZ0Jp/HhfpcP1SPNvy5YvOblHpdOSP49tshGDo
         rFDV8Uo72bOyx7asZD182nojB5gtJqIUu67Rv/l4MfIEpbdkc1172OtZsvsse079iHvP
         MUXyPR6mW6KRdpNY2E52rseff22s9StvyjErEJ/q0l22FuQkbYNK8N9O2VIc2bIHmyWB
         Tl8wQjEUJUMPhJBwwcPgVGst7pd5RlnK18eQAWVLlU6QmtZDmUPeRwtY63A1UlKXcF0F
         1PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sODZiGKX6kmDRaOjcnSpgyd1Nlzv8ZJBp3deK8uxCU8=;
        b=p/oseZCX8XdcWjZ2nED/Tt9dBW6IEKuAEMkJ6Tsw2VLer8ATu/2o7x6bw//7vowBE/
         aRj3rZutQsIElcw8wWQwAM11MysR1ZuLCCxveDYOaxJLKPql/2UQ0Xv/AXWyekaDH/0p
         ILqfRoOnR75UKpXtucAG7w+ftiVS4myWO2ieOszSG3fDHguKwsqnR5xFXAI1sYAYn0qZ
         CHd7+/rZ7GjDp1F7Bwtd5SjBdvb96PBi0tosZNAjqK5MzFy2xWomDWr/utghefYPoYXZ
         qtGmbVrDf2HIYPFWtuJXuAQPgUFuFpmvY2qmmMADUZR5CLtaE4Zue/Ita/XtpDkdLGPF
         JnUw==
X-Gm-Message-State: AA+aEWYWBmYVYL3ObPAxLna4k2/UlK4N/tnv3D3+7erv2X2Smp3uaTQe
        vx3fkFa7KCxko9Z0jLfFCQuyHve7j8RZOOR3gsYVXQ==
X-Google-Smtp-Source: AFSGD/UYlpZxjeIPi3pCQ+rMDvCRj0jXVJRU7gTOVTjGr4d07YsqC4wgwiHzRxf/dNLaPeycm9m6hXzKWiaoZNqzrOA=
X-Received: by 2002:aca:5205:: with SMTP id g5mr8357287oib.149.1543770299172;
 Sun, 02 Dec 2018 09:04:59 -0800 (PST)
MIME-Version: 1.0
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154362453268.2367148.268782514142834053.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181202064304.GA221015@sasha-vm>
In-Reply-To: <20181202064304.GA221015@sasha-vm>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 2 Dec 2018 09:04:47 -0800
Message-ID: <CAPcyv4jQ4Zw7BgONqHdoacbRCXh9-9F0mOzC5fOzN_86u28Q-A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
To:     sashal@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 10:43 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 04:35:32PM -0800, Dan Williams wrote:
> >Commit f77084d96355 "x86/mm/pat: Disable preemption around
> >__flush_tlb_all()" addressed a case where __flush_tlb_all() is called
> >without preemption being disabled. It also left a warning to catch other
> >cases where preemption is not disabled. That warning triggers for the
> >memory hotplug path which is also used for persistent memory enabling:
> >
> > WARNING: CPU: 35 PID: 911 at ./arch/x86/include/asm/tlbflush.h:460
> > RIP: 0010:__flush_tlb_all+0x1b/0x3a
> > [..]
> > Call Trace:
> >  phys_pud_init+0x29c/0x2bb
> >  kernel_physical_mapping_init+0xfc/0x219
> >  init_memory_mapping+0x1a5/0x3b0
> >  arch_add_memory+0x2c/0x50
> >  devm_memremap_pages+0x3aa/0x610
> >  pmem_attach_disk+0x585/0x700 [nd_pmem]
> >
> >Andy wondered why a path that can sleep was using __flush_tlb_all() [1]
> >and Dave confirmed the expectation for TLB flush is for modifying /
> >invalidating existing pte entries, but not initial population [2]. Drop
> >the usage of __flush_tlb_all() in phys_{p4d,pud,pmd}_init() on the
> >expectation that this path is only ever populating empty entries for the
> >linear map. Note, at linear map teardown time there is a call to the
> >all-cpu flush_tlb_all() to invalidate the removed mappings.
> >
> >[1]: https://lore.kernel.org/lkml/9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net
> >[2]: https://lore.kernel.org/lkml/749919a4-cdb1-48a3-adb4-adb81a5fa0b5@intel.com
> >
> >Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_all()")
> >Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: <stable@vger.kernel.org>
> >Reported-by: Andy Lutomirski <luto@kernel.org>
> >Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> This patch on it's own doesn't apply to any of the stable trees, does it
> maybe depend on some of the previous patches in this series?

It does not strictly depend on them, but it does need to be rebased
without them. The minimum patch for -stable are these
__flush_tlb_all() removals, but without the
set_{pte,pmd,pud,p4d,pgd}_safe() conversion. It's also an option to
backport those helpers, and conversion but I'd defer to x86/mm folks
to make that call.
