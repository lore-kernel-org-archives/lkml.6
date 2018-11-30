Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56392C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CD22145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kp7UmdOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CD22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeLAClN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:41:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLAClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8y1i/0D1pNsLQm2/2jZX3n78ngQx7goYbP1rqCaG2M4=; b=kp7UmdOi/B2YM5+CXM6rrH/uO
        mYgMAOj00uEzHskVbauNdA+/Kt6MuSsFbMO+D3NIHMZzVTb709wnYice/bWJDpwzJ1EhIC+VwlyTW
        BgewAM1NPTOtDR6P58MUQsbYvqAfnRlnUZjR9WqLk3JxNnpewxqS9YJx8EfEeuZPehmgn4P/7FfCC
        3tBlhsM3rXWtr1MSpiUoqxCJtrnXPJGzsOokFigNbQvqDNvB2J9PKpF5YmhE9Ho/plq8Jfbt/oIOo
        W9NYNMgplSgg9MiWDof3OLyhmRCX5yNymkzE2BIgGbfKJShSck6j9cTg50X77S6M9Nc109TQobixD
        wmgqONxog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSklN-0004Wi-Cb; Fri, 30 Nov 2018 15:31:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D15A2029FD58; Fri, 30 Nov 2018 16:31:28 +0100 (CET)
Date:   Fri, 30 Nov 2018 16:31:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181130153128.GB11650@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130152347.GB11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:23:47PM +0100, Peter Zijlstra wrote:

> Hurm.. no. They apply cleanly to Linus' tree here.
> 
> linux-2.6$ git describe
> v4.20-rc4-156-g94f371cb7394
> linux-2.6$ quilt push 4
> Applying patch patches/peterz-cpa-addr.patch
> patching file arch/x86/mm/pageattr.c
> Applying patch patches/peterz-cpa-fix-flush_array.patch
> patching file arch/x86/mm/mm_internal.h
> patching file arch/x86/mm/pageattr.c
> patching file arch/x86/mm/tlb.c
> Applying patch patches/peterz-cpa-fold-cpa_flush.patch
> patching file arch/x86/mm/pageattr.c
> Applying patch patches/peterz-cpa-clflush_opt.patch
> patching file arch/x86/mm/pageattr.c
> Now at patch patches/peterz-cpa-clflush_opt.patch
> 
> Weird.

I pushed them out to:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/mm

I hope that works; I'm out for a few hours, but should check on email
again tonight.
