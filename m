Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622882146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ab9Dp8n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBTRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:43:36 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35582 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:43:36 -0500
Received: by mail-pg1-f172.google.com with SMTP id s198so12230909pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0udlmhiWG87/AJG5wJL2ObbI6Ln8J2oifRbK1Xz/liM=;
        b=Ab9Dp8n97GveuaRbNbzqcY23n3jyuYI+AlsFD5V4o58q/sC2lW+OV8VsMK6XsUdoUU
         0yvoCehIF9KoFLZjYA1kDSvEUoOCCqR6Pk8JpqcQTzwwdRQChWWy4J56DS9ojaJvzjEh
         XlW0pBl+dYcy5I2DazR0DKrK7MAHawtIwvTyPzMUxaA8DK56vIa/DnOo2iptJa8UMGu1
         h4Z1Q/FCjjpnL76PLHW0FHzXhKwVST5C/ccWE4+9/3QNomtkAOftiEI/hl5XYN6I5SYI
         vawAoXl9Kv7cRicgtydD5+mrW0sIeaq8BSOrXXEMXA4K89+iKk+iGjP0QYYcQWkdWpob
         bX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0udlmhiWG87/AJG5wJL2ObbI6Ln8J2oifRbK1Xz/liM=;
        b=GEC/VcaXzm/H0JIxer0S7kj0ybgxefuotgyAaN3xZcv6WeO9WK9Wx3ZUpKUoDCbLRP
         xsmuelyhuU7UvVN12Y+Xq2nPxnED3DSff17E2d1rUYZHhnmG3NPs4de8GG4p8zEDXjUO
         oVcFhkYLjExxIYZZZFGY/U2Cg2cg6g0ySeUtoMugUE8ZaQ4eulTQ3VeJCm5GrKqLAStS
         XcRknwnk05MSgUzLLGsUtb9BG+Tsc+mx9WYORyjfM+hqTzznTJ1QrAbEGhnB9uTsd4le
         EOCLlJzw6lR0a437dKdTEVgEbx7c/paMpFy5gmkIvlKidPoIg7lSIhK/cLmmZFII+Qib
         Hmiw==
X-Gm-Message-State: AHQUAubaoqF7a0c1BsccY6cgJTKC/kCAK9wlP5wM1d6hHLIkuQh23Cpf
        hnuphpeHd1eti/+5FLGrJNmaIgDSdtTTYw==
X-Google-Smtp-Source: AHgI3IYd8afweVFgU/ufaXuEC5roGq7GD3uKocCNSv4hvYJHUSnp52amgb7E9CZKvvwOW2QxLzsi+Q==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr36804689pfa.76.1550684615135;
        Wed, 20 Feb 2019 09:43:35 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k3sm21744096pfi.129.2019.02.20.09.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 09:43:34 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwVu9-0001AX-Ju; Wed, 20 Feb 2019 10:43:33 -0700
Date:   Wed, 20 Feb 2019 10:43:33 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220174333.GI8429@ziepe.ca>
References: <20190219235349.GA17351@ziepe.ca>
 <20190220012609.GC12668@bombadil.infradead.org>
 <20190220034627.GA564@ziepe.ca>
 <20190220171414.GI12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220171414.GI12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 09:14:14AM -0800, Matthew Wilcox wrote:

> > void __xa_release(struct xarray *xa, unsigned long index)
> > {
> > 	XA_STATE(xas, xa, index);
> > 	void *curr;
> > 
> > 	curr = xas_load(&xas);
> > 	if (curr == XA_ZERO_ENTRY)
> > 		xas_store(&xas, NULL);
> > }
> > 
> > ?
> 
> I decided to instead remove the magic from xa_cmpxchg().  I used
> to prohibit any internal entry being passed to the regular API, but
> I recently changed that with 76b4e5299565 ("XArray: Permit storing
> 2-byte-aligned pointers").  Now that we can pass XA_ZERO_ENTRY, I
> think this all makes much more sense.

Except that for allocating arrays xa_cmpxchg and xa_store now do
different things with NULL. Not necessarily bad, but if you have this
ABI variation it should be mentioned in the kdoc comment.

This is a bit worrysome though:

                curr = xas_load(&xas);
-               if (curr == XA_ZERO_ENTRY)
-                       curr = NULL;
                if (curr == old) {

It means any cmpxchg user has to care explicitly about the possibility
for true-NULL vs reserved. Seems like a difficult API.

What about writing it like this:

   if ((curr == XA_ZERO_ENTRY && old == NULL) || curr == old)

? I can't think of a use case to cmpxchg against real-null only.

And here:
                        xas_store(&xas, entry);
-                       if (xa_track_free(xa))
+                       if (xa_track_free(xa) && !old)
                                xas_clear_mark(&xas, XA_FREE_MARK);

Should this be

    if (xa_track_free(xa) && entry && !old)

? Ie we don't want to clear the XA_FREE_MARK if we just wrote NULL

Also I would think !curr is clearer? I assume the point is to not pay
the price of xas_clear_mark if we already know the index stored is
marked?

> > Also, I wonder if xa_reserve() is better written as as
> > 
> >        xa_cmpxchg(xa, index, NULL, XA_ZERO_ENTRY)
> > 
> > Bit clearer what is going on..
> 
> Yes, I agree.  I've pushed a couple of new commits to
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray

That looks really readable now that reserve and release are tidy
paired operations.

Thanks,
Jason
