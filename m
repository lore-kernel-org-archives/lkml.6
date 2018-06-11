Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fuc2AmBwHluXdwAAmS7hNA
	; Mon, 11 Jun 2018 12:52:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8FA1560792; Mon, 11 Jun 2018 12:52:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED2F6601C3;
	Mon, 11 Jun 2018 12:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED2F6601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeFKMwD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:52:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932656AbeFKMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:52:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BCmqGd037833
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 08:52:01 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhsau0ct0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 08:52:00 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 11 Jun 2018 08:51:58 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 08:51:54 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5BCpqWM16777592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 12:51:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C9E112061;
        Mon, 11 Jun 2018 08:51:50 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014A5112063;
        Mon, 11 Jun 2018 08:51:49 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.207.139])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 08:51:48 -0400 (EDT)
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Janosch Frank <frankja@linux.vnet.ibm.com>
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
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
 <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
 <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 11 Jun 2018 08:50:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061112-0040-0000-0000-0000043E7060
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009170; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045401; UDB=6.00535309; IPR=6.00824380;
 MB=3.00021579; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-11 12:51:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061112-0041-0000-0000-0000084477BC
Message-Id: <4f5f17f1-48ab-6f1e-6ef2-3741fc39e5f4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 07:32 AM, Halil Pasic wrote:
>
>
> On 06/11/2018 11:23 AM, Pierre Morel wrote:
>> On 08/06/2018 23:59, Tony Krowiak wrote:
>>> On 06/07/2018 01:15 PM, Pierre Morel wrote:
>>>>
>>
>> ...snip...
>>
>>>>>>
>>>>>>>
>>>>>>> Why maintain a list of kvm_ap_matrix structures if we don't have 
>>>>>>> to; it is stored
>>>>>>> with the mediated matrix device which is passed in to all of the 
>>>>>>> vfio_ap driver
>>>>>>> callbacks.
>>>>>>
>>>>>> Because using the vm_list which is a static in kvm makes you 
>>>>>> stick inside the kvm code.
>>>
>>> I understand your point here, but even if we did maintain a list of 
>>> kvm_ap_matrix structures,
>>> we still need the kvm code to configure the guest's CRYCB and 
>>> eventually ECA.28. There is
>>> also code in kvm-ap.c that is called from KVM.
>>
>> The only code from kvm-ap which is called from KVM is temporary code
>> waiting for Harald to offer the clean interface to AP instructions.
>>
>>> The idea behind kvm-ap.c is that all code
>>> related to configuration of AP structures in KVM is in this one spot.
>>
>> This I understand, but the code can be in one spot inside VFIO_AP 
>> instead
>> of inside KVM.
>> Putting the code inside KVM induce dependencies between KVM and AP
>> while the kvm/vfio interface allows to avoid this dependency.
>>
>> The purpose of VFIO_AP is to handle the CRYCB, all get/clear/set 
>> crycb masks
>> functions should be in VFIO AP.
>>
>> If we use wrappers in KVM, since the CRYCB is an a SIE extension,
>> it is legitimate, the KVM interface to the CRYCB should only
>> handle bitmaps and be unaware of the vfio_ap internal structures.
>>
>>
>> Another concern, the kvm_ap_validate_queue_sharing() should not be
>> inside KVM because it is a decision of current VFIO_AP driver
>> to not share the queues between guest of level 2.
>>
>> The Z architecture does not allow to share AP queues between
>> guests of level 1 but we could re-engineer the AP bus and the '
>> VFIO AP to offer queue sharing for guest level 2.
>>
>> This would be a new VFIO_AP driver (and an AP bus extension).
>> We should not have to change KVM for this.
>>
>
>
> Pierre's proposal makes a lot of sense to me. We would not need to take
> the kvm_lock (which we need to traverse the vm_list safely) for the
> validation, and we could have immediate validation (which is in my 
> opinion
> better).
>
> Also your refcount (which is not a refcout) could go away. You simply
> traverse your list and check for duplicates when hooking up the mdev
> with KVM.
>
> And my opinion is if we don't have to add code to the kvm module we
> better not.
>
> @Janosch: Does core KVM share my opinion?

Okay, I'll make the change.

>
>
> Regards,
> Halil
