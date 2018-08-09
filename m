Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C824C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5C521B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5C521B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeHIK6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:58:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728170AbeHIK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:58:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w798TG0G009630
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 04:34:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krg1kmy4c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:34:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 9 Aug 2018 09:34:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 09:34:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w798YSns34209968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 08:34:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0576942052;
        Thu,  9 Aug 2018 11:34:36 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E1042045;
        Thu,  9 Aug 2018 11:34:33 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 11:34:33 +0100 (BST)
Subject: Re: [PATCH v8 21/22] KVM: s390: CPU model support for AP
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
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <58eed530-31b3-49fe-cbd7-4d101b94daa0@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 9 Aug 2018 10:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <58eed530-31b3-49fe-cbd7-4d101b94daa0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080908-0016-0000-0000-000001F4495B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080908-0017-0000-0000-0000324A5B8B
Message-Id: <2fbfa34f-0a82-9fd2-3b52-60479d9eca1a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 10:17, David Hildenbrand wrote:
> On 08.08.2018 16:44, Tony Krowiak wrote:
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
>>    This is indicated by setting facilities bit 12 for
>>    the guest. The kernel will not enable this facility
>>    for the guest if it is not set on the host. This facility
>>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>    feature is not installed.
> Could it happen on real HW (not frankenstein CPU models), that
>
> !AP, but STFL 12 or 15  are indicated?
What is your expectation here ? There are no AP instructions
available but if there would be AP instructions available then
there would be the QCI and or the T bit facility within
the PQAP AP instruction valid ?
>>    If this facility is not set for the KVM guest, then only
>>    APQNs with an APQI less than 16 will be used by a Linux
>>    guest regardless of the matrix configuration for the virtual
>>    machine. This is a limitation of the Linux AP bus.
>>
>> 2. AP Facilities Test facility (APFT) is installed.
>>
>>    This is indicated by setting facilities bit 15 for
>>    the guest. The kernel will not enable this facility for
>>    the guest if it is not set on the host. This facility
>>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>    feature is not installed.
>>
>>    If this facility is not set for the KVM guest, then no
>>    AP devices will be available to the guest regardless of
>>    the guest's matrix configuration for the virtual
>>    machine. This is a limitation of the Linux AP bus.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c         |    7 +++++++
>>  arch/s390/tools/gen_facilities.c |    2 ++
>>  2 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 9203f0b..7d4fe9b 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -367,6 +367,13 @@ static void kvm_s390_cpu_feat_init(void)
>>  
>>  	if (MACHINE_HAS_ESOP)
>>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
>> +
>> +	/*
>> +	 * Check if AP instructions installed on host
>> +	 */
> Make this a one-line comment, please.
>
>> +	if (ap_instructions_available() == 0)
>> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
>> +
>>  	/*
>>  	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>>  	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>> index 90a8c9e..a52290b 100644
>> --- a/arch/s390/tools/gen_facilities.c
>> +++ b/arch/s390/tools/gen_facilities.c
>> @@ -106,6 +106,8 @@ struct facility_def {
>>  
>>  		.name = "FACILITIES_KVM_CPUMODEL",
>>  		.bits = (int[]){
>> +			12, /* AP Query Configuration Information */
>> +			15, /* AP Facilities Test */
>>  			-1  /* END */
>>  		}
>>  	},
>>
>

