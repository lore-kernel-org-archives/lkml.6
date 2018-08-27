Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B64EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AA208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AA208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeH1AXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:23:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51792 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1AX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:23:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F00B207EB; Mon, 27 Aug 2018 22:35:17 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 052F920789;
        Mon, 27 Aug 2018 22:35:06 +0200 (CEST)
Date:   Mon, 27 Aug 2018 22:35:05 +0200
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
Subject: Re: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
Message-ID: <20180827223505.7e2fe6f6@bbrezillon>
In-Reply-To: <ca38bd82-09d2-8e55-a3a2-e0e559abdf7f@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
        <20180827212449.723bdc99@bbrezillon>
        <ca38bd82-09d2-8e55-a3a2-e0e559abdf7f@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 22:31:22 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-08-27 21:24, Boris Brezillon wrote:
> > On Sat, 25 Aug 2018 10:56:16 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> The background for these patches is that our PCB interface between
> >> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> >> this has to be described somewhere, or the atmel-hlcdc driver have no
> >> chance of selecting the correct output mode. Since we have similar
> >> problems with a tda19988 HDMI encoder I added patches to override
> >> the atmel-hlcdc output format via DT properties compatible with the
> >> media video-interface binding and things start to play together.  
> > 
> > Queued to drm-misc-next.  
> 
> Thanks!
> 
> Minute issue, you seem to have some spell-check going on or something,
> because the subject of patch 1/4 has been "corrected" from
> "...add ti,ds90c185" to "...add ti, ds90c185"
> 
> You might want to evaluate if that auto-correction "feature" should be
> disabled/tweaked/whatever...

Hm, weird. I just downloaded the mbox from dri-devel's patchwork and
passed it to dim apply. dim tends to do a lot of things behind the
scene, so maybe it's also trying to fix typos :-).
