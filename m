Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74AE4C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B50208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B50208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbeFNFjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:39:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754599AbeFNFjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:39:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5E5cWXD123565
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:39:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jkhnn1nqv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:39:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 14 Jun 2018 06:39:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 06:39:09 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5E5d86234537676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 05:39:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 084BE11C050;
        Thu, 14 Jun 2018 06:29:42 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB9811C04A;
        Thu, 14 Jun 2018 06:29:41 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.71])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Jun 2018 06:29:41 +0100 (BST)
Date:   Thu, 14 Jun 2018 08:39:05 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     arnd@arndb.de, akpm@linux-foundation.org, zhijianx.li@intel.com,
        aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com,
        prakash.sangappa@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: vm: return Kselftest Skip code for skipped
 tests
References: <20180614033557.10191-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614033557.10191-1-shuah@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18061405-0028-0000-0000-000002D0A4E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061405-0029-0000-0000-00002387CA6F
Message-Id: <20180614053905.GA31020@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:35:57PM -0600, Shuah Khan (Samsung OSG) wrote:
> When vm test is skipped because of unmet dependencies and/or unsupported
> configuration, it exits with error which is treated as a fail by the
> Kselftest framework. This leads to false negative result even when the
> test could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

For the userfaultfd test
 
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/vm/compaction_test.c |  4 +++-
>  tools/testing/selftests/vm/mlock2-tests.c    | 12 +++++++-----
>  tools/testing/selftests/vm/run_vmtests       |  5 ++++-
>  tools/testing/selftests/vm/userfaultfd.c     |  4 +++-
>  4 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
> index 1097f04e4d80..bcec71250873 100644
> --- a/tools/testing/selftests/vm/compaction_test.c
> +++ b/tools/testing/selftests/vm/compaction_test.c
> @@ -16,6 +16,8 @@
>  #include <unistd.h>
>  #include <string.h>
> 
> +#include "../kselftest.h"
> +
>  #define MAP_SIZE 1048576
> 
>  struct map_list {
> @@ -169,7 +171,7 @@ int main(int argc, char **argv)
>  		printf("Either the sysctl compact_unevictable_allowed is not\n"
>  		       "set to 1 or couldn't read the proc file.\n"
>  		       "Skipping the test\n");
> -		return 0;
> +		return KSFT_SKIP;
>  	}
> 
>  	lim.rlim_cur = RLIM_INFINITY;
> diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/selftests/vm/mlock2-tests.c
> index 4997b9222cfa..637b6d0ac0d0 100644
> --- a/tools/testing/selftests/vm/mlock2-tests.c
> +++ b/tools/testing/selftests/vm/mlock2-tests.c
> @@ -9,6 +9,8 @@
>  #include <stdbool.h>
>  #include "mlock2.h"
> 
> +#include "../kselftest.h"
> +
>  struct vm_boundaries {
>  	unsigned long start;
>  	unsigned long end;
> @@ -303,7 +305,7 @@ static int test_mlock_lock()
>  	if (mlock2_(map, 2 * page_size, 0)) {
>  		if (errno == ENOSYS) {
>  			printf("Cannot call new mlock family, skipping test\n");
> -			_exit(0);
> +			_exit(KSFT_SKIP);
>  		}
>  		perror("mlock2(0)");
>  		goto unmap;
> @@ -412,7 +414,7 @@ static int test_mlock_onfault()
>  	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
>  		if (errno == ENOSYS) {
>  			printf("Cannot call new mlock family, skipping test\n");
> -			_exit(0);
> +			_exit(KSFT_SKIP);
>  		}
>  		perror("mlock2(MLOCK_ONFAULT)");
>  		goto unmap;
> @@ -425,7 +427,7 @@ static int test_mlock_onfault()
>  	if (munlock(map, 2 * page_size)) {
>  		if (errno == ENOSYS) {
>  			printf("Cannot call new mlock family, skipping test\n");
> -			_exit(0);
> +			_exit(KSFT_SKIP);
>  		}
>  		perror("munlock()");
>  		goto unmap;
> @@ -457,7 +459,7 @@ static int test_lock_onfault_of_present()
>  	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
>  		if (errno == ENOSYS) {
>  			printf("Cannot call new mlock family, skipping test\n");
> -			_exit(0);
> +			_exit(KSFT_SKIP);
>  		}
>  		perror("mlock2(MLOCK_ONFAULT)");
>  		goto unmap;
> @@ -583,7 +585,7 @@ static int test_vma_management(bool call_mlock)
>  	if (call_mlock && mlock2_(map, 3 * page_size, MLOCK_ONFAULT)) {
>  		if (errno == ENOSYS) {
>  			printf("Cannot call new mlock family, skipping test\n");
> -			_exit(0);
> +			_exit(KSFT_SKIP);
>  		}
>  		perror("mlock(ONFAULT)\n");
>  		goto out;
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
> index 22d564673830..88cbe5575f0c 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -2,6 +2,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #please run as root
> 
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  mnt=./huge
>  exitcode=0
> 
> @@ -36,7 +39,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
>  		echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
>  		if [ $? -ne 0 ]; then
>  			echo "Please run this test as root"
> -			exit 1
> +			exit $ksft_skip
>  		fi
>  		while read name size unit; do
>  			if [ "$name" = "HugePages_Free:" ]; then
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index de2f9ec8a87f..7b8171e3128a 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -69,6 +69,8 @@
>  #include <setjmp.h>
>  #include <stdbool.h>
> 
> +#include "../kselftest.h"
> +
>  #ifdef __NR_userfaultfd
> 
>  static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
> @@ -1322,7 +1324,7 @@ int main(int argc, char **argv)
>  int main(void)
>  {
>  	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
> -	return 0;
> +	return KSFT_SKIP;
>  }
> 
>  #endif /* __NR_userfaultfd */
> -- 
> 2.17.0
> 

-- 
Sincerely yours,
Mike.

