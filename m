Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80428C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51D213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPqxaqXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F51D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbeGKVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:13:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32952 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732522AbeGKVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:13:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so5162261oii.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh8TxHl5WB9OmBO9lEWZUkFPn5o9qgsioXcJ38g1tTE=;
        b=hPqxaqXpbNK98q6ILX77YhgMEtIeMRaBAHxQfRaKS4MJWJPHeKzWnoSGaEgLBO6ZYA
         FXvWA2aoDNipGQdC1MM9vCTOWbBT+zoS49ssfKtLHJWXyzZWaziigAV6fuK+CyJjoVvD
         UJJkbdV8zPjTLBE9yZ5/TQGqhamcXEBqL35nfKHA1UNyEGdwpuVsZuMtYmmw02vwdwvY
         c5c2rR04uu+LzNo52dCw6cVGvUIkFjzrzP69iFpdORFoHCadBPU20LrXbHyoJKa7md+j
         IN3K0PnwlSw5vtxOO/pKgvx+Aq8dDPc/x/VDbiyABDPyuikjW9LDQFgGYA5fvInVfLN1
         xj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh8TxHl5WB9OmBO9lEWZUkFPn5o9qgsioXcJ38g1tTE=;
        b=Cc+IwasvJ/rAS6Y2c8DbqYrw5qLtxOZdpeEzecKtJ3nRmFwWBgjdLPWgbQdg3RIuLg
         O9rqnANaN9z3tvrY3pvIHHlGb4SNwFAdJ2Pmo/SV6dZPMBy/csPuJzwpNb+0Bq67+F19
         4U33HD92eFxsyILXr4xkPjUT4dCgGjyZMcc3yBkrQdw7p0nOvXpKNvXJR0On3vc95XrU
         sgPVgFeWURlzxePdmK0HDcWKtcGmhVvHOz2kIY+goS7RASw7X/oHPWmfOa392zn37IuM
         sxGijH29OMx3dq622LB1KrlmcVATVzixNY3wqPIJy/dj+ejp4QVi1fk8XIt4hu7nrw9E
         S4iA==
X-Gm-Message-State: AOUpUlErlVJrRtGsJqNJyCEbQ1iTM+ZPd640WeDU8AQRh3KoamXS2l4I
        Xl7COVXSlt8HkqS6MrTbHTgb/2mHDrX7XOn3zWSTIQ==
X-Google-Smtp-Source: AAOMgpfBBYEQ4Y+7kVB2Nlk0mE+pKHZhYC0ZSteaZ7lLy7gdT8VD4lD9jRLmD84cSuBGuFSLenyuQI+QiSHhidCTp6U=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr264102oiy.219.1531343256258;
 Wed, 11 Jul 2018 14:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-23-yu-cheng.yu@intel.com>
In-Reply-To: <20180710222639.8241-23-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 11 Jul 2018 14:07:09 -0700
Message-ID: <CAG48ez0h5cabNiSBkCnAoyg9LXoSd7PpuStbRpV5r67VMHocRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/27] x86/cet/ibt: User-mode indirect branch
 tracking support
To:     yu-cheng.yu@intel.com
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>, bsingharora@gmail.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Add user-mode indirect branch tracking enabling/disabling
> and supporting routines.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 4eba7790c4e4..8bbd63e1a2ba 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
[...]
> +static unsigned long ibt_mmap(unsigned long addr, unsigned long len)
> +{
> +       struct mm_struct *mm = current->mm;
> +       unsigned long populate;
> +
> +       down_write(&mm->mmap_sem);
> +       addr = do_mmap(NULL, addr, len, PROT_READ | PROT_WRITE,
> +                      MAP_ANONYMOUS | MAP_PRIVATE,
> +                      VM_DONTDUMP, 0, &populate, NULL);
> +       up_write(&mm->mmap_sem);
> +
> +       if (populate)
> +               mm_populate(addr, populate);
> +
> +       return addr;
> +}

Is this thing going to stay writable? Will any process with an IBT
bitmap be able to disable protections by messing with the bitmap even
if the lock-out mode is active? If so, would it perhaps make sense to
forbid lock-out mode if an IBT bitmap is active, to make it clear that
effective lock-out is impossible in that state?
