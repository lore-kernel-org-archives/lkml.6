Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F5E21734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F5E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbeHGJD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:03:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388294AbeHGJDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:03:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w776nO57073394
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 02:50:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kq54ejvjm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:50:33 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 7 Aug 2018 07:50:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 07:50:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w776oSHj39911620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 06:50:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A476342045;
        Tue,  7 Aug 2018 09:50:37 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B3742047;
        Tue,  7 Aug 2018 09:50:36 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Aug 2018 09:50:36 +0100 (BST)
Date:   Tue, 7 Aug 2018 09:50:25 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH v2 1/4] userfaultfd: selftest: Fix checking of
 userfaultfd_open() result
References: <20180803220046.4019-1-bauerman@linux.ibm.com>
 <20180803220046.4019-2-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803220046.4019-2-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080706-0016-0000-0000-000001F33BD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080706-0017-0000-0000-000032493F46
Message-Id: <20180807065023.GA20140@rapoport-lnx>
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

On Fri, Aug 03, 2018 at 07:00:43PM -0300, Thiago Jung Bauermann wrote:
> If the userfaultfd test is run on a kernel with CONFIG_USERFAULTFD=n, it
> will report that the system call is not available yet go ahead and continue
> anyway:
> 
>   # ./userfaultfd anon 30 1
>   nr_pages: 480, nr_pages_per_cpu: 120
>   userfaultfd syscall not available in this kernel
>   bounces: 0, mode:, register failure
> 
> This is because userfaultfd_open() returns 0 on success and 1 on error but
> all callers assume that it returns < 0 on error.
> 
> Since the convention of the test as a whole is the one used by
> userfault_open(), fix its callers instead. Now the test behaves correctly:
> 
>   # ./userfaultfd anon 30 1
>   nr_pages: 480, nr_pages_per_cpu: 120
>   userfaultfd syscall not available in this kernel
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 7b8171e3128a..e4099afe7557 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -859,7 +859,7 @@ static int userfaultfd_zeropage_test(void)
>  	if (uffd_test_ops->release_pages(area_dst))
>  		return 1;
> 
> -	if (userfaultfd_open(0) < 0)
> +	if (userfaultfd_open(0))
>  		return 1;
>  	uffdio_register.range.start = (unsigned long) area_dst;
>  	uffdio_register.range.len = nr_pages * page_size;
> @@ -902,7 +902,7 @@ static int userfaultfd_events_test(void)
> 
>  	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
>  		UFFD_FEATURE_EVENT_REMOVE;
> -	if (userfaultfd_open(features) < 0)
> +	if (userfaultfd_open(features))
>  		return 1;
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> 
> @@ -961,7 +961,7 @@ static int userfaultfd_sig_test(void)
>  		return 1;
> 
>  	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
> -	if (userfaultfd_open(features) < 0)
> +	if (userfaultfd_open(features))
>  		return 1;
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> 
> @@ -1027,7 +1027,7 @@ static int userfaultfd_stress(void)
>  	if (!area_dst)
>  		return 1;
> 
> -	if (userfaultfd_open(0) < 0)
> +	if (userfaultfd_open(0))
>  		return 1;
> 
>  	count_verify = malloc(nr_pages * sizeof(unsigned long long));

-- 
Sincerely yours,
Mike.

