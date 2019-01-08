Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50F62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAHKGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:06:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbfAHKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:06:13 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08A4AT5087653
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 05:06:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvpsctasg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:06:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Tue, 8 Jan 2019 10:06:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 10:06:06 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08A65On65142898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 10:06:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51C39A404D;
        Tue,  8 Jan 2019 10:06:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC44DA4053;
        Tue,  8 Jan 2019 10:06:04 +0000 (GMT)
Received: from [9.152.98.101] (unknown [9.152.98.101])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 10:06:04 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 14/15] KVM: s390: add and wire function
 gib_alert_irq_handler()
To:     pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
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
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Tue, 8 Jan 2019 11:06:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7dfe72db-97d2-9f33-68f7-acf8ec5ddc5e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010810-4275-0000-0000-000002FBD768
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010810-4276-0000-0000-00003809E1DC
Message-Id: <fd2efaed-24d5-4397-b79c-1f64dc80a9e4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.19 16:16, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The patch implements a handler for GIB alert interruptions
>> on the host. Its task is to alert guests that interrupts are
>> pending for them.
>>
>> A GIB alert interrupt statistic counter is added as well:
>>
>> $ cat /proc/interrupts
>>            CPU0       CPU1
>>    ...
>>    GAL:      23         37   [I/O] GIB Alert
>>    ...
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/irq.h |  1 +
>>   arch/s390/include/asm/isc.h |  1 +
>>   arch/s390/kernel/irq.c      |  1 +
>>   arch/s390/kvm/interrupt.c   | 36 ++++++++++++++++++++++++++++++++++--
>>   4 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
>> index 2f7f27e5493f..afaf5e3c57fd 100644
>> --- a/arch/s390/include/asm/irq.h
>> +++ b/arch/s390/include/asm/irq.h
>> @@ -62,6 +62,7 @@ enum interruption_class {
>>       IRQIO_MSI,
>>       IRQIO_VIR,
>>       IRQIO_VAI,
>> +    IRQIO_GAL,
>>       NMI_NMI,
>>       CPU_RST,
>>       NR_ARCH_IRQS
>> diff --git a/arch/s390/include/asm/isc.h b/arch/s390/include/asm/isc.h
>> index 6cb9e2ed05b6..b2cc1ec78d06 100644
>> --- a/arch/s390/include/asm/isc.h
>> +++ b/arch/s390/include/asm/isc.h
>> @@ -21,6 +21,7 @@
>>   /* Adapter interrupts. */
>>   #define QDIO_AIRQ_ISC IO_SCH_ISC    /* I/O subchannel in qdio mode */
>>   #define PCI_ISC 2            /* PCI I/O subchannels */
>> +#define GAL_ISC 5            /* GIB alert */
>>   #define AP_ISC 6            /* adjunct processor (crypto) devices */
>>   /* Functions for registration of I/O interruption subclasses */
>> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
>> index 0e8d68bac82c..0cd5a5f96729 100644
>> --- a/arch/s390/kernel/irq.c
>> +++ b/arch/s390/kernel/irq.c
>> @@ -88,6 +88,7 @@ static const struct irq_class irqclass_sub_desc[] = {
>>       {.irq = IRQIO_MSI,  .name = "MSI", .desc = "[I/O] MSI Interrupt" },
>>       {.irq = IRQIO_VIR,  .name = "VIR", .desc = "[I/O] Virtual I/O 
>> Devices"},
>>       {.irq = IRQIO_VAI,  .name = "VAI", .desc = "[I/O] Virtual I/O 
>> Devices AI"},
>> +    {.irq = IRQIO_GAL,  .name = "GAL", .desc = "[I/O] GIB Alert"},
>>       {.irq = NMI_NMI,    .name = "NMI", .desc = "[NMI] Machine Check"},
>>       {.irq = CPU_RST,    .name = "RST", .desc = "[CPU] CPU Restart"},
>>   };
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 03e7ba4f215a..79b9c262479b 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -26,6 +26,7 @@
>>   #include <asm/gmap.h>
>>   #include <asm/switch_to.h>
>>   #include <asm/nmi.h>
>> +#include <asm/airq.h>
>>   #include "kvm-s390.h"
>>   #include "gaccess.h"
>>   #include "trace-s390.h"
>> @@ -3043,7 +3044,7 @@ static void __floating_airqs_kick(struct kvm *kvm)
>>   #define NONE_GISA_ADDR 0x00000001UL
>>   #define GISA_ADDR_MASK 0xfffff000UL
>> -static void __maybe_unused process_gib_alert_list(void)
>> +static void process_gib_alert_list(void)
>>   {
>>       u32 final, next_alert, origin = 0UL;
>>       struct kvm_s390_gisa *gisa;
>> @@ -3091,7 +3092,10 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>>       if (!kvm->arch.gisa)
>>           return;
>> +    if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
>> +        process_gib_alert_list();
> 
> We call process_gib_alert_list() from different contexts shouldn't we 
> protect the calls?

That should not be necessary as the xcgh() guarantees that both
instances will work on gib alert lists with disjunctive gisas.

> 
> 
>>       nullify_gisa(kvm->arch.gisa);
>> +    set_iam(kvm->arch.gisa, kvm->arch.iam);
>>       VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>>   }
>> @@ -3111,6 +3115,8 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
>>   {
>>       if (!kvm->arch.gisa)
>>           return;
>> +    if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
>> +        process_gib_alert_list();
> 
> idem.
> 
>>       kvm->arch.gisa = NULL;
>>   }
>> @@ -3159,11 +3165,23 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, 
>> u32 gisc)
>>   }
>>   EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
>> +static void gib_alert_irq_handler(struct airq_struct *airq)
>> +{
>> +    inc_irq_stat(IRQIO_GAL);
>> +    process_gib_alert_list();
> 
> idem.
> 
>> +}
>> +
>> +static struct airq_struct gib_alert_irq = {
>> +    .handler = gib_alert_irq_handler,
>> +    .lsi_ptr = &gib_alert_irq.lsi_mask,
>> +};
>> +

> 

