Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC842086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5HnEOTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC842086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeKSWhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbeKSWhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:37:25 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456C220823;
        Mon, 19 Nov 2018 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542629638;
        bh=7lQDP17kwDvqW/0EJSGVUjFvTAbSC7+XScQ/jjGXdeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5HnEOTkMSXo5Jar1t4VNN/IGLxRu6alVbI89jArl0u1XR5CmZImBnJ6p5GbSKcl6
         3tQoiEe5zkNy9eNvWs0fn9U7cttEX1J+jGDoCPKm04VydUzyEyzZcXbbg6PGffnly3
         CDR2BCoYvmn1ygzUiGTGyqeGyJLTZzJwhf21q8NM=
Date:   Mon, 19 Nov 2018 20:13:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fernando Ramos <greenfoo@gluegarage.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
Message-ID: <20181119121327.GS5829@dragon>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:16:23PM +0100, Fernando Ramos wrote:
> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c             | 4 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 4 ++--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c        | 2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 4 ++--
>  drivers/gpu/drm/tve200/tve200_drv.c          | 4 ++--
>  drivers/gpu/drm/zte/zx_drm_drv.c             | 4 ++--

We have already queued a patch [1] from Thomas Zimmermann for
zx_drm_drv.

Shawn

[1] https://patchwork.kernel.org/patch/10615837/
