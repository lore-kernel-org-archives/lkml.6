Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91551C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FF220855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHkpfBoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfA3OVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:21:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfA3OVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tdEG+MKzTG+afEyamSwnqbIz4Gr3gzvattFq+YOW3xg=; b=GHkpfBoK7F+3EI4b0I3os8+Pw
        tNgrFs039sCghNUrQgSFQp1PLPBoDOQn+N0B89hD/3GL2GgvzdfZx/fKvxuV5FFWE2JQdJrHKIzJm
        ytJ2HkQgLW03jaTyRBCD0Wv7hbY05WbEEddfj4DU3my+vwvNy4f2QJKUsxEv4H8KLGTIVjFcc/30S
        sLXUBiqX7v5ZdCZK/SsWYHAfIqSj1ZUt3t0bktHZOxohbsxiwMi3phn7Ps3W/1gVad3qxIB/B6irJ
        LF6aR0+vHf7bBvitq+HAvOA5w0vwf6Hvr/1KFhFuVLuoHFXSb1M0HwbwkeQDhql3Kk+tiIJ/tH0/1
        30uQSkpvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goqkP-0004O1-Kt; Wed, 30 Jan 2019 14:21:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F093220160355; Wed, 30 Jan 2019 15:21:47 +0100 (CET)
Date:   Wed, 30 Jan 2019 15:21:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        stern@rowland.harvard.edu, keescook@chromium.org
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Message-ID: <20190130142147.GD2296@hirez.programming.kicks-ass.net>
References: <1548847131-27854-1-git-send-email-elena.reshetova@intel.com>
 <1548847131-27854-2-git-send-email-elena.reshetova@intel.com>
 <20190130123131.GA20517@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130123131.GA20517@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:31:31PM +0100, Andrea Parri wrote:
> On Wed, Jan 30, 2019 at 01:18:51PM +0200, Elena Reshetova wrote:
> > This adds an smp_acquire__after_ctrl_dep() barrier on successful
> > decrease of refcounter value from 1 to 0 for refcount_dec(sub)_and_test
> > variants and therefore gives stronger memory ordering guarantees than
> > prior versions of these functions.
> > 
> > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> 
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thanks, got it queued now.
