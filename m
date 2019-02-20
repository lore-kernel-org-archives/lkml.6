Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A6EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4371F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1ABLiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBTOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:05:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36971 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBTOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:05:32 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so15678987itc.2;
        Wed, 20 Feb 2019 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnywmEJQ5bqQfLzt5vAo/SeZGb+fbCTVsFOC8aD5U+k=;
        b=Pm1ABLiqKzTgx4IqWkAR+p4uEpDoZhOJdfBeEz8k4TkLnUzPyjEmPYO/4G+62Pb7dR
         IyNzcoA9tC1VVdWHYx8EdRfkeccn0X0ayaINcDrAacAZDJeytRsJN7noU/3mhSdNwOh0
         oQ4JtvFviLpqOs7/3REZExZgYlRRjx6vUNRMAJF+lu5UiNDM60ReG5AmXUf0BSHkrQPk
         yRo6BDGlmezfSAEN0gz/nm4TVBmcEyF739tUN7S/68uQjq3Z5ZiwBJ6+xWe9NUcvdymJ
         O3epdF6UpwQ6g52rJwvFFcJTKKx9R9R+FFAY9h3lTOdL4FGkCGDl86hfRJOAuzea1+sk
         qLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnywmEJQ5bqQfLzt5vAo/SeZGb+fbCTVsFOC8aD5U+k=;
        b=VaL9eWbBmVXIMD7MkUB/3hVyodaeuEkoPq6puNI41uZA7T4ubS9iQsy22gTJQo9FKp
         6VrZMXZG41moGCSdGW59POsKATssrFZbblxN9Zrart1W2fRUgRXTDbNOFBWGzZxuurE3
         YevkTxrv3v0JhkJVlQk0RsVjsMQqTaX2RHDgBgsTU0YwSpFwZnpHdg5vwCHTxwk+SCfb
         ir9uyRZ9pNrG28zuO4+saRIvkv7r0rSta/87j9wo3bYPiQRSUVlnhPfw/BHgu90CA+h9
         hqZoQzF0JZeIIvTaegQqJnuJqBWJAyvK6Z8hiN4Mc+AJxigMCO0KPBks+opbHUbtTGF4
         BjNQ==
X-Gm-Message-State: AHQUAuY45AKnBVm4YwM9qcaiZ6BFMdjiJn/ilyzMsygbP2e+pzKg1N4V
        c3ote5TwmCo7qMmMJdLf5UnCaBC5IA8FmfZhk9Y=
X-Google-Smtp-Source: AHgI3IbJeMnsMeF+/G16AeQOjBWzNw3gOKSEJSQa+9nd2GBfJ8AgKXKSiVFKRLJnpkEGeR0pTNflF93XZ0kCWVBwe2k=
X-Received: by 2002:a6b:7108:: with SMTP id q8mr19381004iog.7.1550671531649;
 Wed, 20 Feb 2019 06:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com> <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
In-Reply-To: <20190218084931.fdut6d4cgwkwvihx@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 20 Feb 2019 22:05:10 +0800
Message-ID: <CAEExFWuAwUzXwjTiekGsjxY0Jop5_tYVgLj5gi9+Kqq=aFyT4w@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Maxime and ChenYu,

On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > Add support for H5's SID controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index 570a2e354f30..036029e90921 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> >       .size = 0x100,
> >  };
> >
> > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > +     .value_offset = 0x200,
> > +     .size = 0x100,
> > +};
>
> IIRC, there was an endianness issue on the newer SoCs, with the driver
> converting the data from big endian to little endian, while it's
> actually stored little endian in the SID.
>
> Have you checked the SID content?
It seems that data by hexdump /sys/bus/nvmem/devices/sunxi_sid/nvmem or
by md command in uboot , the data is different in some soc.

Sorry, I replied a bit late.
Any suggestions to solve it?

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
