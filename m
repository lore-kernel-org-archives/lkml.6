Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D27BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3A20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfAIJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:36:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47967 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:36:59 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ghAIA-0000UD-QB; Wed, 09 Jan 2019 10:36:54 +0100
Message-ID: <1547026614.3580.29.camel@pengutronix.de>
Subject: Re: [PATCH] Build etnaviv on non-ARM architectures
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Matthew Wilcox <willy@infradead.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 10:36:54 +0100
In-Reply-To: <20190108204356.GF6310@bombadil.infradead.org>
References: <20190108204356.GF6310@bombadil.infradead.org>
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

Am Dienstag, den 08.01.2019, 12:43 -0800 schrieb Matthew Wilcox:
> I wanted to test-compile etnaviv on x86 after making a tree-wide change
> to it.  Unfortunately, Kconfig has a bad dependency, so I couldn't.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

I think we even want to relax this some more in the future, as Vivante
GPUs are also found on non ARM SoCs, but that needs some more testing
so I applied this patch to etnaviv/next as it's certainly the right
thing to do.

Regards,
Lucas

> 
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 041a77e400d4..342591a1084e 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_ETNAVIV
> >  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> >  	depends on DRM
> > -	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
> > +	depends on ARCH_MXC || ARCH_DOVE || ARM || COMPILE_TEST
> >  	depends on MMU
> >  	select SHMEM
> >  	select SYNC_FILE
> 
