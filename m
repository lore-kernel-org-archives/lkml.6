Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeEVP3i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:29:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:29:37 -0400
Subject: Re: [PATCH 05/14] arm64: Add 'ssbd' command-line option
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-6-marc.zyngier@arm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77a402ab-d119-cc71-518c-a6d4755b7889@infradead.org>
Date: Tue, 22 May 2018 08:29:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522150648.28297-6-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 08:06 AM, Marc Zyngier wrote:
> On a system where the firmware implements ARCH_WORKAROUND_2,
> it may be useful to either permanently enable or disable the
> workaround for cases where the user decides that they'd rather
> not get a trap overhead, and keep the mitigation permanently
> on or off instead of switching it on exception entry/exit.
> 
> In any case, default to the mitigation being enabled.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  17 ++++
>  arch/arm64/include/asm/cpufeature.h             |   6 ++
>  arch/arm64/kernel/cpu_errata.c                  | 102 ++++++++++++++++++++----
>  3 files changed, 109 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2040d46f095..646e112c6f63 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4092,6 +4092,23 @@
>  			expediting.  Set to zero to disable automatic
>  			expediting.
>  
> +	ssbd=		[ARM64,HW]
> +			Speculative Store Bypass Disable control
> +
> +			On CPUs that are vulnerable to the Speculative
> +			Store Bypass vulnerability and offer a
> +			firmware based mitigation, this parameter
> +			indicates how the mitigation should be used:
> +
> +			force-on:  Unconditionnaly enable mitigation for

			           Unconditionally

> +				   for both kernel and userspace
> +			force-off: Unconditionnaly disable mitigation for

			           Unconditionally

> +				   for both kernel and userspace
> +			kernel:    Always enable mitigation in the
> +				   kernel, and offer a prctl interface
> +				   to allow userspace to register its
> +				   interest in being mitigated too.
> +
>  	stack_guard_gap=	[MM]
>  			override the default stack gap protection. The value
>  			is in page units and it defines how many pages prior



-- 
~Randy
