Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD9EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F562082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8JxDTkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F562082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeKYH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:28:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37298 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeKYH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:28:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so13265445lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MemGfOqxhb4bbzDSIHdqtma18mku1RRMcm6AHUMBKwc=;
        b=V8JxDTkloCGYAza57L/wVUlXIigfX8RjZnYh6L3ieVMg4v8+U0RUVAG2hMQzNxbIF2
         JKb+3dE4yMPU262wVBS1aWAmvUHwpdf3AU8BaYIKPMv2bbvmJiIFw1MsEbTf9Mv6YLC9
         6yC0rCKQ/mjRahqVnSvD/JpyJt5D/D/C1GHSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MemGfOqxhb4bbzDSIHdqtma18mku1RRMcm6AHUMBKwc=;
        b=DeONOEdN+VNuuSOoJt7eqKXQWE5It601fAJgNZFRHZgXg9B7R1Yt7CNmvNiIBexwnW
         sfxhtL92T3DT+ZiSsGQ+bvo9ScPPKoxAEI/FQtf8l8m1Z02hv1zeB5/ezuoIFw0t5ZxL
         TNaVCmsmkQX5fAjqB3/WrnTae754QWHA+5V+0rPvIrmSxA37Guf+lqF26L3xKGvRVbg6
         w8Fgdp7H8PxEEG34a6UR0SM0v4zmMSLoqdXraEvQsDLqMdbK11EFGHSfz7J52Rq2QYKL
         YCBPH2B8+3PovFZJ0t6ZOg5XJdrHpCaCfHaJYvv4pAAXjROpJL8cCchl/g8LLMcOvJfm
         TSHQ==
X-Gm-Message-State: AA+aEWYbP4gKEBaCxoX1dPmChTZw5pBx2ZFZsQGryFNyxYqapV62yYY/
        4O2y05d6DSzlAvEW89gfZtF+H7X08XYwL34oJPJDcA==
X-Google-Smtp-Source: AFSGD/XC6KXTjoxX9zEf/MyCQjYRS7MODc2B1wcixAJcS2bwJ20s7qPBbusb82qy/27Ifzg0VN7yc6AyEXkMKoN8mbc=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr11674367ljj.9.1543091927901;
 Sat, 24 Nov 2018 12:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-3-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-3-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:38:35 +0100
Message-ID: <CACRpkdZu+RPr4MrsqF_t4Rd0LAu_rYR4omoLh69+02Qhg21jxw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm: remove deprecated "[__]drm_gem_object_[un]reference[_locked]"
 functions
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

> There are no more places where these (deprecated) functions are being
> used from, thus they can now be removed.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied to drm-misc-next.

Yours,
Linus Walleij
