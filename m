Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661E920673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiPlv86Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661E920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbeK3BvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:51:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41637 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbeK3BvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:51:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so1961635ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZV2007TjFCEWoWuUW9JwZgz6Ylp/zem61BAg5NSbJ30=;
        b=JiPlv86YCFX2a2nL9VMX0CNOqdeKsXAItI9lLN7MNOjKzi1MXVCGV4fxTX6XJR6MUB
         jbAqsirDDJLVHLAt2NhSQnZ66Mz/C0fOEcRdyzaMQKH2JCEuaN13eRB0g9aAW92E4ycy
         0gwDuV+aczfjmz2YmZFn8DfTm6mfFIvW4z4qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZV2007TjFCEWoWuUW9JwZgz6Ylp/zem61BAg5NSbJ30=;
        b=AwXaoaYcUQRI16p8MyEbjUNvBZExHDoL0b2UfuPa9FsFFxcmauzU+U9Asqzax6qnLZ
         nJwL8MHgTUbZmKbW951qD6iRKxE6peEZqCOheeFgYq+P5p4UthXQ8nzoRbJ8PeYjG0XO
         gveiCOmIT2OipcHKTNBuKvrDp/IHZqS9mG/i/2VVmg74VnP636mpQLqF8PRfUmkrb5NU
         s27GdXmz8PC7vRmvd+lAudRObuZYJfoH8YIs02dmrgvmFzWGGVrlQ+5JFc5fhUNd4/a3
         x8NSAPgtr1aeA2AGaLpGiQ2N806qXVDc6UAtEy+fiYnHh6U1XIjsfCv6dM7KuMvOUyaY
         nm/Q==
X-Gm-Message-State: AA+aEWZjHPZALS2ZGCTVY7X0aDMCxoC4fzHYzMykdifui9Livjm+Hl+M
        eILZXToDq9qEND0hnn6WpXUY8NHlhoSTplCGT/Ekqw==
X-Google-Smtp-Source: AFSGD/UQ7Jhv0hxPLNJ0fGMUMqJ6VkMJ+WPXc/MQPPE8bhUNP7JH7AmudeXaT9ShbT+hTLx4BuSdN3NMQVKfR4J2wBU=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr1301878ljc.97.1543502746923;
 Thu, 29 Nov 2018 06:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local> <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
 <20181126141241.GM4266@phenom.ffwll.local>
In-Reply-To: <20181126141241.GM4266@phenom.ffwll.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Nov 2018 15:45:33 +0100
Message-ID: <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
To:     greenfoo@gluegarage.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        Dave Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, abrodkin@synopsys.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, michal.lkml@markovi.net,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 3:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:

> > It was especially scary.
> >
> > But I think I managed to apply the patches and push the
> > branch now.
>
> Except when you're racing with someone else you should only see conflicts
> with stuff you've just pushed. Or if someone forgot to fix up their mess.
> What was the conflict?

dim push-branches was complaining that one of the commits was
missing the proper committer sign-off, it was the bottom commit under
mine (IIRC "drm/atomic-helper: WARN if fake_commit->hw_done is not
completed as expected")
and dim update-branches seemed to rebase and fix up my patches
and then everything was fine.

I just felt slightly out of control :D

Yours,
Linus Walleij
