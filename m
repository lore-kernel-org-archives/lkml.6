Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92695C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D8820874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="btHfR92E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D8820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKYHsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:48:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43496 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKYHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:48:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so13261826ljf.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIxw+Yv0PQVXma0Dx+fjN/DXfhPViTkH38A5jStFkdQ=;
        b=btHfR92EH0oQ7CQWU2asTkt7th7d/Pfmtwv8/QWR2UaM8O3FqlRMUoHUd9V+zqnEkc
         H2+6bG7f4Mjfl8BB+YT+lntA+dkMofoJ6dqFq23mHcdAB762Dx/6jWQ05wWRac9tB2J0
         Rnrx6by+Inf7WFFH3hydd48TW/OtncE4pN9MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIxw+Yv0PQVXma0Dx+fjN/DXfhPViTkH38A5jStFkdQ=;
        b=ifNOzYOuiUwvzC8Lq0RpDK6hAW6gfWOhB7b56zaFuy2XMOlzpnqXI/nDcAl1CtDNjp
         +zILfPwMHsK2+K6zZna0HWyxY5Gtfb7fW4MgJFYWXXTozNS5JriA1hkkcIypTZ1P77tB
         v6mXfbKgUenAG+S3+lCGa2d3L75wQa3zcvTXv4HJdbC1Adn+0tZMkAnL5x4S6nC8pdR9
         Iln+B/iorg1jSKuzJAlA7fPu2CSnQrSyCF41eXeQdyVv3CyblFt8J6hwFy8re/O5XkaR
         USmyLX2hYQDOZyXcpS2pyzY9kES7/zrhrJLKMeos5/miX26sqMJWGsYqW/xT/zI/fBJb
         jqfg==
X-Gm-Message-State: AA+aEWbSQszPYvABwHh5GhoPxJMGgVZl6ZxKb1qYoV5hlkjwXyKUaPX4
        ptk+0wSG/el4klFNWOXSKuomJAooKmfiBj2LXfaWIUStkbY=
X-Google-Smtp-Source: AFSGD/V3J7VpJHFXkNmRsM2IxwizFs79rZK+D8eZtt95ixlP6XqtpkhhYnmObkPfTywdCOlZO7rZIci8vQ7OocU/Arw=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr11828648ljj.120.1543093162121;
 Sat, 24 Nov 2018 12:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-10-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-10-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:59:10 +0100
Message-ID: <CACRpkdbRbXCq8DjzeJSGmH=tcb+B1f24oO209wMsLxAdHzvdkg@mail.gmail.com>
Subject: Re: [PATCH 9/9] docs: drm: remove no longer relevant TODO entry
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

On Thu, Nov 15, 2018 at 11:18 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> This entry asked to rename all drm core "*_reference/_unrefence"
> functions to "*_get/_put".
>
> Now that this task is complete, we can remove this entry from the TODO
> list.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied.

Yours,
Linus Walleij
