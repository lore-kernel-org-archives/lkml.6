Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B214C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEF321773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfBRS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:29:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731024AbfBRS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:29:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IITIJB052083
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:29:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qr08jnex6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:29:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 18 Feb 2019 18:29:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 18:29:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IITBhs57802968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 18:29:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1DB311C04A;
        Mon, 18 Feb 2019 18:29:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B44A11C04C;
        Mon, 18 Feb 2019 18:29:11 +0000 (GMT)
Received: from [9.145.70.2] (unknown [9.145.70.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 18:29:11 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 18 Feb 2019 19:29:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021818-0008-0000-0000-000002C1E94C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021818-0009-0000-0000-0000222E18F1
Message-Id: <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 23:02, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> This patch adds interception code for the PQAP instructions,
>> and a callback inside the KVM arch structure for s390.
>>
>> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ
>> instructions, the driver will initialize the callback inside
>> the kvm_arch structure to be called when the interception of a
>> PQAP instruction occurs.
>>
>> If the callback is not initialized, the code still returns
>> -EOPNOTSUPP to let userland handle the instruction as it used to.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  1 +
>>   arch/s390/kvm/priv.c             | 50 
>> ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index c5f5156..49cc8b0 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -719,6 +719,7 @@ struct kvm_s390_cpu_model {
>>   struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> +    int (*pqap_hook)(struct kvm_vcpu *vcpu);
>>       __u32 crycbd;
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 8679bd7..72fdc21 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -27,6 +27,7 @@
>>   #include <asm/io.h>
>>   #include <asm/ptrace.h>
>>   #include <asm/sclp.h>
>> +#include <asm/ap.h>
>>   #include "gaccess.h"
>>   #include "kvm-s390.h"
>>   #include "trace.h"
>> @@ -592,6 +593,53 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>       }
>>   }
>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
>> + *
>> + * This callback only handles PQAP/AQIC instruction and
>> + * calls a dedicated callback for this instruction if
>> + * a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>> + * - the hook is not used do not change the behavior.
>> + * - AP instructions are not available or not available to the guest
>> + * - the instruction is not PQAP with function code indicating
>> + *   AQIC do not change the previous behavior.
>> + *
>> + * For PQAP/AQIC instruction, verify privilege and specifications
>> + *
>> + * return the value returned by the callback.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +    uint8_t fc;
>> +
>> +    /* Verify that the hook callback is registered */
>> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the AP instruction are available */
>> +    if (!ap_instructions_available())
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the guest is allowed to use AP instructions */
>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the function code is AQIC */
>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>> +    if (fc != 0x03)
>> +        return -EOPNOTSUPP;
> 
> This does not belong here. Function code 3 is one of 7 function codes
> that can be sent with the PQAP instruction. This belongs in the PQAP
> hook code.

On one hand, effectively I would prefer to put the code in the VFIO 
driver code.
On the other hand, doing this would lead to export the code for 
test_kvm_facility() and kvm_s390_inject_program_int() from the kvm-s390.h

I choose not to export these functions from the KVM code.

Would like opinion from KVM maintainers?

> 
>> +
>> +    /* PQAP instructions are allowed for guest kernel only */
>> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> +        return kvm_s390_inject_program_intkvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>> +    /* AQIC instruction is allowed only if facility 65 is available */
>> +    if (!test_kvm_facility(vcpu->kvm, 65))
>> +        return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +    /* All right, call the callback */
>> +    return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>> +}
>> +
>>   static int handle_stfl(struct kvm_vcpu *vcpu)
>>   {
>>       int rc;
>> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>>           return handle_sthyi(vcpu);
>>       case 0x7d:
>>           return handle_stsi(vcpu);
>> +    case 0xaf:
>> +        return handle_pqap(vcpu);
>>       case 0xb1:
>>           return handle_stfl(vcpu);
>>       case 0xb2:
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

