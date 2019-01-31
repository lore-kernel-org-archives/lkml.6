Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25558C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BF0218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfAaJyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:54:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731325AbfAaJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:54:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V9sIWQ126028
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:54:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbxr9g5a4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:54:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 31 Jan 2019 09:54:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 09:54:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V9sNhc62914648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 09:54:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C50DF11C058;
        Thu, 31 Jan 2019 09:54:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9D3F11C069;
        Thu, 31 Jan 2019 09:54:22 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 31 Jan 2019 09:54:22 +0000 (GMT)
Date:   Thu, 31 Jan 2019 11:54:21 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [LSF/MM TOPIC]: userfaultfd (was: [LSF/MM TOPIC] NUMA remote THP
 vs NUMA local non-THP under MADV_HUGEPAGE)
References: <20190129234058.GH31695@redhat.com>
 <20190130081336.GC17937@rapoport-lnx>
 <20190130092302.GA25119@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130092302.GA25119@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013109-0008-0000-0000-000002B93D21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013109-0009-0000-0000-000022253F10
Message-Id: <20190131095420.GI28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jan 30, 2019 at 05:23:02PM +0800, Peter Xu wrote:
> On Wed, Jan 30, 2019 at 10:13:36AM +0200, Mike Rapoport wrote:
> > 
> > If we are to discuss userfaultfd, I'd like also to bring the subject of COW
> > mappings.
> > The pages populated with UFFDIO_COPY cannot be COW-shared between related
> > processes which unnecessarily increases memory footprint of a migrated
> > process tree.
> > I've posted a patch [1] a (real) while ago, but nobody reacted and I've put
> > this aside.
> > Maybe it's time to discuss it again :)
> 
> Hi, Mike,
> 
> It's interesting to know such a work...
> 
> Since I really don't have much context on this, so sorry if I'm going
> to ask a silly question... but I'd say when reading this I'm thinking
> of KSM.  I think KSM does not suite in this case since when doing
> UFFDIO_COPY_COW it'll contain hinting information while KSM was only
> scanning over the pages between processes which seems to be O(N*N) if
> assuming there're two processes.  However, would it make any sense to
> provide a general interface to scan for same pages between any two
> processes within specific range and merge them if found (rather than a
> specific interface for userfaultfd only)?  Then it might even be used
> by KSM admins (just as an example) when the admin knows exactly that
> memory range (addr1, len) of process A should very probably has many
> same contents as the memory range (addr2, len) of process B?

I haven't really thought about using KSM in our case. Our goal was to make
the VM layout of the migrated processes as close as possible to the
original, including the COW sharing between parent process and its
descendants. For that UFFDIO_COPY_COW seems to be more natural fit than
KSM.

> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.

