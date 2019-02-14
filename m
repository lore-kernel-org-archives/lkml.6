Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B89C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB782080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390907AbfBNQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:45:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfBNQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:45:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EGWrC9060328
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:45:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qnap3fgnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:45:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 16:45:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 16:45:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EGj7ek7864820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 16:45:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4706F11C058;
        Thu, 14 Feb 2019 16:45:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9759011C04C;
        Thu, 14 Feb 2019 16:45:06 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 16:45:06 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <20190214165407.335b4ec0.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 14 Feb 2019 17:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214165407.335b4ec0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021416-4275-0000-0000-0000030F89DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021416-4276-0000-0000-0000381DA661
Message-Id: <2609f072-ab16-429e-8aba-e1af20757c25@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=539 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 16:54, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 14:51:02 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> This patch adds interception code for the PQAP instructions,
>> and a callback inside the KVM arch structure for s390.
>>
>> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ
> 
> s/drivers/driver/

thanks. OK

> 

...

>>   #include "kvm-s390.h"
>>   #include "trace.h"
>> @@ -592,6 +593,53 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>   	}
>>   }
>>   
>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
> 
> s/issue/issued/

OK. thanks.

> 
>> + *
>> + * This callback only handles PQAP/AQIC instruction and
> 
> Here you only talk about PQAP/AQIC, what about PQAP/TAPQ mentioned in
> the patch description?

I can add "for now" or "in this patch" or suppress the reference to 
PAPQ/TAPQ

> 
>> + * calls a dedicated callback for this instruction if
>> + * a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>> + * - the hook is not used do not change the behavior.
> 
> The hook is not used? Or not set?

I think "is not set" is better.

> (I don't think you need to repeat "do
> not change the behavior".)

OK

> 
>> + * - AP instructions are not available or not available to the guest
>> + * - the instruction is not PQAP with function code indicating
>> + *   AQIC do not change the previous behavior.
>> + *
>> + * For PQAP/AQIC instruction, verify privilege and specifications
>> + *
>> + * return the value returned by the callback.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +	uint8_t fc;
>> +
>> +	/* Verify that the hook callback is registered */
>> +	if (!vcpu->kvm->arch.crypto.pqap_hook)
>> +		return -EOPNOTSUPP;
>> +	/* Verify that the AP instruction are available */
>> +	if (!ap_instructions_available())
>> +		return -EOPNOTSUPP;
>> +	/* Verify that the guest is allowed to use AP instructions */
>> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +		return -EOPNOTSUPP;
>> +	/* Verify that the function code is AQIC */
>> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
>> +	if (fc != 0x03)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* PQAP instructions are allowed for guest kernel only */
>> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>> +	/* AQIC instruction is allowed only if facility 65 is available */
>> +	if (!test_kvm_facility(vcpu->kvm, 65))
>> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +	/* All right, call the callback */
>> +	return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
> 
> Can that callback also return -EOPNOTSUPP to order to drop to user
> space?

Yes.
Why not?

> 
>> +}
>> +
>>   static int handle_stfl(struct kvm_vcpu *vcpu)
>>   {
>>   	int rc;
>> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>>   		return handle_sthyi(vcpu);
>>   	case 0x7d:
>>   		return handle_stsi(vcpu);
>> +	case 0xaf:
>> +		return handle_pqap(vcpu);
>>   	case 0xb1:
>>   		return handle_stfl(vcpu);
>>   	case 0xb2:
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

