Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C61C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfAaXvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:51:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbfAaXvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:51:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VNnBRx027865
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:51:08 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc8a36d3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:51:07 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 31 Jan 2019 23:51:07 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 23:51:04 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VNoxPD17825944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 23:50:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4643578063;
        Thu, 31 Jan 2019 23:50:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFE347805E;
        Thu, 31 Jan 2019 23:50:57 +0000 (GMT)
Received: from [9.80.226.197] (unknown [9.80.226.197])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 23:50:57 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <20190131105555.4af6d8ea.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 31 Jan 2019 18:50:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131105555.4af6d8ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013123-0004-0000-0000-000014DADA4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010512; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154557; UDB=6.00602060; IPR=6.00934990;
 MB=3.00025380; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 23:51:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013123-0005-0000-0000-00008A6E4B1F
Message-Id: <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 4:55 AM, Cornelia Huck wrote:
> On Wed, 30 Jan 2019 12:48:46 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> The current AP bus implementation periodically polls the AP configuration
>> to detect changes. When the AP configuration is dynamically changed via the
>> SE or an SCLP instruction, the changes will not be reflected to sysfs until
>> the next time the AP configuration is polled. The CHSC architecture
>> provides a Store Event Information (SEI)command to make notification of an
> 
> missing blank ---------------------------^

I'll insert it.

> 
>> AP configuration change. This patch introduces a handler to process
>> notification from the CHSC SEI command BY immediately kickING off an AP bus
> 
> s/BY/by/
> 
> s/kickING/kicking/

Will fix both.

> 
>> scan.
> 
> Scan-after-event sounds useful, yeah.

sure

> 
> Two questions:
> - Does the event cover _any_ change to the AP configuration, or can the
>    periodic scan detect changes that are not signaled?

It can detect any change, such as a change to the CRYCB masks.

> - Do we want to generate such an event in QEMU on plugging/unplugging
>    the vfio-ap device?

We've discussed this quite a bit internally and decided not to implement
that at this time. We will address it as a future enhancement.

> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h   | 12 ++++++++++++
>>   drivers/s390/cio/chsc.c      | 12 ++++++++++++
>>   drivers/s390/cio/chsc.h      |  1 +
>>   drivers/s390/crypto/ap_bus.c | 12 ++++++++++++
>>   4 files changed, 37 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index 1a6a7092d942..c778593d509f 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -360,4 +360,16 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>>   	return reg1;
>>   }
>>   
>> +/*
>> + * Interface to tell the AP bus code that a configuration
>> + * change has happened. The bus code should at least do
>> + * an ap bus resource rescan.
>> + */
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
> 
> That #error looks like a development debugging leftover.
> 
>> +static void ap_bus_cfg_chg(void){};
>> +#endif
>> +
>>   #endif /* _ASM_S390_AP_H_ */
>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>> index a0baee25134c..dccccc337078 100644
>> --- a/drivers/s390/cio/chsc.c
>> +++ b/drivers/s390/cio/chsc.c
>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>>   			      " failed (rc=%d).\n", ret);
>>   }
>>   
>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
>> +{
>> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>> +	if (sei_area->rs != 5)
>> +		return;
> 
> I'm guessing that a reporting source of 5 means ap, right? (The code is
> silent on all those magic rs values :/)

The 5 indicates the accessibility of one or more adjunct processors has
changed. The reason this gets called is because the CC sent with the
instruction indicates the AP configuration has changed, so the reporting
belongs where it is. There is only one RS associated with it.

> 
> If so, should the debug logging be moved after the check?

covered in the response above.

> 
>> +
>> +	ap_bus_cfg_chg();
>> +}
>> +
>>   static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
>>   {
>>   	switch (sei_area->cc) {
>> @@ -612,6 +621,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
>>   	case 2: /* i/o resource accessibility */
>>   		chsc_process_sei_res_acc(sei_area);
>>   		break;
>> +	case 3: /* ap config changed */
>> +		chsc_process_sei_ap_cfg_chg(sei_area);
>> +		break;
>>   	case 7: /* channel-path-availability information */
>>   		chsc_process_sei_chp_avail(sei_area);
>>   		break;
>> diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
>> index 78aba8d94eec..5651066c46e3 100644
>> --- a/drivers/s390/cio/chsc.h
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>   #include <asm/chsc.h>
>>   #include <asm/schid.h>
>>   #include <asm/qdio.h>
>> +#include <asm/ap.h>
> 
> I would probably include this in chsc.c instead.

Already done per Sebastian's comment.

> 
>>   
>>   #define CHSC_SDA_OC_MSS   0x2
>>   
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 48ea0004a56d..94f621783d6b 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <asm/crw.h>
> 
> Why are you adding this #include?

Already removed per Sebastian's comment.

> 
>>   
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -860,6 +861,17 @@ void ap_bus_force_rescan(void)
>>   EXPORT_SYMBOL(ap_bus_force_rescan);
>>   
>>   /*
>> +* A config change has happened, Force an ap bus rescan.
> 
> s/Force/force/

Will do.

> 
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>> +
>> +/*
>>    * hex2bitmap() - parse hex mask string and set bitmap.
>>    * Valid strings are "0x012345678" with at least one valid hex number.
>>    * Rest of the bitmap to the right is padded with 0. No spaces allowed
> 

