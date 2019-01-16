Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C33520651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfAPQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:25:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56355 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbfAPQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:25:50 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gjo0a-0006wQ-Ki; Wed, 16 Jan 2019 17:25:40 +0100
Message-ID: <1547655938.4339.42.camel@pengutronix.de>
Subject: Re: [PATCH] etnaviv: allow to build on ARC
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Date:   Wed, 16 Jan 2019 17:25:38 +0100
In-Reply-To: <20190116162125.GA16326@infradead.org>
References: <20190114163157.20114-1-Eugeniy.Paltsev@synopsys.com>
         <20190116162125.GA16326@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 16.01.2019, 08:21 -0800 schrieb Christoph Hellwig:
> On Mon, Jan 14, 2019 at 07:31:57PM +0300, Eugeniy Paltsev wrote:
> > ARC HSDK SoC has Vivante GPU IP so allow build etnaviv for ARC.
> > 
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > ---
> >  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/etnaviv/Kconfig
> > b/drivers/gpu/drm/etnaviv/Kconfig
> > index 342591a1084e..49a9957c3373 100644
> > --- a/drivers/gpu/drm/etnaviv/Kconfig
> > +++ b/drivers/gpu/drm/etnaviv/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DRM_ETNAVIV
> >  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> >  	depends on DRM
> > -	depends on ARCH_MXC || ARCH_DOVE || ARM || COMPILE_TEST
> > +	depends on ARCH_MXC || ARCH_DOVE || ARM || ARC ||
> > COMPILE_TEST
> 
> Is there any reason to not just remove the dependencies entirely?
> It seems like it could literally build everywhere, and who knows what
> other SOCs the IP blocks end up in sooner or later?

I've just sent out a patch to do exactly this instead of playing whack-
a-mole with all the architectures. The patch has been chewed on by the
0-day robot since yesterday and didn't turn up any obvious fallout yet.

Regards,
Lucas
