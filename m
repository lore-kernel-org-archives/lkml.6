Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FECC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB422075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlLtdSvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeIGBUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:20:20 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33739 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbeIGBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:20:20 -0400
Received: by mail-yb1-f195.google.com with SMTP id m123-v6so4672405ybm.0;
        Thu, 06 Sep 2018 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJ0UPslJxrAbVKKtV6nvTniosPmHe+Z8otYVdfOdD3U=;
        b=TlLtdSvNi260eITMOW/emVb421ywK2n3dkfZEQR+EgqMdVIm2rDjoiCsIrwzIqTTAe
         Wywr5i66e5vKJc3Gg525voIrEISEKenkIEEmkGIqHcjFJ3zlzk5a/K6/R6rxM2n9Rq1g
         3gQqgKxkkOFZj3ixQdlG3T2TE8vAgt068FXeveCPUiiwLtau9dCfIAu+zOqmfOCOGfHK
         6Pt8a/LB/DIW+mxUuD4ifPogdmXfQRT6QWPSNKx08pGBmtd+C8HQ/MlpmltEQZt/mz0q
         eqCLoZ/vOe9y6Lw+xc+1A61SFzPxjBd6My9FGJCEC2Rc11hry/IwvWzfEztMdSb3Kp2o
         KyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJ0UPslJxrAbVKKtV6nvTniosPmHe+Z8otYVdfOdD3U=;
        b=onaVn1zMMle2DHsKM1Pr2q9BMx6/sGR0gYk3lYAld/jXBRPmjT0YjSumWZLTgTvtii
         nS5KybQmIoQNL+NxENjrMMP3sXYlgqDzfmcPEoawJpRaqk79XcsxZbXO5wGMc+mgEXYm
         ieXD3ghi/dojEBTstMUepG8Udk4sOw+63MqX8po4hVBBemLy4gI8jvCZvtB6ym+nSOAy
         Po1zOWvPp3ps64R57p7u0zruqIdGscLchXKr2j9wFsKmVnijgbggLQeTxrkn8ChRyL1K
         NrlhxZOkGPHtCmzUO6wZw9G1yP+oEWC8a0IJOAY9yx0cgIgOxwE+wN+KU/7cHnCL6YHm
         zS4g==
X-Gm-Message-State: APzg51DGYDOQ1NH68QhPIVRUV+CK1y1/UhD7KVxHPXJXGDGysu0KL5dJ
        zDZCQuqbzL4klMK2lNi6af4=
X-Google-Smtp-Source: ANB0VdY4c/95Ux64RFnQj1zvG5p1Cx5ozn2JoPkmWW8wAv2B1rEYbjmdG8Hlz5edp1f3sibnp0r65g==
X-Received: by 2002:a25:ba8b:: with SMTP id s11-v6mr2503471ybg.87.1536266588617;
        Thu, 06 Sep 2018 13:43:08 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:20a])
        by smtp.gmail.com with ESMTPSA id 200-v6sm2826445ywr.102.2018.09.06.13.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:43:07 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:43:06 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] blkcg: consolidate bio_issue_init and blkg
 association
Message-ID: <20180906204305.GB26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-8-dennisszhou@gmail.com>
 <20180831154225.zoiztxvdvcfaat5r@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831154225.zoiztxvdvcfaat5r@destiny>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:42:26AM -0400, Josef Bacik wrote:
> On Thu, Aug 30, 2018 at 09:53:48PM -0400, Dennis Zhou wrote:
> > diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> > index 22b2ff0440cc..9d7052bad6f7 100644
> > --- a/block/blk-iolatency.c
> > +++ b/block/blk-iolatency.c
> > @@ -395,34 +395,12 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
> >  				     spinlock_t *lock)
> >  {
> >  	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
> > -	struct blkcg *blkcg;
> > -	struct blkcg_gq *blkg;
> > -	struct request_queue *q = rqos->q;
> > +	struct blkcg_gq *blkg = bio->bi_blkg;
> >  	bool issue_as_root = bio_issue_as_root_blkg(bio);
> >  
> >  	if (!blk_iolatency_enabled(blkiolat))
> >  		return;
> >  
> > -	rcu_read_lock();
> > -	bio_associate_blkcg(bio, NULL);
> > -	blkcg = bio_blkcg(bio);
> > -	blkg = blkg_lookup(blkcg, q);
> > -	if (unlikely(!blkg)) {
> > -		if (!lock)
> > -			spin_lock_irq(q->queue_lock);
> > -		blkg = __blkg_lookup_create(blkcg, q);
> > -		if (IS_ERR(blkg))
> > -			blkg = NULL;
> > -		if (!lock)
> > -			spin_unlock_irq(q->queue_lock);
> > -	}
> > -	if (!blkg)
> > -		goto out;
> > -
> > -	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> > -	bio_associate_blkg(bio, blkg);
> > -out:
> > -	rcu_read_unlock();
> 
> Move this removal to the previous patch, so you keep this patch soley about the
> bio_issue_init.  Thanks,
> 

I've moved this removal to the previous patch and addressed the kbuild
errors.

Thanks,
Dennis
