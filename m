Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80645C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfAILjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:39:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730755AbfAILjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:39:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09BYhjH144133
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 06:39:14 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwepfmk0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 06:39:14 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 9 Jan 2019 11:39:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 11:39:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Bd7m247448210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 11:39:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E1174203F;
        Wed,  9 Jan 2019 11:39:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5FE4204B;
        Wed,  9 Jan 2019 11:39:07 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 11:39:07 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
To:     mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
 <1889d0a2-d22a-1170-10bd-0bfc91549388@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 9 Jan 2019 12:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1889d0a2-d22a-1170-10bd-0bfc91549388@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010911-0012-0000-0000-000002E54BE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010911-0013-0000-0000-0000211C4D8B
Message-Id: <68fae932-b589-f978-3a4a-3bc6643227bb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2019 20:18, Michael Mueller wrote:
> 
> 
> On 03.01.19 15:43, Pierre Morel wrote:
>> On 19/12/2018 20:17, Michael Mueller wrote:
>>> This function processes the Gib Alert List (GAL). It is required
...snip...
> +    struct kvm *kvm;
>>> +
>>> +    do {
>>> +        /*
>>> +         * If the NONE_GISA_ADDR is still stored in the alert list
>>> +         * origin, we will leave the outer loop. No further GISA has
>>> +         * been added to the alert list by millicode while processing
>>> +         * the current alert list.
>>> +         */
>>> +        final = (origin & NONE_GISA_ADDR);
>>> +        /*
>>> +         * Cut off the alert list and store the NONE_GISA_ADDR in the
>>> +         * alert list origin to avoid further GAL interruptions.
>>> +         * A new alert list can be build up by millicode in parallel
>>> +         * for guests not in the yet cut-off alert list. When in the
>>> +         * final loop, store the NULL_GISA_ADDR instead. This will re-
>>> +         * enable GAL interruptions on the host again.
>>> +         */
>>> +        origin = xchg(&gib->alert_list_origin,
>>> +                  (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>>> +        /* Loop through the just cut-off alert list. */
>>> +        while (origin & GISA_ADDR_MASK) {
>>> +            gisa = (struct kvm_s390_gisa *)(u64)origin;
>>> +            next_alert = gisa->next_alert;
>>> +            /* Unlink the GISA from the alert list. */
>>> +            gisa->next_alert = origin;
>>
>> AFAIU this enable GISA interrupt for the guest...
> 
> Only together with the IAM being set what could happen if
> __floating_airqs_kick() calls get_ipm and the IPM is clean already. :(

confused, AFAIK IAM is used to allow interrupt for the host
not for the guest.

> 
>>
>>> +            kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>>> +            /* Kick suitable vcpus */
>>> +            __floating_airqs_kick(kvm);
>>
>> ...and here we kick a VCPU for the guest.
>>
>> Logically I would do it in the otherway, first kicking the vCPU then 
>> enabling the GISA interruption again.

!! sorry to have introduce this confusion.
You did it in the right order.
I should have not send these comments after I gave my R-B

>>
>> If the IPM bit is cleared by the firmware during delivering the 
>> interrupt to the guest before we enter get_ipm() called by 
>> __floating_airqs_kick() we will set the IAM despite we have a running 
>> CPU handling the IRQ.
> 
> I will move the unlink below the kick that will assure get_ipm will 
> never take the IAM restore path.

!! Sorry, you were right.
We must re-enable interrupt before kicking the vcpu, as you did, or the 
vcpu could go to wait before it gets the interrupt.

> 
>> In the worst case we can also set the IAM with the GISA in the alert 
>> list.
>> Or we must accept that the firmware can deliver the IPM as soon as we 
>> reset the GISA next field.
> 
> See statement above.
> 
>>
>>> +            origin = next_alert;
>>> +        }
>>> +    } while (!final);
>>> +}
>>> +
>>>   static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>>   {
>>>       memset(gisa, 0, sizeof(struct kvm_s390_gisa));
>>>
>>
>> I think that avoiding to restore the IAM during the call to get_ipm 
>> inside __floating_airqs_kick() would good.

I still think tis assumption is right: We should not set the IAM during 
the kick.

>>
>> If you agree, with that:
>>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

Still OK with my R-B, as long as w do not set IAM during the kicking.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

