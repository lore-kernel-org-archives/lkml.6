Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDW0BNOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B5F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbeKPIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:48:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33411 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPIse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:48:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so18648210ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXqCNsRnQbG4WjKdL9YGXyFWRA6BFn3DdUb1fgQJwjo=;
        b=GDW0BNOiljUFmdnNq/ha2hXUSbIGKgBh7FNi/ONlT2Hf8nnlG89WsxR7JCQRsQuyw4
         Zca0DdFpy8au6Or48w988hwqvp56S0nWl4Udslb/hLjpnOeRyJbRRd3UkTvsBtRJrVuO
         E6H0GCBybFc+Iti7VcRKr5/mbWO68itWLOrpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXqCNsRnQbG4WjKdL9YGXyFWRA6BFn3DdUb1fgQJwjo=;
        b=lEV/3+RqYXf1YDCULEQyBIA7q3dPsyNubag0QfgMC1UjzIIw63LdQDb2K+bjqcqyKj
         aHXJGBsAwEtVVHD7j0uKlzbnqzOkcUlPrQxmc6xO3Lg9m3msqIontF1cySrf2FT1o4+6
         Ddi/muchMljA/pA8iONHzZRMZ4hHwGK2qAgw00/zD9bCfzbU9SWXISxm7wPie6lu9/Ww
         nxxau0Xnj1QkRq7opUIhQDRT4an3VabPMFg96+kmJiZ+zm57QXlA6BOlwC944OxTf2Dt
         2SWfDB7bM64DoR6wvqFzqg0+rIKdRwKmPQVMOBYY53S5LE4+gprCM6nTNpjjJG34vU0+
         U8nA==
X-Gm-Message-State: AGRZ1gLJ9LY7HrJNRh459NVZTMb6+b+X8668HP2CV/t4mxS8sIoAz5OU
        P2nX8GmqNjOJSYu5RuI/blKl96GQ7Gju89Tw4aQpLA==
X-Google-Smtp-Source: AJdET5fH0oQIDoa2/vLV5ZynXR7Yp7rKSkY/M9aVwgiOTxCI1h96LEZQmd2whxVHe+veTtkmej8toGDJXpGpbg4H1wo=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr4605034ljg.23.1542321528348;
 Thu, 15 Nov 2018 14:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 23:38:35 +0100
Message-ID: <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
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
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
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

> One of the things in the DRM TODO list ("Documentation/gpu/todo.rst") was to
> "switch from reference/unreference to get/put". That's what this patch series is
> about.

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
