Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED6DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B8C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G8bckasn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBTLFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:05:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55463 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfBTLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:05:24 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so14225834itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ooLOu41hAAeatwRBEdyipCEi+tAFWjQHi+FbOCLN3sE=;
        b=G8bckasnWI6+zByVO1nyaQSVr30LWeTtsQx37q277BVL9sXOd+XT+Q+IMxZKU1vPvl
         pJVPNG5zPorFypzQddHatkm+18UUrcjZDpmPCua57bMT+bl5Z/dYI4r+K7/RKgrtSw+g
         2con0dziaI7uLxpoWsSVUL8I1+Il/2GK0ZQXx2MbdYMu8QHFWPu5YpzxxHG82OSqAVh6
         qi7hVdbeS2hD3e7nJsI/LWTOGQLLRUnE2VfQ9AiIA9FnOGqxgKtH8rqdB7fCIGUKpOdc
         klLqn5EiwoePxWK41UxfbgUApmGgqJZDnTz2RfRQMxa1REpzJUXsmOfuOTuW7YGFBZGz
         w0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ooLOu41hAAeatwRBEdyipCEi+tAFWjQHi+FbOCLN3sE=;
        b=ZbrnTvsOjOmjwhOgr0quWci6j2yxrkwN1ePqLYEhSPIJxQ7Yh/ijrcPAfcKvKXZw4U
         qDy4NYeO93ohdICXY+IFIB20CPoOdjrNlSjESAI/wi+TdV65SyccyuwlyuAdrDZPz17E
         9lKsZY5aHPtQ9ozaMeuSADraUTjAXM8duBK857gMCA2caopyosbNQIzzyDVrVsbqbwZ3
         bbJZ92H8FeefBp4+/DBwGvRdqfAueIqOYcn5dxYYJylyNoxC+V7a2SvsRPJTNijHJmYk
         QlMbNQJdvq6vAbMWDR4wPtm4ngOWunuY2NSOIIxQEQuBoEqJnKEht+WGg2aw0OGqMTde
         vRUw==
X-Gm-Message-State: AHQUAuZ0MoDYlFjN5WxlJLc20oCRqH9N/aKegLIh8KQpiQTVrDfnpVRE
        TXOcVVaMW8tKJQI0Xh0v7E3ZaI3m/MCMsF0KZGvjRA==
X-Google-Smtp-Source: AHgI3Ia6YUYsA4j9e3x71KF+BPqxXMbBF7KbohguMGP0rkjLYGhBLGCNnM7hYA5BUJhL11XVuoMcSof2uBhvQ0O9azo=
X-Received: by 2002:a24:2b8c:: with SMTP id h134mr5665379ita.53.1550660723256;
 Wed, 20 Feb 2019 03:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20190215152507.31066-1-brgl@bgdev.pl> <20190215152507.31066-2-brgl@bgdev.pl>
 <CACRpkdY43ojBZ1NUyvc0X8+3tc3=jhv4S2oJX2v-88TgrKxQqg@mail.gmail.com>
In-Reply-To: <CACRpkdY43ojBZ1NUyvc0X8+3tc3=jhv4S2oJX2v-88TgrKxQqg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Feb 2019 12:05:12 +0100
Message-ID: <CAMRc=Mdd2QXYjxJGp22OqBeyB+vm1Oe+OKgcB4OgYx3NS+yMEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: provide devm_platform_ioremap_resource()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 lut 2019 o 10:57 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
>
> On Fri, Feb 15, 2019 at 4:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > There are currently 1200+ instances of using platform_get_resource()
> > and devm_ioremap_resource() together in the kernel tree.
> >
> > This patch wraps these two calls in a single helper. Thanks to that
> > we don't have to declare a local variable for struct resource * and can
> > omit the redundant argument for resource type. We also have one
> > function call less.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This makes a lot of sense. I think Andy can confirm the value, he
> knows a lot about good helpers.
>
> I'd need Greg's ACK on this before merging through GPIO.
>
> Can we make a script or coccinelle thing to fix them all when this
> is applied?
>

Yes, it's on my list (and also a chance to learn first hand how to
work with coccinelle), but we first need this function upstream. I'll
resend a v2 with the EXPORT_SYMBOL fixed.

Bart
