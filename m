Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334ACC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED20320BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeGLOBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:01:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727072AbeGLOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:01:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CDnMi0126042
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:51:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k65jwge9c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:51:54 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alice@linux.vnet.ibm.com>;
        Thu, 12 Jul 2018 09:51:53 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 09:51:50 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CDpnqK12583402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 13:51:49 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE448AC05B;
        Thu, 12 Jul 2018 09:52:45 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E6FAC05E;
        Thu, 12 Jul 2018 09:52:44 -0400 (EDT)
Received: from [9.152.224.119] (unknown [9.152.224.119])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Jul 2018 09:52:44 -0400 (EDT)
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
To:     Hendrik Brueckner <brueckner@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        alice@linux.ibm.com
References: <20180712130733.11510-1-adrian@lisas.de>
 <20180712134717.GB4676@linux.ibm.com>
From:   Alice Frosi <alice@linux.vnet.ibm.com>
Date:   Thu, 12 Jul 2018 15:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712134717.GB4676@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071213-2213-0000-0000-000002C9C32B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009357; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060283; UDB=6.00544237; IPR=6.00838201;
 MB=3.00022117; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 13:51:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071213-2214-0000-0000-00005ACEE601
Message-Id: <dac0b136-26fb-155c-403d-30315f90e978@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2018 15:47, Hendrik Brueckner wrote:
> On Thu, Jul 12, 2018 at 03:07:33PM +0200, Adrian Reber wrote:
>> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
>> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
>> distribution kernels and also part of the defconfigs of various
>> architectures.
>>
>> To make it easier for distributions to enable CHECKPOINT_RESTORE this
>> removes EXPERT and moves the configuration option out of the EXPERT
>> block.
>>
>> Signed-off-by: Adrian Reber <adrian@lisas.de>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Andrei Vagin <avagin@virtuozzo.com>
>> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>> ---
>>   init/Kconfig | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 041f3a022122..9c529c763326 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -932,6 +932,18 @@ config NET_NS
>>
>>   endif # NAMESPACES
>>
>> +config CHECKPOINT_RESTORE
>> +	bool "Checkpoint/restore support"
>> +	select PROC_CHILDREN
>> +	default n
>> +	help
>> +	  Enables additional kernel features in a sake of checkpoint/restore.
>> +	  In particular it adds auxiliary prctl codes to setup process text,
>> +	  data and heap segment sizes, and a few additional /proc filesystem
>> +	  entries.
>> +
>> +	  If unsure, say N here.
>> +
>>   config SCHED_AUTOGROUP
>>   	bool "Automatic process group scheduling"
>>   	select CGROUPS
>> @@ -1348,18 +1360,6 @@ config MEMBARRIER
>>
>>   	  If unsure, say Y.
>>
>> -config CHECKPOINT_RESTORE
>> -	bool "Checkpoint/restore support" if EXPERT
>> -	select PROC_CHILDREN
>> -	default n
>> -	help
>> -	  Enables additional kernel features in a sake of checkpoint/restore.
>> -	  In particular it adds auxiliary prctl codes to setup process text,
>> -	  data and heap segment sizes, and a few additional /proc filesystem
>> -	  entries.
>> -
>> -	  If unsure, say N here.
>> -
>>   config KALLSYMS
>>   	 bool "Load all symbols for debugging/ksymoops" if EXPERT
>>   	 default y
> Thanks!
>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>

