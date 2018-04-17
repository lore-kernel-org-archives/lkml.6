Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDQIlL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeDQIlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:41:10 -0400
Date: Tue, 17 Apr 2018 10:40:49 +0200
From: Borislav Petkov <bp@suse.de>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, rientjes@google.com
Subject: Re: [PATCH v2 2/2] x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB
 when available
Message-ID: <20180417084049.GC18808@pd.tnic>
References: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1522824314-25345-3-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522824314-25345-3-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 01:45:14AM -0500, Suravee Suthikulpanit wrote:
> Derive topology information from Extended Topology Enumeration
> (CPUID Fn0x0000000B) when the information is available.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2c1a9f2..cdd67d1 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -327,6 +327,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
>  
>  	/* get information required for multi-node processors */
>  	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
> +		int err;
>  		u32 eax, ebx, ecx, edx;
>  
>  		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
> @@ -344,6 +345,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
>  				c->x86_max_cores /= smp_num_siblings;
>  		}
>  
> +		/*
> +		 * In case leaf B is avaialble, use leaf B to derive

s/avaialble/available/

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
