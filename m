Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8502623E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trqem68b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8502623E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbeFYWxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:53:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeFYWxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mq70kXoICcQ56OIO0pAjFZqjeayotZjksbOEwj9j91Q=; b=trqem68bHIE+CbaxQHtxUHjUE
        fz0UgGgdDFw/pcxNPY3s8jQY2mIBCpD+mKTSxB11Zm41mHhdDW1petkuZ8wKQCHQxXVac+Nq+OCsr
        VZYOujrJ7Aa+tTMCqzsr8q/LZNpqj1fmrgJYDkyZppSUQ5sKkMl/dw/heA3iYSqdsZ3jpUNvUMbF+
        LNJKAtWWD2AAUGSR0kAJAgBVRs59RBCAIwRHIFknb/NvmbQGehCQDCXw1smXbihU2+nqbuBMymWCF
        PKnisdsbvmVRoR5ndPDwffeX3cEtoEf9gKuHgbyqbWtki752yvsYTBt9DoEnn9sTPouY3KmANzMkJ
        4UZSQT9tA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXaMa-0003hv-Qd; Mon, 25 Jun 2018 22:53:36 +0000
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix typos in __call_srcu() header
 comment
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
References: <20180625224734.GA10860@linux.vnet.ibm.com>
 <20180625224758.11300-1-paulmck@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b48dd53e-f032-3afb-cc48-f47db7e04ecd@infradead.org>
Date:   Mon, 25 Jun 2018 15:53:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625224758.11300-1-paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 15:47, Paul E. McKenney wrote:
> This commit simply changes some copy-pasta call_rcu() instances to

                                       ^^^^^ cute :)

> the correct call_srcu().
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  kernel/rcu/srcutree.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


-- 
~Randy
