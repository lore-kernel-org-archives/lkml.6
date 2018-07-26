Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B37205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B37205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeGZSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:42:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387611AbeGZSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:42:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6QHNqKY143897
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:24:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfhj3b2tg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:24:33 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 18:24:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 18:24:28 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6QHOREW32899082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jul 2018 17:24:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56E0242047;
        Thu, 26 Jul 2018 20:24:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698DD42041;
        Thu, 26 Jul 2018 20:24:40 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.214])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Jul 2018 20:24:40 +0100 (BST)
Date:   Thu, 26 Jul 2018 20:24:23 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] docs/core-api: mm-api: add section about GFP flags
References: <1532607722-17079-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726130106.GC3504@bombadil.infradead.org>
 <20180726142039.GA23627@dhcp22.suse.cz>
 <20180726151852.GF8477@rapoport-lnx>
 <20180726164150.GO28386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726164150.GO28386@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072617-0020-0000-0000-000002AC6D0E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072617-0021-0000-0000-000020F873DB
Message-Id: <20180726172423.GA13478@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807260179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 06:41:50PM +0200, Michal Hocko wrote:
> On Thu 26-07-18 18:18:53, Mike Rapoport wrote:
> > On Thu, Jul 26, 2018 at 04:20:39PM +0200, Michal Hocko wrote:
> > > On Thu 26-07-18 06:01:06, Matthew Wilcox wrote:
> > > > On Thu, Jul 26, 2018 at 03:22:02PM +0300, Mike Rapoport wrote:
> > > > > +Memory Allocation Controls
> > > > > +==========================
> > > > 
> > > > Perhaps call this section "Memory Allocation Flags" instead?
> > > > 
> > > > > +Linux provides a variety of APIs for memory allocation from direct
> > > > > +calls to page allocator through slab caches and vmalloc to allocators
> > > > > +of compressed memory. Although these allocators have different
> > > > > +semantics and are used in different circumstances, they all share the
> > > > > +GFP (get free page) flags that control behavior of each allocation
> > > > > +request.
> > > > 
> > > > While this isn't /wrong/, I think it might not be the most useful way
> > > > of explaining what the GFP flags are to someone who's just come across
> > > > them in some remote part of the kernel.  How about this paragraph instead?
> > > > 
> > > >   Functions which need to allocate memory often use GFP flags to express
> > > >   how that memory should be allocated.  The GFP acronym stands for "get
> > > >   free pages", the underlying memory allocation function.
> > > 
> > > OK.
> > > 
> > > >   Not every GFP
> > > >   flag is allowed to every function which may allocate memory.  Most
> > > >   users will want to use a plain ``GFP_KERNEL`` or ``GFP_ATOMIC``.
> > > 
> > > Or rather than mentioning the two just use "Useful GFP flag
> > > combinations" comment segment from gfp.h
> > 
> > The comment there includes GFP_DMA, GFP_NOIO etc so I'd prefer Matthew's
> > version and maybe even omit GFP_ATOMIC from it.
> > 
> > Some grepping shows that roughly 80% of allocations are GFP_KERNEL, 12% are
> > GFP_ATOMIC and ... I didn't count the usage of other flags ;-)
> 
> Well, I will certainly not insist... I don't know who is the expected
> audience of this documentation. That section was meant for kernel
> developers to know which of the high level flags to use.

Well, as this is kernel api documentation I presume the audience is the
same.
All the descriptions from include/linux/gfp.h are converted by by
kernel-doc and would be included here. This was actually the point of this
patch :)

> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

