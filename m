Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D426C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A29217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JaE2w7ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfACQMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:12:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfACQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:12:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so16194677pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=j51rfX6wnYKjcDiMwHcW7yVFPbV8mnVTvkI9KgLgShg=;
        b=JaE2w7ST29UZmkZPVI7AxzMfWlORWEFj7Rd0JibNoV9y8F25kf/RD/lSTOMuegYsah
         /oq6PHK09n0aG5VE3ql7HIN9riu5GdCcf1RLLN8pggvnPyXhi1+ZAhlkCx2BQDNExQa0
         0PhZT4080ztEB7d531xZAC8Ba/DE+gxzNYTyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=j51rfX6wnYKjcDiMwHcW7yVFPbV8mnVTvkI9KgLgShg=;
        b=cidT3fmPx90+Co2N9dbJJsWlvZci7EHHB2H0DD8GxM82fnNC109lwCl7aNR8y/EQts
         TCuEMALc/mWvaPs/5y5gi6nc+DXTpA4o1kT6LnEvQEowjxeG8/5CrbNs8DR/e7dhoP3x
         7fhUWj2suQvC5P2y/fH09UfOpt//65C1AW5cN5tBRTedS5foZNF6olYmwc/B7bCMTB9H
         rcJNNrkE6P6fEcA2hAp3LvxpDe/goA5W41eAO5fiqrtdKDGdG/z8KDD2kYbo0N5ePJkD
         YkNCfVJVfJu5yrUMOt/YRiDKZayaWUSigEgWxXg4WK2X7rfmD1p+gmH7gzPIIrcTnCct
         jICQ==
X-Gm-Message-State: AA+aEWYaCKizd/Y6X5Let9H7D+wL10699Ly4FXVFVdP+o7975N85XrI6
        LK+lJYBSXPcphfflgGAizp0yew==
X-Google-Smtp-Source: AFSGD/XuCw0hsJkDC3j5+y0kOHh6FU6j34xxri+Ugu+SPl23SgyHan9DK0b2+89V6ZVsmGdX+ZlFoQ==
X-Received: by 2002:a62:1112:: with SMTP id z18mr48399261pfi.173.1546531921854;
        Thu, 03 Jan 2019 08:12:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v5sm93011023pgn.5.2019.01.03.08.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 08:12:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
Cc:     Rob Herring <robh@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com> <20190102185106.56913-1-swboyd@chromium.org> <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
Message-ID: <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 08:11:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-01-03 01:40:26)
> On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, =
unsigned int num)
> >         return r ? r->start : -ENXIO;
> >  #endif
> >  }
> > +
> > +/**
> > + * platform_get_irq - get an IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + */
> > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > +{
> > +       int ret;
> > +
> > +       ret =3D __platform_get_irq(dev, num);
> > +       if (ret < 0 && ret !=3D -EPROBE_DEFER)
> > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
>=20
> Why don't you log the error code too?
>=20

I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
left out the error code.

