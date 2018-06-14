Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7994C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84598208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84598208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbeFNNxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:53:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755214AbeFNNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:53:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EDopKw121002
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:53:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jkrwxb0h3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:53:20 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 14 Jun 2018 09:53:18 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 09:53:17 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5EDrF9c55246976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 13:53:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A2BAE05C;
        Thu, 14 Jun 2018 09:53:22 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AFB4AE05F;
        Thu, 14 Jun 2018 09:53:22 -0400 (EDT)
Received: from oc3272150783.ibm.com (unknown [9.80.215.247])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Jun 2018 09:53:22 -0400 (EDT)
Subject: Re: [PATCH 2/3] perf alias: Rebuild alias expression string to make
 it comparable
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, jolsa@redhat.com
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-2-tmricht@linux.ibm.com>
From:   Paul Clarke <pc@us.ibm.com>
Date:   Thu, 14 Jun 2018 08:53:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614114845.41221-2-tmricht@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061413-0040-0000-0000-000004404BCE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009189; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046859; UDB=6.00536181; IPR=6.00825832;
 MB=3.00021643; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-14 13:53:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061413-0041-0000-0000-00000846564D
Message-Id: <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 06:48 AM, Thomas Richter wrote:
> PMU alias definitions in sysfs files may have spaces, newlines
> and number with leading zeroes. Same alias definitions may
> also appear in JSON files without spaces, etc.
> 
> Scan alias definitions and remove leading zeroes, spaces,
> newlines, etc and rebuild string to make alias->str member
> comparable.
> 
> s390 for example  has terms specified as
> event=0x0091 (read from files ../<PMU>/events/<FILE>
> and terms specified as event=0x91 (read from JSON files).
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/pmu.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 26c79a9c4142..da8f243743d3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -241,9 +241,11 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  				 char *metric_expr,
>  				 char *metric_name)
>  {
> +	struct parse_events_term *term;
>  	struct perf_pmu_alias *alias;
>  	int ret;
>  	int num;
> +	char newval[256];

How was 256 chosen?

> 
>  	alias = malloc(sizeof(*alias));
>  	if (!alias)
> @@ -262,6 +264,27 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  		return ret;
>  	}
> 
> +	/* Scan event and remove leading zeroes, spaces, newlines, some
> +	 * platforms have terms specified as
> +	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
> +	 * and terms specified as event=0x91 (read from JSON files).
> +	 *
> +	 * Rebuild string to make alias->str member comparable.
> +	 */
> +	memset(newval, 0, sizeof(newval));
> +	ret = 0;
> +	list_for_each_entry(term, &alias->terms, list) {
> +		if (ret)
> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> +					 ",");
> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> +					 "%s=%#x", term->config, term->val.num);
> +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> +					 "%s=%s", term->config, term->val.str);

If we exceed 256, we just suddenly terminate the rebuilding without reporting any issues.

> +	}
> +
>  	alias->name = strdup(name);
>  	if (dir) {
>  		/*
> @@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>  	}
>  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> -	alias->str = strdup(val);
> +	alias->str = strdup(newval);
> 
>  	list_add_tail(&alias->list, list);
> 

PC

