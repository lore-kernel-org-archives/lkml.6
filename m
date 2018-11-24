Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF63C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914DB2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsAMo3em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914DB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeKYHdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:33:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44012 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeKYHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:33:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so10842471lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoh/llfN+DP1BphaBbtZ9lMq228Eqfq+oVKAM5tJwj4=;
        b=HsAMo3emE8VtaiHj54uLcvqGv97nQd56MJNoU6kpCasCt5g3POEdVPn6gShPM4zvb8
         uVG/hMag2kMKK7LMpyJWLp+EqBBX/S6eeKLrT9k3OXfHXi3Q7EfAatNz+Ep/y/lLmyVY
         PtLKofkFEPrh99GUUkHinDsJIrnTuZQurdGxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoh/llfN+DP1BphaBbtZ9lMq228Eqfq+oVKAM5tJwj4=;
        b=ZL0CMtplcH9laQyQkHYdkcyjpjRnEe4Wc0eYL1Rdxr5TH/L/+NHfxeOCMeempDYPMJ
         UIkIduLqKxIRBbdOS+eguYuBxqI+0MGX/zuwNGrthgHlwpHMR1Qg3h7jykOSZBKL0TGr
         2WVrHsiOuaGh5kvTd2oWKXqrAddG47kLcm/rwVUMVT1GeUZX7geTuSWzFGT1YP7f5mXO
         dsY2usZZx6WCKBOPS3ExgJoWkS3z10rX1LAtikVMK33zAYPCPB8sIEYVPbi0HTOtq3MJ
         t8cP2hyoD9NM3P2+qB5D0KBWiGgsQqMhbi/55HdmOodMbtaa4f7/bvgDJRGY4z4dzTOF
         ABng==
X-Gm-Message-State: AGRZ1gJ0RTJXbi43hV+ufDMz021EDjAfgMrRixIaN/9OkhI3T78+Owpr
        QWQG3dbuFb8sBvszE6hkk54GuG4eyn9fM8dSBXNmbA==
X-Google-Smtp-Source: AJdET5fPIIwJknb41JYU5KBaOcyMz5QZesu/TkkV9W+nZmDtft5Q3XixWbZ0ZkKxXT3xifbncpYGhzYmEDd0rq/T5Gw=
X-Received: by 2002:a19:c801:: with SMTP id y1mr11885559lff.53.1543092263785;
 Sat, 24 Nov 2018 12:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com> <1542363310.23489.22.camel@pengutronix.de>
 <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
In-Reply-To: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:44:11 +0100
Message-ID: <CACRpkda1FJOzBn42=7GgExA3fdNJabc_=JUba4y7k34uy9tsKA@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with "drm_dev_put"
To:     greenfoo@gluegarage.com
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Dave Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>, cocci@systeme.lip6.fr,
        Marek Vasut <marex@denx.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, abrodkin@synopsys.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux+etnaviv@armlinux.org.uk,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        etnaviv@lists.freedesktop.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        sean@poorly.run, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        michal.lkml@markovi.net,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 6:04 PM Fernando <greenfoo@gluegarage.com> wrote:

> I'm new on this, how should I proceed? Should I create a new (V2) patch series with
> these changes reverted? Or will the maintainer automatically take care
> of this when merging?

I fixed it :) I think. At least I hope I didn't do something bad.

Yours,
Linus Walleij
