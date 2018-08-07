Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C180C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF93521734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF93521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeHGJEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:04:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbeHGJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:04:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w776nS3m071282
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 02:51:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kq1r09r00-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:51:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 7 Aug 2018 07:51:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 07:51:03 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w776p2C533620174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 06:51:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ED1611C05C;
        Tue,  7 Aug 2018 09:51:10 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 204C711C04C;
        Tue,  7 Aug 2018 09:51:09 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Aug 2018 09:51:08 +0100 (BST)
Date:   Tue, 7 Aug 2018 09:50:59 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH v2 2/4] userfaultfd: selftest: Skip test if userfaultfd()
 syscall not supported
References: <20180803220046.4019-1-bauerman@linux.ibm.com>
 <20180803220046.4019-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803220046.4019-3-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080706-0028-0000-0000-000002E73AEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080706-0029-0000-0000-000023A03DDF
Message-Id: <20180807065057.GB20140@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:00:44PM -0300, Thiago Jung Bauermann wrote:
> Since there's no point in doing anything in this case, immediately exit the
> process.
> 
> And take the opportunity to improve the error message.
> 
> Before:
> 
>   # ./userfaultfd shmem 10 10
>   nr_pages: 160, nr_pages_per_cpu: 40
>   userfaultfd syscall not available in this kernel
>   # echo $?
>   1
> 
> After:
> 
>   # ./userfaultfd shmem 10 10
>   nr_pages: 160, nr_pages_per_cpu: 40
>   userfaultfd syscall not available in this kernel: Function not implemented
>   # echo $?
>   4
> 
> Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index e4099afe7557..d728bd1cb33c 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -636,9 +636,11 @@ static int userfaultfd_open(int features)
> 
>  	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>  	if (uffd < 0) {
> -		fprintf(stderr,
> -			"userfaultfd syscall not available in this kernel\n");
> -		return 1;
> +		int errnum = errno;
> +
> +		perror("userfaultfd syscall not available in this kernel");
> +
> +		exit(errnum == ENOSYS ? KSFT_SKIP : 1);
>  	}
>  	uffd_flags = fcntl(uffd, F_GETFD, NULL);
> 

-- 
Sincerely yours,
Mike.

