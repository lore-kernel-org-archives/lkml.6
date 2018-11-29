Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D36C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3F820834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3f1jKtSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3F820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeK2VFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:05:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2VFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WvX5yiZotYVS6lFHbq2kEuRJXrZMMlgvPE8Kj83ES00=; b=3f1jKtSAkrVZNPbdIOrMOdGxY
        +eDatGIOfhPrL1SzLWrki3MCzseiHPpdXOQUzXnLh2dwidzvI/2ZzEtmF+ASErASQ4HoOrBqqdxYH
        vqS8BqceDdWSYM7bqkdCTvvHJ1Rk746UCkjZqWzs4aXt7CXVjBogcQBS5w3tCxmCBRw/avNkbJ7lD
        KIwMtqIUxzVXnP7k2eUxPKq8UeHoNqdIEf5tggSmQlXW0eZ8Mt9d9ZgmPs+OaaBzRczbc+7RBPg+z
        tZUZpi0cq7VMWEtnl9OocV0Vm8NACCRGt2GEDfHX2zgcMm2eF1V7IwtRfy+67p0CaesQ7lrEvFIds
        jwbKgU6mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSJ7U-00072Z-5I; Thu, 29 Nov 2018 10:00:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 935862029FD58; Thu, 29 Nov 2018 11:00:24 +0100 (CET)
Date:   Thu, 29 Nov 2018 11:00:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/27] locking/lockdep: Introduce
 __lockdep_free_key_range()
Message-ID: <20181129100024.GE2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-25-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-25-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:43:22PM -0800, Bart Van Assche wrote:
> This patch does not change any functionality but makes the next patch
> in this series easier to read.

Ooh, I completely forgot about commit:

  35a9393c95b3 ("lockdep: Fix the module unload key range freeing logic")

I was still thinking that all was broken... yes, I think I see where
you're going.
