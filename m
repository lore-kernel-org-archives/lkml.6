Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7837FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328CA21A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328CA21A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeHFQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbeHFQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:19:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76E4exJ072506
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 10:09:51 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpqbphgkc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:09:51 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 10:09:49 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 10:09:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76E9kY136962318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 14:09:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98371B2067;
        Mon,  6 Aug 2018 10:09:12 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67C8AB2065;
        Mon,  6 Aug 2018 10:09:12 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 10:09:12 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B461016CA324; Mon,  6 Aug 2018 07:09:47 -0700 (PDT)
Date:   Mon, 6 Aug 2018 07:09:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/1] rseq/selftests: add __rseq_abi misalignment check
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.thread-5c3a1c.your-ad-here.call-01533555685-ext-8699@work.hours>
 <patch.git-4d215e14e001.your-ad-here.call-01533561863-ext-2109@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch.git-4d215e14e001.your-ad-here.call-01533561863-ext-2109@work.hours>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080614-2213-0000-0000-000002D601AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009495; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070347; UDB=6.00550804; IPR=6.00849544;
 MB=3.00022537; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 14:09:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080614-2214-0000-0000-00005B1B086A
Message-Id: <20180806140947.GO24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:27:23PM +0200, Vasily Gorbik wrote:
> The kernel rseq syscall expects that struct rseq is 32 bytes aligned and
> returns EINVAL otherwise. Even though __rseq_abi is declared as static
> and proper aligned attribute is present __rseq_abi is a part of thread
> local storage. It turns out that on some platforms TLS itself is not
> properly aligned (at least for threads created), which is a glibc nptl
> bug and should be eventually fixed and backported. But in a meanwhile
> add __rseq_abi misalignment check, which would detect this situation
> and skip rseq test with some user friendly message.
> 
> glibc bug: https://sourceware.org/bugzilla/show_bug.cgi?id=23403
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/rseq/rseq.c           | 20 +++++++++++++++++++
>  .../testing/selftests/rseq/run_param_test.sh  |  4 ++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 4847e97ed049..3de7f0e7442e 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -64,6 +64,24 @@ static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
>  	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
>  }
> 
> +/*
> + * rseq syscall might fail on some platforms due to wrong alignment of TLS
> + * variables:
> + * https://sourceware.org/bugzilla/show_bug.cgi?id=23403
> + *
> + * check if glibc bug is present and skip the test in this case
> + */
> +static void assert_rseq_abi_aligned(void)
> +{
> +	if ((unsigned long)&__rseq_abi & (__alignof__(__rseq_abi) - 1)) {
> +		fputs("__rseq_abi is not properly aligned, which is a known\n"
> +		      "glibc nptl bug (https://sourceware.org/bugzilla/show_bug.cgi?id=23403).\n"
> +		      "You need a fixed version of glibc to run this test.\n",
> +		      stderr);
> +		exit(4); /* skip this test */
> +	}
> +}
> +
>  int rseq_register_current_thread(void)
>  {
>  	int rc, ret = 0;
> @@ -72,6 +90,7 @@ int rseq_register_current_thread(void)
>  	signal_off_save(&oldset);
>  	if (refcount++)
>  		goto end;
> +	assert_rseq_abi_aligned();
>  	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
>  	if (!rc) {
>  		assert(rseq_current_cpu_raw() >= 0);
> @@ -94,6 +113,7 @@ int rseq_unregister_current_thread(void)
>  	signal_off_save(&oldset);
>  	if (--refcount)
>  		goto end;
> +	assert_rseq_abi_aligned();
>  	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
>  		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
>  	if (!rc)
> diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
> index 3acd6d75ff9f..56caf5e3de3e 100755
> --- a/tools/testing/selftests/rseq/run_param_test.sh
> +++ b/tools/testing/selftests/rseq/run_param_test.sh
> @@ -34,9 +34,9 @@ function do_tests()
>  	local i=0
>  	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
>  		echo "Running test ${TEST_NAME[$i]}"
> -		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
> +		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit $?
>  		echo "Running compare-twice test ${TEST_NAME[$i]}"
> -		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
> +		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit $?
>  		let "i++"
>  	done
>  }
> -- 
> 2.18.0.13.gd42ae10

