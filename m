Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CB2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPRtilaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfBZSIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:08:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfBZSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OLYD9DPOQKik+9x7emIDBF5clSQyO9kvHM+XWhyrMDY=; b=tPRtilajaF+1p/qdPwWq9qIqh
        rWB9rU/6+P36LEwUm+8XAuKj/+VcYhWJJ/tSAi7XqUIRPZxW4SeWqYzyatUXPtxmiSk2XvNyYVTFH
        qBkKSf+pRpDmN3sVY88pd/WUyNmRcDtD/61nweNcgxY7Jr/FCmJDPAhmq+G3r0LKrlZnjOBD1Yn2+
        u2kgQfKr8/ihc1gMXpTi88szwQrMMUOeDECSPH83TxqAXy8niDmJBtyb1neFH/4yMEp3CjOtZO88u
        vWSIPnEpfxCrmbozw7HV+dlDgdoBpsYCWvNVpUZpoc0bZXXyg3TopKhKK6bmGX61fESfmE0pdEqjv
        D4XALjvKA==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyh9D-0002lv-HZ; Tue, 26 Feb 2019 18:08:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5E1F984351; Tue, 26 Feb 2019 19:08:02 +0100 (CET)
Date:   Tue, 26 Feb 2019 19:08:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, mingo@redhat.com,
        will.deacon@arm.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190226180802.GM2861@worktop.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
 <20190215022658.GB21045@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215022658.GB21045@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:26:59AM +0800, Ming Lei wrote:
> There might be lots of blk_flush_queue instance which is allocated
> for each hctx, then lots of class key slot may be wasted.

What is 'lots' ? for someone who doesn't really know all that much about
the block layer.
