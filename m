Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2uHKSh0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfAKIfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:35:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfAKIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kelrXQbBqMPVfWfGI5pGtG3Jl+7CnczQ99qnwIjZpwE=; b=2uHKSh0RwLwypTW6BjePTXdFN
        tewk8QV1SiA6drbcQ8CKX6FYr5vbEY6XEc9GeVbMkAuYMZ/j2forQMRtb5TYFEs/kU3PBuGfCCUWh
        LtkAlxPi49ysUBMIk7kVfWGxldajl3YnTowfvkF25b7iBwcJkeJ0jrNFZjYyrj+WS5SNcdScT0dK5
        RqP4JGTRdwArz15tWqlDX1XYYNmhQDqvGSDb3IwZ8Scsqt2iva5UnZpXGQLFBva6AVbSXOko9njNV
        T72qj7P2vWgwvQR/8C6aM12seMe/5y63Tmj9kS8SwmMwIyO/UBTo1ZEV3FRdcWlXQ57jBbjdhhw0U
        UbGWcYw3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghsHt-0006BX-Pg; Fri, 11 Jan 2019 08:35:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12DC620280450; Fri, 11 Jan 2019 09:35:31 +0100 (CET)
Date:   Fri, 11 Jan 2019 09:35:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190111083531.GN1900@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
 <20190110152412.GG30894@hirez.programming.kicks-ass.net>
 <1547146287.83374.49.camel@acm.org>
 <20190110194459.GD2861@worktop.programming.kicks-ass.net>
 <1547157401.83374.59.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547157401.83374.59.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:56:41PM -0800, Bart Van Assche wrote:
> Hi Peter,
> 
> Now that I had a closer look at your patch I think the approach of your patch
> is fine. Sorry for the confusion.

No problem; I'll try and write a coherent explanation in the Changelog
to help future readers.
