Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265A72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V5wTcec0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265A72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbeK3CBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:01:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39331 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbeK3CBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:01:17 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so1784542iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zltmiCUlVco/OMj6WMOtVnqUWC0sd0wXJjHaa3DT8Ro=;
        b=V5wTcec0hhJjeUWi2Q740IfROGJIYTELR2rd8+dLmffCGPeZpQMFmi9dqyGY7D72Zw
         RWvWuGi2OY+OLSikRtN5CVmwp0IflTtek+mFwc1GAJk2pKuIGn2lZ7kufu2cu8qcgrzA
         XpDWqgsXr7+C4P3pUGDKXo8I1oIAK7G49Ihcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zltmiCUlVco/OMj6WMOtVnqUWC0sd0wXJjHaa3DT8Ro=;
        b=m3oKN6gLnxRrNOHJ7LD2ul8JBVhe0NyOVPNZl5qEpaXbee1MvtW5DURv/3EOOrrLYs
         VyIIBjX1WUE2hBHbknMpzS+xNQaaarCKt5bvdciWHyWwIUCcA4Kh9seT9QXUWnF8AAG9
         GaOR9wL0mk6yRdBp4n3nVNeaiuo7NwzWaOzzSUypQquflu5o/Hy0chjzoAU85wk0i+na
         3E2TvdKhQvlKtI3aslQTgS5SdQ235tfRQC+ns6pI6VufFp5BqfgZDGssfHnUpK7m1Mg8
         S4OZbBwh4YUC0yTa9ZyFLJpH1SsQYdahCdud2wozY2l1nF7LDYrW675Rz+uo7XGqN59h
         TTmA==
X-Gm-Message-State: AA+aEWaHaj3wy2A/kp+QO6qCD8gCOR8QrkEUZsN5f0VbNICgw1qxZrSR
        ySc5DgBuNCJmQsKJuAcQmUFy/FPKUr8iNjEbvGr0Sg==
X-Google-Smtp-Source: AFSGD/WORmHTU40LHiSoYvEcp5Yjz7OJkhXJCIDbSmkmMi8iTkUUs9bN4CzbB4Yilzxly7ZRQsfX9skW2PxPyeQAaVs=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr1582174ioa.34.1543503339523;
 Thu, 29 Nov 2018 06:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local> <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
 <20181126141241.GM4266@phenom.ffwll.local> <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
In-Reply-To: <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 29 Nov 2018 15:55:28 +0100
Message-ID: <CAKMK7uF9Q-LySAXg=kT9B-ueFR9qhr_B0N3y1g1D_OTc-+Vbdg@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     greenfoo@gluegarage.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        etnaviv@lists.freedesktop.org,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>, cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Nov 26, 2018 at 3:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:
>
> > > It was especially scary.
> > >
> > > But I think I managed to apply the patches and push the
> > > branch now.
> >
> > Except when you're racing with someone else you should only see conflicts
> > with stuff you've just pushed. Or if someone forgot to fix up their mess.
> > What was the conflict?
>
> dim push-branches was complaining that one of the commits was
> missing the proper committer sign-off, it was the bottom commit under
> mine (IIRC "drm/atomic-helper: WARN if fake_commit->hw_done is not
> completed as expected")
> and dim update-branches seemed to rebase and fix up my patches
> and then everything was fine.

This sounds like you (or dim?) accidentaly amended that commit (which
changes the committer and results in the warning), and a rebase would
indeed have fixed that. If the first patch conflicts this can happen
because dim apply-branch doesn't bail out correctly. Or at least did
in the past, I recently fixed that in

commit ee299e510ae468aab27610bcbc4fdd4de932f74b
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed Oct 17 08:53:00 2018 +0200

    dim: make apply-patch fail again

> I just felt slightly out of control :D

If your dim didn't have the above commit and you had a conflict it's
all explained. Otherwise I'm not sure what's been going on ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
