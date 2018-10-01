Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4282089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4282089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeJAXz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:55:28 -0400
Received: from foss.arm.com ([217.140.101.70]:53062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJAXz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FF61596;
        Mon,  1 Oct 2018 10:16:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1E893F5B7;
        Mon,  1 Oct 2018 10:16:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 799611AE3C57; Mon,  1 Oct 2018 18:17:04 +0100 (BST)
Date:   Mon, 1 Oct 2018 18:17:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] locking/qspinlock: Re-order code
Message-ID: <20181001171703.GD13918@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.401531130@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926111307.401531130@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:01:18PM +0200, Peter Zijlstra wrote:
> Flip the branch condition after atomic_fetch_or_acquire(_Q_PENDING_VAL)
> such that we loose the indent. This also result in a more natural code
> flow IMO.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/qspinlock.c |   56 +++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 29 deletions(-)

I think I actually prefer the current code flow, but that's probably just
because I'm used to it and I don't have a strong opinion about this, so:

Acked-by: Will Deacon <will.deacon@arm.com>

given that this looks correct to me.

Will
