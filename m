Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELthjWMmEzIHMJDWTwGf0MKjrwCmvSFqPzXJrhXho2xtrbmBKU22xPuofrOCDxWRyu52G8w4
ARC-Seal: i=1; a=rsa-sha256; t=1520033219; cv=none;
        d=google.com; s=arc-20160816;
        b=N11IwMH/jVHjT8W0MVcEMkmhSSNBTSvpfHhoKla5y2/Ch+CzJjfbRz2u8qNHisF/dt
         PdNk/Q8hCWTSYJACvl4PQ+Q9wXJc+3EHe5a4qTrYsbzWsiZ/K6OI5bw4EWIqHrr2M6wT
         yyt/rpPSoOLE7jH86ohkKErxe3sJVxrl/6YndyJRLjsfXo5oi0GR/+W8s52RvrLLr+IL
         O5WU1FEY4DCeMDYlHhAJRkA1htNP6i6/zuFPL0YaJGamyvYTnZxwVB+XZR7VBjuNfJF9
         xyQ0z3xwRvBOZfJvgDxh7adZMVLqF8qCFcHzcrQLLiEWu1MEZp+pakKYOz39svQdDUDR
         oPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=eXszRTfAGQ0C4FHK59cbB0Coe8jQqeM+i+aNqjr/hUM=;
        b=Oz5UlSiuhaYQ8HIt4NQU3UWO1g1IFgDvuWofjM0Uo9dd8Q8dZNh2NiTQXn3TKi8lZu
         9ZSnEDR4tuMA+KnseZ60wDhIK8J8ov8CTTbnf+Qb2Zu+f49MlV/0YmPkWldIBXz75+dF
         wsXQDafHvpiY0dFEsxdqsPjCKu9fMaRZ4gQntODDT7D4k7kmcgi8ztuViB9CePOGQ+MM
         kzk0dWm37re3RqCFTnsMHXWRofHXUAuznTFc+Q38S3YX61ZJHIhj4n7YWFiRsi+VogkT
         9peR9GVPkM/pyk/YQl1pMJ6bUfMM/vCT6838+h7PT+5LEviOZOAVz213XVc5P3pDFzrg
         WUtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=pLJjfhaQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=pLJjfhaQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934485AbeCBX05 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 2 Mar 2018 18:26:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34136 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934230AbeCBX05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Mar 2018 18:26:57 -0500
Subject: Re: [PATCH] selftests/vm/run_vmtests: adjust hugetlb size accroding
 to nr_cpus
To: Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        akpm@linux-foundation.org, sj38.park@gmail.com,
        pombredanne@nexb.com, aneesh.kumar@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com
References: <20180302024356.83359-1-zhijianx.li@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <27de0b4e-d75b-a71d-c45c-1d84bc7e6e9e@oracle.com>
Date: Fri, 2 Mar 2018 15:26:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180302024356.83359-1-zhijianx.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020271
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593792153540765223?=
X-GMAIL-MSGID: =?utf-8?q?1593870352809260025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 06:43 PM, Li Zhijian wrote:
> this patch is to fix running userfaultfd_hugetlb failed on the host which has
> more than 64 cpus
> ---------------------------
> running userfaultfd_hugetlb
> ---------------------------
> invalid MiB
> Usage: <MiB> <bounces>
> [FAIL]
> 
> From userfaultfd.c we can know, hugetlb_size need to meet hugetlb_size >= nr_cpus * hugepage_size
> hugepage_size is often 2M, so when host cpus > 64, it requires more than 128M.
> 
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

Thanks for fixing this.

> ---
>  tools/testing/selftests/vm/run_vmtests | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
> index d2561895a021a..c440fb972afe9 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -2,8 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #please run as root
>  
> -#we need 256M, below is the size in kB
> -needmem=262144
>  mnt=./huge
>  exitcode=0
>  
> @@ -17,6 +15,13 @@ while read name size unit; do
>  	fi
>  done < /proc/meminfo
>  
> +nr_cpus=$(nproc)
> +pgsize_MB=$((pgsize/1024))
> +# rule: nr_cpus * pgsize_MB <= hugetlb_size(round to 128M for testing)
> +hugetlb_size=$((((nr_cpus*pgsize_MB+127)/128)*128))
> +# needmem depends on the nr_cpus, below is the size in kB
> +needmem=$((hugetlb_size*2*1024))
> +
>  #set proper nr_hugepages
>  if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
>  	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
> @@ -107,8 +112,8 @@ fi
>  echo "---------------------------"
>  echo "running userfaultfd_hugetlb"
>  echo "---------------------------"
> -# 256MB total huge pages == 128MB src and 128MB dst
> -./userfaultfd hugetlb 128 32 $mnt/ufd_test_file
> +# 256MB total huge pages == 128MB src and 128MB dst when nr_cpus <= 64
> +./userfaultfd hugetlb $hugetlb_size 32 $mnt/ufd_test_file
>  if [ $? -ne 0 ]; then
>  	echo "[FAIL]"
>  	exitcode=1

The above changes are functionally OK.  But, I think something like the
following may be easier to read/understand.  Feel free to use as much or
little as you would like.
-- 
Mike Kravetz

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/run_vmtests | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index d2561895a021..40671f6739a9 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -2,25 +2,33 @@
 # SPDX-License-Identifier: GPL-2.0
 #please run as root
 
-#we need 256M, below is the size in kB
-needmem=262144
 mnt=./huge
 exitcode=0
 
-#get pagesize and freepages from /proc/meminfo
+#get huge pagesize and freepages from /proc/meminfo
 while read name size unit; do
 	if [ "$name" = "HugePages_Free:" ]; then
 		freepgs=$size
 	fi
 	if [ "$name" = "Hugepagesize:" ]; then
-		pgsize=$size
+		hpgsize_KB=$size
 	fi
 done < /proc/meminfo
 
+# Simple hugetlbfs tests have a hardcoded minimum requirement of
+# huge pages totaling 256MB (262144KB) in size.  The userfaultfd
+# hugetlb test requires a minimum of 2 * nr_cpus huge pages.  Take
+# both of these requirements into account and attempt to increase
+* number of huge pages available.
+nr_cpus=$(nproc)
+hpgsize_MB=$((hpgsize_KB / 1024))
+half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
+needmem_KB=$((half_ufd_size_MB * 2 * 1024))
+
 #set proper nr_hugepages
-if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
+if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
-	needpgs=`expr $needmem / $pgsize`
+	needpgs=$((needmem_KB / hpgsize_KB))
 	tries=2
 	while [ $tries -gt 0 ] && [ $freepgs -lt $needpgs ]; do
 		lackpgs=$(( $needpgs - $freepgs ))
@@ -107,8 +115,9 @@ fi
 echo "---------------------------"
 echo "running userfaultfd_hugetlb"
 echo "---------------------------"
-# 256MB total huge pages == 128MB src and 128MB dst
-./userfaultfd hugetlb 128 32 $mnt/ufd_test_file
+# Test requires source and destination huge pages.  Size of source
+# (half_ufd_size_MB) is passed as argument to test.
+./userfaultfd hugetlb $half_ufd_size_MB 32 $mnt/ufd_test_file
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
-- 
2.13.6

