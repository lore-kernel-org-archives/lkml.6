Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkSUEX2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbeLNV3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:29:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbeLNV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:29:52 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so11643171ith.3;
        Fri, 14 Dec 2018 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XPPxeyKFREoS2GcW2/S4Arhax4A1QyvIVUlnPDl3qyM=;
        b=IkSUEX2ZG2+OXmGjasoWEA8H5Qt7SavwQcnYY4EzUCgPK6b/q+KtgSwMksPo6m/Hqs
         zt5ny3D4v1LoUcbxvPo1dror9OWO0Npvlnk7in+Dl/etbWf2IHlHfiIFxetvy5BK0Ijn
         tuRGw6xTh2kTJJT2AwMS65n/yplh8PJaagjIqK5ZR8W9n5W3ztGoLpEp819ya9r+PZGJ
         oh5egrmNqbU6Lm3MyvcU6F/prCs6C5PorYtIJL1ILCy6NIOYHTDRzRLQeF6NiAUO+Gz4
         omC3ynnLiw6Qq1ukLbfR5U5dkLchXtJvNxPWIuy3EKHCCTR/8zTrfu0fNuGY2vLt1Hk9
         4Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPPxeyKFREoS2GcW2/S4Arhax4A1QyvIVUlnPDl3qyM=;
        b=gpMEmhVwJY4CogExiHDy4LG14PSXrObtHtBh+RcdINoDP8zx960b9j1DEsPiGA934x
         9xkgVR1DyILDLBD3x3rxr0If3GhiDmMxanMsdaGVbdw5ahe/90T6HbBDGzY2nFtUXwMw
         JhaTfmapWWXR7tkzUINnjJVfqUd8HSYQXR7pk5UtQqHhGzxJJ5mBW4vqA+90nqSHFI90
         q2FIvrVgYno0VlYd04P+pRK7Wsras8BLKIj4+ZUXljT4/L3vfntElfqSPrRwLbvq6pxy
         YFtkQes653xuL2fZL6dTOc67uFsyYDQRULzrzQdGcGqLjOaQ6tArwtSBqy6mJdr/ShfD
         L41A==
X-Gm-Message-State: AA+aEWaQULluR7DmJGYuJebwDwhj1Wrl8abZjxvgk7fdRfIo8qX972e0
        kG8C+c0KEAUFG2H03tgUipE=
X-Google-Smtp-Source: AFSGD/UfTLz/MxOqqJygvlIMgYovl8fsIpop1qPRtjweAUXD07pZcRWsoLWpsv+nJQF+8f9uk2o9NQ==
X-Received: by 2002:a24:d30c:: with SMTP id n12mr4984203itg.50.1544822991358;
        Fri, 14 Dec 2018 13:29:51 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id b192sm3084256itb.12.2018.12.14.13.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 13:29:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:29:44 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 04/11] staging: iio: adt7316: fix handling of dac high
 resolution option
Message-ID: <20181214212944.GA2400@r2700x.localdomain>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-5-jeremyfertic@gmail.com>
 <20181212082315.GI3116@kadam>
 <20181213220146.GA2496@r2700x.localdomain>
 <20181214062618.GW3116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214062618.GW3116@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:26:18AM +0300, Dan Carpenter wrote:
> On Thu, Dec 13, 2018 at 03:01:46PM -0700, Jeremy Fertic wrote:
> > On Wed, Dec 12, 2018 at 11:23:16AM +0300, Dan Carpenter wrote:
> > > On Tue, Dec 11, 2018 at 05:54:56PM -0700, Jeremy Fertic wrote:
> > > > @@ -651,10 +649,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> > > >  	u8 config3;
> > > >  	int ret;
> > > >  
> > > > +	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
> > > > +		return -EPERM;
> > > 
> > > return -EINVAL is more appropriate than -EPERM.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > I chose -EPERM because the driver uses it quite a few times in similar
> > circumstances.
> 
> Yeah.  I saw that when I reviewed the later patches in this series.
> 
> It's really not doing it right.  -EPERM means permission checks like
> access_ok() failed so it's not appropriate.  -EINVAL is sort of general
> purpose for invalid commands so it's probably the correct thing.
> 
> > At least with this driver, -EINVAL is used when the user
> > attempts to write data that would never be valid. -EPERM is used when
> > either the current device settings prevent some functionality from being
> > used, or the device never supports that functionality. This patch is the
> > latter, that these two chip ids never support this function.
> > 
> > I'll change to -EINVAL in a v2 series, but I wonder if I should hold off
> > on a separate patch for other instances in this driver since it will be
> > undergoing a substantial refactoring.
> 
> Generally, you should prefer kernel standards over driver standards and
> especially for staging.  But it doesn't matter.  When I reviewed this
> patch, I hadn't seen that the driver was doing it like this but now I
> know so it's fine.  We can clean it all at once later if you want.
> 
> regards,
> dan carpenter
> 

I'll wait to deal with these error values since some of them might go away
with all the changes necessary to get the driver out of staging. Thanks
for clarifying things for me.

