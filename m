Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB21C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C5120811
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="cyUwKVp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvMqoVHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C5120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbeKQDZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:25:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35853 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbeKQDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:25:10 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 22:25:09 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BAED21F39;
        Fri, 16 Nov 2018 12:04:49 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute1.internal (MEProxy); Fri, 16 Nov 2018 12:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:in-reply-to:references:subject:date; s=mesmtp; bh=
        iEGdTKyN0HEwE030k1fx6PVMxlh7yAiD+wyouNJIlik=; b=cyUwKVp4MdK08Lna
        xA0UnRWQ4ny7nhvCNYO4ryjuJLbeRvlSnGqpScytgY4Jk6L4p6plJ3+owtNhYbAO
        8IMaADYqoeA0EqjugizbwV1rCougjvSQnd57LjQFwrLfyTsdZza/akb3SqUFTdH/
        cqyWc7ZaViHFA6ZnsUeY3dnoA5M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=iEGdTKyN0HEwE030k1fx6PVMxlh7yAiD+wyouNJIl
        ik=; b=TvMqoVHm4ale8vgWSzOWXPcYQJPgTzekqaXPgUJ1GtU8T7dZ2nUtvz34H
        wdVxDRHT57D3WiB2vuTAumn9elnRIzriDcQ7GdvLElvBfaQMFjGH1Pj9QdCWftEv
        KtrJ4aZJjTa14B5nxUVckNObFRqRvBTeU3Kb8u4IsJlKqwHyd53Rs7Gglu9j1uyM
        B3LvvjZNMpKK6ounVGWBNznessBLu1mV2Oc99wkuh1r9gkdgXuEONCrWvcjIWFJp
        IDqPGXJVyy3Q1FpnARyKUdIYWeo84StNPzJDs6VK4WdH83IoEq8rqFn+DrppT5e5
        HyQERmyO6AOWNj5f25W2LfpBV3Eaw==
X-ME-Sender: <xms:rPjuWyQKLu7kLjet_Mk-LZZa4FeSDlNkqEDJgPtWMLB7raZVyiCgQg>
X-ME-Proxy: <xmx:rPjuWys2BTVZJwiJG5F7cAT0WhQJzBST-QCDp7kNk5_zs8gM-YJgFg>
    <xmx:rPjuW2KvtpWljgJ0_x7LzwbgauD77BOfF09jkqcLs7s4_E7NL32k7Q>
    <xmx:rPjuWwvOuNlxU4dw1JKDoE3uYCFXs70JhrF5ZEIk6MZoZYI4zU0zKg>
    <xmx:rPjuW91jUIP__UoxYwXTqQlU4wPHJPuTFghOjIGYK3N2UzSfukfy9g>
    <xmx:rPjuWzrZn9e0lI5goqmCq76OA1CdF2j6dUQ4zEy7hGwTkFgnSw6G0A>
    <xmx:sfjuW8yLi_On1OdMh2WH7aLaCrUGrC0ZaBhhWcSNcKls3YAe0ilFvw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 51F4741E7; Fri, 16 Nov 2018 12:04:44 -0500 (EST)
Message-Id: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
From:   Fernando <greenfoo@gluegarage.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>, cocci@systeme.lip6.fr,
        Marek Vasut <marex@denx.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        etnaviv@lists.freedesktop.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        virtualization@lists.linux-foundation.org,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        Michal Marek <michal.lkml@markovi.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-2d882eb6
In-Reply-To: <1542363310.23489.22.camel@pengutronix.de>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
 <1542363310.23489.22.camel@pengutronix.de>
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with "drm_dev_put"
Date:   Fri, 16 Nov 2018 18:04:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018, at 11:15 AM, Lucas Stach wrote:
> Am Donnerstag, den 15.11.2018, 23:16 +0100 schrieb Fernando Ramos:
> > This patch unifies the naming of DRM functions for reference counting as
> > requested on Documentation/gpu/todo.rst
> >=20
> > > Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> > ---
> > =C2=A0drivers/gpu/drm/arc/arcpgu_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
> > =C2=A0drivers/gpu/drm/etnaviv/etnaviv_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 4 ++--
>=20
> At least the etnaviv part of the patch is already fixed in linux-next.
>=20
> Regards,
> Lucas
=20

Thanks for the notice.

I'm new on this, how should I proceed? Should I create a new (V2) patch ser=
ies with these changes reverted? Or will the maintainer automatically take =
care of this when merging?

And, related to this, what is the "good" branch to start developing new drm=
 patches? Is is "drm-next" or "linux-next"? Or does it change depending on =
how much time until the merge window closes?

Thanks!
