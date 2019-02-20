Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F501C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCC2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QUbmgaDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBTVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:18:54 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45645 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:18:53 -0500
Received: by mail-pg1-f171.google.com with SMTP id y4so12532553pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=352hCjzdtbDQRJN5A6c5OQfIQDAbYMzidJIT37i/htk=;
        b=QUbmgaDnn4nD+Lqkn4sfbUqWUG2E3vo3XS6UoiuHFOZkU/FVpwyWyRtE5cEa12ts/z
         LALx232nzfVH0WYkPl6D9yHE6pDY90Lyxu6CUfo9EZxZbh+s/7+5ZCFcS9sFQMLUwR+n
         ZjsVDnLGQGl4R8TnXvzD1uatYXeqUC3dgf4odjCeYUkzD8mes93w7t92InhioHSTIMVS
         peqdv5uxk9d4zS6vxBbZuhzBmzhRBsw9VV/LUsvxeUFQuYaY94rpqV7TVz0jbnwGDFEU
         oSJTNjrXCREteFYSsYcY2XOovShx4UayOAOGubpSb/j7AwitxJpb415MDyDARFC3X1py
         I5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=352hCjzdtbDQRJN5A6c5OQfIQDAbYMzidJIT37i/htk=;
        b=TwEFy84XL2K/gZcavbRBQRY1/awUkvOE0gVQkw/j5naqE1JR+Wv4da08KOyujc5wcz
         MRNZUO/WCEEcCPlHqQWbZ1HMjTEnBqOF4cPomWBe72A1g4C2oKnXghonWiG1lqz3OnV5
         pdsdkk+TROoNiics37hAKePM/eBV1OfkaF8tOWu1GBLNdGyqFHqYO0NYXsV5kkZNQfF8
         FvGNumGOazphAmbd2QOTqZjvGiotQSeeKkuUMNlbB+I9xEiLPVTl15igSpeyh2/u67vB
         lfLRU1pSouWgxQUPRWpm6h+5y9AAe03rd9Eu8Nu4Q0e2o/IdnTARNnQxhdvdjAR720c4
         lqvA==
X-Gm-Message-State: AHQUAuY1lOUV0isEyHOm/fPhNvouq8vybuj3Gg5eCol0wcTKYb0/+TGV
        uPmeMDXza0j2WwnFKLFB2TSRCg==
X-Google-Smtp-Source: AHgI3IYPP/5TJbtCvMtnO72pGlVPSP5xRZy7CC10C4DAv3X6mGc6jXUZbPS3CC5bFLhr67+cxNhnfg==
X-Received: by 2002:a62:7602:: with SMTP id r2mr36605118pfc.191.1550697532508;
        Wed, 20 Feb 2019 13:18:52 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b65sm685298pfm.127.2019.02.20.13.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 13:18:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwZGU-0003oJ-Je; Wed, 20 Feb 2019 14:18:50 -0700
Date:   Wed, 20 Feb 2019 14:18:50 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220211850.GK8429@ziepe.ca>
References: <20190219235349.GA17351@ziepe.ca>
 <20190220012609.GC12668@bombadil.infradead.org>
 <20190220034627.GA564@ziepe.ca>
 <20190220171414.GI12668@bombadil.infradead.org>
 <20190220174333.GI8429@ziepe.ca>
 <20190220204726.GK12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220204726.GK12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:47:26PM -0800, Matthew Wilcox wrote:
> On Wed, Feb 20, 2019 at 10:43:33AM -0700, Jason Gunthorpe wrote:
> > On Wed, Feb 20, 2019 at 09:14:14AM -0800, Matthew Wilcox wrote:
> > > > void __xa_release(struct xarray *xa, unsigned long index)
> > > > {
> > > > 	XA_STATE(xas, xa, index);
> > > > 	void *curr;
> > > > 
> > > > 	curr = xas_load(&xas);
> > > > 	if (curr == XA_ZERO_ENTRY)
> > > > 		xas_store(&xas, NULL);
> > > > }
> > > > 
> > > > ?
> > > 
> > > I decided to instead remove the magic from xa_cmpxchg().  I used
> > > to prohibit any internal entry being passed to the regular API, but
> > > I recently changed that with 76b4e5299565 ("XArray: Permit storing
> > > 2-byte-aligned pointers").  Now that we can pass XA_ZERO_ENTRY, I
> > > think this all makes much more sense.
> > 
> > Except that for allocating arrays xa_cmpxchg and xa_store now do
> > different things with NULL. Not necessarily bad, but if you have this
> > ABI variation it should be mentioned in the kdoc comment.
> 
> I'm worrying about the whole xa_store(... NULL, gfp) situation.  Before
> I realised I needed to unify the XArray and the IDR (I'd originally
> intended to have the IDR be a client of the XArray the same way that
> it was a client of the radix tree), everything was nice and simple.
> xa_erase() was a synonym for xa_store(... NULL, gfp).  Then the IDR
> users showed up with their understanding of what storing NULL meant,
> and now xa_store(NULL) means something different depending what kind of
> array you have.  This sucks.  I'm tempted to have xa_store(NULL) always
> transform the NULL into XA_ZERO_ENTRY, but I worry I might break some
> users without noticing.

So you will end up with xa_store, xa_insert, xa_alloc doing the
conversion on store, and xa_cmpxchg not doing it.

I'd excuse xa_alloc/xa_insert, as anyone calling them surely means to
reserve the entry. The comment for xa_insert even says it does
this. Great.

xa_store(NULL) == xa_erase(), sometimes, is weird, IMHO. Two APIs
would be clearer: xa_store() which always does the XA_ZERO_ENTRY and
xa_store_erase() which always does xa_erase() if the argument is
NULL.

This makes the itent of the call site super clear without having to
find the xa_init and check the mode.

If this was done then xa_track_free() would only cause the mark to be
updated, or not, and has no other behavior change.

For completeness xa_cmpxchg() should probably get a similar comment as
xa_insert():

  If the predicate matches then a NULL entry will do xa_erase() on the
  index. Otherwise the value is stored.

  When matching the predicate the value NULL only matches unreserved
  entries. [this more or less matches xa_insert anyhow]

> > This is a bit worrysome though:
> > 
> >                 curr = xas_load(&xas);
> > -               if (curr == XA_ZERO_ENTRY)
> > -                       curr = NULL;
> >                 if (curr == old) {
> > 
> > It means any cmpxchg user has to care explicitly about the possibility
> > for true-NULL vs reserved. Seems like a difficult API.
> 
> I think the users know, though.  I went through the current users of
> xa_cmpxchg() and they're not the same users which are using xa_reserve()
> or xa_alloc().

Reflecting on this more, the use case I was looking at was basically

   // First thread here wins ownership of 'id' and does reserve
   ret = xa_cmpxchg(xa, id NULL, XA_ZERO_ENTRY)
   if (ret != NULL)
       return;

   ...

   // Can't fail
   xa_store(xa, id, something);

So that actually works better the way you have it.

Can always have another cmpxchg varient if a use comes up.

> > Also I would think !curr is clearer? I assume the point is to not pay
> > the price of xas_clear_mark if we already know the index stored is
> > marked?
> 
> If you find it clearer, I'll use 'curr'.  They're equal at this point anyway.

Yeah, it brings to mind your table more directly then having to also
work out that old == curr == xa_load ==> optimizing away unneeded clear

BTW, will you send conversion patches for drivers/infiniband sometime
soonish? Feel like I know enough about xarray to review them these
days

Thanks,
Jason
