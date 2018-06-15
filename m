Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C1710C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB34208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB34208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965557AbeFOI4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:56:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936183AbeFOI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:56:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5F8roiw113878
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 04:56:23 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jm7qa6fq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 04:56:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 15 Jun 2018 09:56:20 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Jun 2018 09:56:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5F8uHC834144390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jun 2018 08:56:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB1CA4055;
        Fri, 15 Jun 2018 09:47:05 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C927A4059;
        Fri, 15 Jun 2018 09:47:05 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jun 2018 09:47:05 +0100 (BST)
Subject: Re: [PATCH 3/3] perf stat: Remove duplicate event counting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-3-tmricht@linux.ibm.com> <20180615082124.GG5082@krava>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date:   Fri, 15 Jun 2018 10:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615082124.GG5082@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061508-0012-0000-0000-0000027FB1D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061508-0013-0000-0000-000020B0D885
Message-Id: <351a9e7d-5cca-57ae-8e87-4a792bde5ecd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806150096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 10:21 AM, Jiri Olsa wrote:
> On Thu, Jun 14, 2018 at 01:48:45PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
>> +static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
>> +				char **new_str)
>> +{
>> +	if (!*old_str)
>> +		goto set_new;
>> +
>> +	if (*new_str) {	/* Have new string, check with old */
>> +		if (strcasecmp(*old_str, *new_str))
>> +			pr_debug("alias %s differs in field '%s'\n",
>> +				 name, field);
>> +		zfree(old_str);
>> +	} else		/* Nothing new --> keep old string */
>> +		return;
>> +set_new:
>> +	*old_str = *new_str;
>> +	*new_str = NULL;
>> +}
>> +
>> +static void perf_pmu_update_alias(struct perf_pmu_alias *old,
>> +				  struct perf_pmu_alias *newalias)
>> +{
>> +	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
>> +	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
>> +			    &newalias->long_desc);
>> +	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
>> +	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
>> +			    &newalias->metric_expr);
>> +	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
>> +			    &newalias->metric_name);
>> +	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
>> +	old->scale = newalias->scale;
>> +	old->per_pkg = newalias->per_pkg;
>> +	old->snapshot = newalias->snapshot;
>> +	memcpy(old->unit, newalias->unit, sizeof(old->unit));
>> +}
>> +
>> +/* Delete an alias entry. */
>> +static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>> +{
>> +	zfree(&newalias->name);
>> +	zfree(&newalias->desc);
>> +	zfree(&newalias->long_desc);
>> +	zfree(&newalias->topic);
>> +	zfree(&newalias->str);
>> +	zfree(&newalias->metric_expr);
>> +	zfree(&newalias->metric_name);
>> +	parse_events_terms__purge(&newalias->terms);
>> +	free(newalias);
>> +}
>> +
>> +/* Merge an alias, search in alias list. If this name is already
>> + * present merge both of them to combine all information.
>> + */
>> +static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>> +				 struct list_head *alist)
>> +{
>> +	struct perf_pmu_alias *a;
>> +
>> +	list_for_each_entry(a, alist, list) {
>> +		if (!strcasecmp(newalias->name, a->name)) {
>> +			perf_pmu_update_alias(a, newalias);
>> +			perf_pmu_free_alias(newalias);
>> +			return true;
>> +		}
>> +	}
>> +	return false;
>> +}
> 
> ok, I like your change better.. we can rebuilt it to use
> rb tree later when we have this fixed
> 
> thanks,
> jirka
> 

Thanks for the review. I will resend the patch set later today when I have added
Arnaldo's comments.
After that we add your rb tree stuff.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

