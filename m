Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B662A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B662A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeINTWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:22:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbeINTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:22:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EE4QwT085393
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:07:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mgd2jce6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:07:21 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 14 Sep 2018 15:07:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 15:07:16 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8EE7FQM66125872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 14:07:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A5534C046;
        Fri, 14 Sep 2018 17:07:06 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDE6B4C040;
        Fri, 14 Sep 2018 17:07:05 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Sep 2018 17:07:05 +0100 (BST)
Date:   Fri, 14 Sep 2018 16:07:14 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
In-Reply-To: <20180914130207.GD24106@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
        <20180913141827.1776985e@mschwideX1>
        <20180913123937.GX24124@hirez.programming.kicks-ass.net>
        <20180914122824.181d9778@mschwideX1>
        <20180914130207.GD24106@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091414-0020-0000-0000-000002C659ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091414-0021-0000-0000-00002113BCAE
Message-Id: <20180914160714.45a11f13@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=737 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 15:02:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 14, 2018 at 12:28:24PM +0200, Martin Schwidefsky wrote:
> 
> > I spent some time to get s390 converted to the common mmu_gather code.
> > There is one thing I would like to request, namely the ability to
> > disable the page gather part of mmu_gather. For my prototype patch
> > see below, it defines the negative HAVE_RCU_NO_GATHER_PAGES Kconfig
> > symbol that if defined will remove some parts from common code.
> > Ugly but good enough for the prototype to convey the idea.
> > For the final solution we better use a positive Kconfig symbol and
> > add that to all arch Kconfig files except for s390.  
> 
> In a private thread ealier Linus raised the point that the batching and
> freeing of lots of pages at once is probably better for I$.

That would be something to try. For now I would like to do a conversion
that more or less preserves the old behavior. You know these pesky TLB
related bugs..

> > +config HAVE_RCU_NO_GATHER_PAGES
> > +	bool  
> 
> I have a problem with the name more than anything else; this name
> suggests it is the RCU table freeing that should not batch, which is not
> the case, you want the regular page gather gone, but very much require
> the RCU table gather to batch.
> 
> So I would like to propose calling it:
> 
> config HAVE_MMU_GATHER_NO_GATHER
> 
> Or something along those lines.
 
Imho a positive config option like HAVE_MMU_GATHER_PAGES would make the
most sense. It has the downside that it needs to be added to all
arch/*/Kconfig files except for s390. 

But I am not hung-up on a name, whatever does not sound to awful will do
for me. HAVE_MMU_GATHER_NO_GATHER would be ok.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

