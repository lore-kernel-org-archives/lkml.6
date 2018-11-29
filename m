Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B20C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8322B205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjCaZFhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8322B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeK2Xg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:36:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeK2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LePhLSWLyXrb3OZEjRo8IbuakXWg9i1RmtvCbcA7cfc=; b=YjCaZFhnXIOqghvqG6k/Es2px
        9E8yN9MXpO7g97VbOLODWxRg3HQtUNZjb8RvbZ2aTQ8geO7Z2tDZapEmTcz4J0FbQzZPIEzz8PhYf
        mq3Fg/5r+88NYhSDJV6tWxUJXFQ23c7q4QG+Noo74bZxEIA15r0FisuYwB0myt6RJwgr3WOPiz30K
        5o5phLX2x/xYrcVAr8oR5XLZDuF0f/uf7JvUpC9teqpGKfjUG57KfA8BeMafQFDwEMr3j5wd+C5qB
        ZRDUqfx6tNBsIQFKHAI471u65/HT7GZIGMSBs4vzxmTlUC/9VsKyztmRvJXvV8tb22EbmKkESjzlC
        dwc0HBTHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSLTp-0007yw-Sm; Thu, 29 Nov 2018 12:31:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CB4A2029FD58; Thu, 29 Nov 2018 13:31:40 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:31:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/27] locking/lockdep: Add support for dynamic keys
Message-ID: <20181129123140.GK2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:42:58PM -0800, Bart Van Assche wrote:
> Hi Ingo and Peter,
> 
> A known shortcoming of the current lockdep implementation is that it requires
> lock keys to be allocated statically and that this key sharing can cause false
> positive deadlock reports. This patch series adds support for dynamic keys in
> the lockdep code. I'm not claiming that this patch series is perfect. However,
> the code in this patch series survives nontrivial tests so I think it's worth
> a look. Two unrelated changes in this patch series are:
> - Improve the lockdep tests.
> - Complain if no name has been assigned to a lock object.

Looks very good mostly, and it improves the lives of people that like
modules too.

Thanks for doing all that.
