Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F297C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA0D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfEQPOBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeIFT5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:57:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45815 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIFT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:57:50 -0400
Received: by mail-yw1-f65.google.com with SMTP id p206-v6so4196217ywg.12;
        Thu, 06 Sep 2018 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zb2t7fnEFpTNY92P+q79KIuwpqsi0lHQ8yrY3sayUYo=;
        b=dfEQPOBaSRiw1xlv2rsfYhgg1AgZjEGmxweeotaQt76RJ6rsw/kynSjJNQADcdre/b
         NYQx1xIVWWgu377YSlkvCTuowzC+Gw0ZvNfCj7ksqNwcJI3i3w+TRlnPQSDiNboj3Umx
         1uQi7QV3qgALw9D2eBzNZDS37Ts1bl6LMwuopKKkbAXs7O4cg9SFL5KXiEwLJ/V3DIij
         JvGDaWcltZF1RajrLj8e0RclKnPd2WS7a1b4QVebhg+ncuz3p4FlXQtNnGyMVu6S74db
         ckmszjeTLQimwH3zk/fUWEGEc7pYVoUA6GydO5kUOjtlip80CRpOwxOJvgJTCsCexgb4
         0pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zb2t7fnEFpTNY92P+q79KIuwpqsi0lHQ8yrY3sayUYo=;
        b=j5DeDRhf/43RwJrVXV6aQ6vnzWZb1J4oQMqVKt0TZWvP0STj2GDc0lVW7SLSAgw6Gp
         shLqm6aaQ537vQiTJOVNFxT3B6jo0XdNTBmRilcJkq5/+kagSxCjan8taCrUCO1wz3pq
         pprm2a5AHqyPrdD8IVheySguyI5PIEgvLb3vRFarvN4jPlVe5z1sIf45nQuGG3iM7vFd
         NQSLQIoNaKlw35d4cM076Rs5i5PfhAM7o61479mQcat8iB/yW+2nMPpNZ+t1JAlm2Z6l
         VWjbVnwprCUhCcE+sOpSest9Kh2ptPbocwRIlkRTsXk+n9FzYtnVX9PsC36BpRW88K2w
         Z6gQ==
X-Gm-Message-State: APzg51B/iqIYDPSqGt0OWBj3FnRU8b5H1xlQPKUW2ZlKVl0Ac9Jjqwdg
        tce9gHQp+Oiec6gGiEmDnV8=
X-Google-Smtp-Source: ANB0VdaHHFS6Ib8CVFp6Bsn8C03a/TPkA65nly8k5yvWqhjKYNiSp16QXZYNmxi1+T89Mhls7hpKDQ==
X-Received: by 2002:a81:453:: with SMTP id 80-v6mr1715599ywe.203.1536247309343;
        Thu, 06 Sep 2018 08:21:49 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:ad69])
        by smtp.gmail.com with ESMTPSA id j186-v6sm1882153ywd.88.2018.09.06.08.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:21:48 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:21:23 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] blkcg: fix ref count issue with bio_blkcg using
 task_css
Message-ID: <20180906152120.GA5055@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-5-dennisszhou@gmail.com>
 <20180831153538.brzgcm3rgmwfy3rg@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831153538.brzgcm3rgmwfy3rg@destiny>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:35:39AM -0400, Josef Bacik wrote:
> On Thu, Aug 30, 2018 at 09:53:45PM -0400, Dennis Zhou wrote:
> > From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> > +/**
> > + * blkcg_get_css - find and get a reference to the css
> > + *
> > + * Find the css associated with either the kthread or the current task.
> > + */
> > +static inline struct cgroup_subsys_state *blkcg_get_css(void)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +
> > +	rcu_read_lock();
> > +
> > +	css = kthread_blkcg();
> > +	if (css) {
> > +		css_get(css);
> > +	} else {
> > +		while (true) {
> > +			css = task_css(current, io_cgrp_id);
> > +			if (likely(css_tryget(css)))
> > +				break;
> > +			cpu_relax();
> 
> Does this work?  I'm ignorant of what cpu_relax() does, but it seems if we're
> rcu_read_lock()'ed here we aren't going to queisce so if we fail to get the css
> here we just simply aren't going to get it unless we go to sleep right?  An
> honest question, because this is all magic to me, I'd like to understand how
> this isn't going to infinite loop on us if css_tryget(css) fails.
> 

Tejun replied earlier with an indepth answer. Thanks Tejun! I'll make
sure to add a comment detailing what's going on.

> > +/**
> > + * bio_blkcg - grab the blkcg associated with a bio
> > + * @bio: target bio
> > + *
> > + * This returns the blkcg associated with a bio, NULL if not associated.
> > + * Callers are expected to either handle NULL or know association has been
> > + * done prior to calling this.
> > + */
> >  static inline struct blkcg *bio_blkcg(struct bio *bio)
> >  {
> > -	struct cgroup_subsys_state *css;
> > -
> >  	if (bio && bio->bi_css)
> >  		return css_to_blkcg(bio->bi_css);
> > -	css = kthread_blkcg();
> > -	if (css)
> > -		return css_to_blkcg(css);
> > -	return css_to_blkcg(task_css(current, io_cgrp_id));
> > +	return NULL;
> >  }
> >  
> 
> So this is fine per se, but I know recently I was doing a bio_blkcg(NULL) to get
> whatever the blkcg was for the current task.  I threw that work away so I'm not
> worried about me, but have you made sure nobody else is doing something similar?
> 

Initially I thought the BFQ and CFQ stuff only interacted with bios
which should already be associated. Turns out during init, they rely on
that bio_blkcg to read from current and then do the wrong thing of hard
associating with it (_get vs _tryget).

I've created a __bio_blkcg which is identical to the old function with
notes to not use it. Making changes to BFQ and CFQ would take a good bit
more work to make sure I'm not breaking what they're expecting to do, so
I leave that to future work.

> >  static inline bool blk_cgroup_congested(void)
> > @@ -519,6 +549,11 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
> >  	rcu_read_lock();
> >  
> >  	blkcg = bio_blkcg(bio);
> > +	if (blkcg) {
> > +		css_get(&blkcg->css);
> > +	} else {
> > +		blkcg = css_to_blkcg(blkcg_get_css());
> > +	}
> 
> Kill these extra braces please.  Thanks,

Done.

Thanks,
Dennis
