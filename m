Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CBCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5282172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5282172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeHCJZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:25:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39420 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbeHCJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:25:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10A88207AB; Fri,  3 Aug 2018 09:30:05 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9081C2069C;
        Fri,  3 Aug 2018 09:30:04 +0200 (CEST)
Date:   Fri, 3 Aug 2018 09:30:05 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [RESEND PATCH v5 0/3] drm/atmel-hlcdc: bus-width override
 support
Message-ID: <20180803093005.60eec28e@bbrezillon>
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Aug 2018 09:23:05 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> This is perhaps not a true resend in that these three patches were
> originally in a larger series [1], and the series have been rebased
> to v4.18-rc6. However, I did ask that these three patches should be
> considered separately. The other patches in the original series have
> been adopted and reworked by Russell King [2].

Oops, completely forgot to apply those 3 patches. If there's no
objection I'll queue them to drm-misc-next.

Regards,

Boris

> 
> The background for these patches is that our PCB interface between
> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> this has to be described somewhere, or the atmel-hlcdc driver have no
> chance of selecting the correct output mode. Since we have similar
> problems with a tda19988 HDMI encoder I added patches to override
> the atmel-hlcdc output format via DT properties compatible with the
> media video-interface binding and things start to play together.
> I of course need my old patches or the new ones from Russell to
> actually use the HDMI encoder with the SAMA5D3, but that is not
> directly related to this (shortened) series.
> 
> Cheers,
> Peter
> 
> [1] https://lkml.org/lkml/2018/5/23/273
> [2] https://www.spinics.net/lists/arm-kernel/msg669238.html
> 
> Peter Rosin (3):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   dt-bindings: display: atmel: optional video-interface of endpoints
>   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
> 
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++
>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 67 ++++++++++++++++++---
>  5 files changed, 144 insertions(+), 28 deletions(-)
> 

