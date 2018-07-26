Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE12C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628020857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VD+TPCTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1628020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeGZQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbeGZQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S0Ba/XILZM+5NKwvnAg/BW4PQkb0whah8cGJV3AxGQ4=; b=VD+TPCTTES5f+jWPfPCkWhpA1
        vFg1qpLH8NXV/42qRpmOMHOQkg9P9pvTq8hZRIpE38eXI3U0KoV/ogcnC4EAtBFQ/0kdWWO13ZVry
        aA9t0jwLhPmU9Q982CJ/LP4K8n1V8hCjXw+3DMp6f4xVlzeOzh95aPzyZgC2btiRXTXc31B6+LQnX
        ZoKnp+6/YsqRz8thA0MWqrBNGg+HrPe/xsXERgpcvz1nwBaqtJ7fy7OGNeSB5+Ie884px361fFGah
        ymre/AxT4T4IgR4NoCHxerE8uyGeuffuOSg7ccjInKj6MZKifxDHQMGaQ2EkUAQVtuDrgQvlpg6y9
        kTn2eae4Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiiJD-0007qM-8G; Thu, 26 Jul 2018 15:36:07 +0000
Date:   Thu, 26 Jul 2018 08:36:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] docs/core-api: mm-api: add section about GFP flags
Message-ID: <20180726153605.GB27612@bombadil.infradead.org>
References: <1532607722-17079-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726130106.GC3504@bombadil.infradead.org>
 <20180726142039.GA23627@dhcp22.suse.cz>
 <20180726151852.GF8477@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726151852.GF8477@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 06:18:53PM +0300, Mike Rapoport wrote:
> On Thu, Jul 26, 2018 at 04:20:39PM +0200, Michal Hocko wrote:
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

I'm totally OK with that.

> Some grepping shows that roughly 80% of allocations are GFP_KERNEL, 12% are
> GFP_ATOMIC and ... I didn't count the usage of other flags ;-)

;-)  You'll find a lot of GFP_NOFS and GFP_NOIO in the filesystem/block
code ...
