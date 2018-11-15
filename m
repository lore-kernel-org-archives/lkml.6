Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wOkJUz5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E9121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbeKPAw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:52:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41922 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPAw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:52:58 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so2723940ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM/erqQoyAE4x89zzue0iS64mJoKOr90Yd/aQrgawJc=;
        b=wOkJUz5vg2srmlzzx3hztqzlTZFiDNst+bwUM6oUZw9UcX4lo7oRW+sQlRz0BiYmqe
         RvKbTm9/pb2ermvfqLQLahuTY+lLcgwacQUJkFEq+/fXYyDAUHhN10KNgTqVeNqXmpiR
         sWoikHRryRW2d66KIXMxmW3+0rNUT4X1HSecDyA1ry4CvUq3lrm4+om7RAMwM8GASMQw
         bci97wfFtLjUk6IYVLHE02e5XF8wCA104lOngmuDJpHgy3t8fGboSUcufFbF51m5Zjaa
         XrrBGk1YVJE0B0LFRa3OTexGR84eDYPw1QD6iha7N9J6IF3LzYlaT/Ai6zntejTDP+fa
         tesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM/erqQoyAE4x89zzue0iS64mJoKOr90Yd/aQrgawJc=;
        b=uWZjijAqZyl75tq7P7eKDKbzuZjcW0a2fdl/c/mMOR5P3QTpAotNCYkluU8zbl/w9Y
         wLT/eul+wPfOU6oB+G4CjS0yyqYf18N+u2OMWSU3ncsvsK6C0YxkSgbvMF/EsmnaHebw
         N/6KN3Z1BJ295fhMDKL06HAX/E64b032ez2IsORclIZzYBqWBjeWCUJbH4LeyULnE2l6
         4/X8i8egX8drN1kdNETjWC/M7lSg/ZT1lsR5DQWvDCv4IgXkVqGUEqAqGRzWfAXU7y9k
         CCfoN5HmdkSzmWEI02bluQARCz6NX+P5mTshpmVLXxBjOrCHXscbMXC1gjBml7+mtnI2
         U+0w==
X-Gm-Message-State: AA+aEWZXfszTyvB0wK7L4411VbduFqmvTfnntifq1IVyF79L+JvvUuT1
        2Lj4Msy1WrPhW0mLLFWcC9qidvlQoDo3FuYILGNNfg==
X-Google-Smtp-Source: AFSGD/XeC6WIzR8TKRGv0JtJLiuYrxaRr7OhC1U3pe5TfGbFehX6P1JDIhCqBjtGj5M6RLIouQR7ZT9XhoiP+WQ2jwg=
X-Received: by 2002:a5e:9701:: with SMTP id w1-v6mr5164252ioj.257.1542293090502;
 Thu, 15 Nov 2018 06:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-3-matheus.bernardino@usp.br> <20181111114224.1d8cfaec@archlinux>
In-Reply-To: <20181111114224.1d8cfaec@archlinux>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 15 Nov 2018 12:44:39 -0200
Message-ID: <CAHd-oW5ax5uj=xtpOD3HYHT+TM8eAZ6kJ91mHpFVf+VFX6NoeQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] staging:iio:ad2s90: Remove spi setup that should be
 done via dt
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:42 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri,  9 Nov 2018 20:00:40 -0200
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> > The ad2s90 driver currently sets some spi settings (max_speed_hz and
> > mode) at ad2s90_probe. This should, instead, be handled via device tree.
> > This patch removes these configurations from the probe function.
> >
> > Note: The way in which the mentioned spi settings need to be specified
> > on the ad2s90's node of a device tree will be documented in the future
> > patch "dt-bindings:iio:resolver: Add docs for ad2s90".
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> I'd actually like to get Rob and Mark's views on this one.  Previously
> I would just have applied it without thinking on the basis these can
> be easily specified from devicetree.
>
> Recent discussions with Rob have suggested that the settings in devicetree
> should perhaps be concerned with specifying constraints about the device
> that are not visible to the driver.  The driver itself should apply
> the device constraints, but there are others such as wiring that
> might reduce the maximum frequency for example...
>
> So should a driver be clamping an over specified value from DT for
> example?  Or given that is optional in DT, should it be making sure
> that a controller max frequency isn't too high for the sensor?
>

First of all, thanks for the review and comments.

By what you've said here and in the reviews for patches 3 and 4 of
this patch-set, it seems to me that the most reasonable thing would be
to keep the SPI mode 3 settings at the driver but the max frequency
setting at DT and check if it exceeds the maximum at the driver (as
patch 3 does). This makes sense to me, based on what you've said,
because mode 3 is a device constraint visible to the driver (as it
won't change) but max frequency is not (because of things such as
wiring, as you said).

What do you think, Jonathan, Rob, and Mark?

Matheus

> It seems to be unusual to do this, but to my mind it would make
> sense and might be worth pushing out into more drivers.
>
> Jonathan
> > ---
> >  drivers/staging/iio/resolver/ad2s90.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > index ff32ca76ca00..95c118c48400 100644
> > --- a/drivers/staging/iio/resolver/ad2s90.c
> > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > @@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
> >  {
> >       struct iio_dev *indio_dev;
> >       struct ad2s90_state *st;
> > -     int ret;
> >
> >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >       if (!indio_dev)
> > @@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
> >       indio_dev->num_channels = 1;
> >       indio_dev->name = spi_get_device_id(spi)->name;
> >
> > -     /* need 600ns between CS and the first falling edge of SCLK */
> > -     spi->max_speed_hz = 830000;
> > -     spi->mode = SPI_MODE_3;
> > -     ret = spi_setup(spi);
> > -
> > -     if (ret < 0) {
> > -             dev_err(&spi->dev, "spi_setup failed!\n");
> > -             return ret;
> > -     }
> > -
> >       return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >  }
> >
>
