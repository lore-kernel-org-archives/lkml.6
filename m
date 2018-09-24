Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC93C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF67214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF67214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbeIXUwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388193AbeIXUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OEnXoS016016
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:49:57 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mq1ckhr74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:49:57 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 24 Sep 2018 08:49:56 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 08:49:53 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OEnoaM25559256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 07:49:50 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD49BE051;
        Mon, 24 Sep 2018 08:49:50 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33838BE04F;
        Mon, 24 Sep 2018 08:49:47 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.130.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 08:49:46 -0600 (MDT)
Subject: Re: [PATCH v10 10/26] KVM: s390: interfaces to clear CRYCB masks
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
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924130153.766eaec7.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 24 Sep 2018 10:49:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180924130153.766eaec7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092414-0016-0000-0000-00000933CF56
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092993; UDB=6.00564877; IPR=6.00873030;
 MB=3.00023482; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 14:49:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092414-0017-0000-0000-0000407768EE
Message-Id: <5b825cbc-1d5c-42cf-9cd8-6615938163de@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 07:01 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:43:00 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
>> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
>> not get out of sync.
> 
> Hm, that patch description does not quite match what the patch actually
> does...

No, it doesn't, does it? I'll fix it.

> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |    2 ++
>>   arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
>>   2 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 423cce7..1e758fe 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -858,6 +858,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>   void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>   				 struct kvm_async_pf *work);
>>   
>> +void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>> +
>>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>   extern char sie_exit;
>>   
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d717041..ac4c93f 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2033,6 +2033,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
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
>> +EXPORT_SYMBOL_GPL(kvm_arch_crypto_clear_masks);
> 
> ...although this function looks fine.
> 
>> +
>>   static u64 kvm_s390_get_initial_cpuid(void)
>>   {
>>   	struct cpuid cpuid;
> 

