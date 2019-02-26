Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D372173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfBZG6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:58:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbfBZG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:58:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q6wc9t002346
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:58:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw0dcgs09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:58:48 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 06:58:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 06:58:41 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1Q6weTH30146636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 06:58:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1301B52050;
        Tue, 26 Feb 2019 06:58:40 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9DAC05204F;
        Tue, 26 Feb 2019 06:58:38 +0000 (GMT)
Date:   Tue, 26 Feb 2019 08:58:36 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 26/26] userfaultfd: selftests: add write-protect test
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-27-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-27-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022606-0008-0000-0000-000002C4F51C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022606-0009-0000-0000-000022313CE8
Message-Id: <20190226065836.GD5873@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:32AM +0800, Peter Xu wrote:
> This patch adds uffd tests for write protection.
> 
> Instead of introducing new tests for it, let's simply squashing uffd-wp
> tests into existing uffd-missing test cases.  Changes are:
> 
> (1) Bouncing tests
> 
>   We do the write-protection in two ways during the bouncing test:
> 
>   - By using UFFDIO_COPY_MODE_WP when resolving MISSING pages: then
>     we'll make sure for each bounce process every single page will be
>     at least fault twice: once for MISSING, once for WP.
> 
>   - By direct call UFFDIO_WRITEPROTECT on existing faulted memories:
>     To further torture the explicit page protection procedures of
>     uffd-wp, we split each bounce procedure into two halves (in the
>     background thread): the first half will be MISSING+WP for each
>     page as explained above.  After the first half, we write protect
>     the faulted region in the background thread to make sure at least
>     half of the pages will be write protected again which is the first
>     half to test the new UFFDIO_WRITEPROTECT call.  Then we continue
>     with the 2nd half, which will contain both MISSING and WP faulting
>     tests for the 2nd half and WP-only faults from the 1st half.
> 
> (2) Event/Signal test
> 
>   Mostly previous tests but will do MISSING+WP for each page.  For
>   sigbus-mode test we'll need to provide standalone path to handle the
>   write protection faults.
> 
> For all tests, do statistics as well for uffd-wp pages.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 154 ++++++++++++++++++-----
>  1 file changed, 126 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index e5d12c209e09..57b5ac02080a 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -56,6 +56,7 @@
>  #include <linux/userfaultfd.h>
>  #include <setjmp.h>
>  #include <stdbool.h>
> +#include <assert.h>
> 
>  #include "../kselftest.h"
> 
> @@ -78,6 +79,8 @@ static int test_type;
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
>  static volatile bool test_uffdio_zeropage_eexist = true;
> +/* Whether to test uffd write-protection */
> +static bool test_uffdio_wp = false;
> 
>  static bool map_shared;
>  static int huge_fd;
> @@ -92,6 +95,7 @@ pthread_attr_t attr;
>  struct uffd_stats {
>  	int cpu;
>  	unsigned long missing_faults;
> +	unsigned long wp_faults;
>  };
> 
>  /* pthread_mutex_t starts at page offset 0 */
> @@ -141,9 +145,29 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
>  	for (i = 0; i < n_cpus; i++) {
>  		uffd_stats[i].cpu = i;
>  		uffd_stats[i].missing_faults = 0;
> +		uffd_stats[i].wp_faults = 0;
>  	}
>  }
> 
> +static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
> +{
> +	int i;
> +	unsigned long long miss_total = 0, wp_total = 0;
> +
> +	for (i = 0; i < n_cpus; i++) {
> +		miss_total += stats[i].missing_faults;
> +		wp_total += stats[i].wp_faults;
> +	}
> +
> +	printf("userfaults: %llu missing (", miss_total);
> +	for (i = 0; i < n_cpus; i++)
> +		printf("%lu+", stats[i].missing_faults);
> +	printf("\b), %llu wp (", wp_total);
> +	for (i = 0; i < n_cpus; i++)
> +		printf("%lu+", stats[i].wp_faults);
> +	printf("\b)\n");
> +}
> +
>  static int anon_release_pages(char *rel_area)
>  {
>  	int ret = 0;
> @@ -264,19 +288,15 @@ struct uffd_test_ops {
>  	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
>  };
> 
> -#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
> -					 (1 << _UFFDIO_COPY) | \
> -					 (1 << _UFFDIO_ZEROPAGE))
> -
>  static struct uffd_test_ops anon_uffd_test_ops = {
> -	.expected_ioctls = ANON_EXPECTED_IOCTLS,
> +	.expected_ioctls = UFFD_API_RANGE_IOCTLS,
>  	.allocate_area	= anon_allocate_area,
>  	.release_pages	= anon_release_pages,
>  	.alias_mapping = noop_alias_mapping,
>  };
> 
>  static struct uffd_test_ops shmem_uffd_test_ops = {
> -	.expected_ioctls = ANON_EXPECTED_IOCTLS,
> +	.expected_ioctls = UFFD_API_RANGE_IOCTLS,

Isn't UFFD_API_RANGE_IOCTLS includes UFFDIO_WP which is not supported for
shmem?

>  	.allocate_area	= shmem_allocate_area,
>  	.release_pages	= shmem_release_pages,
>  	.alias_mapping = noop_alias_mapping,

...

-- 
Sincerely yours,
Mike.

