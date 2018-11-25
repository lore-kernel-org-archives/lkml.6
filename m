Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE92084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF8fUsi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AE92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeKZCgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 21:36:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34501 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZCgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 21:36:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so14306496ljd.1;
        Sun, 25 Nov 2018 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ca2S2AGx0JbM4tvAfIZIGXtvcYbQk7xax4jM4JrCUMU=;
        b=XF8fUsi3dFYjlQCAzI0z5220eXX1i1Kp/UB8EIierMGrCid2v8yFJi2TigkVlijEwC
         5I+DF5knCdirFzFrhGUHbBAO8+61k7TM8xofPoV23IaakKrQLABSd7l9Xf0g0shX8Ktg
         OTT32idcg0qfrWlnfVlvGagt9vpWkLs17OSKE6wT5YPJjey4NHb7GhCcUApzLG7L0Xyq
         R6MfcOvxvKb7uqN0XPwrtSd8jiqO7NUbACogY1pNBCbY6Zl22nwcIfPtPl6fyYPEvsZy
         ew8RGwVI+s3CbpoeXHrsKofAe/XVrx6bayf5Gj399Op+Liwk2Us2M6dM3JB/p1TAqjgO
         jpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ca2S2AGx0JbM4tvAfIZIGXtvcYbQk7xax4jM4JrCUMU=;
        b=SPyaYFtB1A+RlubEsh2knSKuA84eoaDDRhcnYvk8zNiPJ3cJi6gNaNtcLjfN5zPT0z
         DrXHpk1rfrLD4IQmdxJaVa/lHwXHhE3iS3gUPn8Qwl6kYvwZXs4Rjt6LnEYTb89Enjk0
         nMPKb2SEwmiFoT3Ttak2Onz3V/Y58Ax2SGVsL3GJ8bNWef2HLThC89NSlOqu6KPRaC+3
         twGIvXZonnRorL64eTiU9gty1ALb03e5ye2PI44xE4ySgDOMqg1rYN5/KxWzXo3lZuv2
         aw8aC3ykmD7XQ4dlwdPhy/hpFmVZGZBpR5EiXfdpUnqsA6wyeCu4FDpq+48UerEzzULo
         dK5g==
X-Gm-Message-State: AGRZ1gLF97deKrOlYOaGMgytparDLTY4gzrqp3HHpaBSESH40MgRpoSt
        4sKr7HYFAOBJ09Pug5WU8Pjcj+FqEF8=
X-Google-Smtp-Source: AFSGD/W3/yjChsHJZYMt6mNfebpgDX4G3bwzVpi4GvgyKDonBkQ5Q9mT4rhflNQ/sv3ywRcnefTrYQ==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr13116396lje.171.1543160683155;
        Sun, 25 Nov 2018 07:44:43 -0800 (PST)
Received: from localhost (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id a18-v6sm8721172ljk.86.2018.11.25.07.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 07:44:42 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:44:23 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     jic23@jic23.retrosnub.co.uk, Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: add IIO_MASSCONCENTRATION channel type
Message-ID: <20181125154423.GC5053@arch>
References: <20181124221415.10081-1-tduszyns@gmail.com>
 <20181124221415.10081-2-tduszyns@gmail.com>
 <CAJCx=g=H6Zp4AtWPpC-KdZmyOxTymtdgf+Hx8VvThLFg0bjYVQ@mail.gmail.com>
 <20181125140316.59d9872b@archlinux>
 <CAJCx=g=oUmcfCA2octwfaoWr6aC=ZF7LUkMsraNe8buHc9mjPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJCx=g=oUmcfCA2octwfaoWr6aC=ZF7LUkMsraNe8buHc9mjPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 06:14:44AM -0800, Matt Ranostay wrote:
> On Sun, Nov 25, 2018 at 6:03 AM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Sun, 25 Nov 2018 05:51:32 -0800
> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >
> > > On Sat, Nov 24, 2018 at 2:14 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> > > >
> > > > Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
> > > > is de facto standard. Existing air quality sensors usually follow
> > > > this convention and are capable of returning measurements using
> > > > this unit.
> > > >
> > > > IIO currently does not offer suitable channel type for this
> > > > type of measurements hence this patch adds this.
> > > >
> > > > In addition, two modifiers are introduced used for distinguishing
> > > > between coarse (PM10) and fine particles (PM2p5) measurements, i.e
> > > > IIO_MOD_PM10 and IIO_MOD_PM2p5.
> > > >
> > > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++++++-
> > > >  drivers/iio/industrialio-core.c         |  3 +++
> > > >  include/uapi/linux/iio/types.h          |  3 +++
> > > >  tools/iio/iio_event_monitor.c           |  6 ++++++
> > > >  4 files changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > > index 8127a08e366d..ce0ed140660d 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > > @@ -1684,4 +1684,13 @@ KernelVersion:   4.18
> > > >  Contact:       linux-iio@vger.kernel.org
> > > >  Description:
> > > >                 Raw (unscaled) phase difference reading from channel Y
> > > > -               that can be processed to radians.
> > > > \ No newline at end of file
> > > > +               that can be processed to radians.
> > > > +
> > > > +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
> > > > +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
> > > > +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
> > > > +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
> > > > +KernelVersion: 4.21
> > > > +Contact:       linux-iio@vger.kernel.org
> > > > +Description:
> > > > +               Mass concentration reading of particulate matter in ug / m3.
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > > index a062cfddc5af..2a9ef600c1fb 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
> > > >         [IIO_GRAVITY]  = "gravity",
> > > >         [IIO_POSITIONRELATIVE]  = "positionrelative",
> > > >         [IIO_PHASE] = "phase",
> > > > +       [IIO_MASSCONCENTRATION] = "massconcentration",
> > > >  };
> > > >
> > > >  static const char * const iio_modifier_names[] = {
> > > > @@ -127,6 +128,8 @@ static const char * const iio_modifier_names[] = {
> > > >         [IIO_MOD_Q] = "q",
> > > >         [IIO_MOD_CO2] = "co2",
> > > >         [IIO_MOD_VOC] = "voc",
> > > > +       [IIO_MOD_PM2p5] = "pm2p5",
> > > > +       [IIO_MOD_PM10] = "pm10",
> > > >  };
> > > >
> > > >  /* relies on pairs of these shared then separate */
> > > > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > > > index 92baabc103ac..465044b42af5 100644
> > > > --- a/include/uapi/linux/iio/types.h
> > > > +++ b/include/uapi/linux/iio/types.h
> > > > @@ -46,6 +46,7 @@ enum iio_chan_type {
> > > >         IIO_GRAVITY,
> > > >         IIO_POSITIONRELATIVE,
> > > >         IIO_PHASE,
> > > > +       IIO_MASSCONCENTRATION,
> > >
> > > So I'm guessing IIO_CONCENTRATION can't be scaled to the micro-grams
> > > per cubic meter?
> >
> > Currently concentration is defined as a percentage reading of a substance
> > (which does make me wonder if it is meant to be percentage of the volume or
> > percentage of the mass?)  Either way, if can't convert to a density measurement
> > as it's a unit free ratio (I think).
>
> Seems like it can be both..  guessing all the atmosphere ( CO2, VOC,
> etc) ones are mass/density because on how they work.

Hmm, but still percentage was picked up for IIO_CONCENTRATION which does
really match PM expectations. Perhaps if units were sticked to modifiers
it whould be easier to reuse that.

> But the electro-conductivity sensor that is using IIO_CONCENTRATION
> channels is likely from percentage of volume.
>
> - Matt
>
> >
> > >
> > > >  };
> > > >
> > > >  enum iio_modifier {
> > > > @@ -87,6 +88,8 @@ enum iio_modifier {
> > > >         IIO_MOD_VOC,
> > > >         IIO_MOD_LIGHT_UV,
> > > >         IIO_MOD_LIGHT_DUV,
> > > > +       IIO_MOD_PM2p5,
> > >
> > > I know this is unit of measure but the lowercase p in IIO_MOD_PM2p5 is
> > > a bit non-standard for iio defines/enum.
> > It is a bit odd and will get us scripted reports so maybe best to
> > just go upper case and not worry about it.
> >
> > Jonathan
> > >
> > > - Matt
> > >
> > > > +       IIO_MOD_PM10,
> > > >  };
> > > >
> > > >  enum iio_event_type {
> > > > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > > > index ac2de6b7e89f..f0fcfeddba2b 100644
> > > > --- a/tools/iio/iio_event_monitor.c
> > > > +++ b/tools/iio/iio_event_monitor.c
> > > > @@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
> > > >         [IIO_GRAVITY] = "gravity",
> > > >         [IIO_POSITIONRELATIVE] = "positionrelative",
> > > >         [IIO_PHASE] = "phase",
> > > > +       [IIO_MASSCONCENTRATION] = "massconcentration",
> > > >  };
> > > >
> > > >  static const char * const iio_ev_type_text[] = {
> > > > @@ -115,6 +116,8 @@ static const char * const iio_modifier_names[] = {
> > > >         [IIO_MOD_Q] = "q",
> > > >         [IIO_MOD_CO2] = "co2",
> > > >         [IIO_MOD_VOC] = "voc",
> > > > +       [IIO_MOD_PM2p5] = "pm2p5",
> > > > +       [IIO_MOD_PM10] = "pm10",
> > > >  };
> > > >
> > > >  static bool event_is_known(struct iio_event_data *event)
> > > > @@ -156,6 +159,7 @@ static bool event_is_known(struct iio_event_data *event)
> > > >         case IIO_GRAVITY:
> > > >         case IIO_POSITIONRELATIVE:
> > > >         case IIO_PHASE:
> > > > +       case IIO_MASSCONCENTRATION:
> > > >                 break;
> > > >         default:
> > > >                 return false;
> > > > @@ -200,6 +204,8 @@ static bool event_is_known(struct iio_event_data *event)
> > > >         case IIO_MOD_Q:
> > > >         case IIO_MOD_CO2:
> > > >         case IIO_MOD_VOC:
> > > > +       case IIO_MOD_PM2p5:
> > > > +       case IIO_MOD_PM10:
> > > >                 break;
> > > >         default:
> > > >                 return false;
> > > > --
> > > > 2.19.2
> > > >
> >
