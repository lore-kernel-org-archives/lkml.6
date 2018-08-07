Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF35C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D32721920
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D32721920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeHGJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:09:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728157AbeHGJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:09:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w776nTqB054519
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 02:56:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kq5tp1pu3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:56:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 7 Aug 2018 07:56:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 07:56:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w776uj6i35651836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 06:56:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FD23A404D;
        Tue,  7 Aug 2018 09:56:53 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0EF4A4053;
        Tue,  7 Aug 2018 09:56:52 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Aug 2018 09:56:52 +0100 (BST)
Date:   Tue, 7 Aug 2018 09:56:42 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH v2 4/4] userfaultfd: selftest: Cope if shmem doesn't
 support zeropage
References: <20180803220046.4019-1-bauerman@linux.ibm.com>
 <20180803220046.4019-5-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803220046.4019-5-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080706-0020-0000-0000-000002B33BCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080706-0021-0000-0000-000021003F59
Message-Id: <20180807065642.GD20140@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 03, 2018 at 07:00:46PM -0300, Thiago Jung Bauermann wrote:
> If userfaultfd runs on a system that doesn't support UFFDIO_ZEROPAGE for
> shared memory, it currently ends with error code 1 which indicates test
> failure:
> 
>   # ./userfaultfd shmem 10 10
>   nr_pages: 160, nr_pages_per_cpu: 80
>   bounces: 9, mode: rnd poll, unexpected missing ioctl for anon memory
>   # echo $?
>   1
> 
> Change userfaultfd_zeropage_test() to return KSFT_SKIP to indicate that
> the test is being skipped.

I took a deeper look at what userfaultfd_zeropage_test() does and,
apparently, I've mislead you. The test checks if the range has
UFFDIO_ZEROPAGE and verifies that it works if yes; otherwise the test
verifies that EINVAL is returned.

Can you please check if the patch below works in your environment?

From 7a34c84c0461b5073742275638c44b6535d19166 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Tue, 7 Aug 2018 09:44:19 +0300
Subject: [PATCH] userfaultfd: selftest: make supported range ioctl
 verification more robust

When userfaultfd tests runs on older kernel that does not support
UFFDIO_ZEROPAGE for shared memory it fails at the ioctl verification.

Split out the verification that supported ioctls are superset of the
expected ioctls and relax the checks for UFFDIO_ZEROPAGE for shared memory
areas.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 63 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7b8171e3128a..a64bc38bc0e1 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -271,6 +271,32 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 	return 0;
 }
 
+static int verify_ioctls(unsigned long supported_ioctls)
+{
+	unsigned long expected_ioctls = uffd_test_ops->expected_ioctls;
+
+	if ((supported_ioctls & expected_ioctls) == expected_ioctls)
+		return 0;
+
+	/*
+	 * For older kernels shared memory may not have UFFDIO_ZEROPAGE.
+	 * In this case we just mask it out from the
+	 * expected_ioctls. The userfaultfd_zeropage_test will then
+	 * verify that an attempt to use UFFDIO_ZEROPAGE returns
+	 * EINVAL
+	 */
+	if (test_type == TEST_SHMEM) {
+		expected_ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+		if ((supported_ioctls & expected_ioctls) == expected_ioctls) {
+			uffd_test_ops->expected_ioctls = expected_ioctls;
+			return 0;
+		}
+	}
+
+	fprintf(stderr,	"unexpected missing ioctl\n");
+	return 1;
+}
+
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -851,7 +877,6 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 static int userfaultfd_zeropage_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
@@ -867,12 +892,8 @@ static int userfaultfd_zeropage_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (uffdio_zeropage(uffd, 0)) {
 		if (my_bcmp(area_dst, zeropage, page_size))
@@ -887,7 +908,6 @@ static int userfaultfd_zeropage_test(void)
 static int userfaultfd_events_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -912,12 +932,8 @@ static int userfaultfd_events_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
 		perror("uffd_poll_thread create"), exit(1);
@@ -947,7 +963,6 @@ static int userfaultfd_events_test(void)
 static int userfaultfd_sig_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -971,12 +986,8 @@ static int userfaultfd_sig_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (faulting_process(1))
 		fprintf(stderr, "faulting process failed\n"), exit(1);
@@ -1076,8 +1087,6 @@ static int userfaultfd_stress(void)
 
 	err = 0;
 	while (bounces--) {
-		unsigned long expected_ioctls;
-
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
 			printf(" rnd");
@@ -1103,13 +1112,9 @@ static int userfaultfd_stress(void)
 			fprintf(stderr, "register failure\n");
 			return 1;
 		}
-		expected_ioctls = uffd_test_ops->expected_ioctls;
-		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls) {
-			fprintf(stderr,
-				"unexpected missing ioctl for anon memory\n");
+
+		if (verify_ioctls(uffdio_register.ioctls))
 			return 1;
-		}
 
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long)
-- 
2.7.4

 
> Also change userfaultfd_events_test() and userfaultfd_stress() to ignore
> the missing UFFDIO_ZEROPAGE bit from the list of supported ioctls since
> these tests don't require that feature.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 36 +++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index c84e44ddf314..00f1ca663d67 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -852,6 +852,16 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
>  	return __uffdio_zeropage(ufd, offset, false);
>  }
> 
> +/* Tells whether the kernel doesn't support ZEROPAGE on shared memory VMAs. */
> +static bool shmem_without_zeropage_support(unsigned long expected_ioctls,
> +					   unsigned long supported_ioctls)
> +{
> +	/* Turn off ZEROPAGE bit from expected_ioctls. */
> +	expected_ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
> +
> +	return test_type == TEST_SHMEM && supported_ioctls == expected_ioctls;
> +}
> +
>  /* exercise UFFDIO_ZEROPAGE */
>  static int userfaultfd_zeropage_test(void)
>  {
> @@ -877,10 +887,20 @@ static int userfaultfd_zeropage_test(void)
> 
>  	expected_ioctls = uffd_test_ops->expected_ioctls;
>  	if ((uffdio_register.ioctls & expected_ioctls) !=
> -	    expected_ioctls)
> +	    expected_ioctls) {
> +		close(uffd);
> +
> +		if (shmem_without_zeropage_support(expected_ioctls,
> +						   uffdio_register.ioctls)) {
> +			fprintf(stderr,
> +				"UFFDIO_ZEROPAGE unsupported in shmem VMAs\n");
> +			return KSFT_SKIP;
> +		}
> +
>  		fprintf(stderr,
> -			"unexpected missing ioctl for anon memory\n"),
> -			exit(1);
> +			"unexpected missing ioctl for anon memory\n");
> +		return 1;
> +	}
> 
>  	if (uffdio_zeropage(uffd, 0)) {
>  		if (my_bcmp(area_dst, zeropage, page_size))
> @@ -924,7 +944,10 @@ static int userfaultfd_events_test(void)
> 
>  	expected_ioctls = uffd_test_ops->expected_ioctls;
>  	if ((uffdio_register.ioctls & expected_ioctls) !=
> -	    expected_ioctls)
> +	    expected_ioctls &&
> +	    /* No need for zeropage support in this test, so ignore it. */
> +	    !shmem_without_zeropage_support(expected_ioctls,
> +					    uffdio_register.ioctls))
>  		fprintf(stderr,
>  			"unexpected missing ioctl for anon memory\n"),
>  			exit(1);
> @@ -1117,7 +1140,10 @@ static int userfaultfd_stress(void)
>  		}
>  		expected_ioctls = uffd_test_ops->expected_ioctls;
>  		if ((uffdio_register.ioctls & expected_ioctls) !=
> -		    expected_ioctls) {
> +		    expected_ioctls &&
> +		    /* No need for zeropage support in this test, so ignore it. */
> +		    !shmem_without_zeropage_support(expected_ioctls,
> +						    uffdio_register.ioctls)) {
>  			fprintf(stderr,
>  				"unexpected missing ioctl for anon memory\n");
>  			return 1;

-- 
Sincerely yours,
Mike.

