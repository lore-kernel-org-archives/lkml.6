Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65144C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315DF21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gT8IzfYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391719AbfBOI5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:57:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfBOI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lC0sJXKkNVKrNcwoJXfFFpIZaHgwwYjVNEpuiQ0lz3E=; b=gT8IzfYM0rLFTG1VADzNxWfkL
        0eTJScOywY+BgA5bL80r6zjO1AZl0H1zn29CTmFlZpu9sIc1WYqCtNA2bv/sLQy+V7B5KSUJL9kBf
        Mjc3XlxeAS2Al3t6/Whmm/lamblTaQI4AOdXw4EJkWBnRgFshT9ee/IpFzmm8tY1oqVPt1WRJewMQ
        wg8kTdGA4sk4TirfNw88ZtdtbGnDMH45veEYZy1uMspmPpNxOUFG+XJ9YCgDMkUqaGfGURYZIExdP
        N88tGKmHqC9VA5C/vAfXJZLPzY1ecvbeTU9gZV2OI7fGkQGeoFyBBHE8kTs/NXjsX9OU67Bl1b2ZI
        4/Q6jy/xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guZJT-0000As-Ke; Fri, 15 Feb 2019 08:57:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE255201A8970; Fri, 15 Feb 2019 09:57:36 +0100 (CET)
Date:   Fri, 15 Feb 2019 09:57:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 03/12] __wr_after_init: Core and default arch
Message-ID: <20190215085736.GO32494@hirez.programming.kicks-ass.net>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
 <b99f0de701e299b9d25ce8cfffa3387b9687f5fc.1550097697.git.igor.stoppa@huawei.com>
 <20190214112849.GM32494@hirez.programming.kicks-ass.net>
 <6e9ec71c-ee75-9b1e-9ff8-a3210030e85d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9ec71c-ee75-9b1e-9ff8-a3210030e85d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:10:33AM +0200, Igor Stoppa wrote:
> 
> 
> On 14/02/2019 13:28, Peter Zijlstra wrote:
> > On Thu, Feb 14, 2019 at 12:41:32AM +0200, Igor Stoppa wrote:
> 
> [...]
> 
> > > +#define wr_rcu_assign_pointer(p, v) ({	\
> > > +	smp_mb();			\
> > > +	wr_assign(p, v);		\
> > > +	p;				\
> > > +})
> > 
> > This requires that wr_memcpy() (through wr_assign) is single-copy-atomic
> > for native types. There is not a comment in sight that states this.
> 
> Right, I kinda expected native-aligned <-> atomic, but it's not necessarily
> true. It should be confirmed when enabling write rare on a new architecture.
> I'll add the comment.
> 
> > Also, is this true of x86/arm64 memcpy ?
> 
> 
> For x86_64:
> https://elixir.bootlin.com/linux/v5.0-rc6/source/arch/x86/include/asm/uaccess.h#L462
> the mov"itype"  part should deal with atomic copy of native, aligned types.
> 
> 
> For arm64:
> https://elixir.bootlin.com/linux/v5.0-rc6/source/arch/arm64/lib/copy_template.S#L110
> .Ltiny15 deals with copying less than 16 bytes, which includes pointers.
> When the data is aligned, the copy of a pointer should be atomic.
> 

Where are the comments and Changelog notes ? How is an arch maintainer
to be aware of this requirement when adding support for his/her arch?
