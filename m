Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8571C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4140C208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4140C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeHOUtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:49:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729537AbeHOUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:49:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHsllk108293
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:56:03 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kvmadvkyb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:56:03 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 15 Aug 2018 11:56:02 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Aug 2018 11:55:58 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7FHttMu9699740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Aug 2018 10:55:55 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE06213605E;
        Wed, 15 Aug 2018 11:55:55 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9029C136051;
        Wed, 15 Aug 2018 11:55:52 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.175.5])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Aug 2018 11:55:52 -0600 (MDT)
Subject: Re: [PATCH v9 14/22] KVM: s390: interfaces to clear CRYCB masks
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-15-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815151039.63d83d5d.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 15 Aug 2018 13:55:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180815151039.63d83d5d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081517-0016-0000-0000-0000091B02F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009550; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073966; UDB=6.00553412; IPR=6.00853924;
 MB=3.00022736; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-15 17:56:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081517-0017-0000-0000-000040024BC6
Message-Id: <4cbed75b-adb6-e97f-6719-c630266a16cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 09:10 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:11 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
>> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
>> not get out of sync.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |    3 +++
>>   arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
>>   2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 4a739d4..07e58d8 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -258,6 +258,7 @@ struct kvm_s390_sie_block {
>>   	__u64	tecmc;			/* 0x00e8 */
>>   	__u8	reservedf0[12];		/* 0x00f0 */
>>   #define CRYCB_FORMAT_MASK 0x00000003
>> +#define CRYCB_FORMAT0 0x00000000
> This should probably go into a different patch (define is not used
> here)?

You are spot on. It needs to go in patch 15 where it is first used.

>
>>   #define CRYCB_FORMAT1 0x00000001
>>   #define CRYCB_FORMAT2 0x00000003
>>   	__u32	crycbd;			/* 0x00fc */
>> @@ -861,6 +862,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>   void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>   				 struct kvm_async_pf *work);
>>   
>> +void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>> +
>>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>   extern char sie_exit;
>>   
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index f7de123..8d8a65a 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1919,6 +1919,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>>   		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>>   }
>>   
>> +void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>> +{
>> +	mutex_lock(&kvm->lock);
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	memset(&kvm->arch.crypto.crycb->apcb0, 0,
>> +	       sizeof(kvm->arch.crypto.crycb->apcb0));
>> +	memset(&kvm->arch.crypto.crycb->apcb1, 0,
>> +	       sizeof(kvm->arch.crypto.crycb->apcb1));
>> +
>> +	kvm_s390_vcpu_unblock_all(kvm);
>> +	mutex_unlock(&kvm->lock);
>> +}
>> +EXPORT_SYMBOL(kvm_arch_crypto_clear_masks);
> A quick grep shows that kvm-related exports tend to be
> EXPORT_SYMBOL_GPL. Should that also be done here?

I did some internet searching to find out why the EXPORT_SYMBOL_GPL 
macro is used
rather than EXPORT_SYMBOL. I found the link below which explains why. 
According to
that article, if the EXPORT_SYMBOL_GPL macro is used, modules that do 
not carry a
GPL-compatible license can not use the function. Apparently Linus 
Trovalds and the
lawyers he consulted believe it codifies the intention in code itself 
makes the code
more flexible and a lot less likely to be misunderstood. It is further 
pointed out
that "circumventing the GPL-only export requires an explicit action, 
making it clear
that the copyright infringement was a  deliberate act.

Since our modules are GPL-licensed, it would probably behoove us to use the
EXPORT_SYMBOL_GPL macro to export this function.

https://lwn.net/Articles/154602/

>
>> +
>>   static u64 kvm_s390_get_initial_cpuid(void)
>>   {
>>   	struct cpuid cpuid;


