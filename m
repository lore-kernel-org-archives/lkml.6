Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pwbZM4I4GVuefAAAmS7hNA
	; Thu, 07 Jun 2018 13:52:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2284D607E7; Thu,  7 Jun 2018 13:52:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65F84601D2;
	Thu,  7 Jun 2018 13:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65F84601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeFGNwj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:52:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932468AbeFGNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:52:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57Dj0pB031968
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 09:52:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5nhs1ah-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:52:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 09:52:36 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 09:52:32 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57DqUA410420988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 13:52:30 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EE39124053;
        Thu,  7 Jun 2018 10:53:55 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28B82124058;
        Thu,  7 Jun 2018 10:53:54 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.135.133])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 10:53:54 -0400 (EDT)
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
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 09:52:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060713-2213-0000-0000-000002B4C604
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009146; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043514; UDB=6.00534327; IPR=6.00822616;
 MB=3.00021511; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 13:52:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060713-2214-0000-0000-00005A64F4FE
Message-Id: <2b128772-f2c2-25fe-e6a8-358711745a94@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 12:08 PM, Pierre Morel wrote:
> On 06/06/2018 16:28, Tony Krowiak wrote:
>> On 06/05/2018 08:19 AM, Pierre Morel wrote:
>>> On 30/05/2018 16:33, Tony Krowiak wrote:
>>>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>> Implements the open callback on the mediated matrix device.
>>>>>>>> The function registers a group notifier to receive notification
>>>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>>>
>>>>>>>> 1. Ensure that only one mediated device is opened for the guest
>>>>>
>>>>> You should explain why.
>>>>>
>>>>>>>>
>>>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>>>
>>>>> ...snip...
>>>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>>>> +{
>>>>>>>> +    atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>>>> +
>>>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>>>> +{
>>>>>>>> +    atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>>>
>>>>>>> Why are these functions inside kvm-ap ?
>>>>>>> Will anyone use this outer of vfio-ap ?
>>>>>>
>>>>>> As I've stated before, I made the choice to contain all 
>>>>>> interfaces that
>>>>>> access KVM in kvm-ap because I don't think it is appropriate for 
>>>>>> the device
>>>>>> driver to have to have "knowledge" of the inner workings of KVM. 
>>>>>> Why does
>>>>>> it matter whether any entity outside of the vfio_ap device driver 
>>>>>> calls
>>>>>> these functions? I could ask a similar question if the interfaces 
>>>>>> were
>>>>>> contained in vfio-ap; what if another device driver needs access 
>>>>>> to these
>>>>>> interfaces?
>>>>>
>>>>> This is very driver specific and only used during initialization.
>>>>> It is not a common property of the cryptographic interface.
>>>>>
>>>>> I really think you should handle this inside the driver.
>>>>
>>>> We are going to have to agree to disagree on this one. Is it not 
>>>> possible
>>>> that future drivers - e.g., when full virtualization is implemented 
>>>> - will
>>>> require access to KVM?
>>>
>>> I do not think that an access to KVM is required for full 
>>> virtualization.
>>
>> You may be right, but at this point, there is no guarantee. I stand 
>> by my
>> design on this one.
>
> I really regret that we abandoned the initial design with the matrix 
> bus and one
> single parent matrix device per guest.

This is an interesting time to be bringing this up.

> We would not have the problem of these KVM dependencies.

How does that eliminate these KVM dependencies? We would still have to 
configure
the guest's SIE state description - i.e., ECA.28 and the CRYCB - regardless
of the number or purpose of the matrix devices. To what KVM dependencies are
you referring?

>
>
> It had the advantage of taking care of having only one device per guest
> (available_instance = 1), 

Maybe you didn't state this as you intended, but when you refer to
available_instances, you are referring to mediated devices. We allow
only one mediated device per guest in the current design. I suspect
that is not what you meant here.

> could take care of provisioning as you have
> sysfs entries available for a matrix without having a guest and a 
> mediated
> device.

I assume here that you are saying that the matrix configuration would be
done via sysfs files for the matrix device as opposed to the mediated
device?

>
>
> it also had advantage for virtualization to keep host side and guest 
> side matrix
> separate inside parent (host side) and mediated device (guest side).

In my opinion, since the AP devices assigned to the matrix device are 
used only by
a guest (i.e., pass-through) and never by the host, it is all guest side 
configuration.
Even if we map virtual AP devices to real AP devices, the mapping is still
guest side configuration from my perspective. I think this can all be 
handled
by using differing mediated device types for pass-through, virtualized 
and emulated
devices. In fact, early on I prototyped the mediated device sysfs 
structures for
configuring all three mediated device types if you recall. I see no 
advantage
to keeping separate configurations for host and guest sides and in fact 
think it
complicates things.


>
>
> Shouldn't we treat this problem with a design using standard interfaces
> Instead of adding new dedicated interfaces?

I do not understand this question. I believe we are using standard 
interfaces.
We use the bind/unbind interface to reserve queues for use by guests and 
have
sysfs attributes for the mediated devices that map directly to the APM, AQM
and ADM. What do you mean by dedicated interfaces?

In fact, I think the design about which you speak introduces a need for
non-standard and confusing interfaces. For example, think about securing
AP queues; you'd have to unbind the queues from a device driver on the
AP bus and bind them to a driver on a different bus, the matrix bus.
This would require radical design changes to and/or introduction of 
non-standard
interfaces on the AP bus. It would also introduce some unusual sysfs 
interfaces
on the matrix driver to validate and commit the matrix - i.e., APM, AQM 
- created
from the queues bound to it.

>
> Regards,
>
> Pierre
>
>
