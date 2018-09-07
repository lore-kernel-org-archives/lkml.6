Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD883C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E6120645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1VKss8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E6120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeIHBQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:16:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33955 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIHBQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:16:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id t10-v6so5924192ybb.1;
        Fri, 07 Sep 2018 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FT1JS+mP7s3H0ehWUhrZs7M0IklabbNNqY5+yLxrfIE=;
        b=Q1VKss8Lue+m3hZoEmC1iP9DFK/xjg8lz1z8J7Ujsr7HryEXQRC1lTg8wqGJFvxEO+
         bd6Jb9sfUf7vD4tNZT9y3zGccUxxhlimUzWYrXJuwB9/mafY4IGuHQxR0mAMY/8DVqKk
         XPbtVip+rWcYNrCiTrrmfWfHMAklxPNakcHRBTmKYMRkB1bUWmQqU3ur/ge1Obdv8mrK
         o2ZhlPouil/4ldzGShrmQDbafb2xbiaTEhebWY9C25oDyu8JjAGeXmn5OW4edWw48Ze2
         3543IoWePb2R+ECB4s6AqNpjWBWVtm1Da2qpk8YD3a2iOVqn81bdIt7Ii0P0psva5JXm
         NLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FT1JS+mP7s3H0ehWUhrZs7M0IklabbNNqY5+yLxrfIE=;
        b=kr1RdP94MBMQdAsp8gCvDMd4ASU/i1UsA5TeBLj794hofNsWWsIjyGDj4/qX7iPFIC
         f9yOgrn80fowUsYPjv+a5QfrIAyu7Hv9sVpr5hiX0dCgCptKt3RH6qD63wuljH1EMT/W
         Ha+wp08OHLFJBemkKy6lijCzr6crE491T5tgUksf1Jt1JlHqIwep/yAeQqhSXygEm/y3
         t+R1bKd9V5M8PKtlecUZgdJI3PbXe9iSeIqzHIiyXWHhldzRmqI0XdV7FWa+r/fAcWh1
         EbfSfArOzJH9ToxjrLdkTnThd4NfWe2O53iPHSa/8iZyWlIVI2wDWx2qT5j1t8rEVwCX
         UO3A==
X-Gm-Message-State: APzg51AuiDUTIxWUb8Lj5VXE9Xnfkvvo7/YE8iqqE+U8vkvex1v8m3Gz
        NIMWDWxvZwaTF85bGG6ncD8=
X-Google-Smtp-Source: ANB0VdZhMk63wCkNmzFCjoiOOwronigVI3zKb4S7J1AJ0wtM93WJIX4deqWsbe/uN8jEw3xe8mWbPg==
X-Received: by 2002:a25:cfd2:: with SMTP id f201-v6mr5127679ybg.317.1536352404475;
        Fri, 07 Sep 2018 13:33:24 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::9697])
        by smtp.gmail.com with ESMTPSA id o193-v6sm3430213ywd.84.2018.09.07.13.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:33:23 -0700 (PDT)
Date:   Fri, 7 Sep 2018 16:33:21 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180907203320.GB97913@dennisz-mbp.dhcp.thefacebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-4-dennisszhou@gmail.com>
 <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Sep 07, 2018 at 10:27:30AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 06, 2018 at 05:10:36PM -0400, Dennis Zhou wrote:
> > @@ -2021,9 +2021,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
> >  {
> >  	if (unlikely(bio->bi_blkg))
> >  		return -EBUSY;
> > +	bio->bi_blkg = blkg_try_get_closest(blkg);
> >  	return 0;
> 
> It prolly would be a good idea to point out that the associated blkg
> might not be the same one passed in.  Maybe this gets cleared up later
> in the series?
> 

Heh. I added comments everywhere else but the place it's used. Updated.

In hindsight though, it does make it a little problematic here as you
may have a different blkg than css. FWIW, it makes the next few patches
easier to read as they don't need to do nontrivial error handling that
will eventually be ripped out. And this is to really handle the edge
cases of OOM and dying cgroups. If you think it's worth fixing I can go
back through the set and adjust it all.

> > @@ -298,14 +297,23 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
> >  	while (true) {
> >  		struct blkcg *pos = blkcg;
> >  		struct blkcg *parent = blkcg_parent(blkcg);
> > -
> > -		while (parent && !__blkg_lookup(parent, q, false)) {
> > +		struct blkcg_gq *ret_blkg = NULL;
> > +
> > +		while (parent) {
> > +			blkg = __blkg_lookup(parent, q, false);
> > +			if (blkg) {
> > +				/* remember closest blkg */
> > +				ret_blkg = blkg;
> > +				break;
> > +			}
> >  			pos = parent;
> >  			parent = blkcg_parent(parent);
> >  		}
> >  
> >  		blkg = blkg_create(pos, q, NULL);
> > -		if (pos == blkcg || IS_ERR(blkg))
> > +		if (IS_ERR(blkg))
> > +			return ret_blkg ?: q->root_blkg;
> 
> Why not ret_blkg here?
> 

ret_blkg is only set if a parent exists. I can move that up to the
definition to remove the extra branch.

Thanks,
Dennis
