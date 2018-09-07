Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8058720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhmoyqen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIGW6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:58:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46026 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIGW6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:58:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id b78-v6so1176057vka.12;
        Fri, 07 Sep 2018 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f2XDJjI+/M5Kh2tkLlEoxdeUARDx/KvB6NLctANHFrE=;
        b=Hhmoyqenc5rn1vIHBAuVQHQvvwY0zpk5qZq61vM0e4kqpSGAdR/LZV2szSIg5WHPpM
         GFlgv+Cgbe7f9aHIuLsrY/2uMX8OJneIacCGx84Et3lexY62WOP75qqPp9Y1rJqnkKhv
         rFadNJhyV9YCD0bC+rSwgVoYhnn4dHz2zqr0FvydysaQsu4OgFj7/VSjVUAfwp2XvW6N
         52vyCOKgwg/5nzwFfhC9j4zu3Qqc5ebVYSkXP/Z4MuRz7hTnV/LY2dg8cLPQvbOI3IJT
         TSRRioL9YThMYt7N9LsKb5kXS7+e7L+dPsuBvgqSjIHa4zKBgpy1JwLJvP2TpKSwoH/p
         Wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2XDJjI+/M5Kh2tkLlEoxdeUARDx/KvB6NLctANHFrE=;
        b=p5HCPEvQb5CHVj7ir92yIsWrti4gMa0geF+cKQbsP33BuXJu7vN0Ja6/y3odq+AZN1
         BGmseLSIg5LczDAG7I74qSmni2+5iiJCVe90B4ILEOv8cSjOzQrGahI+6Dj3/SOAYzL0
         DRDZhZJiv/lygpjA5DGhb/rJlcIuRUGvlOFaB+DFloIOtBhcRv1Dv8ym38squTnW2llV
         yfJ66+A9JvgOrHrfQLKWZVjF1UllPZ+XUeqlN8zVTp2MD7t1xyAoqTVjwhYdzvSO7DS8
         Tp8JaSbGQQ8zgk1s3R0KD+ZuF/0x9UmtBqp2P/xeswuCMkFLAIdCYu3Q8HTH172ZRJp6
         Vfsw==
X-Gm-Message-State: APzg51Cx/ffWBl1cB6d4fuwGO3iHKOuZ+AA9fi5Kfm1zGkaFFY8kiQKH
        yzcKo5ok2yHReKkSjce9Fw==
X-Google-Smtp-Source: ANB0VdbBDkijrCS3/UcqBWbXvXhYb63itgpKAaX+ZkMSP2SzfDxOstvDVBs2I8ifZmMWWM0d6z08JQ==
X-Received: by 2002:a1f:9945:: with SMTP id b66-v6mr3028526vke.100.1536344174334;
        Fri, 07 Sep 2018 11:16:14 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id o33-v6sm1727216uac.1.2018.09.07.11.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 11:16:13 -0700 (PDT)
Date:   Fri, 7 Sep 2018 14:16:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: [PATCH 2/6] md: convert to kvmalloc
Message-ID: <20180907181610.GB29485@kmo-pixel>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-3-kent.overstreet@gmail.com>
 <20180907174942.GB3425@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907174942.GB3425@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:49:42AM -0700, Matthew Wilcox wrote:
> On Fri, Sep 07, 2018 at 12:56:31PM -0400, Kent Overstreet wrote:
> > @@ -165,7 +164,7 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
> >  		       struct dma_async_tx_descriptor *tx)
> >  {
> >  	int disks = sh->disks;
> > -	struct page **srcs = flex_array_get(percpu->scribble, 0);
> > +	struct page **srcs = percpu->scribble;
> >  	int count = 0, pd_idx = sh->pd_idx, i;
> >  	struct async_submit_ctl submit;
> >  
> > @@ -196,8 +195,8 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
> >  	}
> >  
> >  	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
> > -			  NULL, sh, flex_array_get(percpu->scribble, 0)
> > -			  + sizeof(struct page *) * (sh->disks + 2));
> > +			  NULL, sh, percpu->scribble +
> > +			  sizeof(struct page *) * (sh->disks + 2));
> 
> I think this would read better written as:
> 
> 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
> 			  NULL, sh, srcs + sh->disks + 2);
> 
> >  static addr_conv_t *to_addr_conv(struct stripe_head *sh,
> >  				 struct raid5_percpu *percpu, int i)
> >  {
> > -	void *addr;
> > -
> > -	addr = flex_array_get(percpu->scribble, i);
> > -	return addr + sizeof(struct page *) * (sh->disks + 2);
> > +	return percpu->scribble + i * percpu->scribble_obj_size +
> > +		sizeof(struct page *) * (sh->disks + 2);
> >  }
> >  
> >  /* return a pointer to the address conversion region of the scribble buffer */
> >  static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
> >  {
> > -	void *addr;
> > -
> > -	addr = flex_array_get(percpu->scribble, i);
> > -	return addr;
> > +	return percpu->scribble + i * percpu->scribble_obj_size;
> >  }
> 
> Perhaps this would be better as ...
> 
>  static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
>  {
> -	void *addr;
> -
> -	addr = flex_array_get(percpu->scribble, i);
> -	return addr;
> +	return percpu->scribble + i * percpu->scribble_obj_size;
>  }
> 
>  static addr_conv_t *to_addr_conv(struct stripe_head *sh,
>  				 struct raid5_percpu *percpu, int i)
>  {
> -	void *addr;
> -
> -	addr = flex_array_get(percpu->scribble, i);
> -	return addr + sizeof(struct page *) * (sh->disks + 2);
> +	return to_addr_page(percpu, i) + sh->disks + 2;
>  }
> 
> 
> The rest looks good.

Need some casts (to void * or addr_conv_t *) but yeah, I suppose that's a bit
cleaner.
