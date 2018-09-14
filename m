Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC2B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC2B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeINWgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeINWgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 688E33DBFD;
        Fri, 14 Sep 2018 17:21:26 +0000 (UTC)
Received: from [10.36.116.58] (ovpn-116-58.ams2.redhat.com [10.36.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A976C2010CE7;
        Fri, 14 Sep 2018 17:21:23 +0000 (UTC)
Subject: Re: [PATCH] x86/kvm/lapic: always disable MMIO interface in x2APIC
 mode
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20180802150816.18374-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cd2619b9-52d9-9cf6-9ec1-8b7f014321ea@redhat.com>
Date:   Fri, 14 Sep 2018 19:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802150816.18374-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Sep 2018 17:21:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 17:08, Vitaly Kuznetsov wrote:
> When VMX is used with flexpriority disabled (because of no support or
> if disabled with module parameter) MMIO interface to lAPIC is still
> available in x2APIC mode while it shouldn't be (kvm-unit-tests):
> 
> PASS: apic_disable: Local apic enabled in x2APIC mode
> PASS: apic_disable: CPUID.1H:EDX.APIC[bit 9] is set
> FAIL: apic_disable: *0xfee00030: 50014
> 
> The issue appears because we basically do nothing while switching to
> x2APIC mode when APIC access page is not used. apic_mmio_{read,write}
> only check if lAPIC is disabled before proceeding to actual write.
> 
> When APIC access is virtualized we correctly manipulate with VMX controls
> in vmx_set_virtual_apic_mode() and we don't get vmexits from memory writes
> in x2APIC mode so there's no issue.
> 
> Disabling MMIO interface seems to be easy. The question is: what do we
> do with these reads and writes? If we add apic_x2apic_mode() check to
> apic_mmio_in_range() and return -EOPNOTSUPP these reads and writes will
> go to userspace. When lAPIC is in kernel, Qemu uses this interface to
> inject MSIs only (see kvm_apic_mem_write() in hw/i386/kvm/apic.c). This
> somehow works with disabled lAPIC but when we're in xAPIC mode we will
> get a real injected MSI from every write to lAPIC. Not good.
> 
> The simplest solution seems to be to just ignore writes to the region
> and return ~0 for all reads when we're in x2APIC mode. This is what this
> patch does. However, this approach is inconsistent with what currently
> happens when flexpriority is enabled: we allocate APIC access page and
> create KVM memory region so in x2APIC modes all reads and writes go to
> this pre-allocated page which is, btw, the same for all vCPUs.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since RFC:
> - add KVM_X86_QUIRK_LAPIC_MMIO_HOLE disabling the newly introduced
>   'MMIO hole' behavior [Paolo Bonzini]
> ---
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/lapic.c            | 22 +++++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 86299efa804a..fd23d5778ea1 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -377,6 +377,7 @@ struct kvm_sync_regs {
>  
>  #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
>  #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
> +#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
>  
>  #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
>  #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index b5cd8465d44f..83c4e8cc7eb9 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1291,9 +1291,8 @@ EXPORT_SYMBOL_GPL(kvm_lapic_reg_read);
>  
>  static int apic_mmio_in_range(struct kvm_lapic *apic, gpa_t addr)
>  {
> -	return kvm_apic_hw_enabled(apic) &&
> -	    addr >= apic->base_address &&
> -	    addr < apic->base_address + LAPIC_MMIO_LENGTH;
> +	return addr >= apic->base_address &&
> +		addr < apic->base_address + LAPIC_MMIO_LENGTH;
>  }
>  
>  static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> @@ -1305,6 +1304,15 @@ static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  	if (!apic_mmio_in_range(apic, address))
>  		return -EOPNOTSUPP;
>  
> +	if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
> +		if (!kvm_check_has_quirk(vcpu->kvm,
> +					 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
> +			return -EOPNOTSUPP;
> +
> +		memset(data, 0xff, len);
> +		return 0;
> +	}
> +
>  	kvm_lapic_reg_read(apic, offset, len, data);
>  
>  	return 0;
> @@ -1864,6 +1872,14 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  	if (!apic_mmio_in_range(apic, address))
>  		return -EOPNOTSUPP;
>  
> +	if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
> +		if (!kvm_check_has_quirk(vcpu->kvm,
> +					 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
> +			return -EOPNOTSUPP;
> +
> +		return 0;
> +	}
> +
>  	/*
>  	 * APIC register must be aligned on 128-bits boundary.
>  	 * 32/64/128 bits registers must be accessed thru 32 bits.
> 

Queued, thanks.

Paolo
