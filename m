Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C523C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C1120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kBFXa3dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C1120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbeGSS1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:27:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbeGSS1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OA7Df0Nbv+XXAQSk3gA5cLLOYBsbk3TxPIN5+JRPH2w=; b=kBFXa3dglj0otcng+gdJjGMik
        nPH5HU3nBK2a36N75+1Fr+giC7euD9WNY58yF4vXW7F17qO20D9762KmuR8OH74SzMoRJFkehFWZw
        rRUVaJvYd/EjJTHKHTWV2hSewbDkOfvxzEOW6QNthpLQ3nxw/wDY+BdKO64qC9ghTNGa/V4QI5922
        /MnGJTE3ASQXHDvf/B/HGvWWOsiK2zlI3Ws8a5RFyIeFoCPcdsN6oqGkeM4SptyXi1qp4d2vUuuXx
        MXibTqCEZ54C1P1L0+bc93KlFzD1kvFsk99yNn7CLnsmaCIHk61Zby/8NxihnSZuzUpQVTVBeUeJ6
        42//T8FMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgCxO-00050g-4f; Thu, 19 Jul 2018 17:43:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97FA520277352; Thu, 19 Jul 2018 19:43:11 +0200 (CEST)
Date:   Thu, 19 Jul 2018 19:43:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame
Message-ID: <20180719174311.GK2494@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719153347.buoe6pavpqc75zbb@treble>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:33:47AM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 19, 2018 at 01:33:54PM +0900, Prashant Bhole wrote:
> > Hi Peter, Josh,
> > 
> > Found following bug. This bug can not be seen with this fix:
> > https://lkml.org/lkml/2018/5/10/280.
> 
> Peter, care to clean that up and submit it?

Ah, thanks for the prod. Yes I'll go clean that up.
