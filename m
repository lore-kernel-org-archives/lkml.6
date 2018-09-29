Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158AEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723E2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B723E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeI2Q4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 12:56:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbeI2Q4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 12:56:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8TAPHH8137361
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:28:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mt4q5mjqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:28:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 29 Sep 2018 11:28:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Sep 2018 11:28:16 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8TASFTm63635696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Sep 2018 10:28:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A794C040;
        Sat, 29 Sep 2018 13:27:58 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D95D24C044;
        Sat, 29 Sep 2018 13:27:56 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.35])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Sep 2018 13:27:56 +0100 (BST)
Date:   Sat, 29 Sep 2018 13:28:12 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] userfaultfd: selftest: cleanup help messages
References: <20180929084311.15600-1-peterx@redhat.com>
 <20180929084311.15600-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929084311.15600-2-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092910-0020-0000-0000-000002CD2547
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092910-0021-0000-0000-0000211B5969
Message-Id: <20180929102811.GA6429@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809290110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 04:43:09PM +0800, Peter Xu wrote:
> Firstly, the help in the comment region is obsolete, now we support
> three parameters.  Since at it, change it and move it into the help
> message of the program.
> 
> Also, the help messages dumped here and there is obsolete too.  Use a
> single usage() helper.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Small comment below, otherwise

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 44 ++++++++++++++----------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 7b8171e3128a..2a84adaf8cf8 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -34,18 +34,6 @@
>   * per-CPU threads 1 by triggering userfaults inside
>   * pthread_mutex_lock will also verify the atomicity of the memory
>   * transfer (UFFDIO_COPY).
> - *
> - * The program takes two parameters: the amounts of physical memory in
> - * megabytes (MiB) of the area and the number of bounces to execute.
> - *
> - * # 100MiB 99999 bounces
> - * ./userfaultfd 100 99999
> - *
> - * # 1GiB 99 bounces
> - * ./userfaultfd 1000 99
> - *
> - * # 10MiB-~6GiB 999 bounces, continue forever unless an error triggers
> - * while ./userfaultfd $[RANDOM % 6000 + 10] 999; do true; done
>   */
> 
>  #define _GNU_SOURCE
> @@ -115,6 +103,28 @@ pthread_attr_t attr;
>  				 ~(unsigned long)(sizeof(unsigned long long) \
>  						  -  1)))
> 
> +const char *examples =
> +    "# 100MiB 99999 bounces\n"
> +    "./userfaultfd anon 100 99999\n"
> +    "\n"
> +    "# 1GiB 99 bounces\n"
> +    "./userfaultfd anon 1000 99\n"
> +    "\n"
> +    "# 10MiB-~6GiB 999 bounces, continue forever unless an error triggers\n"
> +    "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n"
> +    "\n";

While at it, can you please update the examples to include other test
types?

> +
> +static void usage(void)
> +{
> +	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
> +		"[hugetlbfs_file]\n\n");
> +	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
> +		"hugetlb_shared, shmem\n\n");
> +	fprintf(stderr, "Examples:\n\n");
> +	fprintf(stderr, examples);
> +	exit(1);
> +}
> +
>  static int anon_release_pages(char *rel_area)
>  {
>  	int ret = 0;
> @@ -1272,8 +1282,7 @@ static void sigalrm(int sig)
>  int main(int argc, char **argv)
>  {
>  	if (argc < 4)
> -		fprintf(stderr, "Usage: <test type> <MiB> <bounces> [hugetlbfs_file]\n"),
> -				exit(1);
> +		usage();
> 
>  	if (signal(SIGALRM, sigalrm) == SIG_ERR)
>  		fprintf(stderr, "failed to arm SIGALRM"), exit(1);
> @@ -1286,20 +1295,19 @@ int main(int argc, char **argv)
>  		nr_cpus;
>  	if (!nr_pages_per_cpu) {
>  		fprintf(stderr, "invalid MiB\n");
> -		fprintf(stderr, "Usage: <MiB> <bounces>\n"), exit(1);
> +		usage();
>  	}
> 
>  	bounces = atoi(argv[3]);
>  	if (bounces <= 0) {
>  		fprintf(stderr, "invalid bounces\n");
> -		fprintf(stderr, "Usage: <MiB> <bounces>\n"), exit(1);
> +		usage();
>  	}
>  	nr_pages = nr_pages_per_cpu * nr_cpus;
> 
>  	if (test_type == TEST_HUGETLB) {
>  		if (argc < 5)
> -			fprintf(stderr, "Usage: hugetlb <MiB> <bounces> <hugetlbfs_file>\n"),
> -				exit(1);
> +			usage();
>  		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
>  		if (huge_fd < 0) {
>  			fprintf(stderr, "Open of %s failed", argv[3]);
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

