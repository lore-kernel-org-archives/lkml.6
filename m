Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8B320881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8B320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIMR2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:28:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbeIMR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:28:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DCJVoB136371
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:19:34 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mfn96pf0f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:19:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 13 Sep 2018 13:18:32 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 13:18:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8DCISTC45154336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 12:18:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A63F2AE056;
        Thu, 13 Sep 2018 15:17:42 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C5AAE045;
        Thu, 13 Sep 2018 15:17:42 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Sep 2018 15:17:42 +0100 (BST)
Date:   Thu, 13 Sep 2018 14:18:27 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
In-Reply-To: <20180913105738.GW24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091312-0028-0000-0000-000002F8DF5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091312-0029-0000-0000-000023B28346
Message-Id: <20180913141827.1776985e@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=834 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 12:57:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 13, 2018 at 12:30:14PM +0200, Martin Schwidefsky wrote:
> 
> > > + * The mmu_gather data structure is used by the mm code to implement the
> > > + * correct and efficient ordering of freeing pages and TLB invalidations.
> > > + *
> > > + * This correct ordering is:
> > > + *
> > > + *  1) unhook page
> > > + *  2) TLB invalidate page
> > > + *  3) free page
> > > + *
> > > + * That is, we must never free a page before we have ensured there are no live
> > > + * translations left to it. Otherwise it might be possible to observe (or
> > > + * worse, change) the page content after it has been reused.
> > > + *  
> > 
> > This first comment already includes the reason why s390 is probably better off
> > with its own mmu-gather implementation. It depends on the situation if we have
> > 
> > 1) unhook the page and do a TLB flush at the same time
> > 2) free page
> > 
> > or
> > 
> > 1) unhook page
> > 2) free page
> > 3) final TLB flush of the whole mm  
> 
> that's the fullmm case, right?

That includes the fullmm case but we use it for e.g. munmap of a single-threaded
program as well.
 
> > A variant of the second order we had in the past is to do the mm TLB flush first,
> > then the unhooks and frees of the individual pages. The are some tricky corners
> > switching between the two variants, see finish_arch_post_lock_switch.
> > 
> > The point is: we *never* have the order 1) unhook, 2) TLB invalidate, 3) free.
> > If there is concurrency due to a multi-threaded application we have to do the
> > unhook of the page-table entry and the TLB flush with a single instruction.  
> 
> You can still get the thing you want if for !fullmm you have a no-op
> tlb_flush() implementation, assuming your arch page-table frobbing thing
> has the required TLB flush in.

We have a non-empty tlb_flush_mmu_tlbonly to do a full-mm flush for two cases
1) batches of page-table entries for single-threaded programs
2) flushing of the pages used for the page-table structure itself

In fact only the page-table pages are added to the mmu_gather batch, the target
page of the virtual mapping is always freed immediately.
 
> Note that that's not utterly unlike how the PowerPC/Sparc hash things
> work, they clear and invalidate entries different from others and don't
> use the mmu_gather tlb-flush.

We may get something working with a common code mmu_gather, but I fear the
day someone makes a "minor" change to that subtly break s390. The debugging of
TLB related problems is just horrible..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

