Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8220867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE8220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeIZCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbeIZCEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E01C3082141;
        Tue, 25 Sep 2018 19:55:33 +0000 (UTC)
Received: from [10.36.116.104] (ovpn-116-104.ams2.redhat.com [10.36.116.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012B25C8A7;
        Tue, 25 Sep 2018 19:55:26 +0000 (UTC)
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
 <09a6b9e5-e335-14cf-debd-de0f92dafd5e@redhat.com>
 <ebe81ebf-9b61-dbf6-743e-6145162cdcfb@linux.ibm.com>
 <69b5e3d3-5d44-37c0-ca10-720345852134@redhat.com>
 <df269178-b486-b091-4da4-731fc3f77e85@linux.ibm.com>
 <a59965e3-0624-65e7-f1dd-8656219dcbe2@redhat.com>
 <1a457c48-35f3-cb73-4db8-d3b50a82f211@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <76ee84e1-e7a7-10bf-ade1-008e48cba0ad@redhat.com>
Date:   Tue, 25 Sep 2018 21:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1a457c48-35f3-cb73-4db8-d3b50a82f211@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 25 Sep 2018 19:55:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 21:54, Tony Krowiak wrote:
> On 09/24/2018 03:55 PM, David Hildenbrand wrote:
>> On 24/09/2018 21:46, Tony Krowiak wrote:
>>> On 09/24/2018 02:40 PM, David Hildenbrand wrote:
>>>> On 24/09/2018 18:07, Tony Krowiak wrote:
>>>>> On 09/24/2018 04:40 AM, David Hildenbrand wrote:
>>>>>>
>>>>>>>      /**
>>>>>>> - * Verify that the AP instructions are available on the guest. This is
>>>>>>> indicated
>>>>>>> - * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
>>>>>>> + * Verify that the AP instructions are being interpreted by firmware
>>>>>>> for the
>>>>>>> + * guest. This is indicated by the kvm->arch.crypto.apie flag.
>>>>>>>       */
>>>>>>>      static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>>>>>>>      {
>>>>>>> -	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
>>>>>>> +	if (kvm->arch.crypto.apie)
>>>>>>>      		return 0;
>>>>>>
>>>>>> I wonder if this check makes sense, because apie can be toggled during
>>>>>> runtime. I guess it would be sufficient to check if the ap control block
>>>>>> is available and apie is supported by the HW.
>>>>>
>>>>> I am not clear about what you are getting at here, but I'll attempt
>>>>> to respond. There is no need to check if the AP control block (CRYCB)
>>>>> is available as the address is set in the CRYCBD three instructions
>>>>> above, even if AP instructions are not available. Regarding whether apie
>>>>> is supported by the hardware, the value of vcpu->kvm->arch.crypto.apie
>>>>> can not be set unless it is supported by the HW. In the patch (24/26)
>>>>> that provides the VM attributes to toggle this value, it can only be
>>>>> turned on if the AP instructions are available. I might also note that
>>>>> the kvm_ap_validate_crypto_setup() function is called whenever one of
>>>>> the VM crypto attributes is changed, so it makes sense that decisions
>>>>> made in this function are based on a change to a VM crypto attribute. In
>>>>> my first pass at changing this function, I checked
>>>>> ap_instructions_available() here, but after considering all of the
>>>>> above, it made sense to me to check the apie flag.
>>>>>
>>>>
>>>> I prefer ap_instructions_available(). As I said, kvm->arch.crypto.apie
>>>> is a moving target.
>>>
>>> Looking at this again, I think I responded before my brain shifted from
>>> digesting comments about patch 24/26 (enable/disable APIE) to the
>>> context for your comment here; namely, the device open callback. My
>>> comment above makes no sense in this context. From the perspective of
>>> the vfio_ap device driver, there is one requirement that must be met in
>>> order to provide pass-through functionality: The AP instructions must be
>>> must be interpreted by the HW (i.e., ECA.28 == 1). Checking whether AP
>>> instructions are available does not tell us whether they are being
>>> interpreted by HW. Checking whether the AP control block (i.e., CRYCB)
>>> is available, even when combined with the instruction availability
>>> check, does not provide any more insight into the value of ECA.28
>>> becuase the CRYCB will be provided if the MSAX3 facility is installed
>>> (STFLE.76) for the guest regardless of whether AP instructions are
>>> available or not. There is no doubt that if the AP instructions are
>>> not available, then the mdev open callback should fail, but it doesn't
>>> tell the whole story.
>>>
>>> I realize that our CPU model protects against configuring a vfio-ap
>>> device for the guest if ap=off, but this function knows nothing about
>>> userspace. I can make a similar argument that kvm->arch.crypto.apie
>>> will be switched on only if ap=on but again, that is userspace
>>> configuration.
>>>
>>> Having said all of the above, maybe it doesn't really matter whether
>>> AP instructions are being interpreted or not. If ECA.28 == 0, then
>>> the AP masks may very well be ignored since all AP instructions will
>>> be intercepted; so, maybe checking AP instruction availability is all
>>> that is needed. I will verify this and if I'm correct, I'll make the
>>> change you suggested.
>>
>> Yes, that was exactly what I had in mind - we just have to make sure
>> that the ap control block exists, so we can set the right mask bits. If
>> QEMU asks for an intercept, it shall get an intercept.
>>
>> But please proceed with whatever you think is best!
> 
> After discussing this with Halil, here's what I decided:
> * There will be no check for kvm->arch.crypto.apie here
> * A check for ap_instructions_available() will not be executed
>    here, but inserted into the vfio_ap module init function.
>    The module init function will fail (ENODEV) if the AP
>    instructions are not installed. In my (our) opinion that
>    makes more sense given the purpose of the vfio_ap driver is
>    to pass through the AP instructions to the guest.
> * A check will be added here to verify the CRYCB is available (i.e.,
>    matrix_mdev->kvm->arch.crypto.crycbd != 0).
> 

Sounds good to me!


-- 

Thanks,

David / dhildenb
