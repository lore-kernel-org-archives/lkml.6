Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /8Z7LkZfGVu6NAAAmS7hNA
	; Thu, 07 Jun 2018 16:37:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A19116074D; Thu,  7 Jun 2018 16:37:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWzbqC39"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16951605A2;
	Thu,  7 Jun 2018 16:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16951605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeFGQhY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753441AbeFGQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:37:19 -0400
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C16208A4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528389439;
        bh=fdVR+4rJC4gKyN1jQx/rSzO0HzVa88L2KIlxxF0hcOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AWzbqC393uwVdpZFqYineoiXTgoyD5fLcBFCfRZaXCOiBrIHR3yiNgT0zQWdSNQ+V
         +l3gqDy99krnXThgL05/BizNJiU43hgMZy6yF4Bmo9ou7h+l8NhLC6LD8nzW1DBooE
         GwHcqnIkb4ZynrMfdYQUNs/Y3UyFRk6RZE/XOmg4=
Received: by mail-wr0-f169.google.com with SMTP id l41-v6so10520156wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:37:19 -0700 (PDT)
X-Gm-Message-State: APt69E1d98obdMWqWoTS1t5swN7ZnLYsp3EZynrK5YnrR78bCrbcQwCV
        KUPum78kx/DYWhAX5joRdNUi4dRLkFeZru+Q4dgD2g==
X-Google-Smtp-Source: ADUXVKLT6HInAxnan2ACKvUgY/Uh2+NGJonJ0h8M7Ol8d0QHeD5MrafG+wNz/4B4AduLU9aAXLiHmP3Om3nbrf1PA6M=
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr2180958wra.221.1528389437545;
 Thu, 07 Jun 2018 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-2-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-2-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 09:37:05 -0700
X-Gmail-Original-Message-ID: <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com>
Message-ID: <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com>
Subject: Re: [PATCH 01/10] x86/cet: User-mode shadow stack support
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

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> This patch adds basic shadow stack enabling/disabling routines.
> A task's shadow stack is allocated from memory with VM_SHSTK
> flag set and read-only protection.  The shadow stack is
> allocated to a fixed size and that can be changed by the system
> admin.

How do threads work?  Can a user program mremap() its shadow stack to
make it bigger?

Also, did you add all the needed checks to make get_user_pages(),
access_process_vm(), etc fail when called on the shadow stack?  (Or at
least fail if they're requesting write access and the FORCE bit isn't
set.)

> +#define SHSTK_SIZE (0x8000 * (test_thread_flag(TIF_IA32) ? 4 : 8))

Please don't add more mode-dependent #defines.  Also, please try to
avoid adding any new code that looks at TIF_IA32 or similar.  Uses of
that bit are generally bugs, and the bit itself should get removed
some day.  If you need to make a guess, use in_compat_syscall() or
similar if appropriate.

> +
> +static inline int cet_set_shstk_ptr(unsigned long addr)
> +{
> +       u64 r;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +               return -1;
> +
> +       if ((addr >= TASK_SIZE) || (!IS_ALIGNED(addr, 4)))
> +               return -1;'

TASK_SIZE_MAX, please.  TASK_SIZE is weird and is usually the wrong
thing to use.

> +static unsigned long shstk_mmap(unsigned long addr, unsigned long len)
> +{
> +       struct mm_struct *mm = current->mm;
> +       unsigned long populate;
> +
> +       down_write(&mm->mmap_sem);
> +       addr = do_mmap(NULL, addr, len, PROT_READ,
> +                      MAP_ANONYMOUS | MAP_PRIVATE, VM_SHSTK,
> +                      0, &populate, NULL);
> +       up_write(&mm->mmap_sem);
> +
> +       if (populate)
> +               mm_populate(addr, populate);

Please don't populate if do_mmap() failed.

> +int cet_setup_shstk(void)
> +{
> +       unsigned long addr, size;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +               return -EOPNOTSUPP;
> +
> +       size = SHSTK_SIZE;
> +       addr = shstk_mmap(0, size);
> +
> +       if (addr >= TASK_SIZE)
> +               return -ENOMEM;

Please check the actual value that do_mmap() would return on error.
(IS_ERR, 0, MAP_FAILED -- I don't remember.)

> +
> +       cet_set_shstk_ptr(addr + size - sizeof(void *));
> +       current->thread.cet.shstk_base = addr;
> +       current->thread.cet.shstk_size = size;
> +       current->thread.cet.shstk_enabled = 1;
> +       return 0;
> +}
> +
> +void cet_disable_shstk(void)
> +{
> +       u64 r;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +               return;
> +
> +       rdmsrl(MSR_IA32_U_CET, r);
> +       r &= ~(MSR_IA32_CET_SHSTK_EN);
> +       wrmsrl(MSR_IA32_U_CET, r);
> +       wrmsrl(MSR_IA32_PL3_SSP, 0);
> +       current->thread.cet.shstk_enabled = 0;
> +}
> +
> +void cet_disable_free_shstk(struct task_struct *tsk)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +           !tsk->thread.cet.shstk_enabled)
> +               return;
> +
> +       if (tsk == current)
> +               cet_disable_shstk();

if tsk != current, then this will malfunction, right?  What is it
intended to do?

> +
> +       /*
> +        * Free only when tsk is current or shares mm
> +        * with current but has its own shstk.
> +        */
> +       if (tsk->mm && (tsk->mm == current->mm) &&
> +           (tsk->thread.cet.shstk_base)) {
> +               vm_munmap(tsk->thread.cet.shstk_base,
> +                         tsk->thread.cet.shstk_size);
> +               tsk->thread.cet.shstk_base = 0;
> +               tsk->thread.cet.shstk_size = 0;
> +       }

I'm having trouble imagining why the kernel would ever want to
automatically free the shadow stack vma.  What is this for?
