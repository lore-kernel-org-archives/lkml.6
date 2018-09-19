Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCFFECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ADE2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TuqaPuzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ADE2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeISSuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:50:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbeISSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6dcC8t6gmgVjP4fCkb+Kcyg1MQCNKjdgUj5V7h7KPws=; b=TuqaPuzZZpAgaCuU2ydiFjFXQ
        VbUbymInmdHkY9KYrQTSGY78VM05S6rI8krNbHXoLHBuIyRCf0n3pbIoSjgLrTZ7wJcC307hxtMEr
        g9mWsfHFZJ/qtEhpUGEepjBU9lax0CTEFQjaSqZqW7ZGcvh/mk+h6q2lWukaRq9rH2DloKBuDbZr5
        H7G9vCFaOe5Ez1+zvDCAEYTjODGXkdcvMP534ocjk/JvKwQv7awSbJ3lV4LVX/M7cYnAUPlpFHjRn
        iiMuDtNOaP4lu9FJYnM+k43KNk2GQ2GmvLEBvSE0gELA5gddNzbhWkfdEppUhO1zG5iRpfKS2XIZP
        DC+uwmLMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2cHo-0007on-2V; Wed, 19 Sep 2018 13:12:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BC062024E448; Wed, 19 Sep 2018 15:12:54 +0200 (CEST)
Date:   Wed, 19 Sep 2018 15:12:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919131254.GI24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
 <20180919115158.GD24124@hirez.programming.kicks-ass.net>
 <20180919122328.GB22723@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919122328.GB22723@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:23:29PM +0100, Will Deacon wrote:

> > > > + *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
> > > > + *    the range that needs to be flushed to cover the pages to be freed.
> > > 
> > > I don't understand the mention of need_flush_all here -- I didn't think it
> > > was used by the core code at all.
> > 
> > The core does indeed not use that flag; but if the architecture set
> > that, the range is still ignored.
> > 
> > Can you suggest clearer wording?
> 
> The range is only ignored if the default tlb_flush() implementation is used
> though, right? Since this text is about the fields that tlb_flush() can use,
> I think we can just delete the part in brackets.

Well, any architecture that actually uses need_flush_all will obviously
require a tlb_flush implementation that looks at it.

But OK, I'll remove the note.
