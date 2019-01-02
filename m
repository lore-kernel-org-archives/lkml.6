Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C041218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFt7daVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfABSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:18:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfABSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:18:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so14884762pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=4BX045HuqzZQyLnghk5iaBiLMxe1Qq6U3uS4PB9/uLg=;
        b=PFt7daVNho4cL+SGAaJnt6xRclJEymy7RG1WUL+d3dyiTbMU0otgop2rC4MQffKGrA
         XG7N3vNiUXJ62b6+G+UUR6BxKSnXYO7A+l3Wv942x7lDb2iWUOD8TrzG9BxMHObIH4Ya
         k0qgzHq0RFyCveyIdYrgQigxU18J5xcJ6A7TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=4BX045HuqzZQyLnghk5iaBiLMxe1Qq6U3uS4PB9/uLg=;
        b=POwoA+5jeMtR9PeQSxUY2D4K+UiyxLxQfLd9QXX9LjSDxNnm7eVog9/LfOFQn0m3aQ
         fSlFkcZZir2zZXMM5rdlfdFItVUZ8nNtjee2eBpTsU97wf4WC+OXtDhhpGINeApzQgNQ
         NGdzW8yCYFib0dxf9nOxq91ytew309JPz3Hqg0s33nxR4sFTMLhi7GQzG16J7zfjoJzx
         MvUmLjucwXMPv0TAgUmyLwaGmjkfyTksNzUyB+v1s5/2KIOyOE5wuY7wfPt7jUCbsQdy
         XjXYDqln9XXCQOHRr5t1zaNgU543kR6Hk3mGNsIUppuXrEcXTO8/1QtXIakpKgNfNKef
         aIRA==
X-Gm-Message-State: AA+aEWZPz6tOiWDthTkJuG8gU2p0eV7wL1coCMuKQz4QRXzoyknVdBVt
        AP6OXTI5mHCGm2ChA3Ev/rLpeA==
X-Google-Smtp-Source: AFSGD/UPHpLjW+AXVFjEjAm75gjeEgjowwb3HS9AAeGheP1dpquQ//uCgTP9undsY4Tnx9xebWkFng==
X-Received: by 2002:a62:6799:: with SMTP id t25mr45307411pfj.139.1546453080499;
        Wed, 02 Jan 2019 10:18:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n73sm86997017pfj.148.2019.01.02.10.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 10:17:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] driver core: platform: Add an error message to platform_get_irq*()
Cc:     Rob Herring <robh@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
In-Reply-To: <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com> <20181228215620.120672-1-swboyd@chromium.org> <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
Message-ID: <154645307874.15366.9874268705850757907@swboyd.mtv.corp.google.com>
Date:   Wed, 02 Jan 2019 10:17:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2018-12-30 02:42:39)
> On Fri, Dec 28, 2018 at 11:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > A grep of the kernel shows that many drivers print an error message if
> > they fail to get the irq they're looking for. Furthermore, those drivers
> > all decide to print the device name, or not, and the irq they were
> > requesting, or not, etc. Let's consolidate all these error messages into
> > the API itself, allowing us to get rid of the error messages in each
> > driver.
>=20
> > +static int __platform_get_irq(struct platform_device *dev, unsigned in=
t num, bool warn)
> >  {
>=20
> > +error:
> > +       if (warn)
> > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * platform_get_irq - get an IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + */
> > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > +{
> > +       return __platform_get_irq(dev, num, true);
>=20
> Hmm... Why not just  do
> int  ret =3D __plaform_get_irq();
> if (ret)
>  dev_err();
> return ret;
>=20
> instead of big refactoring of platform_get_irq()?

Sure. Thanks for the suggestion. But we need to check for ret < 0 I
suppose so that we don't print an error message for all the irq numbers.
I'll send the updated patch as a v3.

