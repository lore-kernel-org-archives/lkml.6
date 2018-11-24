Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AD32086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV66h96n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AD32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeKYIGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 03:06:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36882 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKYIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 03:06:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so13302792lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LFoDMHZQz8UBWaJLXzIWV8IXutyISCt0Xum8q759EGs=;
        b=FV66h96nOuhPRcswvE33wNkp9sWMVqWLcX8T8M6Q87Zv66u+/V0tiwzmkQLMf7oQJn
         /8opov9c44wHuR8vHnmngX+vW5d9j4tRlBVaDAO64yB+sXpoEN/GzpKoyDIC0dcK3jSf
         c0GI0SNiuyVetgqEew7VpXJvxZu3j8GGCwh0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LFoDMHZQz8UBWaJLXzIWV8IXutyISCt0Xum8q759EGs=;
        b=A6bJs/MS5LzU5NTTBpUokPjcmWoOj6m1ksrQkqPewR6jAFiYtPD9oY36byXQGtDML4
         OhgM/NiGefFYF3NwMNTKfNYUsmh3unNYdgzHSdy67FthzVIT6TD7YsCrqkOE2ylPPgbb
         RpmhOo1EHivI0BFyUK86stH/bJ9SQXvMNzxmHf/dZYVKeCyvM8JP3WdixRvPV9sliBQ9
         Hda1QyTDpjXByRWUBt6+CGXNvi2tvylVKoISLN39XX32E9LdzWJTRQ0DyoRJLCbSphW8
         H9uWJAIiC8p3gJBIAHK0u1JyLxK4qWuBmREeJsyVos9GmPiWYV0iIfQJVL7qKvNcqbi6
         hx+A==
X-Gm-Message-State: AA+aEWafUKIbRnw69AFLzYpAlzripGdVSAt+w/dBaTlrcZ2RrAAQC0h4
        T8E4+IeFvNA6BjO0MeBtwGCq8JvJQRHCP1+L8xqPeg==
X-Google-Smtp-Source: AJdET5dBN60eGZw4aZBnUaOtrwGI8Lx40LRymSPRBcxwlYWJxaFKw3ZoWCG2GtfVkWkwNbhaZle6s1TnZhJ89YN1f7o=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr13103518ljg.23.1543094245529;
 Sat, 24 Nov 2018 13:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com> <20181121094233.GN4266@phenom.ffwll.local>
In-Reply-To: <20181121094233.GN4266@phenom.ffwll.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 22:17:13 +0100
Message-ID: <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 10:42 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Nov 15, 2018 at 11:38:35PM +0100, Linus Walleij wrote:
> > On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:
> >
> > > One of the things in the DRM TODO list ("Documentation/gpu/todo.rst") was to
> > > "switch from reference/unreference to get/put". That's what this patch series is
> > > about.
> >
> > The series:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Since your reviewed it all, and there's a pile of acks for the driver
> parts too: Want to go ahead and apply it too?

OK I did... the git was quirky, patches changes around
under my feet and dim started to complain about problems
with commits that weren't even mine.

It was especially scary.

But I think I managed to apply the patches and push the
branch now.

Yours,
Linus Walleij
