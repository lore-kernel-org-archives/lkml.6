Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99334C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D4A213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U042XaT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D4A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeJAWhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:37:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C6nsrFJ9whuEb9Un2iA7/Rye+yRRBPij6H7JEN+5Cc8=; b=U042XaT5a1FR5eZcPUMAyIGXC
        NOE+bMs+6BXHaL5hvJnvwBqOMes7UMpaH0Ekb2CzDGfkKlz5iXAILOx6JDYoq8KWX8DDqgQ3YMmNQ
        LREN6CVP6sS4tGNmwtAS1NgGmUZLOGEdieFkHBTJ6LLH9uw0nF6IjNESFYzue7bwKGZZAdvNg8orC
        w7u7odgf/aA/5zckrQE6ukM2qPcU6tzvFNknPOKJe+lVNsXtgQ5LiPYY3tLGOUuZDp/IolHBI2PgZ
        a6eZpcdJfgDs9aFuAa7a6de4xQXIlZa+lz1HIxwggd1XKv4E1GUlkpFGMtUBAFEMS9z3zF3iTYL8a
        8ahnO5kTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g70b8-0006ar-Dw; Mon, 01 Oct 2018 15:59:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3761B2075FAA7; Mon,  1 Oct 2018 17:58:57 +0200 (CEST)
Date:   Mon, 1 Oct 2018 17:58:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Subject: Re: [PATCH 1/7] x86/mm/tlb: Always use lazy TLB mode
Message-ID: <20181001155857.GK3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
 <20180926035844.1420-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926035844.1420-2-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:58:38PM -0400, Rik van Riel wrote:
> Now that CPUs in lazy TLB mode no longer receive TLB shootdown IPIs, except
> at page table freeing time, and idle CPUs will no longer get shootdown IPIs
> for things like mprotect and madvise, we can always use lazy TLB mode.

But that's only so at the end of this patch series; either change the
Changelog or the location of this patch?
