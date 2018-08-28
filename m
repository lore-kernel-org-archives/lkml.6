Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75732C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E81208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E81208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeH1KFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:05:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbeH1KFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:05:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S6EUvi138756
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:15:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m4y51v095-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:15:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 28 Aug 2018 07:15:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 07:15:14 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7S6FDMh34078944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 06:15:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 792EB4C046;
        Tue, 28 Aug 2018 09:15:12 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E87F64C06A;
        Tue, 28 Aug 2018 09:15:11 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.97])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Aug 2018 09:15:11 +0100 (BST)
Date:   Tue, 28 Aug 2018 09:15:11 +0300
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
 <20180807065642.GD20140@rapoport-lnx>
 <87zhx7rywm.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhx7rywm.fsf@morokweng.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082806-0012-0000-0000-0000029FA9DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082806-0013-0000-0000-000020D3AFB8
Message-Id: <20180828061510.GA25317@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:46:33PM -0300, Thiago Jung Bauermann wrote:
> 
> Hello Mike,
> 
> Mike Rapoport <rppt@linux.vnet.ibm.com> writes:
> 
> > Hi,
> >
> > On Fri, Aug 03, 2018 at 07:00:46PM -0300, Thiago Jung Bauermann wrote:
> >> If userfaultfd runs on a system that doesn't support UFFDIO_ZEROPAGE for
> >> shared memory, it currently ends with error code 1 which indicates test
> >> failure:
> >>
> >>   # ./userfaultfd shmem 10 10
> >>   nr_pages: 160, nr_pages_per_cpu: 80
> >>   bounces: 9, mode: rnd poll, unexpected missing ioctl for anon memory
> >>   # echo $?
> >>   1
> >>
> >> Change userfaultfd_zeropage_test() to return KSFT_SKIP to indicate that
> >> the test is being skipped.
> >
> > I took a deeper look at what userfaultfd_zeropage_test() does and,
> > apparently, I've mislead you. The test checks if the range has
> > UFFDIO_ZEROPAGE and verifies that it works if yes; otherwise the test
> > verifies that EINVAL is returned.
> >
> > Can you please check if the patch below works in your environment?
> >
> > From 7a34c84c0461b5073742275638c44b6535d19166 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Date: Tue, 7 Aug 2018 09:44:19 +0300
> > Subject: [PATCH] userfaultfd: selftest: make supported range ioctl
> >  verification more robust
> >
> > When userfaultfd tests runs on older kernel that does not support
> > UFFDIO_ZEROPAGE for shared memory it fails at the ioctl verification.
> >
> > Split out the verification that supported ioctls are superset of the
> > expected ioctls and relax the checks for UFFDIO_ZEROPAGE for shared memory
> > areas.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  tools/testing/selftests/vm/userfaultfd.c | 63 +++++++++++++++++---------------
> >  1 file changed, 34 insertions(+), 29 deletions(-)
> 
> I'm sorry to take this long to respond, I was only able to get back to
> this today.

No problem :)

> Your patch does solve my problem. Thank you very much!
> 
> It has a trivial conflict in the second hunk with patch 3 in my series.
> Should I repost the series with your patch in place of patch 4?

Yep.
 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center

-- 
Sincerely yours,
Mike.

