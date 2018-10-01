Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E410A204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E410A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJAWjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJAWjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:39:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3728080F9A;
        Mon,  1 Oct 2018 16:01:26 +0000 (UTC)
Received: from [10.36.117.216] (ovpn-117-216.ams2.redhat.com [10.36.117.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3996D1001903;
        Mon,  1 Oct 2018 16:01:21 +0000 (UTC)
Subject: Re: [PATCH v6 7/7] KVM: x86: hyperv: implement PV IPI send hypercalls
To:     Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-8-vkuznets@redhat.com>
 <20180927110711.GE4186@rkaganb.sw.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <51ff55e0-9d8d-73be-e0e7-f8580bc0206e@redhat.com>
Date:   Mon, 1 Oct 2018 18:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927110711.GE4186@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 01 Oct 2018 16:01:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2018 13:07, Roman Kagan wrote:
> On Wed, Sep 26, 2018 at 07:02:59PM +0200, Vitaly Kuznetsov wrote:
>> Using hypercall for sending IPIs is faster because this allows to specify
>> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
>> will take only one VMEXIT.
>>
>> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
>> hypercall can't be 'fast' (passing parameters through registers) but
>> apparently this is not true, Windows always uses it as 'fast' so we need
>> to support that.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  Documentation/virtual/kvm/api.txt |   7 ++
>>  arch/x86/kvm/hyperv.c             | 115 ++++++++++++++++++++++++++++++
>>  arch/x86/kvm/trace.h              |  42 +++++++++++
>>  arch/x86/kvm/x86.c                |   1 +
>>  include/uapi/linux/kvm.h          |   1 +
>>  5 files changed, 166 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 647f94128a85..1659b75d577d 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4772,3 +4772,10 @@ CPU when the exception is taken. If this virtual SError is taken to EL1 using
>>  AArch64, this value will be reported in the ISS field of ESR_ELx.
>>  
>>  See KVM_CAP_VCPU_EVENTS for more details.
>> +8.20 KVM_CAP_HYPERV_SEND_IPI
>> +
>> +Architectures: x86
>> +
>> +This capability indicates that KVM supports paravirtualized Hyper-V IPI send
>> +hypercalls:
>> +HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index cc0535a078f7..4b4a6d015ade 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1405,6 +1405,107 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>>  }
>>  
>> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
>> +			   bool ex, bool fast)
>> +{
>> +	struct kvm *kvm = current_vcpu->kvm;
>> +	struct kvm_hv *hv = &kvm->arch.hyperv;
>> +	struct hv_send_ipi_ex send_ipi_ex;
>> +	struct hv_send_ipi send_ipi;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned long valid_bank_mask;
>> +	u64 sparse_banks[64];
>> +	int sparse_banks_len, bank, i, sbank;
>> +	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
>> +	bool all_cpus;
>> +
>> +	if (!ex) {
>> +		if (!fast) {
>> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
>> +						    sizeof(send_ipi))))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +			sparse_banks[0] = send_ipi.cpu_mask;
>> +			irq.vector = send_ipi.vector;
>> +		} else {
>> +			/* 'reserved' part of hv_send_ipi should be 0 */
>> +			if (unlikely(ingpa >> 32 != 0))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +			sparse_banks[0] = outgpa;
>> +			irq.vector = (u32)ingpa;
>> +		}
>> +		all_cpus = false;
>> +		valid_bank_mask = BIT_ULL(0);
>> +
>> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
>> +	} else {
>> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
>> +					    sizeof(send_ipi_ex))))
>> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +
>> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
>> +					 send_ipi_ex.vp_set.format,
>> +					 send_ipi_ex.vp_set.valid_bank_mask);
>> +
>> +		irq.vector = send_ipi_ex.vector;
>> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
>> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
>> +			sizeof(sparse_banks[0]);
>> +
>> +		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>> +
>> +		if (!sparse_banks_len)
>> +			goto ret_success;
>> +
>> +		if (!all_cpus &&
>> +		    kvm_read_guest(kvm,
>> +				   ingpa + offsetof(struct hv_send_ipi_ex,
>> +						    vp_set.bank_contents),
>> +				   sparse_banks,
>> +				   sparse_banks_len))
>> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +	}
>> +
>> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
>> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
>> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +
>> +	if (all_cpus || atomic_read(&hv->num_mismatched_vp_indexes)) {
>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>> +			if (all_cpus || hv_vcpu_in_sparse_set(
>> +				    &vcpu->arch.hyperv, sparse_banks,
>> +				    valid_bank_mask)) {
>> +				/* We fail only when APIC is disabled */
>> +				kvm_apic_set_irq(vcpu, &irq, NULL);
>> +			}
>> +		}
>> +		goto ret_success;
>> +	}
>> +
>> +	/*
>> +	 * num_mismatched_vp_indexes is zero so every vcpu has
>> +	 * vp_index == vcpu_idx.
>> +	 */
>> +	sbank = 0;
>> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask, 64) {
>> +		for_each_set_bit(i, (unsigned long *)&sparse_banks[sbank], 64) {
>> +			u32 vp_index = bank * 64 + i;
>> +			struct kvm_vcpu *vcpu =
>> +				get_vcpu_by_vpidx(kvm, vp_index);
>> +
>> +			/* Unknown vCPU specified */
>> +			if (!vcpu)
>> +				continue;
>> +
>> +			/* We fail only when APIC is disabled */
>> +			kvm_apic_set_irq(vcpu, &irq, NULL);
>> +		}
>> +		sbank++;
>> +	}
>> +
>> +ret_success:
>> +	return HV_STATUS_SUCCESS;
>> +}
>> +
> 
> I must say that now it looks even more tempting to follow the same
> pattern as your kvm_hv_flush_tlb: define a function that would call
> kvm_apic_set_irq() on all vcpus in a mask (optimizing the all-set case
> with a NULL mask), and make kvm_hv_send_ipi perform the same hv_vp_set
> -> vcpu_mask transformation followed by calling into that function.


It would perhaps be cleaner, but really kvm_apic_set_irq is as efficient
as it can be, since it takes the destination vcpu directly.

The code duplication for walking the sparse set is a bit ugly, perhaps
that could be changed to use an iterator macro.

Paolo
