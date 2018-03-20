Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeCTJAi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:00:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeCTJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:00:36 -0400
Date: Tue, 20 Mar 2018 10:00:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
cc: hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: don't use unstable TSC to detect timer IRQ
In-Reply-To: <20180320084255.GA187704@sofia>
Message-ID: <alpine.DEB.2.21.1803200956580.6506@nanos.tec.linutronix.de>
References: <20180320084255.GA187704@sofia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Liu, Changcheng wrote:

> In rare case, the TSC is every unstable or can't sync with
> real time hardware clock.

What does that mean?

> After setting "tsc=unstable" in command line, system should use
> delay_without_tsc to detect timer IRQ. Or system could panic as shown in
> below log:

tsc=unstable has nothing to do with TSC being usable for delay loops unless
your TSC is completely broken. Please explain more detailed in which way
this TSC is defect in the hardware. Aside of that is this production
hardware or some experimental silicon?

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index fb43027..27b1bae 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -36,7 +36,8 @@ EXPORT_SYMBOL(tsc_khz);
>  /*
>   * TSC can be unstable due to cpufreq or due to unsynced TSCs
>   */
> -static int __read_mostly tsc_unstable;
> +int __read_mostly tsc_unstable;
> +EXPORT_SYMBOL(tsc_unstable);

Even if we decided to do that, there is no need to export that symbol ever.

Thanks,

	tglx
