Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C21ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991F820869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991F820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeJTAxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeJTAxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45AE52D2691;
        Fri, 19 Oct 2018 16:46:17 +0000 (UTC)
Received: from [10.36.112.30] (ovpn-112-30.ams2.redhat.com [10.36.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B12BC54377;
        Fri, 19 Oct 2018 16:45:57 +0000 (UTC)
Subject: Re: [PATCH] x86/kvm/nVMX: tweak shadow fields
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20181019141603.15995-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <31279dfd-d0a1-3720-46a2-52395a124057@redhat.com>
Date:   Fri, 19 Oct 2018 18:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181019141603.15995-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 19 Oct 2018 16:46:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 16:16, Vitaly Kuznetsov wrote:
> It seems we have some leftovers from times when 'unrestricted guest'
> wasn't exposed to L1. Stop shadowing GUEST_CS_{BASE,LIMIT,AR_SELECTOR}
> and GUEST_ES_BASE, shadow GUEST_SS_AR_BYTES as it was found that some
> hypervisors (e.g. Hyper-V without Enlightened VMCS) access it pretty
> often.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued, thanks.

Paolo

> ---
>  arch/x86/kvm/vmx.c               | 10 +++++-----
>  arch/x86/kvm/vmx_shadow_fields.h |  5 +----
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index abeeb45d1c33..641a65b30685 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -12715,6 +12715,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>  			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>  		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
> +		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>  		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
>  		vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
>  		vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
> @@ -12722,6 +12723,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
>  		vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
>  		vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
> +		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>  		vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
>  		vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
>  		vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
> @@ -12731,12 +12733,13 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
>  		vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
>  		vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
> -		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>  		vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
>  		vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
>  		vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
>  		vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
>  		vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
> +		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
> +		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>  		vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
>  		vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
>  		vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
> @@ -12838,11 +12841,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	 */
>  	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>  			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
> -		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
> -		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>  		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
> -		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
> -		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
> +		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>  	}
>  
>  	if (vmx->nested.nested_run_pending &&
> diff --git a/arch/x86/kvm/vmx_shadow_fields.h b/arch/x86/kvm/vmx_shadow_fields.h
> index cd0c75f6d037..132432f375c2 100644
> --- a/arch/x86/kvm/vmx_shadow_fields.h
> +++ b/arch/x86/kvm/vmx_shadow_fields.h
> @@ -28,7 +28,6 @@
>   */
>  
>  /* 16-bits */
> -SHADOW_FIELD_RW(GUEST_CS_SELECTOR)
>  SHADOW_FIELD_RW(GUEST_INTR_STATUS)
>  SHADOW_FIELD_RW(GUEST_PML_INDEX)
>  SHADOW_FIELD_RW(HOST_FS_SELECTOR)
> @@ -47,8 +46,8 @@ SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE)
>  SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD)
>  SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN)
>  SHADOW_FIELD_RW(TPR_THRESHOLD)
> -SHADOW_FIELD_RW(GUEST_CS_LIMIT)
>  SHADOW_FIELD_RW(GUEST_CS_AR_BYTES)
> +SHADOW_FIELD_RW(GUEST_SS_AR_BYTES)
>  SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO)
>  SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE)
>  
> @@ -61,8 +60,6 @@ SHADOW_FIELD_RW(GUEST_CR0)
>  SHADOW_FIELD_RW(GUEST_CR3)
>  SHADOW_FIELD_RW(GUEST_CR4)
>  SHADOW_FIELD_RW(GUEST_RFLAGS)
> -SHADOW_FIELD_RW(GUEST_CS_BASE)
> -SHADOW_FIELD_RW(GUEST_ES_BASE)
>  SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK)
>  SHADOW_FIELD_RW(CR0_READ_SHADOW)
>  SHADOW_FIELD_RW(CR4_READ_SHADOW)
> 

