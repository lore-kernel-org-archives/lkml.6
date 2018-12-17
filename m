Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E87C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6489F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dxsen0M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbeLQVJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:09:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=urV/xEq56lOIX3Pr7UC6nVHSgDMdRMCttx0YP8+MEZQ=; b=Dxsen0M2V/hFmoUlPQvTR3FGk
        yJhxtS9ioFcbgmOmYU7sB97pYQgRpN95cA0gqwyCzBVN1K1rS/6uB2oOXPMrkRtIXLNho68xEWtmF
        VSH8w1NvL0heTXuvkt3NON2kUNf6VMaIOkceA7IVJDKR2Vn4Ds7YIC0g5vg3ED5KcSmVH94Y8KHb4
        3p4v/XNTzVhvtFsk7HOyzIqAKOLdOkYpB1xdcCSaxcaOxC/al/PDCs4kGBF0Ebq/mqxRxTCxJb5NG
        bMl9YAoEq3CDY/PAJir9DaSE21tOYWrya7RKpyGRajQK4nWqf+EI3G/aOd0K9b+eJtEJZaHq05bQa
        k4QqL2AAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ08Y-0007Vl-7c; Mon, 17 Dec 2018 21:09:14 +0000
Date:   Mon, 17 Dec 2018 13:09:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        const@MakeLinux.com, joeypabalinas@gmail.com,
        arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags: Add more declarations
Message-ID: <20181217210914.GS10600@bombadil.infradead.org>
References: <154505048571.504.18330420599768007443.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154505048571.504.18330420599768007443.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:41:46PM +0300, Kirill Tkhai wrote:
> -	'/\<DEFINE_\(MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
> +	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
>  	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'

I don't know anything about regexes this complex or tags, but couldn't this 
be '/\<DEFINE_\([[:upper:]_]\)(\([[:alnum:]_]*\)/\2/v/' to catch all
DEFINE_THINGIES?
