Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA390C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639CB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nKYva7pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfAONct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:32:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAONct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rNYZJdstk0VJsnEDcjmMM67KZsaGttnUKpGq+U6tqNc=; b=nKYva7pi8/U4bC413mckuhm15
        BKNAoFG4B2md10wmP+xj81K5kkGGBE9dk7R5lU3iQ8kuGWlbgr9KWFc7Q3RsxU1y6CSNjjAUp4H9s
        UOPgTmFJEsx2FADHkxMgD6ev9FWIbL6vhVC32nvjnZ6EyRWkX2z/W8lH8DrN56rHLkd/TllFJMFIg
        joFjHbcYfucQBenQOVnHHDJFY/scoYVHZBBdirXkqCjoqATs+aDfEnIRUbKNNPpbTg5r9juPbNHBJ
        3db1yZfyKGW6KZtAIGzIutLY05vH+bDfG3bur9vZhrpuJJtlP4flqfoHY8P5wqSydahiGoIyIqj1j
        moymhvZLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjOpf-0001Pw-Lb; Tue, 15 Jan 2019 13:32:43 +0000
Date:   Tue, 15 Jan 2019 05:32:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Rene Schickbauer <cavac@cavac.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190115133243.GB31202@infradead.org>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rene,

please switch to FreeBSD instead of advocating to violate the copyright
and licensing rule on my and others work.

Thanks you!
