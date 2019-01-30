Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61917C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328B218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXYKhba0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfA3OHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:07:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3OHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mFtZD8FsU9SByejnKSVGuz8wbKXwfjkZMYtckQtLX1w=; b=VXYKhba0YUBBmaTsFL/Q9f08z
        sFszIv1CO+KAYIGv4IUoadYL58PDGbco+Jr183YOwIpcijh/BdCWLHXEBFjiO87uFlazBO4ZpvRG3
        qSc7GLn2DiNMtohEOiPZY23oBs8gWzH9DgewWzDJ6wS5XaWRPhx5nMs4CKNScgt6whoM7LCuKoHtE
        ETPVDTepvfzzlILlTLXBeJsl54nBChBYY/EKnYalpNxXqPfHCUv5el8MlZCYNOP0SdmAjJmodQXtK
        bnUjJxKFFkwrPkX5yZ3u30ijOsVeulsrNfUpjOL+E3IeM3HwGRBf3HxCxppbgQ83+96IVkxNNUcOf
        jly2agp5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goqWE-000262-BP; Wed, 30 Jan 2019 14:07:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1FFD2072FAD4; Wed, 30 Jan 2019 15:07:07 +0100 (CET)
Date:   Wed, 30 Jan 2019 15:07:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: [PATCH v3 0/4] locking/qspinlock: Handle > 4 nesting levels
Message-ID: <20190130140707.GC2296@hirez.programming.kicks-ass.net>
References: <1548798828-16156-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548798828-16156-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Waiman Long (4):
>   locking/qspinlock: Handle > 4 slowpath nesting levels
>   locking/qspinlock_stat: Track the no MCS node available case

I've taken these two,

>   locking/qspinlock_stat: Introduce a generic lockevent counting APIs
>   locking/lock_events: Make lock_events available for all archs & other
>     locks

while no real objection to these; I feel we should wait until there are
in fact more users of this.
