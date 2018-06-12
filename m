Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2270C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F90208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BADuIwtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F90208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934147AbeFLROb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cDFbdyI7syqFisYIP6ZRaZKr+9RxcFhDJBS1fl6wPo8=; b=BADuIwtH8KJERqXxjGrX2+NDh
        o7jxCqh4k0ktv5hl/qP703m7UiGBb6BotZ1LICO8A4c8QuI+U4+jcrahIyzE4SP74Dk8Ddx2SQTbl
        +3DK2xEDeJeM98ZQzaI4THO80XWcigJG8fhAMSgY+FMcQYXRl8s6SKc6aFbEKWlnd10D4ilt7ABhI
        /Ios4RK75zbUlorPeifCNrAWiy7GW1ZxbhbPW5AF64sWL3axVb9s/1ccUL7qVepe1OMtFUftVtc/5
        cyk6hiMXUQJXrXGTVqmDn2Moqh2iI30Bg+Wb8iSDDvlcJ36tj9Iqk+VkEEFufTkBahXa9uwYb+Eyg
        jRStnLPSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmsA-0001eD-J9; Tue, 12 Jun 2018 17:14:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF8DF201EA7CB; Tue, 12 Jun 2018 19:14:20 +0200 (CEST)
Date:   Tue, 12 Jun 2018 19:14:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Quilt vs gmail (Was: [PATCH 0/3] sched/swait: Convert to full
 exclusive mode)
Message-ID: <20180612171420.GU12217@hirez.programming.kicks-ass.net>
References: <20180612083449.100099222@infradead.org>
 <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:47:34AM -0700, Linus Torvalds wrote:

> I do note how quilt emails are really hard to read, because that:
> 
>     Content-Disposition: inline
> 
> makes gmail think it's flowed.
> 
> Which works horribly badly for patches, surprise surprise.
> 
> So I really wish quilt wouldn't do that. It does smell like a gmail
> bug, but at the same time, why would you use "Content-Disposition:
> inline" when you don't have an actual multi-part email? So I do blame
> quilt too for sending nonsensical headers.
> 
> (Yes, yes, I see the "It is permissible to use Content-Disposition on
> the main body" in the RFC. But the RFC also makes it clear that it
> actually matters for how things are presented, so saying "ok, I'll do
> flowed" seems equally insane and equally technically RFC-compliant)

Quilt people, anything that can be done about that?
