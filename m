Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B56820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfBYQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:46:11 -0500
Received: from mail.gydle.com ([64.18.173.180]:50384 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfBYQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:46:10 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2019 11:46:10 EST
X-Received: from [192.168.1.136] (unknown [69.70.179.254])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboisvert@gydle.com)
        by mail.gydle.com (Postfix) with ESMTPSA id C2911449B3;
        Mon, 25 Feb 2019 11:40:45 -0500 (EST)
Subject: Re: [PATCH 03/11] perf tools report: Support nano seconds
To:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-4-andi@firstfloor.org>
From:   Sebastien Boisvert <sboisvert@gydle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sboisvert@gydle.com; keydata=
 xsFNBFi0QgMBEADLVQ63iQaeZj99I4+5AZe9ilJQ/fE7J49iS+NV3ChKgTfxMlxhagmq4a8E
 czme5AGkYeb9JAufWzcaGe4DGHJ0l26QdU/YQcpxGVGTobql+LUQ4VgEe9MxB6sMuO7QV5fZ
 aO27nCqk488ZS7e5g7Y10lMrY+4ZqzjOBIWVOXPpsDrqFY4zKuryLMtRDdINDCl+uahpIi4F
 P/c00/uGR04s+UmdZRgB1RroyZJjeSHgyR90THl8sDssR8zddaDEae2aO1/1dMI9KGamStYe
 5wo9zS4ewPAgfNxRdhsdBvCNIrU2qnKFIE9Juc59NjGPmeRUjB/iHHS6zY4BSNruWrUG5KHs
 ykHpZhP/Gg5y2RL3Pmu9vIBo5C8sUb2/sRNeWXSD7Rh/0zHtYu5T3cx3/gz71WNRhiOncZuY
 pgZltzFRxCYc9kDuthITXbI8GoR3XGq8uo2hTDBW8b+VYqLZ7n4fggkvo8f1bgt0ACVKR0nq
 JViiVO9mYDr7UUWUfS8CABAJCjsbqjxRHMEDw+UNbCS54KJ5vxxkt4LNd0nkwaVwMfrOF3mA
 foEjSmeM2NLx5SOJuMPOSRyOKjfsOgYEbFsA9hZJ34r/zAPEIdwHf57dY+nSiV/avcE6WN5P
 ks0CfGMOTBNsxyqYXPov7kkwvCb09KYU9/J6F1nM9Wm83knzewARAQABzShTZWJhc3RpZW4g
 Qm9pc3ZlcnQgPHNib2lzdmVydEBneWRsZS5jb20+wsF9BBMBCAAnBQJYtEIDAhsjBQkJZgGA
 BQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEGsrrSebZ4/xsY4QAJHIgXH9+KBNt0rgccCt
 DN4ueDoRIEmYS7NK/gUKQ8yHUreRHNpJqRSxNKzUPmvVAnnLdaopf/abhS+Ado5QGAZhiNzp
 +szWcwT4Za8P1mat+/HJznz06TwgiBJNSuMwItZmlgkBpgt2GVtmTP8LOJ1LVSD0615FO84m
 xUWqNfKijfngxQl3Ldh5TyQ4yHtdAScQVr0R1+ROIKGwjolflnzDLlb23mr2jzB/ycXo1fAo
 QLtj+Ga1cQ9ZkyRJXxicD2GsczbB/qSOMytR1iitgrxf9xtwSxHW9C1hNqb64Zr7S0ALlhhc
 nxDbOliirmcad3LFsnoHgrKWlfwj0+Qs/mjfnKiONRSWq7I1jN5wpQnY0QYm4jVRsnkAibpL
 vOqpir1qM1LNWcQ3bdvi9z5IvniB+54/QcKmtbHPAX6LCtwjd3XjfNMMEV4Lb0kCXSZdO3k2
 nG3vDOWvwVMG5gBuQUIb9iwIr5MySHieTv8ycX+TXdD8DgcjUILfz5mxEDYe8I6uyhIKwO+f
 OExGFtfgd/s7Q2pdbN/6p6zZv2Olg0TlWuB2DOERHfCCVKOSyPY4leQ7nq3jgoxk881golT7
 Sf90NqVMAnoZdXchLzqK0ChIpFB0OxbNQ2emLFgWEt93nKFo2v3C/WRoU0DizgIA7V8HdN/p
 HE8J0k2vJdH2W7mozsFNBFi0QgMBEADaEPu7lZZkv7zbZBHdC9LZLF5Blyk2Z38+9bCa60ON
 bqqXaD8sBYQO04GsoVc6FPf3EJoI2/4yFX0eh4l8aYmCfrNvm0zUWMI5T29LmchPg/zw6PW7
 qlh3kFmKqv5JmV6hdc2Exp6/VZ5C/mjbbTCcJtsOHkg22J37dbKXj2h7v1UK21i3G1HSvHwX
 YSCs7Pg7Nw2Ilkseum5wqs4UvI3T2a/0OQC7wjVSUQlKtV8bIWxNxutF7Y548m9tE5QDDtjF
 w4cIWRiOVe1EXFWASBPlJeTmrWK3/OdeKxnW7QJH/R6ebDgViG/EZPOGm+xSrznSyCwpWNWE
 tyVFSf45ow2FoVJ3z/ChvxCqXp3Jk6s0ULzyGCrGfmZJCjY8xrIW6k4dDHkr5vsygPQg3/aF
 IRmdK/aUGaQGSSAmiwRkH49gH92Y0HK2+HNL5Qp6mV3IZaSQhRs5kOG2stYUXRKhdnHKGSQz
 B1WKv5clzQGhQ9MpQX7Ch2QL+3QQVx91GPhv/Q4oAafQaX7oN1XgTPNWgbcdU+OYVjHqVWvI
 ae7HXSITVgByZAK6Di7/byqqjl1hwkiZeIcajZqK8hws6h6bLLZBn7EcZAEj8VLSdfUjJqCt
 VOZyQGdo8sNYjJPeV69vNbBUbX7BcxhxRZEYXw1rCz/xaCbNyRqRsxT03haPLg+WVQARAQAB
 wsFlBBgBCAAPBQJYtEIDAhsMBQkJZgGAAAoJEGsrrSebZ4/x13oP/2gWO3D6zo2Ok13khz4u
 +blJz8rzV1PQ5TVJmrsU05pVDlKgoZdtfEUtHlfAkzvNUpoKhNRWVN5/3QLwF4z0jfXyFYuS
 8CVMRA75h59jSABdCWvZrQLHKJV03t++IFBi3y2DUilHXrCHUxg0iJeUhbMorgxc43d6DJw2
 o53r+hBTfexVvcCodOREHR253eaw55lnL1J4sn0KVfprd0tLUTtR6QtF6oMXTcRedrE5bbQB
 oH/mmorTeQcEO6uDqc9SgqzEaLpNUxsXOBEMp0HYsQBoTdGzsh6aZGrVHX47A3ZLFv9WbRB+
 iluFb5KY2n673MOZgSuCFurTuNm+Ik4qfHz3KCVkEghN/swYZW/ONxqZC+2kIPO30WJOnvSL
 OptwSrxigmRMwJMCYI59NwaF9lyk/F8iL798mNXuhb9mWoiw2Qfjm5xAI+8u3ECDlF6RImKJ
 QW26frU/JgIUOPrTP+XkxBzCK+vKVekqjhASMH0vLMUBjY02EvqjYfR1egevXc63hMJDR513
 uqyECDvmUMJulfMUR2BeaX/+6/alsvQLlvDF8sZ1wrP4PFdqTELwMPHvKsZgX4KhMnNUhPSD
 XxdTif6ZoOAt/ZdtmdSV6InuwAz/1C9VnBRGP459T4N2OYSql4P4rcGBokrQCFC4kP/ZdqDf
 vnOzfc5OOiR/D+lE
Message-ID: <d90b76f2-8d53-05ac-1526-9f0ddc4a0328@gydle.com>
Date:   Mon, 25 Feb 2019 11:40:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190224153722.27020-4-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-02-24 10:37 a.m., Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Upcoming changes add timestamp output in perf report. Add a --ns
> argument similar to perf script to support nanoseconds resolution
> when needed.

Is this a ISO-8601 date with nanoseconds ?

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt | 3 +++
>  tools/perf/builtin-report.c              | 1 +
>  tools/perf/builtin-script.c              | 1 -
>  tools/perf/util/sort.c                   | 1 +
>  tools/perf/util/sort.h                   | 2 ++
>  5 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 1a27bfe05039..51dbc519dbce 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -477,6 +477,9 @@ include::itrace.txt[]
>  	Please note that not all mmaps are stored, options affecting which ones
>  	are include 'perf record --data', for instance.
>  
> +--ns::
> +	Show time stamps in nanoseconds.
> +
>  --stats::
>  	Display overall events statistics without any further processing.
>  	(like the one at the end of the perf report -D command)
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2e8c74d6430c..bb8918a747ba 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1147,6 +1147,7 @@ int cmd_report(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
> +	OPT_BOOLEAN(0, "ns", &nanosecs, "Show times in nanosecs"),
>  	OPT_END()
>  	};
>  	struct perf_data data = {
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 261055302d08..628c04543974 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -59,7 +59,6 @@ static bool			no_callchain;
>  static bool			latency_format;
>  static bool			system_wide;
>  static bool			print_flags;
> -static bool			nanosecs;
>  static const char		*cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>  static struct perf_stat_config	stat_config;
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 2b6c1ccb878c..d1010a966f9b 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -31,6 +31,7 @@ const char	*field_order;
>  regex_t		ignore_callees_regex;
>  int		have_ignore_callees = 0;
>  enum sort_mode	sort__mode = SORT_MODE__NORMAL;
> +bool		nanosecs = false;
>  
>  /*
>   * Replaces all occurrences of a char used with the:
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 2fbee0b1011c..98223d952404 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -278,6 +278,8 @@ struct sort_entry {
>  extern struct sort_entry sort_thread;
>  extern struct list_head hist_entry__sort_list;
>  
> +extern bool nanosecs;
> +
>  struct perf_evlist;
>  struct tep_handle;
>  int setup_sorting(struct perf_evlist *evlist);
> 
