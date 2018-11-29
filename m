Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566882145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PcRHs2Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566882145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeK3EFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:05:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3EFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M5aUyK4mIr+5pn7XI1TUHLc/MgGNQdA58pUInw6lvUk=; b=PcRHs2RrW/8st6BC2cmeJWB/r
        MUV9+QrZNf7bzZYpyJEZGjWCP1EbJZwHpEFDXct5Ta+4FttAS/mCsUl8bDTlvaXt8O8WieEg4OxMH
        GVvHBnF5uvYFegYHj/B3bAkMpEYtB1n91R1rz8GeNwZi8an2urJk8ILFYQDEaiPMq0zQIqZhEPIsk
        IFEWRjUn1157UKzMVbCjdrwtvWecZXXaX25/z+97hSdmvFEwUUEEjCw7vx1aLTqiK33AyQ82bLtf5
        XLlEDmX2rQPM5d8xAOMnWH5LESYWbSg0Bl96a0VgDCUzq3eMfPrLz1GldUE+x4bVdVTBKMQaWy1Cv
        hcsIho/mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPf7-0004lU-Dm; Thu, 29 Nov 2018 16:59:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB16B2029FD58; Thu, 29 Nov 2018 17:59:35 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:59:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/27] locking/lockdep: Check data structure consistency
Message-ID: <20181129165935.GB9027@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-24-bvanassche@acm.org>
 <20181129123039.GJ2131@hirez.programming.kicks-ass.net>
 <1543510202.185366.140.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543510202.185366.140.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:50:02AM -0800, Bart Van Assche wrote:
> On Thu, 2018-11-29 at 13:30 +0100, Peter Zijlstra wrote:
> > IIRC there were a few other sites in the series, please check them all.
> 
> OK, I will add braces around multi-line statement blocks. You may want to
> know that checkpatch didn't complain about missing braces.

Yeah, checkpatch is far from perfect. I think this recently got
documented somewhere though. Lets see if I can find that.

  https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de

Not sure what the status of that all is, but there goes.
