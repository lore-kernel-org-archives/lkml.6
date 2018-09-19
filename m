Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14637ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD2D208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DF5rc1zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeISLZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:25:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3z5tt22JgIBxVr6tjVkyoQYzVdk4DYDXR5L4gOq9DJw=; b=DF5rc1zW6MqFznzjU10ZXzMY0
        +VjVrIE0SR4i6xoweljZUi0ewTyXf5Bjca+0HEk83c3yY3oHiRie3wN2tVvo5gL86xJ3T53jod/AN
        K/KRBPKy/cfy11LuaxpLCqbyTeBub/8kdNGMwan4eacEnob2HREGgm+qo2cJwZmh9WOodsTsMtIwD
        9lk0lm23HMLzi0Ut30O0WDThgzopR7W6eVcz7N1cWyJ0t0pscoyedUURDBlrO5aRSpdv2uAdjEAC9
        lX5ALsbMWtKhs81ZOw2BFMKtLKPihfO7APE+yp3F1H1mnQLcz7SIxgoKypErESjyHwvvzznP9b6rA
        1O7BMdQsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2VMB-0003d6-L6; Wed, 19 Sep 2018 05:48:59 +0000
Date:   Tue, 18 Sep 2018 22:48:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation
 into do_bounds
Message-ID: <20180919054859.GB32263@infradead.org>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918000546.12552-6-ebiederm@xmission.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct mpx_fault_info
> +{

Normal kernel style would be:

struct mpx_fault_info {
