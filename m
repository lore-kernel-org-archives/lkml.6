Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B6E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeGZPhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:37:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729894AbeGZPhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE507AFC6;
        Thu, 26 Jul 2018 14:20:39 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:20:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] docs/core-api: mm-api: add section about GFP flags
Message-ID: <20180726142039.GA23627@dhcp22.suse.cz>
References: <1532607722-17079-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726130106.GC3504@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726130106.GC3504@bombadil.infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 06:01:06, Matthew Wilcox wrote:
> On Thu, Jul 26, 2018 at 03:22:02PM +0300, Mike Rapoport wrote:
> > +Memory Allocation Controls
> > +==========================
> 
> Perhaps call this section "Memory Allocation Flags" instead?
> 
> > +Linux provides a variety of APIs for memory allocation from direct
> > +calls to page allocator through slab caches and vmalloc to allocators
> > +of compressed memory. Although these allocators have different
> > +semantics and are used in different circumstances, they all share the
> > +GFP (get free page) flags that control behavior of each allocation
> > +request.
> 
> While this isn't /wrong/, I think it might not be the most useful way
> of explaining what the GFP flags are to someone who's just come across
> them in some remote part of the kernel.  How about this paragraph instead?
> 
>   Functions which need to allocate memory often use GFP flags to express
>   how that memory should be allocated.  The GFP acronym stands for "get
>   free pages", the underlying memory allocation function.

OK.

>   Not every GFP
>   flag is allowed to every function which may allocate memory.  Most
>   users will want to use a plain ``GFP_KERNEL`` or ``GFP_ATOMIC``.

Or rather than mentioning the two just use "Useful GFP flag
combinations" comment segment from gfp.h
-- 
Michal Hocko
SUSE Labs
