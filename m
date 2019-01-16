Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37435C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EDE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405174AbfAPQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:06:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405165AbfAPQGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:06:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GG5VGr102012
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:06:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q27hqgxac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:06:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 16 Jan 2019 16:06:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:06:36 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GG6ZMU57868304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:06:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 832C8A4055;
        Wed, 16 Jan 2019 16:06:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED42A404D;
        Wed, 16 Jan 2019 16:06:35 +0000 (GMT)
Received: from [9.83.224.254] (unknown [9.83.224.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 16:06:34 +0000 (GMT)
Subject: Re: [PATCH 2/4] gcov: clang support
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
References: <20190114210426.177543-1-trong@android.com>
 <20190114210426.177543-3-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 16 Jan 2019 17:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190114210426.177543-3-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011616-0016-0000-0000-0000024652BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0017-0000-0000-000032A070DB
Message-Id: <6c97cdb9-7b7d-e95b-567e-1938ca7f4ac2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.2019 22:04, Tri Vo wrote:
> From: Greg Hackmann <ghackmann@google.com>
> 
> LLVM uses profiling data that's deliberately similar to GCC, but has a very
> different way of exporting that data.  LLVM calls llvm_gcov_init() once per
> module, and provides a couple of callbacks that we can use to ask for more
> data.
> 
> We care about the "writeout" callback, which in turn calls back into
> compiler-rt/this module to dump all the gathered coverage data to disk:
> 
>    llvm_gcda_start_file()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      [... repeats for each function ...]
>    llvm_gcda_summary_info()
>    llvm_gcda_end_file()
> 
> This design is much more stateless and unstructured than gcc's, and is
> intended to run at process exit.  This forces us to keep some local state
> about which module we're dealing with at the moment.  On the other hand, it
> also means we don't depend as much on how LLVM represents profiling data
> internally.
> 
> See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
> details on how this works, particularly GCOVProfiler::emitProfileArcs(),
> GCOVProfiler::insertCounterWriteout(), and GCOVProfiler::insertFlush().
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Trilok Soni <tsoni@quicinc.com>
> Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
> Tested-by: Tri Vo <trong@android.com>
> ---
>  kernel/gcov/Kconfig  |   5 +
>  kernel/gcov/Makefile |   1 +
>  kernel/gcov/clang.c  | 531 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 kernel/gcov/clang.c

Please consider adding a short section detailing usage differences
between GCC and Clang coverage to the GCOV documentation at

  Documentation/dev-tools/gcov.rst

> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> new file mode 100644
> index 000000000000..b00795d28137
> --- /dev/null
> +++ b/kernel/gcov/clang.c

[...]

> +/**
> + * gcov_info_add - add up profiling data
> + * @dest: profiling data set to which data is added
> + * @source: profiling data set which is added
> + *
> + * Adds profiling counts of @source to @dest.
> + */
> +void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
> +{
> +	struct gcov_fn_info *dfn_ptr;
> +	struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
> +			struct gcov_fn_info, head);
> +
> +	list_for_each_entry(dfn_ptr, &dst->functions, head) {
> +		u32 i;
> +
> +		for (i = 0; i < sfn_ptr->num_counters; i++)
> +			dfn_ptr->counters[i] += sfn_ptr->counters[i];
> +
> +		if (!list_is_last(&sfn_ptr->head, &src->functions))

This check seems wrong - both dst and src should contain the same amount
of functions and counters per function (the GCC support is based on the
same assumption).

Even if not, the next iteration would try to add counters for different
functions which would be incorrect and could cause access violations due
to differing values for num_counters.

> +			sfn_ptr = list_next_entry(sfn_ptr, head);
> +	}
> +}
> +
> +static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> +{
> +	struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
> +			GFP_KERNEL);
> +	if (!fn_dup)
> +		return NULL;
> +	INIT_LIST_HEAD(&fn_dup->head);
> +
> +	fn_dup->name = kstrdup(fn->name, GFP_KERNEL);

Since struct gcov_fn_info does not define a member named 'name', this
should fail during compilation. I saw that this is fixed with the next
patch, but this really needs to be merged into this one.

> +	if (!fn_dup->name)
> +		goto err_name;
> +
> +	fn_dup->counters = kmemdup(fn->counters,
> +			fn->num_counters * sizeof(fn->counters[0]),
> +			GFP_KERNEL);

Please consider using vmalloc() here (like the GCC support does) because
the number of counters can be quite large and there might be situations
where the required amount of physically contiguous memory is not
available at run-time.

> +	if (!fn_dup->counters)
> +		goto err_counters;
> +
> +	return fn_dup;
> +
> +err_counters:
> +	kfree(fn_dup->name);
> +err_name:
> +	kfree(fn_dup);
> +	return NULL;
> +}
> +
> +/**
> + * gcov_info_dup - duplicate profiling data set
> + * @info: profiling data set to duplicate
> + *
> + * Return newly allocated duplicate on success, %NULL on error.
> + */
> +struct gcov_info *gcov_info_dup(struct gcov_info *info)
> +{
> +	struct gcov_info *dup;
> +	struct gcov_fn_info *fn, *tmp;
> +
> +	dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
> +	if (!dup)
> +		return NULL;
> +	INIT_LIST_HEAD(&dup->head);
> +	INIT_LIST_HEAD(&dup->functions);
> +	dup->filename = kstrdup(info->filename, GFP_KERNEL);

To be consistent, please also check for a failed allocation here.

> +
> +	list_for_each_entry_safe(fn, tmp, &info->functions, head) {

It should not be necessary to use the _safe variant here as
info->functions is not modified during traversal.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

