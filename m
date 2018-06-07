Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /aSnFSdcGVuiIgAAmS7hNA
	; Thu, 07 Jun 2018 16:24:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0F036608BF; Thu,  7 Jun 2018 16:24:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="jQnaZWKL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89891601B4;
	Thu,  7 Jun 2018 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89891601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeFGQYT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:24:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35220 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeFGQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:24:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so10495361wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzZMET5ITA4C5FM/Jlp0Cq66m2LLOOU87w3BEMwQ7lA=;
        b=jQnaZWKLkn4LVU+VAIZxhcbFqtb6eH1oH6Knpt31ma5bwJWcILnvN1N5Zrbw5bN2jd
         HHDDI402uLH0PR/91qydpHRUWkGobfWWI+VJlnRgJEvFAuuThe5BFu+Xr9/OFq5h5IHi
         3Rv1E0PX7C0bzSp89Uhe0cv3yrcRGvWdwfaYLEG6J1rzFJJT/Rx4BfOhGJdkAbGFTwez
         iW3dk1M0iwfAYwdQHrn/y3ixzeq299m4sY99ZRP6V5lL9Ejky+cFC98mo2lMuu7v5eqd
         qwIRoJ7FPKFHHWvXus/oGa1m/TpHWKnmFbxnwhoKB20UyYSmut7ICB+P63OxSCjD9aVA
         73Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzZMET5ITA4C5FM/Jlp0Cq66m2LLOOU87w3BEMwQ7lA=;
        b=GsYbWXGUnlzsfA+Mx6+Q6bfQPklWs9MPeMTAMj/1oFtVGNM2NI1meOYqBh3bh8Pmrr
         Ye9KK5idetaEsFJtftjCCbKPvNGqZW76qJqD1OYKgaUkTov9xJZkhID+lLt0hzuz+2LS
         DkKomG9oht/GbmiJ5J6V7LdHk3SrQnlAZsVvPcbw6w3wH+DjFT1DyO0GU0GyXJFgGt0b
         JzsTt2A8fyOs7zWq/A+u/zsEKDVgkYBrzmNBdj64QymEVyRk7EhYeWr/D4gnIlAFVqm1
         Dy8tWMemJhT0AZU9iiBasoJmWGMSZtjeFVLDUwVEa57opwkQde/8ssabDYFYky3YhhNx
         kLFQ==
X-Gm-Message-State: APt69E3X3Y1Ulb/4ykqmZFUsSmPR3cFtBjldZjvhKsPu90KcgtsThSvi
        wskEq6abxg0T5yK/0lQUyQ60oR5TI0Ec1ISDjn2TpQ==
X-Google-Smtp-Source: ADUXVKJHJwjfi6EBhMlHHI6HHlfXeWl3nerZb/RjehsgeSilBC90gAK9qfegX3KogMDUdi4rJJpzMxi9Ep8iY7hz/w4=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr2210625wrd.67.1528388655645;
 Thu, 07 Jun 2018 09:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-7-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143705.3531-7-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 7 Jun 2018 09:24:03 -0700
Message-ID: <CALCETrVa8MtxP9iqYkZLnetaQiN4UaWb=jGz1+rLsCuETHKydg@mail.gmail.com>
Subject: Re: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and
 related functions
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The function ptep_set_wrprotect()/huge_ptep_set_wrprotect() is
> used by copy_page_range()/copy_hugetlb_page_range() to copy
> PTEs.
>
> On x86, when the shadow stack is enabled, only a shadow stack
> PTE has the read-only and _PAGE_DIRTY_HW combination.  Upon
> making a dirty PTE read-only, we move its _PAGE_DIRTY_HW to
> _PAGE_DIRTY_SW.
>
> When ptep_set_wrprotect() moves _PAGE_DIRTY_HW to _PAGE_DIRTY_SW,
> if the PTE is writable and the mm is shared, another task could
> race to set _PAGE_DIRTY_HW again.
>
> Introduce ptep_set_wrprotect_flush(), pmdp_set_wrprotect_flush(),
> and huge_ptep_set_wrprotect_flush() to make sure this does not
> happen.
>

This patch adds flushes where they didn't previously exist.

> +static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> +                                           unsigned long addr, pte_t *ptep)
> +{
> +       bool rw;
> +
> +       rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
> +               struct mm_struct *mm = vma->vm_mm;
> +               pte_t pte;
> +
> +               if (rw && (atomic_read(&mm->mm_users) > 1))
> +                       pte = ptep_clear_flush(vma, addr, ptep);

Why are you clearing the pte?

> -#define __HAVE_ARCH_PMDP_SET_WRPROTECT
> -static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> -                                     unsigned long addr, pmd_t *pmdp)
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT_FLUSH
> +static inline void huge_ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> +                                                unsigned long addr, pte_t *ptep)
>  {
> -       clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
> +       ptep_set_wrprotect_flush(vma, addr, ptep);

Maybe I'm just missing something, but you're changed the semantics of
this function significantly.
