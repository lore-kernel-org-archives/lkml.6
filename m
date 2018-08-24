Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2BDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484122157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484122157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeHXLZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:25:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42930 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbeHXLZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:25:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7050922A2B; Fri, 24 Aug 2018 09:51:43 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E60320732;
        Fri, 24 Aug 2018 09:51:33 +0200 (CEST)
Date:   Fri, 24 Aug 2018 09:51:31 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v8 0/4] drm/atmel-hlcdc: bus-width override support
Message-ID: <20180824095131.5d9cb33f@bbrezillon>
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, 10 Aug 2018 15:03:55 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> The background for these patches is that our PCB interface between
> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> this has to be described somewhere, or the atmel-hlcdc driver have no
> chance of selecting the correct output mode. Since we have similar
> problems with a tda19988 HDMI encoder I added patches to override
> the atmel-hlcdc output format via DT properties compatible with the
> media video-interface binding and things start to play together.
> 
> Cheers,
> Peter
> 
> Changes since v7  https://lkml.org/lkml/2018/8/4/288
> - The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
>   which simplifies fixing this in patch 4/4 (and adds flexibility)
>   and adjust patch 4/4 to the changes done in the new 3/4.
> - return -ENOMEM on allocation failure in patch 4/4

I stopped following the discussion at some point. Are there any open
issues or Ack you're waiting for?
