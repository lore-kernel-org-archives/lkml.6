Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bShiLPVMGVukZQAAmS7hNA
	; Thu, 07 Jun 2018 15:20:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 128E26089E; Thu,  7 Jun 2018 15:20:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 611E66063F;
	Thu,  7 Jun 2018 15:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 611E66063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935654AbeFGPUx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:20:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935477AbeFGPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:20:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57FJAdi081301
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 11:20:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf656bg1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:20:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 7 Jun 2018 16:20:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 16:20:43 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57FKfjt24117420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 15:20:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C80475203F;
        Thu,  7 Jun 2018 15:10:18 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 260DD52041;
        Thu,  7 Jun 2018 15:10:18 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 7 Jun 2018 17:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060715-0008-0000-0000-0000024538F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060715-0009-0000-0000-000021AB4B03
Message-Id: <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 15:54, Tony Krowiak wrote:
> On 06/06/2018 01:40 PM, Pierre Morel wrote:
>> On 06/06/2018 18:08, Pierre Morel wrote:
>>> On 06/06/2018 16:28, Tony Krowiak wrote:
>>>> On 06/05/2018 08:19 AM, Pierre Morel wrote:
>>>>> On 30/05/2018 16:33, Tony Krowiak wrote:
>>>>>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>>>>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>>>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>>>> Implements the open callback on the mediated matrix device.
>>>>>>>>>> The function registers a group notifier to receive notification
>>>>>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>>>>>
>>>>>>>>>> 1. Ensure that only one mediated device is opened for the guest
>>>>>>>
>>>>>>> You should explain why.
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>>>>>
>>>>>>> ...snip...
>>>>>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>>>>>> +{
>>>>>>>>>> + atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>>>>>> +
>>>>>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>>>>>> +{
>>>>>>>>>> + atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>>>>>> +}
>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>>>>>
>>>>>>>>> Why are these functions inside kvm-ap ?
>>>>>>>>> Will anyone use this outer of vfio-ap ?
>>>>>>>>
>>>>>>>> As I've stated before, I made the choice to contain all 
>>>>>>>> interfaces that
>>>>>>>> access KVM in kvm-ap because I don't think it is appropriate 
>>>>>>>> for the device
>>>>>>>> driver to have to have "knowledge" of the inner workings of 
>>>>>>>> KVM. Why does
>>>>>>>> it matter whether any entity outside of the vfio_ap device 
>>>>>>>> driver calls
>>>>>>>> these functions? I could ask a similar question if the 
>>>>>>>> interfaces were
>>>>>>>> contained in vfio-ap; what if another device driver needs 
>>>>>>>> access to these
>>>>>>>> interfaces?
>>>>>>>
>>>>>>> This is very driver specific and only used during initialization.
>>>>>>> It is not a common property of the cryptographic interface.
>>>>>>>
>>>>>>> I really think you should handle this inside the driver.
>>>>>>
>>>>>> We are going to have to agree to disagree on this one. Is it not 
>>>>>> possible
>>>>>> that future drivers - e.g., when full virtualization is 
>>>>>> implemented - will
>>>>>> require access to KVM?
>>>>>
>>>>> I do not think that an access to KVM is required for full 
>>>>> virtualization.
>>>>
>>>> You may be right, but at this point, there is no guarantee. I stand 
>>>> by my
>>>> design on this one.
>>>
>>> I really regret that we abandoned the initial design with the matrix 
>>> bus and one
>>> single parent matrix device per guest.
>>> We would not have the problem of these KVM dependencies.
>>>
>>> It had the advantage of taking care of having only one device per guest
>>> (available_instance = 1), could take care of provisioning as you have
>>> sysfs entries available for a matrix without having a guest and a 
>>> mediated
>>> device.
>>>
>>> it also had advantage for virtualization to keep host side and guest 
>>> side matrix
>>> separate inside parent (host side) and mediated device (guest side).
>>>
>>> Shouldn't we treat this problem with a design using standard interfaces
>>> Instead of adding new dedicated interfaces?
>>>
>>> Regards,
>>>
>>> Pierre
>>>
>>>
>>
>> Forget it.
>>
>> I am not happy with the design but the design I was speaking of may 
>> not be the solution either.
>
> The AP architecture makes virtualization of AP devices complex. We 
> tried the solution you
> described and found it to be sorely lacking which is why we ended up 
> where we are now.

I did not see any explanation on why between v1 and v2 as it was abandoned.


We have internal structures like the ap_matrix and kvm_ap_matrix
which look like the bus/devices we had previously but are differently
or not at all integrated with the LDD.

Also I think that with a little data structure refactoring you can avoid 
most of
the code in the arch/s390/kvm.

For example, storing the kvm pointer inside the kvm_ap_matrix and
maintaining a list of the kvm_ap_matrix structures allows to easily know
if a guest already has an associated mediated device.

Pierre

>
>>
>>
>> Sorry for the noise.
>>
>> Regards,
>>
>> Pierre
>>
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
