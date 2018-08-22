Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A851C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB102147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB102147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeHVR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:59:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728718AbeHVR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:59:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7METYGO069693
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:33:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m18cbkvba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:33:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Aug 2018 15:33:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 15:33:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MEXnkH32505862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 14:33:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53D69A404D;
        Wed, 22 Aug 2018 17:33:49 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C4BA4055;
        Wed, 22 Aug 2018 17:33:48 +0100 (BST)
Received: from [9.152.224.111] (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 17:33:48 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     David Hildenbrand <david@redhat.com>,
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 22 Aug 2018 16:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082214-0012-0000-0000-0000029D32F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082214-0013-0000-0000-000020D076DA
Message-Id: <e7e1efe7-a7f5-f9a8-bd85-88759fa8ba2b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 13:19, David Hildenbrand wrote:
> On 13.08.2018 23:48, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces a new CPU model feature and two CPU model
>> facilities to support AP virtualization for KVM guests.
>>
>> CPU model feature:
>>
>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
>> AP instructions are available on the guest. This
>> feature will be enabled by the kernel only if the AP
>> instructions are installed on the linux host. This feature
>> must be specifically turned on for the KVM guest from
>> userspace to use the VFIO AP device driver for guest
>> access to AP devices.
>>
>> CPU model facilities:
>>
>> 1. AP Query Configuration Information (QCI) facility is installed.
>>
>>     This is indicated by setting facilities bit 12 for
>>     the guest. The kernel will not enable this facility
>>     for the guest if it is not set on the host.
>>
>>     If this facility is not set for the KVM guest, then only
>>     APQNs with an APQI less than 16 will be used by a Linux
>>     guest regardless of the matrix configuration for the virtual
>>     machine. This is a limitation of the Linux AP bus.
>>
>> 2. AP Facilities Test facility (APFT) is installed.
>>
>>     This is indicated by setting facilities bit 15 for
>>     the guest. The kernel will not enable this facility for
>>     the guest if it is not set on the host.
>>
>>     If this facility is not set for the KVM guest, then no
>>     AP devices will be available to the guest regardless of
>>     the guest's matrix configuration for the virtual
>>     machine. This is a limitation of the Linux AP bus.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c         |    5 +++++
>>   arch/s390/tools/gen_facilities.c |    2 ++
>>   2 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 1e8cb67..d5e04d2 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -367,6 +367,11 @@ static void kvm_s390_cpu_feat_init(void)
>>   
>>   	if (MACHINE_HAS_ESOP)
>>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
>> +
>> +	/* Check if AP instructions installed on host */
>> +	if (ap_instructions_available())
>> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
>> +
>>   	/*
>>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>> index 90a8c9e..a52290b 100644
>> --- a/arch/s390/tools/gen_facilities.c
>> +++ b/arch/s390/tools/gen_facilities.c
>> @@ -106,6 +106,8 @@ struct facility_def {
>>   
>>   		.name = "FACILITIES_KVM_CPUMODEL",
>>   		.bits = (int[]){
>> +			12, /* AP Query Configuration Information */
>> +			15, /* AP Facilities Test */
>>   			-1  /* END */
>>   		}
>>   	},
>>
> 
> I really wonder if we should also export the APXA facility.
> 
> We can probe and allow that CPU feature. However, we cannot disable it
> (as of now).
> 
> We have other CPU features where it is the same case (basically all
> subfunctions). See kvm_s390_get_processor_subfunc(). We probe them and
> export them, but support to disable them has never been implemented.
> 
> On a high level, we could then e.g. deny to start a QEMU guest if APXA
> is available but has been disabled. (until we know that disabling it
> actually works - if ever).
> 
> This helps to catch nasty migration bugs (e.g. APXA suddenly
> disappearing). Although unlikely, definitely possible. >
> 
> Are there any other AP related facilities that the guest can from now on
> probe that should also become part of the CPU model?
> 



Before going too far in a discussion on features which we do not really 
need, we can make clear that we only support beginning with z13 and only 
in the Z architecture mode as host and as guest.

We then need to abort the VFIO driver if APXA is not installed.

In this case we will have no problem with older guests not having idea 
about APXA.

Would it be a solution?


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

