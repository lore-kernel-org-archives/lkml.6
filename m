Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491620-2-7996649634352526812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491619; b=sqA8U48N99ZahmtT4yH9oaKwGtrEh+gyJViKhFwjxz6IEP0
    vPjVcB5iHhiTFiNlGcU9xTBuH+eCv4x16Ue+EvwyaWCD66nTPDPorsF0XFX4Lqju
    Bjo+qM8i/gM1wQV0snAKlfcWEn9waj9xgDrAdWI68c3fzw01rByxVLhjvyOIvm3y
    QA3q6w+4X0599CzITgOt1gzzaOZZE+dESVjO4Ff27X28zwRkyfDnDUDAY/C3WPqO
    P4u2IphH0jPGIdSKcnNLAUZ3qJGk2H/q4gqSntnLBktY5xAkCN2wtPVNU/ND8Uga
    BCvQ0wQ1bim/qdW8hnCLJR03WvW9qGJIpaRy6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520491619; bh=1SFUL5gBegQL/MWMl7kvFtvmSBSTGfuA5x5BXb9hTx0=; b=L
    X4egmJbQnKljAoJWw8Iq1sy3b58/p/KtkzFhhKaAl3ZhDWK9VDHFG3rrEeluFwTa
    jneGsKDLB+8mZrTpieFZzFthD8yiEGRSRJVKvjRy5vbNh/j0Ijk5pbYnizM5arL9
    di3qFMgwkngC/N/rMgLYt7a+bx0lCGC4yNf39H2zZ9bAJI+OtMhrd0+jcvUfv3Gf
    h4ByKYsefez3tZszcVFDFM9QRiHfBY16u201UKjhvqMXvOr74RT+QHJx8DZkCB1A
    KHXNoQYs7SWrmAuHsTOb9Nal4IcPAka42vyvzBIGu9qwVpUUEgcd34HgRwlvgJqA
    tPyaZGtwdAkMHTKpw5rbg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965230AbeCHGqp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935041AbeCHGqk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 01:46:40 -0500
Date: Thu, 8 Mar 2018 01:46:39 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <1211566882.5943983.1520491599636.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180308045641.7814-12-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com> <20180308045641.7814-12-alexander.levin@microsoft.com>
Subject: Re: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for
 emulating UMIP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.36.191.219, 10.4.196.4, 10.4.195.13]
Thread-Topic: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for
 emulating UMIP
Thread-Index: AQHTtpn6RxGhJxHWy02eLbnawN2M7MGVFwZS
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



----- Original Message -----
> From: "Sasha Levin" <Alexander.Levin@microsoft.com>
> To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
> Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Sasha Levin" <Alexander.Levin@microsoft.com>
> Sent: Thursday, March 8, 2018 5:57:36 AM
> Subject: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for emulating UMIP
> 
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit 66336cab3531d3325ebde36a04725dddd0c42cb5 ]
> 
> The User-Mode Instruction Prevention feature present in recent Intel
> processor prevents a group of instructions (sgdt, sidt, sldt, smsw, and
> str) from being executed with CPL > 0. Otherwise, a general protection
> fault is issued.
> 
> UMIP instructions in general are also able to trigger vmexits, so we can
> actually emulate UMIP on older processors.  This commit sets up the
> infrastructure so that kvm-intel.ko and kvm-amd.ko can set the UMIP
> feature bit for CPUID even if the feature is not actually available
> in hardware.
> 
> Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

This is not enough (there were a couple bugs, plus you have not
added the changes needed to the handle SLDT, STR, etc. in the
emulator).  But since this is a feature, why is it being backported
to 4.14, especially without any testing??

Thanks,

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/cpuid.c            | 2 ++
>  arch/x86/kvm/svm.c              | 6 ++++++
>  arch/x86/kvm/vmx.c              | 6 ++++++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> index 4f8b80199672..52ecf9b2f61e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1004,6 +1004,7 @@ struct kvm_x86_ops {
>  	void (*handle_external_intr)(struct kvm_vcpu *vcpu);
>  	bool (*mpx_supported)(void);
>  	bool (*xsaves_supported)(void);
> +	bool (*umip_emulated)(void);
>  
>  	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 13f5d4217e4f..f3fc225f5ebb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -325,6 +325,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2
> *entry, u32 function,
>  	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
>  	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
>  	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
> +	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
>  
>  	/* cpuid 1.edx */
>  	const u32 kvm_cpuid_1_edx_x86_features =
> @@ -476,6 +477,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2
> *entry, u32 function,
>  			entry->ebx |= F(TSC_ADJUST);
>  			entry->ecx &= kvm_cpuid_7_0_ecx_x86_features;
>  			cpuid_mask(&entry->ecx, CPUID_7_ECX);
> +			entry->ecx |= f_umip;
>  			/* PKU is not yet implemented for shadow paging. */
>  			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
>  				entry->ecx &= ~F(PKU);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index e0bc3ad0f6cd..8ea19bf09202 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5322,6 +5322,11 @@ static bool svm_xsaves_supported(void)
>  	return false;
>  }
>  
> +static bool svm_umip_emulated(void)
> +{
> +	return false;
> +}
> +
>  static bool svm_has_wbinvd_exit(void)
>  {
>  	return true;
> @@ -5633,6 +5638,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init =
> {
>  	.invpcid_supported = svm_invpcid_supported,
>  	.mpx_supported = svm_mpx_supported,
>  	.xsaves_supported = svm_xsaves_supported,
> +	.umip_emulated = svm_umip_emulated,
>  
>  	.set_supported_cpuid = svm_set_supported_cpuid,
>  
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 5ffde16253cb..924d88d5ca35 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -9212,6 +9212,11 @@ static bool vmx_xsaves_supported(void)
>  		SECONDARY_EXEC_XSAVES;
>  }
>  
> +static bool vmx_umip_emulated(void)
> +{
> +	return false;
> +}
> +
>  static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
>  {
>  	u32 exit_intr_info;
> @@ -12252,6 +12257,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init
> = {
>  	.handle_external_intr = vmx_handle_external_intr,
>  	.mpx_supported = vmx_mpx_supported,
>  	.xsaves_supported = vmx_xsaves_supported,
> +	.umip_emulated = vmx_umip_emulated,
>  
>  	.check_nested_events = vmx_check_nested_events,
>  
> --
> 2.14.1
> 
