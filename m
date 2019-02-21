Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7781C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4692086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBUKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:42:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbfBUKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:42:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LAeAn8151091
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 05:42:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qsssxt0mq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 05:42:29 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 21 Feb 2019 10:42:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 10:42:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LAgO3c21168144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 10:42:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D61E52050;
        Thu, 21 Feb 2019 10:42:24 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4416752054;
        Thu, 21 Feb 2019 10:42:24 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Sebastian Ott <sebott@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com,
        cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 21 Feb 2019 11:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1901301912380.2372@schleppi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19022110-0028-0000-0000-0000034B3DE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022110-0029-0000-0000-0000240981EA
Message-Id: <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.19 19:32, Sebastian Ott wrote:
> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
>    ^
> I don't think that's the right thing to do here.
>
>
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>  #include <asm/chsc.h>
>>  #include <asm/schid.h>
>>  #include <asm/qdio.h>
>> +#include <asm/ap.h>
> This should be moved to chsc.c
>
>
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/ctype.h>
>> +#include <asm/crw.h>
> This is not needed here.
>
>
>>  /*
>> +* A config change has happened, Force an ap bus rescan.
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> There is no need for the export symbol - you don't call that function
> from module code.
That's what I have learned now: You don't need to export a symbol
as long as the symbol is only called in static code parts of the kernel.
But you need to export it when it is intended to be used by code
which sits in a kernel module. So now the big question:
How does a provider of a function in the kernel know, if the caller is in static
code or in module code ? And ... maybe this may even change over
the time. So my recommendation is to always export the symbol with
the EXPORT_SYMBOL macro. This way you don't need to change the
code providing a function when the caller code changes or additional
code uses the symbol.

Other opinions ?


> As an unrelated question, just to be sure: ap_bus.c is compiled as
> built-in even with ZCRYPT=m, right?
>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
>
> Regards,
> Sebastian

