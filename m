Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB8C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567262087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfA3INs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:13:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfA3INr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:13:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U88rRg095268
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:13:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qb7f3j2ex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:13:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 30 Jan 2019 08:13:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 08:13:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0U8DdBG57606364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 08:13:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E904C040;
        Wed, 30 Jan 2019 08:13:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C9724C046;
        Wed, 30 Jan 2019 08:13:38 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.107])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Jan 2019 08:13:38 +0000 (GMT)
Date:   Wed, 30 Jan 2019 10:13:36 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [LSF/MM TOPIC]: userfaultfd (was: [LSF/MM TOPIC] NUMA remote THP vs
 NUMA local non-THP under MADV_HUGEPAGE)
References: <20190129234058.GH31695@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129234058.GH31695@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013008-0020-0000-0000-0000030E29CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013008-0021-0000-0000-0000215F2B77
Message-Id: <20190130081336.GC17937@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(changed the subject and added CRIU folks)

On Tue, Jan 29, 2019 at 06:40:58PM -0500, Andrea Arcangeli wrote:
> Hello,
> 
> --
> 
> In addition to the above "NUMA remote THP vs NUMA local non-THP
> tradeoff" topic, there are other developments in "userfaultfd" land that
> are approaching merge readiness and that would be possible to provide a
> short overview about:
> 
> - Peter Xu made significant progress in finalizing the userfaultfd-WP
>   support over the last few months. That feature was planned from the
>   start and it will allow userland to do some new things that weren't
>   possible to achieve before. In addition to synchronously blocking
>   write faults to be resolved by an userland manager, it has also the
>   ability to obsolete the softdirty feature, because it can provide
>   the same information, but with O(1) complexity (as opposed of the
>   current softdirty O(N) complexity) similarly to what the Page
>   Modification Logging (PML) does in hardware for EPT write accesses.
 
We (CRIU) have some concerns about obsoleting soft-dirty in favor of
uffd-wp. If there are other soft-dirty users these concerns would be
relevant to them as well.

With soft-dirty we collect the information about the changed memory every
pre-dump iteration in the following manner:
* freeze the tasks
* find entries in /proc/pid/pagemap with SOFT_DIRTY set
* unfreeze the tasks
* dump the modified pages to disk/remote host

While we do need to traverse the /proc/pid/pagemap to identify dirty pages,
in between the pre-dump iterations and during the actual memory dump the
tasks are running freely.

If we are to switch to uffd-wp, every write by the snapshotted/migrated
task will incur latency of uffd-wp processing by the monitor.

We'd need to see how this affects overall slowdown of the workload under
migration before moving forward with obsoleting soft-dirty.

> - Blake Caldwell maintained the UFFDIO_REMAP support to atomically
>   remove memory from a mapping with userfaultfd (which can't be done
>   with a copy as in UFFDIO_COPY and it requires a slow TLB flush to be
>   safe) as an alternative to host swapping (which of course also
>   requires a TLB flush for similar reasons). Notably UFFDIO_REMAP was
>   rightfully naked early on and quickly replaced by UFFDIO_COPY which
>   is more optimal to add memory to a mapping is small chunks, but we
>   can't remove memory with UFFDIO_COPY and UFFDIO_REMAP should be as
>   efficient as it gets when it comes to removing memory from a
>   mapping.

If we are to discuss userfaultfd, I'd like also to bring the subject of COW
mappings.
The pages populated with UFFDIO_COPY cannot be COW-shared between related
processes which unnecessarily increases memory footprint of a migrated
process tree.
I've posted a patch [1] a (real) while ago, but nobody reacted and I've put
this aside.
Maybe it's time to discuss it again :)

> Thank you,
> Andrea
> 

[1] https://lwn.net/ml/linux-api/20180328101729.GB1743%40rapoport-lnx/

-- 
Sincerely yours,
Mike.

