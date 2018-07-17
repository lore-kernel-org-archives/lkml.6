Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98744ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4723220BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmaOOPcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4723220BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeGQDLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:11:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGQDLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NHTTYKkayQ/9JS2jPzZ9dqFt2qqic5/uDioWFevfwaI=; b=WmaOOPcABwtzDDAP2VVqaseeh
        aQcte6LevjvNyDH7wyhWv7UR7yxksO+E0VAXx12EELWke02y0G8lIDYqHyWbNQ72JyfBQ2kh1OqFn
        c81Qv1IyOJOtEMi9DdiHvsXnHT6Lh2mQMj2r0uSFOWxeBbMWqB/0gLt/hro9Y/BJz2sQ3NtJL/FI5
        R8xJkHGc9bTJ6R6MxkNmxf9fnhBmDiXGPOy899W79Kkkd8HdMK/v96YpXKB3rYSAlfALwrpZe81S4
        9xMYRE43X86rO1R2BF8zr+InAM4mSkEaIMrJJsYTfcPvj6zeZHCk+BftDOiED7AnLKccwD4kYqE++
        9mUwEw1Rw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffFvg-0005xZ-E2; Tue, 17 Jul 2018 02:41:32 +0000
Date:   Mon, 16 Jul 2018 19:41:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180717024132.GC7934@bombadil.infradead.org>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
 <20180715230052.GA6486@bombadil.infradead.org>
 <20180716160710.GA2287@linux.intel.com>
 <20180716195249.GA14380@bombadil.infradead.org>
 <20180716210820.GA17164@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716210820.GA17164@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:08:20PM -0600, Ross Zwisler wrote:
> On Mon, Jul 16, 2018 at 12:52:49PM -0700, Matthew Wilcox wrote:
> > On Mon, Jul 16, 2018 at 10:07:10AM -0600, Ross Zwisler wrote:
> <>
> > OK ... what version of make are you using?  Because this works fine for me:
> > 
> > $ git clone linux clean
> > $ cd clean
> > $ git checkout v4.17
> > $ cd tools/testing/radix-tree/ 
> > $ git revert 8d9fa88edd5e360b71765feeadb915d4066c9684
> > $ make
> > 
> > $ make --version
> > GNU Make 4.1
> > Built for x86_64-pc-linux-gnu
> > 
> > It's Debian's Version: 4.1-9.1
> 
> $ make --version
> GNU Make 4.2.1
> Built for x86_64-redhat-linux-gnu
> 
> The one from Fedora 27.

Huh.  I just tried 4.2.1-1.1 from Debian unstable and that doesn't
produce the problem either.  I'm not sure how to proceed at this point.
I'm really not a makefile expert.

