Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB57520882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB57520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeGYPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:24:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbeGYPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:24:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEARXP012040
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:12:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kerweyag7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:12:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 25 Jul 2018 15:11:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:11:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEBpmN39714856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:11:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4E3642054;
        Wed, 25 Jul 2018 17:12:05 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A48542061;
        Wed, 25 Jul 2018 17:12:05 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.110])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:12:05 +0100 (BST)
Date:   Wed, 25 Jul 2018 17:11:48 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 2/3] userfaultfd: selftest: Skip test if a feature isn't
 supported
References: <20180725024209.32586-1-bauerman@linux.ibm.com>
 <20180725024209.32586-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725024209.32586-3-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072514-0020-0000-0000-000002AB03E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-0021-0000-0000-000020F79E3E
Message-Id: <20180725141148.GD25188@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 11:42:08PM -0300, Thiago Jung Bauermann wrote:
> If userfaultfd runs on a system that doesn't support some feature it is
> trying to test, it currently ends with error code 1 which indicates
> test failure:
> 
>   # ./userfaultfd anon 10 10
>   nr_pages: 160, nr_pages_per_cpu: 80
>   bounces: 9, mode: rnd poll, userfaults: 7 59
>   bounces: 8, mode: poll, userfaults: 0 0
>   bounces: 7, mode: rnd racing ver, userfaults: 45 2
>   bounces: 6, mode: racing ver, userfaults: 3 1
>   bounces: 5, mode: rnd ver, userfaults: 55 32
>   bounces: 4, mode: ver, userfaults: 69 0
>   bounces: 3, mode: rnd racing, userfaults: 1 1
>   bounces: 2, mode: racing, userfaults: 65 0
>   bounces: 1, mode: rnd, userfaults: 44 1
>   bounces: 0, mode:, userfaults: 3 2
>   testing UFFDIO_ZEROPAGE: done.
>   testing signal delivery: UFFDIO_API
>   # echo $?
>   1
> 
> Make the testcase return KSFT_SKIP instead, which is more accurate since it
> is not a real test failure:
> 
>   # ./userfaultfd anon 10 10
>   nr_pages: 160, nr_pages_per_cpu: 80
>   bounces: 9, mode: rnd poll, userfaults: 3 0
>   bounces: 8, mode: poll, userfaults: 6 1
>   bounces: 7, mode: rnd racing ver, userfaults: 3 1
>   bounces: 6, mode: racing ver, userfaults: 2 1
>   bounces: 5, mode: rnd ver, userfaults: 2 1
>   bounces: 4, mode: ver, userfaults: 3 47
>   bounces: 3, mode: rnd racing, userfaults: 38 0
>   bounces: 2, mode: racing, userfaults: 4 61
>   bounces: 1, mode: rnd, userfaults: 16 6
>   bounces: 0, mode:, userfaults: 55 25
>   testing UFFDIO_ZEROPAGE: done.
>   testing signal delivery: UFFDIO_API: Invalid argument
>   # echo $?
>   4
> 
> While at it, also improve the error message of the ioctl(UFFDIO_API) call.

Can you please also make the test return KSFT_SKIP if userfaultfd(2) fails
with ENOSYS?
 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 41 ++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index e4099afe7557..bc9ec38fbc34 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -645,8 +645,11 @@ static int userfaultfd_open(int features)
>  	uffdio_api.api = UFFD_API;
>  	uffdio_api.features = features;
>  	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
> -		fprintf(stderr, "UFFDIO_API\n");
> -		return 1;
> +		int errnum = errno;
> +
> +		perror("UFFDIO_API");
> +
> +		return errnum == EINVAL ? KSFT_SKIP : 1;
>  	}
>  	if (uffdio_api.api != UFFD_API) {
>  		fprintf(stderr, "UFFDIO_API error %Lu\n", uffdio_api.api);
> @@ -852,6 +855,7 @@ static int userfaultfd_zeropage_test(void)
>  {
>  	struct uffdio_register uffdio_register;
>  	unsigned long expected_ioctls;
> +	int err;
> 
>  	printf("testing UFFDIO_ZEROPAGE: ");
>  	fflush(stdout);
> @@ -859,8 +863,10 @@ static int userfaultfd_zeropage_test(void)
>  	if (uffd_test_ops->release_pages(area_dst))
>  		return 1;
> 
> -	if (userfaultfd_open(0))
> -		return 1;
> +	err = userfaultfd_open(0);
> +	if (err)
> +		return err;
> +
>  	uffdio_register.range.start = (unsigned long) area_dst;
>  	uffdio_register.range.len = nr_pages * page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> @@ -902,8 +908,9 @@ static int userfaultfd_events_test(void)
> 
>  	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
>  		UFFD_FEATURE_EVENT_REMOVE;
> -	if (userfaultfd_open(features))
> -		return 1;
> +	err = userfaultfd_open(features);
> +	if (err)
> +		return err;
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> 
>  	uffdio_register.range.start = (unsigned long) area_dst;
> @@ -961,8 +968,9 @@ static int userfaultfd_sig_test(void)
>  		return 1;
> 
>  	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
> -	if (userfaultfd_open(features))
> -		return 1;
> +	err = userfaultfd_open(features);
> +	if (err)
> +		return err;
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> 
>  	uffdio_register.range.start = (unsigned long) area_dst;
> @@ -1027,8 +1035,9 @@ static int userfaultfd_stress(void)
>  	if (!area_dst)
>  		return 1;
> 
> -	if (userfaultfd_open(0))
> -		return 1;
> +	err = userfaultfd_open(0);
> +	if (err)
> +		return err;
> 
>  	count_verify = malloc(nr_pages * sizeof(unsigned long long));
>  	if (!count_verify) {
> @@ -1199,8 +1208,16 @@ static int userfaultfd_stress(void)
>  		return err;
> 
>  	close(uffd);
> -	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
> -		|| userfaultfd_events_test();
> +
> +	err = userfaultfd_zeropage_test();
> +	if (err)
> +		return err;
> +
> +	err = userfaultfd_sig_test();
> +	if (err)
> +		return err;
> +
> +	return userfaultfd_events_test();
>  }
> 
>  /*

-- 
Sincerely yours,
Mike.

