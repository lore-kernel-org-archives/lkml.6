Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5F5C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECA52081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Q25bkfGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725741AbeLBFKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:10:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46130 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:10:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so8046565otm.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwA6awFvHOc6tnt10Emd9289Wn10nQJsh8iDj6V4NuI=;
        b=Q25bkfGg7vU0WKYHSzmzLFCKkhCcCrFfo0PgGpVg4FWsBl8HuHReI8MQAQOIm3xAcj
         3zMDdEHnwGRlVzzNZzNlpsB+yojZtbYDvBeqMo9MGvqbBtr8dndBPwb5g3SrV8aHtzvU
         7CZuL4lN2mqXHg9l7jNYtSqNeKYUB0FjwXmqj3QxYBm0yqX+zCqHwg/B9u4oZjSjAgD8
         a6xdab7YFUMOd44XI6hm4SshOZ/Z0fcSUHyvnTRmAcMomdOkN228YrfZycjKcAgQuH+u
         IvPU7AhvSDZby9CfCJyqlYORGggmgC22G5wT3VqQFLREFKc+ZGvu+amhxx57pKh8G3dw
         /atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwA6awFvHOc6tnt10Emd9289Wn10nQJsh8iDj6V4NuI=;
        b=Wfz3e+sfATM2wSWeizvoPSPOUxiyNYXE4cVDLBqiEUYi4foyb2l+HEoCxrIKQUHsnM
         qEXnHjrLQqFMuY/9prfxYfgiXt0YldGMyfhVlSN6EeKJ5t88RdWqzm+W3tO9uKb9xrRa
         7TFWY1K4+8WcJEaUTZng/AbkPTUfiCsswH4BwJs7p6FSe8RXImKk/6DIPoSna1AEdWUI
         GcAZpzHGtPrFVW4gOAmbBbdSY+nfg5XNHusQBG2MW6mUSrEtkgCSzm1gurpAOonog//s
         RpS+kWO0XLff/MbmW6nDypsuIYzucpOT9okACaCbdPC7ntRxTftf9tHT8b72TePaWT7+
         eBNw==
X-Gm-Message-State: AA+aEWafz2agxD0mBYzFLLqqRfIg0ae4aOmEBTsa2i026kmTH9bYv8pO
        n23Z3C3wmzYKW9h2KIrG3s6245h981ZYiZ1C8IiVxA==
X-Google-Smtp-Source: AFSGD/UdAHqgRLUjYyWsCQfljBI8P2tVnyMz5Ch7Id99rWLmV1RSNavOkxGVjKFqj2AS1iPVMqDP5XoU4ookIiq9kgA=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr6657398otn.214.1543686566095;
 Sat, 01 Dec 2018 09:49:26 -0800 (PST)
MIME-Version: 1.0
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181201102843.GF11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181201102843.GF11614@hirez.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Dec 2018 09:49:14 -0800
Message-ID: <CAPcyv4hm1yRz9qU35f9ZsCHyAeM6c+cQuipJ02GJk48wTTL00A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 2:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 30, 2018 at 04:35:06PM -0800, Dan Williams wrote:
> >
> > Dan Williams (5):
> >       generic/pgtable: Make {pmd,pud}_same() unconditionally available
> >       generic/pgtable: Introduce {p4d,pgd}_same()
> >       generic/pgtable: Introduce set_pte_safe()
> >       x86/mm: Validate kernel_physical_mapping_init() pte population
> >       x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
> >
>
> Since you failed to send me 1,2, only for 3-5:

Whoops, sorry about that, I'll add you to my "auto-cc on all if cc'd
on one" list.

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks.

> although going by the subjects, the earlier two patches should be fine
> too.
