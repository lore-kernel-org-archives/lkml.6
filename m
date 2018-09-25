Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAFDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315372086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315372086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeIYTd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:33:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729152AbeIYTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:33:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PDOnmx029060
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:26:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqm82w6v3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:26:23 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 25 Sep 2018 07:26:22 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 07:26:19 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PDQG7B55902330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 06:26:16 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D75E6E04C;
        Tue, 25 Sep 2018 07:26:16 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EBEE6E053;
        Tue, 25 Sep 2018 07:26:13 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.207.102])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 07:26:13 -0600 (MDT)
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
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
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9263b698-1827-1b7f-28bf-75b44657dea2@redhat.com>
 <18a21cda-1da9-3bfb-7b34-80415b5457f9@linux.ibm.com>
 <172560fb-2c54-ea43-3401-f108cf2a0595@redhat.com>
 <bb2639ac-469a-a71f-8f0a-2df3c12c6ac5@linux.ibm.com>
 <1c0c5a2e-3ef4-e5f5-52b8-7aeddca1f472@linux.ibm.com>
 <62f0cacc-8338-9370-a4dc-12f793214c48@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 25 Sep 2018 09:26:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <62f0cacc-8338-9370-a4dc-12f793214c48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092513-0016-0000-0000-000009346CC3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009769; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093445; UDB=6.00565148; IPR=6.00873482;
 MB=3.00023497; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 13:26:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092513-0017-0000-0000-0000407A39C4
Message-Id: <889157be-c209-8938-ccb2-240ae5249cda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 03:32 AM, David Hildenbrand wrote:
> On 24/09/2018 20:42, Tony Krowiak wrote:
>> On 09/24/2018 12:25 PM, Tony Krowiak wrote:
>>> On 09/24/2018 07:23 AM, David Hildenbrand wrote:
>>
>> (...)
>>
>>>> Will you also fixup this patch to expose KVM_S390_VM_CRYPTO_ENABLE_APIE
>>>> only if supported by HW? (ap_instructions_available)
>>>
>>> Given that this patch DOES expose KVM_S390_VM_CRYPTO_ENABLE_APIE only if
>>> supported by HW, I assume you are talking about
>>> KVM_S390_VM_CRYPTO_DISABLE_APIE. I didn't check
>>> ap_instructions_available() for disabling APIE because I didn't
>>> think it necessary given that ECA.28 will be set to 0 (intercept) by
>>> default, whether AP instructions are installed or not; so why not allow
>>> disabling apie. I suppose from the perspective of consistency, since the
>>> kvm_s390_vm_has_attr() function checks ap_instructions_available() for
>>> both attributes, then it probably makes sense to add that check to
>>> KVM_S390_VM_CRYPTO_DISABLE_APIE here. Then again, we could make a change
>>> in ap_instructions_available() to allow KVM_S390_VM_CRYPTO_DISABLE_APIE
>>> regardless of whether AP instructions are available. It boils down to
>>> whether APIE needs to be dynamically disabled at some point when it has
>>> been enabled. The only case I can think of where that may be necessary
>>> is if a guest is migrated to a system without AP instructions. I don't
>>> think that can happen and may even be protected against precisely
>>> because the VM attributes won't be available on the target system due to
>>> no AP instructions. What say you?
>>>
>> David,
>>
>> I'm sorry, I misinterpreted what you were asking for. Check out the
>> fixup! patch below and let me know if that is what you are looking for.
>> If so, I will integrate that change and post v11 tomorrow (Tuesday 9/24).
>>
>> -----------------------------------8<-----------------------------------
>>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>> Date: Mon, 24 Sep 2018 14:18:37 -0400
>> Subject: [FIXUP v10] fixup! KVM: s390: device attrs to enable/disable AP
>>    interpretation
>>
>> ---
>>    arch/s390/kvm/kvm-s390.c | 9 ++++++++-
>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6654bb1fc26a..a528558baa78 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -901,6 +901,10 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm,
>> struct kvm_device_attr *attr)
>>    		kvm->arch.crypto.apie = 1;
>>    		break;
>>    	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>> +		if (!ap_instructions_available()) {
>> +			mutex_unlock(&kvm->lock);
>> +			return -EOPNOTSUPP;
>> +		}
>>    		kvm->arch.crypto.apie = 0;
>>    		break;
>>    	default:
>> @@ -1509,9 +1513,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm,
>> struct kvm_device_attr *attr)
>>    		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>> +			ret = 0;
>> +			break;
>>    		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>> -			ret = 0;
>> +			ret = ap_instructions_available();
> 
> Just a little remark, I guess we want to report 0 if available and
> -ENXIO if not.

That makes sense ... I'll fix it.

> 

