Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968287AbeEYTuP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:50:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967858AbeEYTuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:50:13 -0400
Date: Fri, 25 May 2018 21:50:10 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/KVM: Fix incorrect SSBD bit in
 kvm_cpuid_7_0_edx_x86_features
Message-ID: <20180525195009.GC26007@flask>
References: <1527268584-752-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527268584-752-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-25 13:16-0400, Waiman Long:
> As the SSBD bit in kvm_cpuid_7_0_edx_x86_features has been renamed to
> SPEC_CTRL_SSBD in the commit 52817587e706 ("x86/cpufeatures: Disentangle
> SSBD enumeration"). The corresponding name change needed to be made in
> the KVM code as well.
> 
> Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Thomas, are you taking this one?

>  arch/x86/kvm/cpuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ced8511..598461e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -407,8 +407,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
> -		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(SSBD) |
> -		F(ARCH_CAPABILITIES);
> +		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> -- 
> 1.8.3.1
> 
