Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DE3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B97020874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+ozAtAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B97020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeKYHpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:45:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36982 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeKYHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:45:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so13281216lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPfyQ+7n1YYX7CPsLFiLqlbk/g/+BhVnBee1KeCITsw=;
        b=K+ozAtAkj+cEJPolhQSlJhhOzt1MQp2p7bscWS0hcwJjgnUQ5T70sgxOX1JWaEykUU
         C0xTjrWgPA37PMOoDVz9yBpX747po7o0g7C5GH/8DoLVR3aiA15kgNq202gYCYeAK6S3
         paKpv4AdjF9FyxTV3QmT6VpVpFUsHIzsW+Fa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPfyQ+7n1YYX7CPsLFiLqlbk/g/+BhVnBee1KeCITsw=;
        b=n2DpD8/9ZDDCmHSUTVgGQS5ljDJFGNwBQDXGDSMUS2CiSA1BSZEdCLVB10uEHkir/Z
         S5hAPwLwr0/2AyI62IDwTYl4/b0RUlDJMc4TDAC+BOmqMOXQSWpEGPscbVtToQ00M7hJ
         n4t5Yi9zz/NAE+BoTWUjVSDt5dhT5V+jmyMKa3CJSl7sxtON1nXNqulTaQS8jM7rsP6S
         Onkl2RbpaXfrT5/9/5HPnnYW4aEBOhKKEOcJIeTedUB/wMvpIFUDOJI6iXCJzY9CBXjl
         tvlodrQC1CfwJfqT6bL1SDwrMutVEPp0eCF6Lhi8YQzZuFvoLpQ1VUwQKYG6piDAsFdo
         E4Mw==
X-Gm-Message-State: AA+aEWal/QHvKw5RcOMqyH3orO7yMeq5CEMsjBG6K+KT0Od1mFSfX2uq
        o7XCCVcgdkziaFQ65NwjLdCCJcBmarsffR+7kpt88w==
X-Google-Smtp-Source: AFSGD/XA19TvIu5XxzdQPDRN8FU1WiyCel4XONUhvvUw0SPXcY9zAU+ZjL2a3ErzOgI77bC/Kd1UBaLst+S8dKF/BR8=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr12979412ljc.66.1543092947655;
 Sat, 24 Nov 2018 12:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-8-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-8-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:55:35 +0100
Message-ID: <CACRpkdbj1q8qSR3ffJOki2pcB-rj5-sq2CDdUKUZ0UD=m0_cAQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] drm: remove deprecated "drm_framebuffer_[un]reference"
 functions
To:     greenfoo@gluegarage.com
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
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

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> There are no more places where this (deprecated) function is being used
> from, thus it can now be removed.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied.

Yours,
Linus Walleij
