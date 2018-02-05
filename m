Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeBENny (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbeBENno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:43:44 -0500
Date: Mon, 5 Feb 2018 14:43:24 +0100
From: Radim Krcmar <rkrcmar@redhat.com>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>
Subject: Re: [PATCH v4 3/3] x86/kvm: Expose AMD Core Perf Extension flag to
 guests
Message-ID: <20180205134321.GD27896@flask>
References: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
 <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-30 11:32-0600, Janakarajan Natarajan:
> Expose the AMD Core Perf Extension flag to the guests.
> 
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> @@ -365,7 +371,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
>  		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
>  		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
> -		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
> +		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM) | f_perfext;

You can just say F(PERFCTR_CORE) here.  The conditional features are
needed when there is a runtime config option for them.  We are
automatically masking features that the host doesn't support,

thanks.

>  
>  	/* cpuid 0xC0000001.edx */
>  	const u32 kvm_cpuid_C000_0001_edx_x86_features =
> -- 
> 2.7.4
> 
