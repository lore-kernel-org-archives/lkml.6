Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B92089B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5B92089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbeGZR7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730413AbeGZR7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:59:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D84F1AE06;
        Thu, 26 Jul 2018 16:41:51 +0000 (UTC)
Date:   Thu, 26 Jul 2018 18:41:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] docs/core-api: mm-api: add section about GFP flags
Message-ID: <20180726164150.GO28386@dhcp22.suse.cz>
References: <1532607722-17079-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726130106.GC3504@bombadil.infradead.org>
 <20180726142039.GA23627@dhcp22.suse.cz>
 <20180726151852.GF8477@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726151852.GF8477@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 18:18:53, Mike Rapoport wrote:
> On Thu, Jul 26, 2018 at 04:20:39PM +0200, Michal Hocko wrote:
> > On Thu 26-07-18 06:01:06, Matthew Wilcox wrote:
> > > On Thu, Jul 26, 2018 at 03:22:02PM +0300, Mike Rapoport wrote:
> > > > +Memory Allocation Controls
> > > > +==========================
> > > 
> > > Perhaps call this section "Memory Allocation Flags" instead?
> > > 
> > > > +Linux provides a variety of APIs for memory allocation from direct
> > > > +calls to page allocator through slab caches and vmalloc to allocators
> > > > +of compressed memory. Although these allocators have different
> > > > +semantics and are used in different circumstances, they all share the
> > > > +GFP (get free page) flags that control behavior of each allocation
> > > > +request.
> > > 
> > > While this isn't /wrong/, I think it might not be the most useful way
> > > of explaining what the GFP flags are to someone who's just come across
> > > them in some remote part of the kernel.  How about this paragraph instead?
> > > 
> > >   Functions which need to allocate memory often use GFP flags to express
> > >   how that memory should be allocated.  The GFP acronym stands for "get
> > >   free pages", the underlying memory allocation function.
> > 
> > OK.
> > 
> > >   Not every GFP
> > >   flag is allowed to every function which may allocate memory.  Most
> > >   users will want to use a plain ``GFP_KERNEL`` or ``GFP_ATOMIC``.
> > 
> > Or rather than mentioning the two just use "Useful GFP flag
> > combinations" comment segment from gfp.h
> 
> The comment there includes GFP_DMA, GFP_NOIO etc so I'd prefer Matthew's
> version and maybe even omit GFP_ATOMIC from it.
> 
> Some grepping shows that roughly 80% of allocations are GFP_KERNEL, 12% are
> GFP_ATOMIC and ... I didn't count the usage of other flags ;-)

Well, I will certainly not insist... I don't know who is the expected
audience of this documentation. That section was meant for kernel
developers to know which of the high level flags to use.
-- 
Michal Hocko
SUSE Labs
