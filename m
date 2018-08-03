Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC8C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6D2172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgrKUHmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6D2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeHCEpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:45:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35631 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHCEpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:45:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1908169plq.2;
        Thu, 02 Aug 2018 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wt2kUJiEAx1cp/Iz14VldSndfKjaJAhniBsNDzXUe/M=;
        b=OgrKUHmdRjvEPT8BtH4dNM93chLBCJeUYfYZeABEwgWX+EnUIHogiGMMlMSwI05/Yz
         vehiS5Z1IoRqsPzYXA8RbMDxOtPJ4Va6IFKjbmwHA86brpio543eJDs5iVwoLuFRADLt
         Si3Ru/UGtWQQ+0pzSY2q4I8hpNZQSranEBkSZIGMSvTJqPftV39y/T1sa0pj5HHJ3dT7
         8ebNaOe7S+44ZVboA8oRyWTEG0avfCadfWcbATy9MIyk0yvK/GrGBxGAZelC6BlL+0Vx
         hCcRYeX1j2VrXiiXzJVItxa1sgAiI5w23JdlD39EPlue5afGKqN4rGYPNN4shJRYDj7A
         VZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wt2kUJiEAx1cp/Iz14VldSndfKjaJAhniBsNDzXUe/M=;
        b=p48jk2EMOIAJoOk8GxPqbCVyOg/hgQlN9a2oJXPYnfzjIdDOo+uoDSdWT0hzVju/9i
         fNwRQ05LPUwg+UB7MC6bUMNC7CTNY5Wu+K+ASrVm3ncdmlKb+xCEjNUpeXi43A3c/siy
         Z0zjIXOtvJI2o9Un6upr7lxwvYAoFkpKmw7GJ7yldAgFvy3WyWw647Oh5Z8iT6/ALP7f
         LKLegAO4SsheLrl/PVQjKiQOmH8/8UfD3p1Mo3bJpb7UHXrUqKPpCIIpgo8aqgfBLusC
         vr54YrRwywE2MuCH7BTqXbVnJP9nFkAdFzCSNlLAAUSFoMJuzxSVjAFK3Dp6BuCK1uWV
         tJ8Q==
X-Gm-Message-State: AOUpUlHlt3ivjuQ68BoOdmd8Ck3etbDh2Uo0qD9gL4wK9uVLTp7AGk5g
        2jMBgcxlnJg+tcex5IgRm/s=
X-Google-Smtp-Source: AAOMgpeapTshjMO222KPFJ7Or5JOUAnAC8MEf1Aa8/18AAeE50k+C5TMeSkPhdhssIc0O6hhzhwyuw==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr1765516plb.210.1533264709439;
        Thu, 02 Aug 2018 19:51:49 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:9465:817a:e0d1:934d])
        by smtp.gmail.com with ESMTPSA id b67-v6sm5720202pfd.74.2018.08.02.19.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:51:47 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:51:43 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803025143.GA86818@rodete-desktop-imager.corp.google.com>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Aug 02, 2018 at 02:13:04PM -0700, Andrew Morton wrote:
> On Thu,  2 Aug 2018 14:11:12 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > If zram supports writeback feature, it's no more syncrhonous
> > device beause zram does synchronous IO opeation for
> > incompressible page.
> > 
> > Do not pretend to be syncrhonous IO device. It makes system
> > very sluggish as waiting IO completion from upper layer.
> > 
> > Furthermore, it makes user-after-free problem because swap
> > think the opearion is done when the IO functions returns so
> > it could free page by will(e.g., lock_page_or_retry and
> > goto out_release in do_swap_page) but in fact, IO is
> > asynchrnous so driver could access just freed page afterward.
> > 
> > This patch fixes the problem.

I fixed my faults from original description.
Otherwise, ones you corrected looks good to me.

> 
> That changelog is rather hard to follow.  Please review my edits:
> 
> : If zram supports writeback feature, it's no longer a BD_CAP_SYNCHRONOUS_IO
> : device beause zram does synchronous IO operations for incompressible pages.

                            asynchronous

> : 
> : Do not pretend to be synchronous IO device.  It makes the system very
> : sluggish due to waiting for IO completion from upper layers.
> : 
> : Furthermore, it causes a user-after-free problem because swap thinks the
> : opearion is done when the IO functions returns so it can free the page
> : (e.g., lock_page_or_retry and goto out_release in do_swap_page) but in
> : fact, IO is asynchrnous so the driver could access a just freed page

                asynchronous 

> : afterward.
> : 
> : This patch fixes the problem. 
> 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 7436b2d27fa3..0b6eda1bd77a 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -298,7 +298,8 @@ static void reset_bdev(struct zram *zram)
> >  	zram->backing_dev = NULL;
> >  	zram->old_block_size = 0;
> >  	zram->bdev = NULL;
> > -
> > +	zram->disk->queue->backing_dev_info->capabilities |=
> > +				BDI_CAP_SYNCHRONOUS_IO;
> >  	kvfree(zram->bitmap);
> >  	zram->bitmap = NULL;
> >  }
> > @@ -400,6 +401,8 @@ static ssize_t backing_dev_store(struct device *dev,
> >  	zram->backing_dev = backing_dev;
> >  	zram->bitmap = bitmap;
> >  	zram->nr_pages = nr_pages;
> > +	zram->disk->queue->backing_dev_info->capabilities &=
> > +			~BDI_CAP_SYNCHRONOUS_IO;
> >  	up_write(&zram->init_lock);
> >  
> >  	pr_info("setup backing device %s\n", file_name);
> 
> A reader looking at this would wonder "why the heck are we doing that".
> Adding a code comment would help them.

I will add

/*
 * With writeback feature, zram does a asynchronous IO so it's no longer
 * synchronous device. If it pretend to be, upper layer could wait IO
 * completion rather than (submit and return), which will cause system
 * sluggish.
 * Furthermore, when the IO function returns(e.g., swap_readpage),
 * uppler lay could guess IO was done so it could deallocate the page
 * freely but in fact, IO is going on and it finally could cause
 * use-after-free when the IO is really done.
 */

> 
> Is it legitimate to be altering the bdi capabilities at this level?  Or
> is this hacky?

Most of device's bdi capability seems to be static but there are few drivers
which can change capability. For example, BDI_CAP_STABLE_WRITES

drivers/scsi/iscsi_tcp.c
drivers/md/raid5.c

I believe it's driver itself advertisement stuff so I hope it's not hack.

> 
> If "yes" then should reset_bdev() be unconditionally setting
> BDI_CAP_SYNCHRONOUS_IO?  Shouldn't it be restoring that flag to its
> previous setting?
> 

Yu, reset_bdev should set it unconditionally. Because zram's default
mode is synchronous and it changed only if user set backing device.

I will respin the patch with revised comment and description.

Thanks.
