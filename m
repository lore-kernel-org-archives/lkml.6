Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BFBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF1F2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLHZkhab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF1F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIAA3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:29:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38332 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAA3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:29:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id n21-v6so5490440ywh.5;
        Fri, 31 Aug 2018 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xB65XgsuIhVMr4wfu+fmV5tJ/QI8bJpBH5q/qwwB4aI=;
        b=mLHZkhablFk9waUyMc8kuvj/PVXTKpZFF3mTAy+iVwTmSjp5bGMlkpbDQ+WexC9mat
         X7UE7Ks2ezPEFePe9khKWJkqkIsWGEcDRxIB7Wo/nz8VDcuVbv2YaiH4ZAOTeq47okVL
         dbT78Hp/pANTrGwrjY6jx2tHaBbyBtZOEUwQG38SKtuSruX3fqzCW6x9hpZfE8AdS1NA
         pEQ5i+x/Qv8YZKyd3EVN/PI/Ci9IqIhY2nx2lGmaGqrWEeDyTjMg2dUuYvbcp9ZK/VFx
         x7Rf0XUqTQvdOz8Tl/qkEdrAb2Ii45fyEpN9SGMjw3h+th+nnbIIXBiLTH6wQg+Zm5sF
         zazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xB65XgsuIhVMr4wfu+fmV5tJ/QI8bJpBH5q/qwwB4aI=;
        b=l9437i365aWGCb7BnbPNo95sD4ROqt81r1qxYoJZtvpiJEYSDWYD2MeI8i8XDE4KLu
         Bjie6qaZeMW7/QOSQMdM9Mwowc+eV8s8m40355wQjjQoM7iC65tMvipZ+/noFFnm1xum
         ChgEWBr5+34wbEr7oo8n0XO2iDnrX/y9LITnVvB36qh1zEyKlZ9T+py1u3flopUa5XMR
         E61Lsl2MZNETPr9EhG0bX8nbYvlnu5HovU/OtsOzfPxvgLDu3k3kNBrprzmmlKJpy/OK
         Ob5poo24LnaqYpvwhQzlkXxKGI78mFgAFthshh5b81oEMyVw7p5LYdWM5ouizndo8Oe/
         WLzg==
X-Gm-Message-State: APzg51CkQER6ceUnT0xTqQ14HZGnq/SVUGvKHC9a5ehAWcjlspB/ep+b
        A2UQhj8SWNIWwW7OkwX2fJUNCegdjO4=
X-Google-Smtp-Source: ANB0VdaNDgewJB/LvvuRvXk4Z5qAZkvfKbVmCnwqQ0Dnmwkfy2EHunXYw70q6XOPnxWffGtf5Dpymw==
X-Received: by 2002:a81:2a0a:: with SMTP id q10-v6mr9970329ywq.159.1535746842438;
        Fri, 31 Aug 2018 13:20:42 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:ae4b])
        by smtp.gmail.com with ESMTPSA id j8-v6sm4479117ywj.6.2018.08.31.13.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:20:42 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:20:40 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 03/15] blkcg: use tryget logic when associating a blkg
 with a bio
Message-ID: <20180831202040.GB20194@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-4-dennisszhou@gmail.com>
 <20180831153007.nybnuyx43adn76rm@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831153007.nybnuyx43adn76rm@destiny>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

On Fri, Aug 31, 2018 at 11:30:08AM -0400, Josef Bacik wrote:
> On Thu, Aug 30, 2018 at 09:53:44PM -0400, Dennis Zhou wrote:
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index a3eede00d302..c626e1f7cdcd 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -2129,8 +2129,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
> >  static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
> >  {
> >  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> > -	if (bio->bi_css)
> > -		bio_associate_blkg(bio, tg_to_blkg(tg));
> > +	/* fallback to root_blkg if we fail to get a blkg ref */
> > +	if (bio->bi_css && bio_associate_blkg(bio, tg_to_blkg(tg)))
> > +		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
> 
> Except if we've already assocated a blkg this is just extra, can we do
> 
> if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
> 
> to make it clear that we're only attaching it to the root if we failed to attach
> a blkg at all?  Thanks,

Done in v2.

Thanks,
Dennis
