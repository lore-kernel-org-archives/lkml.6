Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677E5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268502082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRIC0X3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268502082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeKYHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:35:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35378 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeKYHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:35:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so13294745ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPfyQ+7n1YYX7CPsLFiLqlbk/g/+BhVnBee1KeCITsw=;
        b=kRIC0X3xR7w0MN5vhWpzOuocor2Adll+gKhIcAdHsl8nPmxwpaAtiWacEJR1HRw0Vy
         kX/+oH/zRukHEOOjiBOKG7/fjvpdzurgfpt4CJk1Hm4DTOe0OaBsxUBtKu+Qg1a6mvcT
         3r6arwVXXMrB2CBm1RIeXfvyaLfPDaUTZZH4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPfyQ+7n1YYX7CPsLFiLqlbk/g/+BhVnBee1KeCITsw=;
        b=LAcX8sfr1e/X/97dugRZ4svrRqPtneUlpLCQZt2+4LhQ8jgMUf5qTxwaBMRm+Z/Kmq
         UrtpBLSxmB3bgWv+g6p2wz4SF2505EMus1pVHUAvqbKC2StW2WsUiOyYUUHMHU8NCBm0
         GFSnCG2lNXx7G30udodxqclvxPxa2Ph5+ntkvhU63BmHyYTNCbCoRB1xtvfX5kTp2nkh
         AQYn4+jz3ONpKvyUWKt4WQAR3l48oOeE0qRseR1dwPL9rk+ksMqrlAJxQNLajznC3PSW
         SnBqoo1eXWEaXn74cXVJCU7ykZaDeC3U2ihH1TLRYGhMXJcZlSzafJOx6hTUVfVDQDID
         K9Ag==
X-Gm-Message-State: AA+aEWauxWqaDAsefjZB+yv56fhY7+xEkwsMGa7YXR/pEmREPCbJCLOb
        0TQyNixYzKR8IDcMdP52htDzb/a4uw8hMYptU6UybQ==
X-Google-Smtp-Source: AJdET5dOlzltbyljr++5GfM6EIVINqzc81nKgQY3MQlNzVDc/tyYJnO9Phc/L7QlVgQepJmBZWVG1kkBG1Rm8vMpK0c=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr13069874ljc.97.1543092363062;
 Sat, 24 Nov 2018 12:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-5-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-5-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:45:51 +0100
Message-ID: <CACRpkdb9=s9oFgOKBWD_V7rdVGz1WCxuU+t_4SBymvj93MUR+g@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm: remove deprecated "drm_dev_unref" function
To:     greenfoo@gluegarage.com
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
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

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> There are no more places where this (deprecated) function is being used
> from, thus it can now be removed.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied.

Yours,
Linus Walleij
