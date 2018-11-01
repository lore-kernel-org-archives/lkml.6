Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64090C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C9420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VCbFfad1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C9420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeKBB4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:56:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeKBB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C1OJkFUK0Px5o2OAWm79FhBuhFJ7D31olmNSiCtJuj8=; b=VCbFfad12xfBvwF8B68hXH9Qm
        qy5bL40Cw77yHyBkG2t83Z/7GohsMPylqOivhdvUq6eCCQ9ZqNnqr8bMtbV9gvVSu3NTwaWOjfR6F
        DNO3iRYxVAhofamQ6LuYtN7xrVT/HjRIdrWxVOY/t5O2T6JCP/qLx/BmImYqv8aDvCSHQfURv+k5r
        dkYphh767jNQ5eW6p8D2Ewfcui5NuMv9gC45rFY1UTnVyHSdFovEj1BCzIDmDbFHtJ51VvuPiwy4O
        IXjJmU0LMe8Hq6VHtsJcOd/Sa0+fTpFNOHI6wQoM4yZGxbdONa9v5f38Kwy+IcNCjNwbNxpB8T/F2
        TUZrgTCdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIGCr-0005aW-H7; Thu, 01 Nov 2018 16:52:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2475B2029F9FF; Thu,  1 Nov 2018 17:52:27 +0100 (CET)
Date:   Thu, 1 Nov 2018 17:52:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: Introduce set_next_task() helper for
 better code readability
Message-ID: <20181101165227.GF3178@hirez.programming.kicks-ass.net>
References: <20181101164222.43015-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101164222.43015-1-smuchun@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



What if anything is the difference with v1 (which I found yesterday and
have pending testing).
