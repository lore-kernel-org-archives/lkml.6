Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CEA25507
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m85YQpns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CEA25507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeFYHMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:12:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeFYHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1/aHRg4m+rB4F+SEwxiSikylL790EFJfPlCgvt1zO00=; b=m85YQpnsdPVj4kV5N3PBlQKUr
        2mv5s91EUOG15wHVYQmNQG3XvWadm52YPArVWMY0R8C4zp7bo+1pvrQwsG+CApfhzNGfKRanKsTV1
        lMHKnmgkaR8IJKRxCF2fOPifOzlkuoVgsnSySdB0wnuRLDNneTclCVw9Slf/I0f5WgvSevn7iLEhW
        DHZH8X1m3xLHXmdguha03TBpJZZuW/jCobxZOPDdgd9Yqigb35BVITsi4CJayahjAl/uMkmHjs/+K
        2tBfvFBkxXYV+9Sj+6lDVWfPJSciPWq6AfBJnBL4xeGx4Wv13063GTjldrVUGujhDWI+Xx6nM++tA
        gWw+E4vsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXLff-0004fu-Qw; Mon, 25 Jun 2018 07:12:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5724A2029FA0A; Mon, 25 Jun 2018 09:12:17 +0200 (CEST)
Date:   Mon, 25 Jun 2018 09:12:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 4/4] kthread: Simplify kthread_park() completion
Message-ID: <20180625071217.GQ2494@hirez.programming.kicks-ass.net>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.266038375@infradead.org>
 <20180608095220.GA18941@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608095220.GA18941@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Fri, Jun 08, 2018 at 11:52:20AM +0200, Oleg Nesterov wrote:
> I am travelling till the end of the next week, unlikely I will be able
> to reply to emails or even read them.

Should I post a new version; with updated Changelogs for you?
