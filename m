Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1945DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563C217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfBZLsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:48:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbfBZLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:48:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QBiHxC104222
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:47:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qw41138h2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:47:59 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 26 Feb 2019 11:47:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 11:47:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QBlrig54919318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 11:47:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E30842045;
        Tue, 26 Feb 2019 11:47:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4BFF4203F;
        Tue, 26 Feb 2019 11:47:52 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 11:47:52 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 26 Feb 2019 12:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022611-0008-0000-0000-000002C51385
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022611-0009-0000-0000-000022315C70
Message-Id: <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2019 19:36, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> We prepare the interception of the PQAP/AQIC instruction for
>> the case the AQIC facility is enabled in the guest.
>>
>> We add a callback inside the KVM arch structure for s390 for
>> a VFIO driver to handle a specific response to the PQAP
>> instruction with the AQIC command.
>>
>> We inject the correct exceptions from inside KVM for the case the
>> callback is not initialized, which happens when the vfio_ap driver
>> is not loaded.
>>
>> If the callback has been setup we call it.
>> If not we setup an answer considering that no queue is available
>> for the guest when no callback has been setup.
>>
>> We do consider the responsability of the driver to always initialize
>> the PQAP callback if it defines queues by initializing the CRYCB for
>> a guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

...snip...

>> @@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>       }
>>   }
>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
>> + *
>> + * We now support PQAP/AQIC instructions and we need to correctly
>> + * answer the guest even if no dedicated driver's hook is available.
>> + *
>> + * The intercepting code calls a dedicated callback for this instruction
>> + * if a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * For PQAP/AQIC instructions only, verify privilege and specifications.
>> + *
>> + * If no callback available, the queues are not available, return 
>> this to
>> + * the caller.
>> + * Else return the value returned by the callback.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +    uint8_t fc;
>> +    struct ap_queue_status status = {};
>> +
>> +    /* Verify that the AP instruction are available */
>> +    if (!ap_instructions_available())
>> +        return -EOPNOTSUPP;
> 
> How can the guest even execute an AP instruction if the AP instructions
> are not available? If the AP instructions are not available on the host,
> they will not be available on the guest (i.e., CPU model feature
> S390_FEAT_AP will not be set). I suppose it doesn't hurt to check this
> here given QEMU may not be the only client.
> 
>> +    /* Verify that the guest is allowed to use AP instructions */
>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the function code is AQIC */
>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>> +    if (fc != 0x03)
>> +        return -EOPNOTSUPP;
> 
> You must have missed my suggestion to move this to the
> vcpu->kvm->arch.crypto.pqap_hook(vcpu) in the following responses:

Please consider what happen if the vfio_ap module is not loaded.

> 
> Message ID <342ffd56-b73a-b1f4-004d-de2c4aeef729@linux.ibm.com>
> Message ID <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
> 
> You previously stated:
> 
>     "QEMU and KVM can both accept PQAP/AQIC even if the vfio_ap driver is
>      not loaded. However now that the guest officially get the PQAP/AQIC
>      instruction we need to handle the specification and operation
>      exceptions inside KVM _before_ testing and even calling the driver
>      hook.
> 
>      I will make the changes in the next iteration."

Still seems right to me, and is done is this patch.
Isn't it?

> 
> I don't know what any of the above has to do with checking FC=0x03? If
> that check is moved to the pqap handler hook, it can just as well return
> -EOPNOTSUPP. In fact, down below you do this:
> 
>      return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
> 
> If the RC=0x03 check fails in the hook, it will return -EOPNOTSUPP just
> like above. None of this is critical, but the parsing of the register
> values for the PQAP(AQIC) function ought to be done in the code that
> handles the PQAP instruction IMHO.


This interception code must handle the PQAP/AQIC instruction when the 
hook is not used and should not modify the handling for other PQAP 
instructions.
We can not move anything inside the hook that must be always done.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

