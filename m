Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id W7F8AkP8GlsRAwAAmS7hNA
	; Fri, 08 Jun 2018 21:59:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9E74607DC; Fri,  8 Jun 2018 21:59:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56E87605A2;
	Fri,  8 Jun 2018 21:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56E87605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeFHV72 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:59:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752810AbeFHV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:59:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58Ls2h8060141
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 17:59:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jg0hpbf2y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 17:59:25 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 8 Jun 2018 17:59:24 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 17:59:21 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58LxJTk1311068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 21:59:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F4BD124052;
        Fri,  8 Jun 2018 19:00:42 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DE7E124055;
        Fri,  8 Jun 2018 19:00:41 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.147.229])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 19:00:41 -0400 (EDT)
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 8 Jun 2018 17:59:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060821-0060-0000-0000-0000027A95FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009154; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044154; UDB=6.00534632; IPR=6.00823191;
 MB=3.00021541; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 21:59:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060821-0061-0000-0000-000045630ECB
Message-Id: <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 01:15 PM, Pierre Morel wrote:
>
>>>
>>>
>>> We have internal structures like the ap_matrix and kvm_ap_matrix
>>> which look like the bus/devices we had previously but are differently
>>> or not at all integrated with the LDD.
>>
>> What is LDD? Are you talking about dependencies between the vfio_ap 
>> device
>> driver and KVM? If so, see my arguments below.
>>
>>>
>>>
>>> Also I think that with a little data structure refactoring you can 
>>> avoid most of
>>> the code in the arch/s390/kvm.
>>
>> How will structure refactoring help us avoid the code for updating 
>> the CRYCB
>> in the guest's SIE state description.
>>
>>>
>>>
>>> For example, storing the kvm pointer inside the kvm_ap_matrix and
>>> maintaining a list of the kvm_ap_matrix structures allows to easily 
>>> know
>>> if a guest already has an associated mediated device.
>>
>> How is that easier than storing the kvm pointer inside of the 
>> mediated matrix
>> device (i.e., struct ap_matrix_mdev) which also contains the struct 
>> kvm_ap_matrix?
>
> you can put it in ap_matrix_mdev but just the name "kvm_ap_matrix" 
> make the
> last one a better candidate for my opinion.

It's been in ap_matrix_mdev since v2, but I'll consider moving it to 
kvm_ap_matrix.

>
>
>> How does that allow us to avoid the code in arch/s390/kvm?
>
> This alone does not.
>
>> We still need the code
>> to update the CRYCB in the SIE block. I can obviously avoid placing 
>> that code in
>> kvm-ap.c and move it to the driver, but I already explained my 
>> reasoning for
>> keeping it in KVM. Let's face it, there is no way around the 
>> dependency between
>> the vfio_ap device driver and KVM unless guest matrix configuration 
>> is managed
>> solely by KVM through KVM interfaces.
>
> We get the pointer to KVM from the VFIO interface.
> That we both discuss on this is sterile.
> The only one who could say what is right is a S390 KVM maintainer.
> This would end the discussion.
> My point was just to say that we have an alternative.
>
>
>>
>> Why maintain a list of kvm_ap_matrix structures if we don't have to; 
>> it is stored
>> with the mediated matrix device which is passed in to all of the 
>> vfio_ap driver
>> callbacks.
>
> Because using the vm_list which is a static in kvm makes you stick 
> inside the kvm code.

I understand your point here, but even if we did maintain a list of 
kvm_ap_matrix structures,
we still need the kvm code to configure the guest's CRYCB and eventually 
ECA.28. There is
also code in kvm-ap.c that is called from KVM. The idea behind kvm-ap.c 
is that all code
related to configuration of AP structures in KVM is in this one spot.

>
>
>
