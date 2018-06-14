Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 138B7C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80F2208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80F2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965685AbeFNOKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:10:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965656AbeFNOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:10:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EE5DnH059356
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:10:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jkst6reqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:10:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 14 Jun 2018 15:10:36 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 15:10:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5EEAWYG23265424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 14:10:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E823CAE053;
        Thu, 14 Jun 2018 14:59:20 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 786E1AE058;
        Thu, 14 Jun 2018 14:59:20 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jun 2018 14:59:20 +0100 (BST)
Subject: Re: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
To:     Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <c29a4b36-a2db-b1d9-a5c7-a0c0806970ab@us.ibm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date:   Thu, 14 Jun 2018 16:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c29a4b36-a2db-b1d9-a5c7-a0c0806970ab@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061414-0008-0000-0000-00000247B6EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061414-0009-0000-0000-000021ADED31
Message-Id: <3c66953b-fb56-e446-8dff-53fd91007a43@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 03:17 PM, Paul Clarke wrote:
> On 06/14/2018 06:48 AM, Thomas Richter wrote:
>> Remove a trailing newline when reading sysfs file contents
>> such as /sys/devices/cpum_cf/events/TX_NC_TEND.
>> This show when verbose option -v is used.
>>
>> Output before:
>> tx_nc_tend -> 'cpum_cf'/'event=0x008d
>> '/
>>
>> Output after:
>> tx_nc_tend -> 'cpum_cf'/'event=0x8d'/
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/util/pmu.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 7878934ebb23..26c79a9c4142 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -294,7 +294,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>
>>  static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
>>  {
>> -	char buf[256];
>> +	char *cp, buf[256];
>>  	int ret;
>>
>>  	ret = fread(buf, 1, sizeof(buf), file);
>> @@ -303,6 +303,11 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
>>
>>  	buf[ret] = 0;
>>
>> +	/* Remove trailing newline from sysfs file */
>> +	cp = strrchr(buf, '\n');
>> +	if (cp)
>> +		*cp = '\0';
> 
> A nit, perhaps, but this will search backwards through the entire string if a newline is not found, which is the most common case, I presume.  Would it be more efficient to just look at the last character?  Something like:
> i = strlen(buf);
> if (i > 0 && buf[i-1] == '\n')
>   buf[i-1] = '\0';
> 
>> +
>>  	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
>>  				     NULL, NULL, NULL);
>>  }
>>
> 
> PC
> 

Arnaldo suggested rtrim() which I will use.
I agree that your approach is a bit faster...



-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

