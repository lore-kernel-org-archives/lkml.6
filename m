Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37782C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC43F20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC43F20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeGYPaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:30:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728378AbeGYPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:30:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEFdLM121492
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:19:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kersr0cpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:18:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 25 Jul 2018 15:18:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:18:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEIpKW37028084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:18:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9144C059;
        Wed, 25 Jul 2018 17:19:06 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 382A14C050;
        Wed, 25 Jul 2018 17:19:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.110])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:19:06 +0100 (BST)
Date:   Wed, 25 Jul 2018 17:18:49 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 3/3] userfaultfd: selftest: Report XFAIL if shmem doesn't
 support zeropage
References: <20180725024209.32586-1-bauerman@linux.ibm.com>
 <20180725024209.32586-4-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725024209.32586-4-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072514-0016-0000-0000-000001EB4B74
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-0017-0000-0000-000032402F72
Message-Id: <20180725141849.GE25188@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 11:42:09PM -0300, Thiago Jung Bauermann wrote:
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
> This is a real failure, but expected so signal that to the test harness:

I don't think its a real failure. If the kernel does not support
UFFDIO_ZEROPAGE for shared memory the userfaultfd_zeropage_test can be
simply skipped.
 
>   # ./userfaultfd shmem 10 10
>   nr_pages: 160, nr_pages_per_cpu: 80
>   bounces: 9, mode: rnd poll, UFFDIO_ZEROPAGE unsupported in shmem VMAs
>   # echo $?
>   2
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index bc9ec38fbc34..686fe96f617f 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -1115,6 +1115,14 @@ static int userfaultfd_stress(void)
>  		expected_ioctls = uffd_test_ops->expected_ioctls;
>  		if ((uffdio_register.ioctls & expected_ioctls) !=
>  		    expected_ioctls) {
> +			if (test_type == TEST_SHMEM &&
> +			    (uffdio_register.ioctls & expected_ioctls) ==
> +			    UFFD_API_RANGE_IOCTLS_BASIC) {
> +				fprintf(stderr,
> +					"UFFDIO_ZEROPAGE unsupported in shmem VMAs\n");
> +				return KSFT_XFAIL;
> +			}
> +

By all means, this check should be moved to userfaultfd_zeropage_test().
Ideally, we should call here ksft_test_result_skip() and simply return from
the function.



>  			fprintf(stderr,
>  				"unexpected missing ioctl for anon memory\n");
>  			return 1;

-- 
Sincerely yours,
Mike.

