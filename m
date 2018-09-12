Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC41C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6620C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pCYrjf0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD6620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIMCOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:14:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIMCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tD+2mOELEkjbQG+nbs+kcfOz5RUAVxUK7FdUTuBFijk=; b=pCYrjf0BJ4piMI25d7YXGhou6
        VmKQoMhTy5i25vf0d9H8yTHHfdHbbUf5qV/LtNNUjijXAsr1lPNyWTaiZ3V5ziSbHngnYB5BPTun8
        sl4z2B/2stTt3vIHvc38GmNCaJR0Z8JYhe6Ymkp5EfiBlS6guke094x3R+aWEvJ5oZZFnIVHn+eux
        WGhyqkdmXQvckLhZUt8ifRKLJ22NarMxQpvig4k7lhww79Rrp6x3/HMNflF5Igi5Wn3EgZBhjUbUO
        ozpjXswYcypidqjEuEoXUEsgYh179+3b7+0BS8we4kzVkJSoLn3VMF4lEO2u3NCVcvkBJNZYUxOo5
        a8PS4xsAw==;
Received: from [177.97.26.110] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0CMN-00047r-MU; Wed, 12 Sep 2018 21:07:40 +0000
Date:   Wed, 12 Sep 2018 18:07:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180912180734.37dfafb2@coco.lan>
In-Reply-To: <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
References: <20180828154433.5693-1-robh@kernel.org>
        <20180828154433.5693-7-robh@kernel.org>
        <20180912121705.010a999d@coco.lan>
        <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Sep 2018 15:26:48 -0500
Rob Herring <robh@kernel.org> escreveu:

> +Joe P
> 
> On Wed, Sep 12, 2018 at 10:17 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Em Tue, 28 Aug 2018 10:44:33 -0500
> > Rob Herring <robh@kernel.org> escreveu:
> >  
> > > In preparation to remove the node name pointer from struct device_node,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > Cc: Steve Longerbeam <slongerbeam@gmail.com>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-media@vger.kernel.org
> > > Cc: devel@driverdev.osuosl.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > > - fix conditional use of node name vs devname for imx
> > >
> > >  drivers/staging/media/imx/imx-media-dev.c | 15 ++++++++++-----
> > >  drivers/staging/media/imx/imx-media-of.c  |  4 ++--
> > >  drivers/staging/mt7621-eth/mdio.c         |  4 ++--  
> >
> > It would be better if you had submitted the staging/media stuff
> > on a separate patch, as they usually go via the media tree.  
> 
> Sorry, I thought Greg took all of staging.

No, I usually take media patches on staging. It seems that at least
the IIO subsystem does the same:

IIO SUBSYSTEM AND DRIVERS
M:	Jonathan Cameron <jic23@kernel.org>
R:	Hartmut Knaack <knaack.h@gmx.de>
R:	Lars-Peter Clausen <lars@metafoo.de>
R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
L:	linux-iio@vger.kernel.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
S:	Maintained
F:	Documentation/ABI/testing/configfs-iio*
F:	Documentation/ABI/testing/sysfs-bus-iio*
F:	Documentation/devicetree/bindings/iio/
F:	drivers/iio/
F:	drivers/staging/iio/
F:	include/linux/iio/
F:	tools/iio/

Anyway, as I said before, I don't have any issues if Greg takes
this specific patch.

> A problem with MAINTAINERS is there is no way to tell who applies
> patches for a given path vs. anyone else listed. This frequently
> happens when the maintainer organization doesn't match the directory
> org. If we distinguished this, then it would be quite easy to see when
> you've created a patch that needs to be split to different maintainers
> (or an explanation why it isn't). Whatever happened with splitting up
> MAINTAINERS? If there was a file for each maintainer tree, then it
> would be easier to extract that information.

Yes, but, on the other hand, get_maintainers.pl would likely
take more time to process, if a patch touches multiple subsystems.

> 
> Or maybe we just need to be stricter with the 'M' vs. 'R' tag and 'M'
> means that is the person who applies the patch. I don't think many
> drivers have their own tree and maintainer except for a few big ones.

Hmm... just getting a random file under staging/media:

	./scripts/get_maintainer.pl -f drivers/staging/media/imx/imx-ic.h
	Steve Longerbeam <slongerbeam@gmail.com> (maintainer:MEDIA DRIVERS FOR FREESCALE IMX)
	Philipp Zabel <p.zabel@pengutronix.de> (maintainer:MEDIA DRIVERS FOR FREESCALE IMX)
	Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB))
	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM)
	linux-media@vger.kernel.org (open list:MEDIA DRIVERS FOR FREESCALE IMX)
	devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
	linux-kernel@vger.kernel.org (open list)

It seems that the maintainers are already ordered by the tree
depth (placing the most relevant results first).

So, both driver maintainers appear first, then me and finally
Greg (as supporter). 

Mailing lists are also ordered by relevance: media ML, then staging
ML and finally LKML.

Thanks,
Mauro
