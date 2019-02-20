Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED1C21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G/3NysBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfBTDqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:46:31 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:33164 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBTDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:46:31 -0500
Received: by mail-pl1-f178.google.com with SMTP id y10so11503166plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 19:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sM/L3SAQWZpoMUv5GGkuvSzziV7oe/mKXTb644vHA/Y=;
        b=G/3NysBX65W59rB6IqhAWVdFozZJwOZhpqTiDRytr14Vn1fapUCyKUkB0XC6XZLEe0
         xIBpcc+eh1Ny3GYetkv8livdit3eeEqmGi8zakWHgdRRUXUKCMyz30QJcTTgslWoeP2L
         vCRIVDCt6JIeoIRiqGTlnmyMW3uciAFj1B7PXA9zs8gqN2DgXrnImkwCmmuPwNKltr+i
         qAH+YpnkwiPPSrVY7kDNxfCRJYOi8M3Si0AKTfVrObi+mYlQWXJ+pWgEuTsJsnNKs4nu
         3CXEmYtEx7z7PP8o1WwNmKuftmXTviuV4GUmVVkrC250GdjeH+grS2NkLu5GDLVTRYdd
         xA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sM/L3SAQWZpoMUv5GGkuvSzziV7oe/mKXTb644vHA/Y=;
        b=jlT2lgx6EHfIEDjWY1Ie+2v/BLshdjnjaToXDbVBf27uGcc1gbV/wwlX8Q0XninnMF
         llYWcsZkBebxB0Ps5wdOLdmN+b5Bdb2gySHpHIsZ2sGsWFErbrX7NUEg4KqZWqJ4FMDr
         yCnB8bu8rcSWWM3bbqwbmhW0WaRQglbzE1m6x/FfqG4SN/oGQANjgOiCyxA0qNRg1EU4
         reEefEOCluZ/jtOq3vN/dLpQCzNFFnNLKBQ4m1++pz/UqNp9vxUL53cY/rRbzpqSgish
         xgDp/Oj7JWU79QoYnLBBR1dxgeX09xbMndCDlSkYmctvgcbX1MaUieDn5GhGrg0M0XbU
         GeEw==
X-Gm-Message-State: AHQUAub37SfB6jenJ7mKDcIZ5Wb4H6404LUw7AC9VopElOX5SVyQ7Imx
        FIr6av6ieclu8xgn9pgeOCY4fjjbzRtH5w==
X-Google-Smtp-Source: AHgI3IZULUq2irryFoLNl35nPUygJAUThAqfYRnx+dBHWeNBkVGr8/QyxyeReUSzI7tD1CF/bkR52g==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr34732953plb.312.1550634390130;
        Tue, 19 Feb 2019 19:46:30 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b6sm1192124pfo.27.2019.02.19.19.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 19:46:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwIq4-00029W-0N; Tue, 19 Feb 2019 20:46:28 -0700
Date:   Tue, 19 Feb 2019 20:46:27 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220034627.GA564@ziepe.ca>
References: <20190219235349.GA17351@ziepe.ca>
 <20190220012609.GC12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012609.GC12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 05:26:09PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 19, 2019 at 04:53:49PM -0700, Jason Gunthorpe wrote:
> > Hey Matt,
> > 
> > Did you intend that xa_release doesn't work on allocating arrays:
> 
> That surprises me.  I'll take a look in the morning.

I think the issue is that this:

static inline void xa_release(struct xarray *xa, unsigned long index)
{
	xa_cmpxchg(xa, index, NULL, NULL, 0);

relies on the NULL actually being xas_store(NULL), but cmpxchg
transforms it into xas_store(XA_ZERO_ENTRY) when allocating..

So xa_reserve(), xa_release() and xa_cmpxchg() all do the same thing
for allocating arrays.

Perhaps this:

void __xa_release(struct xarray *xa, unsigned long index)
{
	XA_STATE(xas, xa, index);
	void *curr;

	curr = xas_load(&xas);
	if (curr == XA_ZERO_ENTRY)
		xas_store(&xas, NULL);
}

?

Also, I wonder if xa_reserve() is better written as as

       xa_cmpxchg(xa, index, NULL, XA_ZERO_ENTRY)

Bit clearer what is going on..

Jason
