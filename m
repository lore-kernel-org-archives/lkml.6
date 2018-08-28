Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F596208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F596208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeH1GgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:36:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbeH1GgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:36:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S2i5vv081288
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:46:44 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m4wcprvd3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:46:44 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 27 Aug 2018 20:46:43 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 20:46:40 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7S2kd8m49610790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 19:46:39 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC118BE058;
        Mon, 27 Aug 2018 20:46:39 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C589EBE054;
        Mon, 27 Aug 2018 20:46:37 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.152.225])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Aug 2018 20:46:37 -0600 (MDT)
References: <20180803220046.4019-1-bauerman@linux.ibm.com> <20180803220046.4019-5-bauerman@linux.ibm.com> <20180807065642.GD20140@rapoport-lnx>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH v2 4/4] userfaultfd: selftest: Cope if shmem doesn't support zeropage
In-reply-to: <20180807065642.GD20140@rapoport-lnx>
Date:   Mon, 27 Aug 2018 23:46:33 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082802-0012-0000-0000-000016A82749
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009624; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01079868; UDB=6.00556971; IPR=6.00859852;
 MB=3.00022966; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 02:46:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082802-0013-0000-0000-00005432CCCE
Message-Id: <87zhx7rywm.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Mike,

Mike Rapoport <rppt@linux.vnet.ibm.com> writes:

> Hi,
>
> On Fri, Aug 03, 2018 at 07:00:46PM -0300, Thiago Jung Bauermann wrote:
>> If userfaultfd runs on a system that doesn't support UFFDIO_ZEROPAGE for
>> shared memory, it currently ends with error code 1 which indicates test
>> failure:
>>
>>   # ./userfaultfd shmem 10 10
>>   nr_pages: 160, nr_pages_per_cpu: 80
>>   bounces: 9, mode: rnd poll, unexpected missing ioctl for anon memory
>>   # echo $?
>>   1
>>
>> Change userfaultfd_zeropage_test() to return KSFT_SKIP to indicate that
>> the test is being skipped.
>
> I took a deeper look at what userfaultfd_zeropage_test() does and,
> apparently, I've mislead you. The test checks if the range has
> UFFDIO_ZEROPAGE and verifies that it works if yes; otherwise the test
> verifies that EINVAL is returned.
>
> Can you please check if the patch below works in your environment?
>
> From 7a34c84c0461b5073742275638c44b6535d19166 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Date: Tue, 7 Aug 2018 09:44:19 +0300
> Subject: [PATCH] userfaultfd: selftest: make supported range ioctl
>  verification more robust
>
> When userfaultfd tests runs on older kernel that does not support
> UFFDIO_ZEROPAGE for shared memory it fails at the ioctl verification.
>
> Split out the verification that supported ioctls are superset of the
> expected ioctls and relax the checks for UFFDIO_ZEROPAGE for shared memory
> areas.
>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 63 +++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 29 deletions(-)

I'm sorry to take this long to respond, I was only able to get back to
this today.

Your patch does solve my problem. Thank you very much!

It has a trivial conflict in the second hunk with patch 3 in my series.
Should I repost the series with your patch in place of patch 4?

--
Thiago Jung Bauermann
IBM Linux Technology Center

