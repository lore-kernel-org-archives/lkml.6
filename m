Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558CDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F352086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAaXcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:32:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbfAaXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:32:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VNSoRe055384
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:32:41 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qcaq205k5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:32:41 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 31 Jan 2019 23:32:40 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 23:32:37 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VNWWjU18284726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 23:32:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7779513604F;
        Thu, 31 Jan 2019 23:32:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F401A136055;
        Thu, 31 Jan 2019 23:32:30 +0000 (GMT)
Received: from [9.80.226.197] (unknown [9.80.226.197])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 23:32:30 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <95a29dd5-11d5-0984-ffbd-73ef92ed1aba@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 31 Jan 2019 18:32:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <95a29dd5-11d5-0984-ffbd-73ef92ed1aba@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19013123-0004-0000-0000-000014DAD8FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010512; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154551; UDB=6.00602056; IPR=6.00934983;
 MB=3.00025380; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 23:32:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013123-0005-0000-0000-00008A6E42B5
Message-Id: <c8025bc5-91dc-98dc-63b0-e0617b781bb9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 4:09 AM, Pierre Morel wrote:
> On 30/01/2019 18:48, Tony Krowiak wrote:
>> The current AP bus implementation periodically polls the AP configuration
>> to detect changes. When the AP configuration is dynamically changed 
>> via the
>> SE or an SCLP instruction, the changes will not be reflected to sysfs 
>> until
>> the next time the AP configuration is polled. The CHSC architecture
>> provides a Store Event Information (SEI)command to make notification 
>> of an
>> AP configuration change. This patch introduces a handler to process
>> notification from the CHSC SEI command BY immediately kickING off an 
>> AP bus
>> scan.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h   | 12 ++++++++++++
>>   drivers/s390/cio/chsc.c      | 12 ++++++++++++
>>   drivers/s390/cio/chsc.h      |  1 +
>>   drivers/s390/crypto/ap_bus.c | 12 ++++++++++++
>>   4 files changed, 37 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index 1a6a7092d942..c778593d509f 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -360,4 +360,16 @@ static inline struct ap_queue_status 
>> ap_dqap(ap_qid_t qid,
>>       return reg1;
>>   }
>> +/*
>> + * Interface to tell the AP bus code that a configuration
>> + * change has happened. The bus code should at least do
>> + * an ap bus resource rescan.
>> + */
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
>> +static void ap_bus_cfg_chg(void){};
>> +#endif
>> +
>>   #endif /* _ASM_S390_AP_H_ */
>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>> index a0baee25134c..dccccc337078 100644
>> --- a/drivers/s390/cio/chsc.c
>> +++ b/drivers/s390/cio/chsc.c
>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct 
>> chsc_sei_nt0_area *sei_area)
>>                     " failed (rc=%d).\n", ret);
>>   }
>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area 
>> *sei_area)
>> +{
>> +    CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>> +    if (sei_area->rs != 5)
> 
> Why just return if the rs code is 5?
> 
> The event content code concerns the AP configuration change.
> 
> Should the source of the reporting of this change hold us from 
> rescanning the available AP?

Why rescan if the RS code does not indicate the AP configuration
changed?

> 
> 
> Regards,
> Pierre
> 
> 
>> +        return;
>> +
>> +    ap_bus_cfg_chg();
>> +}
>> +
>>   static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
>>   {
>>       switch (sei_area->cc) {
>> @@ -612,6 +621,9 @@ static void chsc_process_sei_nt0(struct 
>> chsc_sei_nt0_area *sei_area)
>>       case 2: /* i/o resource accessibility */
>>           chsc_process_sei_res_acc(sei_area);
>>           break;
>> +    case 3: /* ap config changed */
>> +        chsc_process_sei_ap_cfg_chg(sei_area);
>> +        break;
>>       case 7: /* channel-path-availability information */
>>           chsc_process_sei_chp_avail(sei_area);
>>           break;
>> diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
>> index 78aba8d94eec..5651066c46e3 100644
>> --- a/drivers/s390/cio/chsc.h
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>   #include <asm/chsc.h>
>>   #include <asm/schid.h>
>>   #include <asm/qdio.h>
>> +#include <asm/ap.h>
>>   #define CHSC_SDA_OC_MSS   0x2
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 48ea0004a56d..94f621783d6b 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <asm/crw.h>
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -860,6 +861,17 @@ void ap_bus_force_rescan(void)
>>   EXPORT_SYMBOL(ap_bus_force_rescan);
>>   /*
>> +* A config change has happened, Force an ap bus rescan.
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +    AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", 
>> __func__);
>> +
>> +    ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>> +
>> +/*
>>    * hex2bitmap() - parse hex mask string and set bitmap.
>>    * Valid strings are "0x012345678" with at least one valid hex number.
>>    * Rest of the bitmap to the right is padded with 0. No spaces allowed
>>
> 
> 

