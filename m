Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07F3EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9768208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9768208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936199AbeFOJJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936163AbeFOJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:09:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5F94lLB099890
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:09:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jm88pdh7c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:09:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 15 Jun 2018 10:09:09 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Jun 2018 10:09:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5F996n129098006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jun 2018 09:09:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B8FBA4053;
        Fri, 15 Jun 2018 09:59:54 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC141A405E;
        Fri, 15 Jun 2018 09:59:53 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jun 2018 09:59:53 +0100 (BST)
Subject: Re: [PATCH 2/3] perf alias: Rebuild alias expression string to make
 it comparable
To:     Jiri Olsa <jolsa@redhat.com>, Paul Clarke <pc@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-2-tmricht@linux.ibm.com>
 <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
 <20180615081242.GF5082@krava>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date:   Fri, 15 Jun 2018 11:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615081242.GF5082@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061509-0020-0000-0000-0000029B2111
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061509-0021-0000-0000-000020E756B2
Message-Id: <f78bbadb-047d-afad-eac6-b1236bd56c81@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806150097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 10:12 AM, Jiri Olsa wrote:
> On Thu, Jun 14, 2018 at 08:53:14AM -0500, Paul Clarke wrote:
> 
> SNIP
> 
>>> +		if (ret)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 ",");
>>> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 "%s=%#x", term->config, term->val.num);
>>> +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 "%s=%s", term->config, term->val.str);
>>
>> If we exceed 256, we just suddenly terminate the rebuilding without reporting any issues.
>>
>>> +	}
>>> +
>>>  	alias->name = strdup(name);
>>>  	if (dir) {
>>>  		/*
>>> @@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>>>  	}
>>>  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>>> -	alias->str = strdup(val);
>>> +	alias->str = strdup(newval);
> 
> hum, how is newval different from val? AFAICS it's the same
> 

Not really, depends on the platform, here is some debug output from s390:
root@s35lp76 perf]# ./perf stat -e tx_nc_tend -- ~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_nc_tend                                                  

       0.001050150 seconds time elapsed

[root@s35lp76 perf]# fgrep -i tx_nc_tend /tmp/111
__perf_pmu__new_alias TX_NC_TEND val:event=0x008d newval:event=0x8d
__perf_pmu__new_alias tx_nc_tend val:event=0x8d newval:event=0x8d
TX_NC_TEND	1 rc 8
[root@s35lp76 perf]# 

On s390 the events in the PMU sysfs file are printed with leading zeroes.
This means the strcmp() of alias->str differs, but the contents is logically
identical. (Same of some files contains spaces).

Thats why I do the rewrite of val into newval.

The alias name does not match too, but we use strcasecmp() to ignore case.

Hope this helps.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

