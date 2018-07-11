Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E90C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BCF20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSUCMT2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BCF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbeGKTve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:51:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45909 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389871AbeGKTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:51:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so25877840oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2tZh6GSXG9/bVoC7cTNw2b4CY6P6mxDiHG8ivICtbM=;
        b=QSUCMT2+e9dDHj4PiwHNEz418C7o7rXcw+BHtbuvObPv4WugR/tMph5PtMyqAGQc21
         CzJZwoidS9A6DSVA1vti+LkUEsW42ByBVFDbdA5ekX8AGSgT3GQDUIk4XkbBFXE57HK9
         3Coj0say03qNoABqNK4GpX+laC9baJTffy4VtmdhfOs3jbKpXT0iolBVk2PNjMZxooWn
         4x9yzV+HVaMIOedcJUKRngEuXQRZL5cGUjy/oDYBut2i0xmnZ9Cqjp5gechyPHBP90fp
         RGRcrvFBtgjD1S3BruTMBgMKgRXyBJxLVgG8iL9mIjVkvA72KqwK6fAvY7k6hxmQJeoB
         F6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2tZh6GSXG9/bVoC7cTNw2b4CY6P6mxDiHG8ivICtbM=;
        b=nzJBbk6SCcrrb3YZspiz9R4NZM65eJ9a5WwjrAublU8Pwov3bbOjxQMeYhKqmTVX8D
         u6LpA5ntZDW2mpbMXQqDx31bd63OUV+wmoMw0VdGLg3CZTK/Z1zhdDT5scFjDCdZ3WL/
         AbJ5eBsUi/+HyMYgOmo5OHMIIfYHGx249EHUHnhkSp0uYUl5SqVgMM1PezeLbhV1aDdL
         quHKwUdWhEEyKDI1A8Szdz4xYIB02+/wreIPfH6WxZmdhVw/Tz8Ng9rzwXZP3KzEdeIb
         bXsbxuM75MInKdvFVVo3Xg12RH1JPoq2mL6k5TDKti7tu0J7ay0BkcxtqTHOFI2Ykcdk
         S+2g==
X-Gm-Message-State: AOUpUlEmENJCQClypfffDo2q9I896lAssMscDmIrBvrzS9tDz0k2pM5I
        8NabhOq+73Dfak01SxaYoJMGkpZynvEM2ISCFtPZZA==
X-Google-Smtp-Source: AAOMgpdIquIaUw4yrety/8sel1/q69YNYIhjLepLhPfgxMZ0c7B7Mg40/wXfS0JN7DdoNBghbA/kW23aZtj058RHBMQ=
X-Received: by 2002:aca:1c04:: with SMTP id c4-v6mr744135oic.173.1531338342384;
 Wed, 11 Jul 2018 12:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-28-yu-cheng.yu@intel.com>
In-Reply-To: <20180710222639.8241-28-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 11 Jul 2018 12:45:16 -0700
Message-ID: <CAG48ez2cY1CPTTfDnV5yZyHVPXP787=fR1+G_D7tR5VYXdjFmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 27/27] x86/cet: Add arch_prctl functions for CET
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
> arch_prctl(ARCH_CET_STATUS, unsigned long *addr)
>     Return CET feature status.
>
>     The parameter 'addr' is a pointer to a user buffer.
>     On returning to the caller, the kernel fills the following
>     information:
>
>     *addr = SHSTK/IBT status
>     *(addr + 1) = SHSTK base address
>     *(addr + 2) = SHSTK size
>
> arch_prctl(ARCH_CET_DISABLE, unsigned long features)
>     Disable SHSTK and/or IBT specified in 'features'.  Return -EPERM
>     if CET is locked out.
>
> arch_prctl(ARCH_CET_LOCK)
>     Lock out CET feature.
>
> arch_prctl(ARCH_CET_ALLOC_SHSTK, unsigned long *addr)
>     Allocate a new SHSTK.
>
>     The parameter 'addr' is a pointer to a user buffer and indicates
>     the desired SHSTK size to allocate.  On returning to the caller
>     the buffer contains the address of the new SHSTK.
>
> arch_prctl(ARCH_CET_LEGACY_BITMAP, unsigned long *addr)
>     Allocate an IBT legacy code bitmap if the current task does not
>     have one.
>
>     The parameter 'addr' is a pointer to a user buffer.
>     On returning to the caller, the kernel fills the following
>     information:
>
>     *addr = IBT bitmap base address
>     *(addr + 1) = IBT bitmap size
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
> new file mode 100644
> index 000000000000..86bb78ae656d
> --- /dev/null
> +++ b/arch/x86/kernel/cet_prctl.c
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/errno.h>
> +#include <linux/uaccess.h>
> +#include <linux/prctl.h>
> +#include <linux/compat.h>
> +#include <asm/processor.h>
> +#include <asm/prctl.h>
> +#include <asm/elf.h>
> +#include <asm/elf_property.h>
> +#include <asm/cet.h>
> +
> +/* See Documentation/x86/intel_cet.txt. */
> +
> +static int handle_get_status(unsigned long arg2)
> +{
> +       unsigned int features = 0;
> +       unsigned long shstk_base, shstk_size;
> +
> +       if (current->thread.cet.shstk_enabled)
> +               features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
> +       if (current->thread.cet.ibt_enabled)
> +               features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
> +
> +       shstk_base = current->thread.cet.shstk_base;
> +       shstk_size = current->thread.cet.shstk_size;
> +
> +       if (in_ia32_syscall()) {
> +               unsigned int buf[3];
> +
> +               buf[0] = features;
> +               buf[1] = (unsigned int)shstk_base;
> +               buf[2] = (unsigned int)shstk_size;
> +               return copy_to_user((unsigned int __user *)arg2, buf,
> +                                   sizeof(buf));
> +       } else {
> +               unsigned long buf[3];
> +
> +               buf[0] = (unsigned long)features;
> +               buf[1] = shstk_base;
> +               buf[2] = shstk_size;
> +               return copy_to_user((unsigned long __user *)arg2, buf,
> +                                   sizeof(buf));
> +       }

Other places in the kernel (e.g. the BPF subsystem) just
unconditionally use u64 instead of unsigned long to avoid having to
switch between different sizes. I wonder whether that would make sense
here?

> +}
> +
> +static int handle_alloc_shstk(unsigned long arg2)
> +{
> +       int err = 0;
> +       unsigned long shstk_size = 0;
> +
> +       if (in_ia32_syscall()) {
> +               unsigned int size;
> +
> +               err = get_user(size, (unsigned int __user *)arg2);
> +               if (!err)
> +                       shstk_size = size;
> +       } else {
> +               err = get_user(shstk_size, (unsigned long __user *)arg2);
> +       }

As above.

> +       if (err)
> +               return -EFAULT;
> +
> +       err = cet_alloc_shstk(&shstk_size);
> +       if (err)
> +               return -err;
> +
> +       if (in_ia32_syscall()) {
> +               if (put_user(shstk_size, (unsigned int __user *)arg2))
> +                       return -EFAULT;
> +       } else {
> +               if (put_user(shstk_size, (unsigned long __user *)arg2))
> +                       return -EFAULT;
> +       }
> +       return 0;
> +}
> +
> +static int handle_bitmap(unsigned long arg2)
> +{
> +       unsigned long addr, size;
> +
> +       if (current->thread.cet.ibt_enabled) {
> +               if (!current->thread.cet.ibt_bitmap_addr)
> +                       cet_setup_ibt_bitmap();
> +               addr = current->thread.cet.ibt_bitmap_addr;
> +               size = current->thread.cet.ibt_bitmap_size;
> +       } else {
> +               addr = 0;
> +               size = 0;
> +       }
> +
> +       if (in_compat_syscall()) {
> +               if (put_user(addr, (unsigned int __user *)arg2) ||
> +                   put_user(size, (unsigned int __user *)arg2 + 1))
> +                       return -EFAULT;
> +       } else {
> +               if (put_user(addr, (unsigned long __user *)arg2) ||
> +                   put_user(size, (unsigned long __user *)arg2 + 1))
> +               return -EFAULT;
> +       }
> +       return 0;
> +}
> +
> +int prctl_cet(int option, unsigned long arg2)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK) &&
> +           !cpu_feature_enabled(X86_FEATURE_IBT))
> +               return -EINVAL;
> +
> +       switch (option) {
> +       case ARCH_CET_STATUS:
> +               return handle_get_status(arg2);
> +
> +       case ARCH_CET_DISABLE:
> +               if (current->thread.cet.locked)
> +                       return -EPERM;
> +               if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +                       cet_disable_free_shstk(current);
> +               if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
> +                       cet_disable_ibt();
> +
> +               return 0;
> +
> +       case ARCH_CET_LOCK:
> +               current->thread.cet.locked = 1;
> +               return 0;
> +
> +       case ARCH_CET_ALLOC_SHSTK:
> +               return handle_alloc_shstk(arg2);
> +
> +       /*
> +        * Allocate legacy bitmap and return address & size to user.
> +        */
> +       case ARCH_CET_LEGACY_BITMAP:
> +               return handle_bitmap(arg2);
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
> index 42e08d3b573e..3d4934fdac7f 100644
> --- a/arch/x86/kernel/elf.c
> +++ b/arch/x86/kernel/elf.c
> @@ -8,7 +8,10 @@
>
>  #include <asm/cet.h>
>  #include <asm/elf_property.h>
> +#include <asm/prctl.h>
> +#include <asm/processor.h>
>  #include <uapi/linux/elf-em.h>
> +#include <uapi/linux/prctl.h>
>  #include <linux/binfmts.h>
>  #include <linux/elf.h>
>  #include <linux/slab.h>
> @@ -255,6 +258,7 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
>         current->thread.cet.ibt_enabled = 0;
>         current->thread.cet.ibt_bitmap_addr = 0;
>         current->thread.cet.ibt_bitmap_size = 0;
> +       current->thread.cet.locked = 0;
>         if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>                 if (shstk) {
>                         err = cet_setup_shstk();
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 43a57d284a22..259b92664981 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -795,6 +795,12 @@ long do_arch_prctl_common(struct task_struct *task, int option,
>                 return get_cpuid_mode();
>         case ARCH_SET_CPUID:
>                 return set_cpuid_mode(task, cpuid_enabled);
> +       case ARCH_CET_STATUS:
> +       case ARCH_CET_DISABLE:
> +       case ARCH_CET_LOCK:
> +       case ARCH_CET_ALLOC_SHSTK:
> +       case ARCH_CET_LEGACY_BITMAP:
> +               return prctl_cet(option, cpuid_enabled);
>         }
>
>         return -EINVAL;
> --
> 2.17.1
>
