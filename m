Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB5C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DB32086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAaX2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:28:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbfAaX2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:28:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VNSoAR062918
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:28:51 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qcam1076p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 18:28:51 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 31 Jan 2019 23:28:50 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 23:28:46 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VNSf5e13238328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 23:28:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D22E8BE053;
        Thu, 31 Jan 2019 23:28:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897FBBE04F;
        Thu, 31 Jan 2019 23:28:40 +0000 (GMT)
Received: from [9.80.226.197] (unknown [9.80.226.197])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 23:28:40 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 31 Jan 2019 18:28:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1901301912380.2372@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013123-8235-0000-0000-00000E53FF49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010512; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154550; UDB=6.00602055; IPR=6.00934982;
 MB=3.00025380; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 23:28:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013123-8236-0000-0000-0000444A730F
Message-Id: <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
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

On 1/30/19 1:32 PM, Sebastian Ott wrote:
> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
>     ^
> I don't think that's the right thing to do here.

I'd like to leave it. If somebody edits .config
and sets CONFIG_ZCRYPT=n, then the build will
fail. The preprocessor error above tells them
why.

> 
> 
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>   #include <asm/chsc.h>
>>   #include <asm/schid.h>
>>   #include <asm/qdio.h>
>> +#include <asm/ap.h>
> 
> This should be moved to chsc.c

I can do that, but I'm curious why.

> 
> 
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <asm/crw.h>
> 
> This is not needed here.

I'll remove it.

> 
> 
>>   /*
>> +* A config change has happened, Force an ap bus rescan.
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> 
> There is no need for the export symbol - you don't call that function
> from module code.
> As an unrelated question, just to be sure: ap_bus.c is compiled as
> built-in even with ZCRYPT=m, right?

No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
into the zcrypt.ko module. Through some other magic, the zcrypt module
is loaded when linux boots.

> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> 
> Regards,
> Sebastian
> 

