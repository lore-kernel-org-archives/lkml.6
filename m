Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127E0206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127E0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJBSVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:21:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbeJBSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0AE7AEE6;
        Tue,  2 Oct 2018 11:38:56 +0000 (UTC)
Subject: Re: [tip:x86/hyperv] x86/hyperv: Enable PV qspinlock for Hyper-V
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        sthemmin@microsoft.com, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, yi.y.sun@linux.intel.com, hpa@zytor.com
References: <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com>
 <tip-aaa7fc34c003bd8133a49f7634480cef6288ad55@git.kernel.org>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0005fc50-4415-87a0-1954-fb15a1f8bd0b@suse.com>
Date:   Tue, 2 Oct 2018 13:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <tip-aaa7fc34c003bd8133a49f7634480cef6288ad55@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for noticing this only now, but I have been fighting with
Xen PV qspinlocks last weekend:

On 02/10/2018 13:28, tip-bot for Yi Sun wrote:
> Commit-ID:  aaa7fc34c003bd8133a49f7634480cef6288ad55
> Gitweb:     https://git.kernel.org/tip/aaa7fc34c003bd8133a49f7634480cef6288ad55
> Author:     Yi Sun <yi.y.sun@linux.intel.com>
> AuthorDate: Thu, 27 Sep 2018 14:01:44 +0800
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Tue, 2 Oct 2018 13:22:06 +0200
> 
> x86/hyperv: Enable PV qspinlock for Hyper-V
> 
> Implement the necessary callbacks for PV spinlocks which allow vCPU idling
> and kicking operations when running as a guest on Hyper-V
> 
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Cc: chao.p.peng@intel.com
> Cc: chao.gao@intel.com
> Cc: isaku.yamahata@intel.com
> Cc: tianyu.lan@microsoft.com
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Link: https://lkml.kernel.org/r/1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 ++
>  arch/x86/hyperv/Makefile                        |  4 ++
>  arch/x86/hyperv/hv_spinlock.c                   | 75 +++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h                 |  1 +
>  arch/x86/kernel/cpu/mshyperv.c                  | 14 +++++
>  5 files changed, 99 insertions(+)
> 

...

> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> new file mode 100644
> index 000000000000..6d3221322d0d
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V specific spinlock code.
> + *
> + * Copyright (C) 2018, Intel, Inc.
> + *
> + * Author : Yi Sun <yi.y.sun@intel.com>
> + */
> +
> +#define pr_fmt(fmt) "Hyper-V: " fmt
> +
> +#include <linux/spinlock.h>
> +
> +#include <asm/mshyperv.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/paravirt.h>
> +#include <asm/qspinlock.h>
> +#include <asm/apic.h>
> +
> +static bool __initdata hv_pvspin = true;
> +
> +static void hv_qlock_kick(int cpu)
> +{
> +	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
> +}
> +
> +static void hv_qlock_wait(u8 *byte, u8 val)
> +{
> +	unsigned long msr_val;
> +
> +	if (READ_ONCE(*byte) != val)
> +		return;
> +
> +	/*
> +	 * Read HV_X64_MSR_GUEST_IDLE MSR can trigger the guest's
> +	 * transition to the idle power state which can be exited
> +	 * by an IPI even if IF flag is disabled.
> +	 */

What if interrupts are enabled? Won't a kick happening here just
interrupt and then the following rdmsr result in a hang?

I believe the correct way would be to:

- disable interrupts before above READ_ONCE() and restore them
  after the rdmsrl()

- return early if in_nmi()

similar as the kvm specific variant is doing it.


Juergen
