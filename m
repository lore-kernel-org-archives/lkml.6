Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A322C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B612206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfAIMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:35:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730438AbfAIMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:35:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09CXlF1053732
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 07:35:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwg0su3cv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:35:50 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 9 Jan 2019 12:35:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 12:35:45 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09CZhHA196922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 12:35:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAAAF42045;
        Wed,  9 Jan 2019 12:35:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DBAD4204C;
        Wed,  9 Jan 2019 12:35:43 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 12:35:43 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 14/15] KVM: s390: add and wire function
 gib_alert_irq_handler()
To:     mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-15-mimu@linux.ibm.com>
 <7dfe72db-97d2-9f33-68f7-acf8ec5ddc5e@linux.ibm.com>
 <fd2efaed-24d5-4397-b79c-1f64dc80a9e4@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 9 Jan 2019 13:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fd2efaed-24d5-4397-b79c-1f64dc80a9e4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010912-0016-0000-0000-000002427FC6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010912-0017-0000-0000-0000329C98F7
Message-Id: <97f1294f-cbb3-a54b-6abf-29471b69946e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 11:06, Michael Mueller wrote:
> 
> 
> On 03.01.19 16:16, Pierre Morel wrote:
>> On 19/12/2018 20:17, Michael Mueller wrote:
>>> The patch implements a handler for GIB alert interruptions
>>> on the host. Its task is to alert guests that interrupts are
>>> pending for them.
>>>

...snip...

>>>   {
>>>       u32 final, next_alert, origin = 0UL;
>>>       struct kvm_s390_gisa *gisa;
>>> @@ -3091,7 +3092,10 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>>>   {
>>>       if (!kvm->arch.gisa)
>>>           return;
>>> +    if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
>>> +        process_gib_alert_list();
>>
>> We call process_gib_alert_list() from different contexts shouldn't we 
>> protect the calls?
> 
> That should not be necessary as the xcgh() guarantees that both
> instances will work on gib alert lists with disjunctive gisas.

Here is how I see the problem:

A CPU get the GAL IRQ and start processing the ALERT list.

On another guest we clear floating interrupt...
we call gisa_clear()
we return from set_iam with -EBUSY, meaning the GISA is in alert list.
   -> we call process_gib_alert_list()
   -> since the list has been disjunct by the GAL IRQ routine we return
      immediately
   -> we nullify the GISA while it has not been handled by the IRQ
      routine

!! if my assumption is right, we loose all GISA following the GISA we 
just nullified.


Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

