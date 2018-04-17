Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDQMpG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:45:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752511AbeDQMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:45:04 -0400
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
To: Harald Freudenberger <FREUDE@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, alex.williamson@redhat.com,
        alifm@linux.vnet.ibm.com, berrange@redhat.com,
        bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com, cohuck@redhat.com,
        fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com,
        Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <83bd1b8f-f3c0-328f-4b3d-6972d82b3662@linux.vnet.ibm.com>
 <OFF71B62BB.95581C62-ON00258272.00264957-C1258272.0026A1CA@notes.na.collabserv.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 14:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <OFF71B62BB.95581C62-ON00258272.00264957-C1258272.0026A1CA@notes.na.collabserv.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041712-0008-0000-0000-000004EC45AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041712-0009-0000-0000-00001E8049D3
Message-Id: <b9c43a0a-7d05-9227-7f2b-862cba532607@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2018 09:01, Harald Freudenberger wrote:
> Hi Pierre
>
> The AP bus can no longer get compiled as a module. There is a (unbeautiful)
> trick done in the Makefile:
>
> ...
> ap-objs := ap_bus.o ap_card.o ap_queue.o
> obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
> # zcrypt_api.o and zcrypt_msgtype*.o depend on ap.o
> ...
>
> which makes sure there is either no AP support in the kernel or it is
> always static.

Hi,

AP can not be compiled as a kernel module but...
we can set ZCRYPT=m in the configuration which means
that the ZCRYPT definition will be CONFIG_ZCRYPT_MODULE and not 
CONFIG_ZCRYPT.

Regards,

Pierre


>
> Mit freundlichen Grüßen / Kind regards
>
>      Harald Freudenberger
>
>
> IBM Systems &Technology Group, zLinux Development
> ----------------------------------------------------------------------------------
>
> IBM Deutschland
> Schoenaicher Str. 220
> 71032 Boeblingen
> Phone: +49-7031-16-5152
> E-Mail: freude@de.ibm.com
> ----------------------------------------------------------------------------------
>
> IBM Deutschland Research & Development GmbH
> Vorsitzender des Aufsichtsrats: Martina Koederitz
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
> ------------------------------------------------------------------------------------
>
>
>
> From:	Pierre Morel <pmorel@linux.vnet.ibm.com>
> To:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
>              linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
>              kvm@vger.kernel.org
> Cc:	Harald Freudenberger/Germany/IBM@IBMDE,
>              mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
>              borntrae@linux.ibm.com, cohuck@redhat.com,
>              kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
>              pbonzini@redhat.com, alex.williamson@redhat.com,
>              alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
>              jjherne@linux.vnet.ibm.com, thuth@redhat.com,
>              pasic@linux.vnet.ibm.com, berrange@redhat.com,
>              fiuczy@linux.vnet.ibm.com, Reinhard Buendgen/Germany/IBM@IBMDE
> Date:	16.04.2018 17:59
> Subject:	Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
>              available function
>
>
>
> On 15/04/2018 23:22, Tony Krowiak wrote:
>> If the AP instructions are not available on the linux host, then
>> AP devices can not be interpreted by the SIE. The AP bus has a
>> function it uses to determine if the AP instructions are
>> available. This patch provides a new function that wraps the
>> AP bus's function to externalize it for use by KVM.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
>> ---
>>    arch/s390/include/asm/ap.h     |    7 +++++++
>>    arch/s390/include/asm/kvm-ap.h |   23 +++++++++++++++++++++++
>>    arch/s390/kvm/Makefile         |    2 +-
>>    arch/s390/kvm/kvm-ap.c         |   21 +++++++++++++++++++++
>>    drivers/s390/crypto/ap_bus.c   |    6 ++++++
>>    5 files changed, 58 insertions(+), 1 deletions(-)
>>    create mode 100644 arch/s390/include/asm/kvm-ap.h
>>    create mode 100644 arch/s390/kvm/kvm-ap.c
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..7773bfd 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -120,4 +120,11 @@ struct ap_queue_status ap_queue_irq_ctrl(ap_qid_t
> qid,
>>    		 		 		 		 		  struct
> ap_qirq_ctrl qirqctrl,
>>    		 		 		 		 		  void *ind);
>>
>> +/**
>> + * ap_instructions_installed() - Tests whether AP instructions are
> installed
>> + *
>> + * Returns 1 if the AP instructions are installed, otherwise; returns 0
>> + */
>> +int ap_instructions_installed(void);
>> +
>>    #endif /* _ASM_S390_AP_H_ */
>> diff --git a/arch/s390/include/asm/kvm-ap.h
> b/arch/s390/include/asm/kvm-ap.h
>> new file mode 100644
>> index 0000000..84412a9
>> --- /dev/null
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +
>> +#ifndef _ASM_KVM_AP
>> +#define _ASM_KVM_AP
>> +
>> +/**
>> + * kvm_ap_instructions_installed()
>> + *
>> + * Tests whether AP instructions are installed on the linux host
>> + *
>> + * Returns 1 if the AP instructions are installed on the host,
> otherwise;
>> + * returns 0
>> + */
>> +int kvm_ap_instructions_installed(void);
>> +
>> +#endif /* _ASM_KVM_AP */
>> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
>> index 05ee90a..1876bfe 100644
>> --- a/arch/s390/kvm/Makefile
>> +++ b/arch/s390/kvm/Makefile
>> @@ -9,6 +9,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $
> (KVM)/async_pf.o $(KVM)/irqch
>>    ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>>
>>    kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o
> sigp.o
>> -kvm-objs += diag.o gaccess.o guestdbg.o vsie.o
>> +kvm-objs += diag.o gaccess.o guestdbg.o vsie.o kvm-ap.o
>>
>>    obj-$(CONFIG_KVM) += kvm.o
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> new file mode 100644
>> index 0000000..1267588
>> --- /dev/null
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +#include <linux/kernel.h>
>> +#include <asm/kvm-ap.h>
>> +#include <asm/ap.h>
>> +
>> +int kvm_ap_instructions_installed(void)
>> +{
>> +#ifdef CONFIG_ZCRYPT
> if you do this take care that ZCRYPT may be a module ;)
>
>> +		 return ap_instructions_installed();
>> +#else
>> +		 return 0;
>> +#endif
>> +}
>> +EXPORT_SYMBOL(kvm_ap_instructions_installed);
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 35a0c2b..9d108b6 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -210,6 +210,12 @@ int ap_query_configuration(struct ap_config_info
> *info)
>>    }
>>    EXPORT_SYMBOL(ap_query_configuration);
>>
>> +int ap_instructions_installed(void)
>> +{
>> +		 return (ap_instructions_available() == 0);
>> +}
>> +EXPORT_SYMBOL(ap_instructions_installed);
>> +
>>    /**
>>     * ap_init_configuration(): Allocate and query configuration array.
>>     */
>
> --
> Pierre Morel
> Linux/KVM/QEMU in Böblingen - Germany
>
>
>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
