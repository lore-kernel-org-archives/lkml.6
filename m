Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A23FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445CD2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfBVRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:12:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A264681E13;
        Fri, 22 Feb 2019 17:12:16 +0000 (UTC)
Received: from [10.36.112.23] (ovpn-112-23.ams2.redhat.com [10.36.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB5F360BF1;
        Fri, 22 Feb 2019 17:12:13 +0000 (UTC)
Subject: Re: [PATCH] x86/kvm/mmu: fix switch between root and guest MMUs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20190222164501.13605-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <9516b2a1-875e-1850-ed2f-0c8e94eab980@redhat.com>
Date:   Fri, 22 Feb 2019 18:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222164501.13605-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 22 Feb 2019 17:12:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/19 17:45, Vitaly Kuznetsov wrote:
> Commit 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu") brought one subtle
> change: previously, when switching back from L2 to L1, we were resetting
> MMU hooks (like mmu->get_cr3()) in kvm_init_mmu() called from
> nested_vmx_load_cr3() and now we do that in nested_ept_uninit_mmu_context()
> when we re-target vcpu->arch.mmu pointer.
> The change itself looks logical: if nested_ept_init_mmu_context() changes
> something than nested_ept_uninit_mmu_context() restores it back. There is,
> however, one thing: the following call chain:
> 
>  nested_vmx_load_cr3()
>   kvm_mmu_new_cr3()
>     __kvm_mmu_new_cr3()
>       fast_cr3_switch()
>         cached_root_available()
> 
> now happens with MMU hooks pointing to the new MMU (root MMU in our case)
> while previously it was happening with the old one. cached_root_available()
> tries to stash current root but it is incorrect to read current CR3 with
> mmu->get_cr3(), we need to use old_mmu->get_cr3() which in case we're
> switching from L2 to L1 is guest_mmu. (BTW, in shadow page tables case this
> is a non-issue because we don't switch MMU).
> 
> While we could've tried to guess that we're switching between MMUs and call
> the right ->get_cr3() from cached_root_available() this seems to be overly
> complicated. Instead, just stash the corresponding CR3 when setting
> root_hpa and make cached_root_available() use the stashed value.
> 
> Fixes: 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Is the bug latent until the other patch?  Or are they completely
separate issues?

Thanks,

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/mmu.c              | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index be87f71ccaa5..180373360e34 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -398,6 +398,7 @@ struct kvm_mmu {
>  	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>  			   u64 *spte, const void *pte);
>  	hpa_t root_hpa;
> +	gpa_t root_cr3;
>  	union kvm_mmu_role mmu_role;
>  	u8 root_level;
>  	u8 shadow_root_level;
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 90ba1a1755a4..f2d1d230d5b8 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3555,6 +3555,7 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  							   &invalid_list);
>  			mmu->root_hpa = INVALID_PAGE;
>  		}
> +		mmu->root_cr3 = 0;
>  	}
>  
>  	kvm_mmu_commit_zap_page(vcpu->kvm, &invalid_list);
> @@ -3610,6 +3611,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
>  		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
>  	} else
>  		BUG();
> +	vcpu->arch.mmu->root_cr3 = vcpu->arch.mmu->get_cr3(vcpu);
>  
>  	return 0;
>  }
> @@ -3618,10 +3620,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu_page *sp;
>  	u64 pdptr, pm_mask;
> -	gfn_t root_gfn;
> +	gfn_t root_gfn, root_cr3;
>  	int i;
>  
> -	root_gfn = vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
> +	root_cr3 = vcpu->arch.mmu->get_cr3(vcpu);
> +	root_gfn = root_cr3 >> PAGE_SHIFT;
>  
>  	if (mmu_check_root(vcpu, root_gfn))
>  		return 1;
> @@ -3646,7 +3649,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  		++sp->root_count;
>  		spin_unlock(&vcpu->kvm->mmu_lock);
>  		vcpu->arch.mmu->root_hpa = root;
> -		return 0;
> +		goto set_root_cr3;
>  	}
>  
>  	/*
> @@ -3712,6 +3715,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
>  	}
>  
> +set_root_cr3:
> +	vcpu->arch.mmu->root_cr3 = root_cr3;
> +
>  	return 0;
>  }
>  
> @@ -4163,7 +4169,7 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_cr3,
>  	struct kvm_mmu_root_info root;
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
>  
> -	root.cr3 = mmu->get_cr3(vcpu);
> +	root.cr3 = mmu->root_cr3;
>  	root.hpa = mmu->root_hpa;
>  
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
> @@ -4176,6 +4182,7 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_cr3,
>  	}
>  
>  	mmu->root_hpa = root.hpa;
> +	mmu->root_cr3 = root.cr3;
>  
>  	return i < KVM_MMU_NUM_PREV_ROOTS;
>  }
> @@ -5517,11 +5524,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  
>  	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
> +	vcpu->arch.root_mmu.root_cr3 = 0;
>  	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
>  		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
>  
>  	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
> +	vcpu->arch.guest_mmu.root_cr3 = 0;
>  	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
>  		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
> 

