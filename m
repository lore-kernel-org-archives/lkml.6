Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AW49GJ1dGVvRegAAmS7hNA
	; Thu, 07 Jun 2018 16:30:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 38809607E7; Thu,  7 Jun 2018 16:30:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70CC860590;
	Thu,  7 Jun 2018 16:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70CC860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeFGQaS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:30:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753707AbeFGQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:30:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57GTX31066921
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 12:30:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf85a0e6m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:30:15 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 12:30:14 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 12:30:11 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57GU9Z85964054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 16:30:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D93F712405E;
        Thu,  7 Jun 2018 13:31:33 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C3212405A;
        Thu,  7 Jun 2018 13:31:32 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.135.133])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 13:31:32 -0400 (EDT)
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 12:30:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060716-2213-0000-0000-000002B4D643
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009146; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043567; UDB=6.00534345; IPR=6.00822656;
 MB=3.00021513; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 16:30:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060716-2214-0000-0000-00005A6551F4
Message-Id: <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 11:20 AM, Pierre Morel wrote:
> On 07/06/2018 15:54, Tony Krowiak wrote:
>> On 06/06/2018 01:40 PM, Pierre Morel wrote:
>>> On 06/06/2018 18:08, Pierre Morel wrote:
>>>> On 06/06/2018 16:28, Tony Krowiak wrote:
>>>>> On 06/05/2018 08:19 AM, Pierre Morel wrote:
>>>>>> On 30/05/2018 16:33, Tony Krowiak wrote:
>>>>>>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>>>>>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>>>>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>>>>> Implements the open callback on the mediated matrix device.
>>>>>>>>>>> The function registers a group notifier to receive notification
>>>>>>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>>>>>>
>>>>>>>>>>> 1. Ensure that only one mediated device is opened for the guest
>>>>>>>>
>>>>>>>> You should explain why.
>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>>>>>>
>>>>>>>> ...snip...
>>>>>>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>>>>>>> +{
>>>>>>>>>>> + atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>>>>>>> +}
>>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>>>>>>> +
>>>>>>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>>>>>>> +{
>>>>>>>>>>> + atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>>>>>>> +}
>>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>>>>>>
>>>>>>>>>> Why are these functions inside kvm-ap ?
>>>>>>>>>> Will anyone use this outer of vfio-ap ?
>>>>>>>>>
>>>>>>>>> As I've stated before, I made the choice to contain all 
>>>>>>>>> interfaces that
>>>>>>>>> access KVM in kvm-ap because I don't think it is appropriate 
>>>>>>>>> for the device
>>>>>>>>> driver to have to have "knowledge" of the inner workings of 
>>>>>>>>> KVM. Why does
>>>>>>>>> it matter whether any entity outside of the vfio_ap device 
>>>>>>>>> driver calls
>>>>>>>>> these functions? I could ask a similar question if the 
>>>>>>>>> interfaces were
>>>>>>>>> contained in vfio-ap; what if another device driver needs 
>>>>>>>>> access to these
>>>>>>>>> interfaces?
>>>>>>>>
>>>>>>>> This is very driver specific and only used during initialization.
>>>>>>>> It is not a common property of the cryptographic interface.
>>>>>>>>
>>>>>>>> I really think you should handle this inside the driver.
>>>>>>>
>>>>>>> We are going to have to agree to disagree on this one. Is it not 
>>>>>>> possible
>>>>>>> that future drivers - e.g., when full virtualization is 
>>>>>>> implemented - will
>>>>>>> require access to KVM?
>>>>>>
>>>>>> I do not think that an access to KVM is required for full 
>>>>>> virtualization.
>>>>>
>>>>> You may be right, but at this point, there is no guarantee. I 
>>>>> stand by my
>>>>> design on this one.
>>>>
>>>> I really regret that we abandoned the initial design with the 
>>>> matrix bus and one
>>>> single parent matrix device per guest.
>>>> We would not have the problem of these KVM dependencies.
>>>>
>>>> It had the advantage of taking care of having only one device per 
>>>> guest
>>>> (available_instance = 1), could take care of provisioning as you have
>>>> sysfs entries available for a matrix without having a guest and a 
>>>> mediated
>>>> device.
>>>>
>>>> it also had advantage for virtualization to keep host side and 
>>>> guest side matrix
>>>> separate inside parent (host side) and mediated device (guest side).
>>>>
>>>> Shouldn't we treat this problem with a design using standard 
>>>> interfaces
>>>> Instead of adding new dedicated interfaces?
>>>>
>>>> Regards,
>>>>
>>>> Pierre
>>>>
>>>>
>>>
>>> Forget it.
>>>
>>> I am not happy with the design but the design I was speaking of may 
>>> not be the solution either.
>>
>> The AP architecture makes virtualization of AP devices complex. We 
>> tried the solution you
>> described and found it to be sorely lacking which is why we ended up 
>> where we are now.
>
> I did not see any explanation on why between v1 and v2 as it was 
> abandoned.
>
>
> We have internal structures like the ap_matrix and kvm_ap_matrix
> which look like the bus/devices we had previously but are differently
> or not at all integrated with the LDD.

What is LDD? Are you talking about dependencies between the vfio_ap device
driver and KVM? If so, see my arguments below.

>
>
> Also I think that with a little data structure refactoring you can 
> avoid most of
> the code in the arch/s390/kvm.

How will structure refactoring help us avoid the code for updating the CRYCB
in the guest's SIE state description.

>
>
> For example, storing the kvm pointer inside the kvm_ap_matrix and
> maintaining a list of the kvm_ap_matrix structures allows to easily know
> if a guest already has an associated mediated device.

How is that easier than storing the kvm pointer inside of the mediated 
matrix
device (i.e., struct ap_matrix_mdev) which also contains the struct 
kvm_ap_matrix?
How does that allow us to avoid the code in arch/s390/kvm? We still need 
the code
to update the CRYCB in the SIE block. I can obviously avoid placing that 
code in
kvm-ap.c and move it to the driver, but I already explained my reasoning 
for
keeping it in KVM. Let's face it, there is no way around the dependency 
between
the vfio_ap device driver and KVM unless guest matrix configuration is 
managed
solely by KVM through KVM interfaces.

Why maintain a list of kvm_ap_matrix structures if we don't have to; it 
is stored
with the mediated matrix device which is passed in to all of the vfio_ap 
driver
callbacks.

>
>
> Pierre
>
>>
>>>
>>>
>>> Sorry for the noise.
>>>
>>> Regards,
>>>
>>> Pierre
>>>
>>>
>>
>
