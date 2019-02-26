Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBBFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C15213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBZGup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:50:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbfBZGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:50:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q6kUJi039210
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:50:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qvy1um5nh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:50:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 06:50:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 06:50:36 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1Q6oa1d34406624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 06:50:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7E2511C052;
        Tue, 26 Feb 2019 06:50:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 888F911C054;
        Tue, 26 Feb 2019 06:50:34 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 06:50:34 +0000 (GMT)
Date:   Tue, 26 Feb 2019 08:50:32 +0200
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
Subject: Re: [PATCH v2 25/26] userfaultfd: selftests: refactor statistics
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-26-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022606-0008-0000-0000-000002C4F493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022606-0009-0000-0000-000022313C59
Message-Id: <20190226065032.GC5873@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:31AM +0800, Peter Xu wrote:
> Introduce uffd_stats structure for statistics of the self test, at the
> same time refactor the code to always pass in the uffd_stats for either
> read() or poll() typed fault handling threads instead of using two
> different ways to return the statistic results.  No functional change.
> 
> With the new structure, it's very easy to introduce new statistics.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 76 +++++++++++++++---------
>  1 file changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 5d1db824f73a..e5d12c209e09 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -88,6 +88,12 @@ static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
>  static char *zeropage;
>  pthread_attr_t attr;
> 
> +/* Userfaultfd test statistics */
> +struct uffd_stats {
> +	int cpu;
> +	unsigned long missing_faults;
> +};
> +
>  /* pthread_mutex_t starts at page offset 0 */
>  #define area_mutex(___area, ___nr)					\
>  	((pthread_mutex_t *) ((___area) + (___nr)*page_size))
> @@ -127,6 +133,17 @@ static void usage(void)
>  	exit(1);
>  }
> 
> +static void uffd_stats_reset(struct uffd_stats *uffd_stats,
> +			     unsigned long n_cpus)
> +{
> +	int i;
> +
> +	for (i = 0; i < n_cpus; i++) {
> +		uffd_stats[i].cpu = i;
> +		uffd_stats[i].missing_faults = 0;
> +	}
> +}
> +
>  static int anon_release_pages(char *rel_area)
>  {
>  	int ret = 0;
> @@ -469,8 +486,8 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
>  	return 0;
>  }
> 
> -/* Return 1 if page fault handled by us; otherwise 0 */
> -static int uffd_handle_page_fault(struct uffd_msg *msg)
> +static void uffd_handle_page_fault(struct uffd_msg *msg,
> +				   struct uffd_stats *stats)
>  {
>  	unsigned long offset;
> 
> @@ -485,18 +502,19 @@ static int uffd_handle_page_fault(struct uffd_msg *msg)
>  	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
>  	offset &= ~(page_size-1);
> 
> -	return copy_page(uffd, offset);
> +	if (copy_page(uffd, offset))
> +		stats->missing_faults++;
>  }
> 
>  static void *uffd_poll_thread(void *arg)
>  {
> -	unsigned long cpu = (unsigned long) arg;
> +	struct uffd_stats *stats = (struct uffd_stats *)arg;
> +	unsigned long cpu = stats->cpu;
>  	struct pollfd pollfd[2];
>  	struct uffd_msg msg;
>  	struct uffdio_register uffd_reg;
>  	int ret;
>  	char tmp_chr;
> -	unsigned long userfaults = 0;
> 
>  	pollfd[0].fd = uffd;
>  	pollfd[0].events = POLLIN;
> @@ -526,7 +544,7 @@ static void *uffd_poll_thread(void *arg)
>  				msg.event), exit(1);
>  			break;
>  		case UFFD_EVENT_PAGEFAULT:
> -			userfaults += uffd_handle_page_fault(&msg);
> +			uffd_handle_page_fault(&msg, stats);
>  			break;
>  		case UFFD_EVENT_FORK:
>  			close(uffd);
> @@ -545,28 +563,27 @@ static void *uffd_poll_thread(void *arg)
>  			break;
>  		}
>  	}
> -	return (void *)userfaults;
> +
> +	return NULL;
>  }
> 
>  pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
> 
>  static void *uffd_read_thread(void *arg)
>  {
> -	unsigned long *this_cpu_userfaults;
> +	struct uffd_stats *stats = (struct uffd_stats *)arg;
>  	struct uffd_msg msg;
> 
> -	this_cpu_userfaults = (unsigned long *) arg;
> -	*this_cpu_userfaults = 0;
> -
>  	pthread_mutex_unlock(&uffd_read_mutex);
>  	/* from here cancellation is ok */
> 
>  	for (;;) {
>  		if (uffd_read_msg(uffd, &msg))
>  			continue;
> -		(*this_cpu_userfaults) += uffd_handle_page_fault(&msg);
> +		uffd_handle_page_fault(&msg, stats);
>  	}
> -	return (void *)NULL;
> +
> +	return NULL;
>  }
> 
>  static void *background_thread(void *arg)
> @@ -582,13 +599,12 @@ static void *background_thread(void *arg)
>  	return NULL;
>  }
> 
> -static int stress(unsigned long *userfaults)
> +static int stress(struct uffd_stats *uffd_stats)
>  {
>  	unsigned long cpu;
>  	pthread_t locking_threads[nr_cpus];
>  	pthread_t uffd_threads[nr_cpus];
>  	pthread_t background_threads[nr_cpus];
> -	void **_userfaults = (void **) userfaults;
> 
>  	finished = 0;
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
> @@ -597,12 +613,13 @@ static int stress(unsigned long *userfaults)
>  			return 1;
>  		if (bounces & BOUNCE_POLL) {
>  			if (pthread_create(&uffd_threads[cpu], &attr,
> -					   uffd_poll_thread, (void *)cpu))
> +					   uffd_poll_thread,
> +					   (void *)&uffd_stats[cpu]))
>  				return 1;
>  		} else {
>  			if (pthread_create(&uffd_threads[cpu], &attr,
>  					   uffd_read_thread,
> -					   &_userfaults[cpu]))
> +					   (void *)&uffd_stats[cpu]))
>  				return 1;
>  			pthread_mutex_lock(&uffd_read_mutex);
>  		}
> @@ -639,7 +656,8 @@ static int stress(unsigned long *userfaults)
>  				fprintf(stderr, "pipefd write error\n");
>  				return 1;
>  			}
> -			if (pthread_join(uffd_threads[cpu], &_userfaults[cpu]))
> +			if (pthread_join(uffd_threads[cpu],
> +					 (void *)&uffd_stats[cpu]))
>  				return 1;
>  		} else {
>  			if (pthread_cancel(uffd_threads[cpu]))
> @@ -910,11 +928,11 @@ static int userfaultfd_events_test(void)
>  {
>  	struct uffdio_register uffdio_register;
>  	unsigned long expected_ioctls;
> -	unsigned long userfaults;
>  	pthread_t uffd_mon;
>  	int err, features;
>  	pid_t pid;
>  	char c;
> +	struct uffd_stats stats = { 0 };
> 
>  	printf("testing events (fork, remap, remove): ");
>  	fflush(stdout);
> @@ -941,7 +959,7 @@ static int userfaultfd_events_test(void)
>  			"unexpected missing ioctl for anon memory\n"),
>  			exit(1);
> 
> -	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
> +	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>  		perror("uffd_poll_thread create"), exit(1);
> 
>  	pid = fork();
> @@ -957,13 +975,13 @@ static int userfaultfd_events_test(void)
> 
>  	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		perror("pipe write"), exit(1);
> -	if (pthread_join(uffd_mon, (void **)&userfaults))
> +	if (pthread_join(uffd_mon, NULL))
>  		return 1;
> 
>  	close(uffd);
> -	printf("userfaults: %ld\n", userfaults);
> +	printf("userfaults: %ld\n", stats.missing_faults);
> 
> -	return userfaults != nr_pages;
> +	return stats.missing_faults != nr_pages;
>  }
> 
>  static int userfaultfd_sig_test(void)
> @@ -975,6 +993,7 @@ static int userfaultfd_sig_test(void)
>  	int err, features;
>  	pid_t pid;
>  	char c;
> +	struct uffd_stats stats = { 0 };
> 
>  	printf("testing signal delivery: ");
>  	fflush(stdout);
> @@ -1006,7 +1025,7 @@ static int userfaultfd_sig_test(void)
>  	if (uffd_test_ops->release_pages(area_dst))
>  		return 1;
> 
> -	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
> +	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>  		perror("uffd_poll_thread create"), exit(1);
> 
>  	pid = fork();
> @@ -1032,6 +1051,7 @@ static int userfaultfd_sig_test(void)
>  	close(uffd);
>  	return userfaults != 0;
>  }
> +
>  static int userfaultfd_stress(void)
>  {
>  	void *area;
> @@ -1040,7 +1060,7 @@ static int userfaultfd_stress(void)
>  	struct uffdio_register uffdio_register;
>  	unsigned long cpu;
>  	int err;
> -	unsigned long userfaults[nr_cpus];
> +	struct uffd_stats uffd_stats[nr_cpus];
> 
>  	uffd_test_ops->allocate_area((void **)&area_src);
>  	if (!area_src)
> @@ -1169,8 +1189,10 @@ static int userfaultfd_stress(void)
>  		if (uffd_test_ops->release_pages(area_dst))
>  			return 1;
> 
> +		uffd_stats_reset(uffd_stats, nr_cpus);
> +
>  		/* bounce pass */
> -		if (stress(userfaults))
> +		if (stress(uffd_stats))
>  			return 1;
> 
>  		/* unregister */
> @@ -1213,7 +1235,7 @@ static int userfaultfd_stress(void)
> 
>  		printf("userfaults:");
>  		for (cpu = 0; cpu < nr_cpus; cpu++)
> -			printf(" %lu", userfaults[cpu]);
> +			printf(" %lu", uffd_stats[cpu].missing_faults);
>  		printf("\n");
>  	}
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

