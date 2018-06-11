Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jheIGHY/HluBYwAAmS7hNA
	; Mon, 11 Jun 2018 09:23:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4526F60792; Mon, 11 Jun 2018 09:23:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4340602FC;
	Mon, 11 Jun 2018 09:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4340602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeFKJXl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:23:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932704AbeFKJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:23:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B9JXwV122298
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:23:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhmsc50th-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:23:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 11 Jun 2018 10:23:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 10:23:30 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B9NSsw28573746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 09:23:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C84042049;
        Mon, 11 Jun 2018 10:13:42 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE894203F;
        Mon, 11 Jun 2018 10:13:41 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 10:13:41 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
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
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 11 Jun 2018 11:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061109-0008-0000-0000-0000024658C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061109-0009-0000-0000-000021AC7AFA
Message-Id: <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 23:59, Tony Krowiak wrote:
> On 06/07/2018 01:15 PM, Pierre Morel wrote:
>>

...snip...

>>>>
>>>>>
>>>>> Why maintain a list of kvm_ap_matrix structures if we don't have 
>>>>> to; it is stored
>>>>> with the mediated matrix device which is passed in to all of the 
>>>>> vfio_ap driver
>>>>> callbacks.
>>>>
>>>> Because using the vm_list which is a static in kvm makes you stick 
>>>> inside the kvm code.
>
> I understand your point here, but even if we did maintain a list of 
> kvm_ap_matrix structures,
> we still need the kvm code to configure the guest's CRYCB and 
> eventually ECA.28. There is
> also code in kvm-ap.c that is called from KVM.

The only code from kvm-ap which is called from KVM is temporary code
waiting for Harald to offer the clean interface to AP instructions.

> The idea behind kvm-ap.c is that all code
> related to configuration of AP structures in KVM is in this one spot.

This I understand, but the code can be in one spot inside VFIO_AP instead
of inside KVM.
Putting the code inside KVM induce dependencies between KVM and AP
while the kvm/vfio interface allows to avoid this dependency.

The purpose of VFIO_AP is to handle the CRYCB, all get/clear/set crycb masks
functions should be in VFIO AP.

If we use wrappers in KVM, since the CRYCB is an a SIE extension,
it is legitimate, the KVM interface to the CRYCB should only
handle bitmaps and be unaware of the vfio_ap internal structures.


Another concern, the kvm_ap_validate_queue_sharing() should not be
inside KVM because it is a decision of current VFIO_AP driver
to not share the queues between guest of level 2.

The Z architecture does not allow to share AP queues between
guests of level 1 but we could re-engineer the AP bus and the '
VFIO AP to offer queue sharing for guest level 2.

This would be a new VFIO_AP driver (and an AP bus extension).
We should not have to change KVM for this.


Regards,

Pierre


>
>>
>>
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
