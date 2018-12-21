Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F12C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81E621927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+Z02Nk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbeLUOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:48:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403893AbeLUOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZnXtK86vehQg5v88LjMKiev44fjihYkPrPg5wUFELQk=; b=N+Z02Nk9E6nwnrFxsiwUz185R
        aT/UmP0VcXS4JJwQQe7RsR47GIiUGHLvnYYcpRd4UNbUAdrJcusc0hziEMWXwvwZrAvj5K4HZYcQz
        xeuR03Bl07NDfWmO/VJPmcCDjquaqTWKYitSMofB1klvUV3qlSCxJck+uQ3aSxuRZzBGIeQlAiLWn
        4FNcYCFmAKdzt54R1hMXLmWTcvmOnbjrcoRdi1JLwhPfABYRqDXOuWtOAv/3ivNhONNqPqrac3suf
        ZmVKaRg/gwWpEVntf9MPHfVHYlNwpGBke2pwS4NV8Es3163YFiQ3d3M4jFQPXquNXbJvWoDT1Ey4j
        GX8iIv17Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaM6S-0003h1-QI; Fri, 21 Dec 2018 14:48:40 +0000
Date:   Fri, 21 Dec 2018 06:48:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: Refactor readahead defines in mm.h
Message-ID: <20181221144840.GB10600@bombadil.infradead.org>
References: <20181221144053.24318-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221144053.24318-1-nborisov@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:40:53PM +0200, Nikolay Borisov wrote:
> All users of VM_MAX_READAHEAD actually convert it to kbytes and then to
> pages. Define the macro explicitly as (SZ_128K / PAGE_SIZE). This
> simplifies the expression in every filesystem. Also rename the macro to
> VM_READAHEAD_PAGES to properly convey its meaning. Finally remove unused
> VM_MIN_READAHEAD
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
