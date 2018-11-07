Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C40C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E21820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E21820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeKGXIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbeKGXII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:08:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32ADB3082A2C;
        Wed,  7 Nov 2018 13:37:44 +0000 (UTC)
Received: from [10.36.112.47] (ovpn-112-47.ams2.redhat.com [10.36.112.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D67F360BEE;
        Wed,  7 Nov 2018 13:37:41 +0000 (UTC)
Subject: Re: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Alexander Potapenko <glider@google.com>,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
References: <0000000000005de8da057a092ba2@google.com>
 <CAG_fn=Wmc+YU8BMcY_RXxAvVTpAMez5QUFyQSH3UsRg4Y-ZwMQ@mail.gmail.com>
 <9d2e26fb-1d2a-248f-5451-ee95d8a6c017@redhat.com>
 <5A114BC0-96E7-41AF-A975-EC3B87A5A60D@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
Date:   Wed, 7 Nov 2018 14:37:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5A114BC0-96E7-41AF-A975-EC3B87A5A60D@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 07 Nov 2018 13:37:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 13:58, Liran Alon wrote:
> 
> 
>> On 7 Nov 2018, at 14:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 07/11/2018 13:10, Alexander Potapenko wrote:
>>> This appears to be a real bug in KVM.
>>> Please see a simplified reproducer attached.
>>
>> Thanks, I agree it's a reael bug.  The basic issue is that the
>> kvm_state->size member is too small (1040) in the KVM_SET_NESTED_STATE
>> ioctl, aka 0x4080aebf.
>>
>> One way to fix it would be to just change kmalloc to kzalloc when
>> allocating cached_vmcs12 and cached_shadow_vmcs12, but really the ioctl
>> is wrong and should be rejected.  And the case where a shadow VMCS has
>> to be loaded is even more wrong, and we have to fix it anyway, so I
>> don't really like the idea of papering over the bug in the allocation.
>>
>> I'll test this patch and submit it formally:
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index c645f777b425..c546f0b1f3e0 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -14888,10 +14888,13 @@ static int vmx_set_nested_state(struct
>> kvm_vcpu *vcpu,
>> 	if (ret)
>> 		return ret;
>>
>> -	/* Empty 'VMXON' state is permitted */
>> -	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
>> +	/* Empty 'VMXON' state is permitted.  A partial VMCS12 is not.  */
>> +	if (kvm_state->size == sizeof(kvm_state))
>> 		return 0;
>>
>> +	if (kvm_state->size < sizeof(kvm_state) + VMCS12_SIZE)
>> +		return -EINVAL;
>> +
> 
> I don’t think that this test is sufficient to fully resolve issue.
> What if malicious userspace supplies valid size but pages containing nested_state->vmcs12 is unmapped?
> This will result in vmx_set_nested_state() still calling set_current_vmptr() but failing on copy_from_user()
> which still leaks cached_vmcs12 on next VMPTRLD of guest.

Makes sense; since SET_NESTED_STATE is not a fast path, we can just
memdup_user and pass a kernel pointer to vmx_set_nested_state.

> Therefore, I think that the correct patch should be to change vmx_set_nested_state() to
> first gather all relevant information from userspace and validate it,
> and only then start applying it to KVM’s internal vCPU state.
> 
>> 	if (kvm_state->vmx.vmcs_pa != -1ull) {
>> 		if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
>> 		    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
>> @@ -14917,6 +14920,7 @@ static int vmx_set_nested_state(struct kvm_vcpu
>> *vcpu,
>> 	}
>>
>> 	vmcs12 = get_vmcs12(vcpu);
>> +	BUILD_BUG_ON(sizeof(*vmcs12) > VMCS12_SIZE);
> 
> Why put this BUILD_BUG_ON() specifically here?
> There are many places which assumes cached_vmcs12 is of size VMCS12_SIZE.
> (Such as nested_release_vmcs12() and handle_vmptrld()).

Unlike those places, here the copy has sizeof(*vmcs12) bytes and an
overflow would cause a userspace write to kernel memory.  Though, that
means there is still a possibility of leaking kernel data when
nested_release_vmcs12 is called.  So it also makes sense to use
VMCS12_SIZE for the memory copies, and kzalloc.

Thanks,

Paolo

>> 	if (copy_from_user(vmcs12, user_kvm_nested_state->data, sizeof(*vmcs12)))
>> 		return -EFAULT;
>>
>> @@ -14932,7 +14936,7 @@ static int vmx_set_nested_state(struct kvm_vcpu
>> *vcpu,
>> 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
>> 	    vmcs12->vmcs_link_pointer != -1ull) {
>> 		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
>> -		if (kvm_state->size < sizeof(kvm_state) + 2 * sizeof(*vmcs12))
>> +		if (kvm_state->size < sizeof(kvm_state) + 2 * VMCS12_SIZE)
>> 			return -EINVAL;
>>
>> 		if (copy_from_user(shadow_vmcs12,
>>
>> Paolo
> 
> -Liran
> 
> 

