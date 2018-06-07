Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vuNhJZF5GVtLNQAAmS7hNA
	; Thu, 07 Jun 2018 18:33:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1262F6089E; Thu,  7 Jun 2018 18:33:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fNRxn2Ic"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 78C1D60590;
	Thu,  7 Jun 2018 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78C1D60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936356AbeFGScx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55422 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936334AbeFGSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so19777628wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14lqIxu6tcrCdagy6uH9m4DflnRkLAEokF03mK09sls=;
        b=fNRxn2Ic2VllwqgMynJUFcfiuVJ3b9mavZehlCDy9aXEyJnF5U7dFteQgR2qpivPrr
         Kpozr8B5IfyI5chNUQZRZ4L+yN98dVD2mS876XMNzcjfd/UY8xj/oKeB7LWd7idwiT83
         8t7LJQQhack1O7TyEiohmBZqtOOHW30jCKIaGr7Gk8fZ63TvEbibfwAm3vgOr2mM0MpT
         b7xV+c9PAb9Il+/lvR5O7IGthgR1vzE9ig5dOm5ky/w1FD19HnYnGNh3gfL7BujYNO68
         73KSvdpRw2MCFPgDiCpjMES62EnFHeYNj1AxbEdFP0hUmkAne4rmVdRBxLREKhZ8LcZ7
         M06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14lqIxu6tcrCdagy6uH9m4DflnRkLAEokF03mK09sls=;
        b=ZZEVmvKoShngudHeoN+u73aIxD0c/LoD4xuV2gFCkREMiLoifZpHIy0qoK3AJfVMrq
         05GoDcKFhKf4MHvDXSAxItfX68AaB7RBfsL6uh3QzmJ387P2ToTDHp6Z6WDpcoRjxD1j
         n5Mov4Lt+LLxqHdHygKYWiDZ7oxz5iauABZWCkYoKOLhmtcYBl7HzYu7N9GHzNANjUrX
         gE9Z5mC+v4YL5EZlgzBBFt/XdML/hLKKbLn0DPzWml4PX6HtkfrZjvezj03OqhpGi3HF
         ldcvlUjUn+vUjsDvTuIhyoiLVfO2QdAXU0HVYGvogPUTocZHSy5iyVp+8FG5PW1VqE1o
         bNVw==
X-Gm-Message-State: APt69E162JKgoUXZSPhEGRml9sOHrSnnqAZzkGfLHLRfHwhziM80qz3+
        RYiSHtjPHih4U1aYncb2vvaH8K1VrbE1vCGH+2Jvlg==
X-Google-Smtp-Source: ADUXVKJGw/E3/wLnDK3SpLc+zora4n+Vl/RWJLo3g06dwVJg8/IjzhVtQSVLogmQpuvSKgU0+JLgwmSsdQkFmR55n98=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr2230370wmh.116.1528396368522;
 Thu, 07 Jun 2018 11:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-8-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143855.3681-8-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 7 Jun 2018 11:32:36 -0700
Message-ID: <CALCETrXx4FHLad8XhrP-RrBtXnmALf7Myy4wVO+u-SKxa_D01Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86/cet: Add PTRACE interface for CET
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

On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Add PTRACE interface for CET MSRs.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/regset.h |  7 ++++---
>  arch/x86/kernel/fpu/regset.c      | 41 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/ptrace.c          | 16 +++++++++++++++
>  include/uapi/linux/elf.h          |  1 +
>  4 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
> index d5bdffb9d27f..edad0d889084 100644
> --- a/arch/x86/include/asm/fpu/regset.h
> +++ b/arch/x86/include/asm/fpu/regset.h
> @@ -7,11 +7,12 @@
>
>  #include <linux/regset.h>
>
> -extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
> +extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
> +                               cetregs_active;
>  extern user_regset_get_fn fpregs_get, xfpregs_get, fpregs_soft_get,
> -                               xstateregs_get;
> +                               xstateregs_get, cetregs_get;
>  extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
> -                                xstateregs_set;
> +                                xstateregs_set, cetregs_set;
>
>  /*
>   * xstateregs_active == regset_fpregs_active. Please refer to the comment
> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> index bc02f5144b95..7008eb084d36 100644
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -160,6 +160,47 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
>         return ret;
>  }
>
> +int cetregs_active(struct task_struct *target, const struct user_regset *regset)
> +{
> +#ifdef CONFIG_X86_INTEL_CET
> +       if (target->thread.cet.shstk_enabled || target->thread.cet.ibt_enabled)
> +               return regset->n;
> +#endif
> +       return 0;
> +}
> +
> +int cetregs_get(struct task_struct *target, const struct user_regset *regset,
> +               unsigned int pos, unsigned int count,
> +               void *kbuf, void __user *ubuf)
> +{
> +       struct fpu *fpu = &target->thread.fpu;
> +       struct cet_user_state *cetregs;
> +
> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
> +               return -ENODEV;

This whole series has a boot_cpu_has, static_cpu_has, and
cpu_feature_enabled all over.  Please settle on just one, preferably
static_cpu_has.

> +
> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_MASK_SHSTK_USER);
> +
> +       fpu__prepare_read(fpu);
> +       return user_regset_copyout(&pos, &count, &kbuf, &ubuf, cetregs, 0, -1);
> +}
> +
> +int cetregs_set(struct task_struct *target, const struct user_regset *regset,
> +                 unsigned int pos, unsigned int count,
> +                 const void *kbuf, const void __user *ubuf)
> +{
> +       struct fpu *fpu = &target->thread.fpu;
> +       struct cet_user_state *cetregs;
> +
> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
> +               return -ENODEV;
> +
> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_MASK_SHSTK_USER);
> +
> +       fpu__prepare_write(fpu);
> +       return user_regset_copyin(&pos, &count, &kbuf, &ubuf, cetregs, 0, -1);

Is this called for core dumping on current?  If so, please make sure
it's correct.  (I think it is for get but maybe not for set.)
