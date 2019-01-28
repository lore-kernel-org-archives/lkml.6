Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7644C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB43C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBKaNdEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1Nmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:42:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Nmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A6LAgfPo5GkGB4QxpBbUfytfHIS3qjXW70hijo+Ppe0=; b=hBKaNdECLSXTaIvJXh/0A8YlC
        8yk8wyD9gNLq7vyD5FHMiRV/7CikMv7jlI9+++VIN7y5Dnd+OV6eRYDYc6HcC8EOyduoi8BLyDpn2
        gqsX7ueJb6HhoXj0iLn1tqSWELb8srEftu36iztxOYv7rkYx6Ve5K6JovquvZNaBIjfZjxY3QaB0X
        g2hdt0UmV3lUlwb4lRw2vhB9oBIMuSE2Gcun6nvffurF4cd1QqFZiVypYr4mf1RI2DPXpdf1HuGtG
        eU84MC4SIaf7kB5g9IHFV0Bta0raE7H44TOuUZuNqMek36QUOzzXyqmu6uZ81KGTzXwt7mfXpsiWn
        ZPBE4pIZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go7BS-00049H-9V; Mon, 28 Jan 2019 13:42:42 +0000
Date:   Mon, 28 Jan 2019 05:42:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH trivial] kernel.h: Make container_of_safe type safe
Message-ID: <20190128134242.GA10951@infradead.org>
References: <20190124205451.GA19634@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124205451.GA19634@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:55:05PM +0000, Jason Gunthorpe wrote:
> The final ternary expression is given void * and type * as arguments, so
> the resulting type of the macro ends up being void *.
> 
> container_of returns a type which maches the argument, this provides type
> safety and allows the expression to be immediately used as the target
> type.
> 
> Explicitly cast ERR_CAST() to get the correct type.

I think we should just kill off container_of_safe - it has no user
in the tree, is grossly misnamed and not really all that useful to start
with.
