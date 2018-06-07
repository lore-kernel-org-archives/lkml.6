Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1iuMGIB4GVv8MAAAmS7hNA
	; Thu, 07 Jun 2018 18:25:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 45F32608B8; Thu,  7 Jun 2018 18:25:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfJcLuQn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0C26606DD;
	Thu,  7 Jun 2018 18:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0C26606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936282AbeFGSZB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933706AbeFGSY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:24:59 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF791208A4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528395899;
        bh=WRClLQ/CzMKv0aNLsYddJj10Q8PypBI24A8hteB5ZfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PfJcLuQnKqF1zfDv1vBVT8maAhByBX+oTvyAVuZDb1Vb7WeZjjcZOE+V9gSldb2zQ
         DVZ15WwMFf946Y3BN48T73jIu1qHB6yg0mz7fF1jdYfI2juoToGtuF4J8j3CLD37fD
         IfLe4b9CWPxlgpb6W4+j3VsVpP8IFyPGyEUeG9qg=
Received: by mail-wm0-f50.google.com with SMTP id q4-v6so4205904wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:24:58 -0700 (PDT)
X-Gm-Message-State: APt69E0fMnAxZD6CSxLxw3hkmEYoqpEe6cZM/t3lHtYc6wCXkzUgWpul
        VJrHthGe4gouYHkWnOM5TuhCe7YDMpTXpNIRHPyScw==
X-Google-Smtp-Source: ADUXVKIp8NgObFVpdQALYaSeAzfWvWN2wbmt5fDT3YnLDMh5r/oc+8BoPz9/U2pf7ElwxLhA9VbeRDeKALeVVB2H3Gg=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr2204961wmi.46.1528395897272;
 Thu, 07 Jun 2018 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-7-yu-cheng.yu@intel.com>
 <CALCETrVa8MtxP9iqYkZLnetaQiN4UaWb=jGz1+rLsCuETHKydg@mail.gmail.com> <d9939c23-bb8b-1fbc-ac65-8bf1d7cbf650@linux.intel.com>
In-Reply-To: <d9939c23-bb8b-1fbc-ac65-8bf1d7cbf650@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:24:45 -0700
X-Gmail-Original-Message-ID: <CALCETrU=_zFvSqc4UWQ1ySgn1MAU=z9JFJbPpeK6gTQwbZGonQ@mail.gmail.com>
Message-ID: <CALCETrU=_zFvSqc4UWQ1ySgn1MAU=z9JFJbPpeK6gTQwbZGonQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and
 related functions
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 11:23 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> On 06/07/2018 09:24 AM, Andy Lutomirski wrote:
> >> +static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> >> +                                           unsigned long addr, pte_t *ptep)
> >> +{
> >> +       bool rw;
> >> +
> >> +       rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> >> +       if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
> >> +               struct mm_struct *mm = vma->vm_mm;
> >> +               pte_t pte;
> >> +
> >> +               if (rw && (atomic_read(&mm->mm_users) > 1))
> >> +                       pte = ptep_clear_flush(vma, addr, ptep);
> > Why are you clearing the pte?
>
> I think I insisted on this being in there.
>
> First of all, we need to flush the TLB eventually because we need the
> shadowstack PTE permissions to be in effect.
>
> But, generally, we can't clear a dirty bit in a "live" PTE without
> flushing.  The processor can keep writing until we flush, and even keep
> setting it whenever _it_ allows a write, which it can do based on stale
> TLB contents.  Practically, I think a walk to set the dirty bit is
> mostly the same as a TLB miss, but that's certainly not guaranteed forever.
>
> That's even ignoring all the fun errata we have.

Maybe make it a separate patch, then?  It seems like this patch is
doing two almost entirely separate things: adding some flushes and
adding the magic hwdirty -> swdirty transition.  As it stands, it's
quite difficult to read the patch and figure out what it does.
