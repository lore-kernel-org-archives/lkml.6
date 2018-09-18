Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B7ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3022146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eadyFVdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3022146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIRMfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:35:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeIRMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OfyAuGrYxrQa87u9k5csTQ9EHSuaxjz43qblAFaabBo=; b=eadyFVdX0wNQgdEp0Utw2kCHH
        MNNScw9WLyj50SqSRKjl8gFvB3Agq/uQXyCVrrH50BJ8VyaLoPM33T+kHvVVdPJo5hDeptoyWtwDG
        /byPzSAQIgbLKR1fZkdFtPD4WldeyO8YWucr8pU/crYUYovxCWo0UeG3iGKsXDnPrMTviz5KyZ32a
        MohTRuS2u4B2c9H2+ekB3L5eRMm5Gyiy+RBzc/++icndV4zA+6ESz86xcVe0IA3hb4vTP9mLZpbpB
        FduqTGMKse8rxTVNYFdUePHPKk1JtXNvhj2KkL2uvMAEcakp81G8KBK/boaNkRsw90vjtohKLrJ5w
        2m3fvnSjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2A3C-0005IX-8X; Tue, 18 Sep 2018 07:03:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88C52202C1A36; Tue, 18 Sep 2018 09:03:55 +0200 (CEST)
Date:   Tue, 18 Sep 2018 09:03:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 02/11] x86/mm/cpa: Split, rename and clean up
 try_preserve_large_page()
Message-ID: <20180918070355.GG24106@hirez.programming.kicks-ass.net>
References: <20180917142906.384767038@linutronix.de>
 <20180917143545.830507216@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917143545.830507216@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:29:08PM +0200, Thomas Gleixner wrote:
> Avoid the extra variable and gotos by splitting the function into the
> actual algorithm and a callable function which contains the lock
> protection.
> 
> Rename it to should_split_large_page() while at it so the return values make
> actually sense.

Much thanks, that makes the whole thing much saner.
