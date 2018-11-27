Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184E2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="i/EQwmsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5184E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeK0SUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:20:38 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33574 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeK0SUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:20:38 -0500
Received: by mail-vk1-f194.google.com with SMTP id d201so4828716vka.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fqg86FRXYw9sFN4NZt6ovSqVnyOsrTynUVh/pu6ir0I=;
        b=i/EQwmsnvSR4F3GXJVNsMWU+e4ahPVvy0V+mmJfoAHix7WDpagAjd8HIQt8QtRoBAt
         rqm7PlI4oeLg80kunq2q02il36/26ROJYzrLxiDoF1ObscC8PLHHeyzRmXur5Fr+Nf9a
         Nnan6rjCn2UftwmX2gAnhoE4i7ada0XQ4bs2/uTL1Kx6sKq25biGgQQEatD573IKTO1m
         Vt3slaAfr7C74/Jd6n3PB5CStrNsHNYvm6lXd6+NChxeRFJR1GKgzf+Vb3gfhOJLY5fu
         LQ/zP8SicHtW6gY01N3E+UcA9xaA2vjJAj1snubUmtZ5xP+D3orBPSPdPW2lFIZ4dvyL
         wJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fqg86FRXYw9sFN4NZt6ovSqVnyOsrTynUVh/pu6ir0I=;
        b=Kfnkp/Fz1RRDvJVOJFeNx7FrZQTm4sml7fjUwlYX4bbZtQeIMeGJOmlg83u/RLTb84
         ZqO709zOOJ4XwI56hkTsDnz6oFv0EHOpc/D9NZGHpPDRryZ0wWpveVvPPoKGsfD1V0AA
         ckHHPCdQLGtjR4LH5hG9nY5LYWCizOvF48Id8HUssVmJeaHOIsUpgauDkW4OyoQ5ni/r
         fO/H8/g5+h7gzl0M0GsgyqxjPS3X+3LNZj9mg8UmceEq466H+UbUPUt5iiqM2fmZaV3c
         RMuVon5X902M+1XCYkePluYADqN4FD74GnP57Lfitc1nuTk6HMhnEf6HULKn8ca9Y3Bg
         vBVg==
X-Gm-Message-State: AA+aEWbtrsXwSQEY28q3mvoE8iB9ef3x0vfLXZite1aVyNXngmaS884i
        oK+gHwHcUJHM5KOXnWuizCNeCqOWr5mxmQQouPjwBA==
X-Google-Smtp-Source: AFSGD/WwiZuu6ia1LKvRLwvOiBWyBU+ww77MByZos5ENHBRBBqkx1IQErVIzYgn4X2la46jjJ392HFS/Uue/5dOSlbA=
X-Received: by 2002:a1f:e807:: with SMTP id f7mr12396673vkh.16.1543303420924;
 Mon, 26 Nov 2018 23:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20181119061219.14238-1-jian-hong@endlessm.com>
 <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com> <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
 <20181125132257.6ae9fe82@archlinux>
In-Reply-To: <20181125132257.6ae9fe82@archlinux>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 27 Nov 2018 15:23:04 +0800
Message-ID: <CAPpJ_eeqxzgwXwm1v3n2u2cEiVgBPN9y96+5x589-bO3+k+1jg@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: Fix the sleep time for sampling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Denis Ciocca <denis.ciocca@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2018=E5=B9=B411=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=889:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 21 Nov 2018 13:13:40 +0800
> Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> > Denis CIOCCA <denis.ciocca@st.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Jian,
> > >
> > > Not clear to me why should be + instead of *.
> > >
> > > ODR is expressed in Hz, so (1/Hz) =3D period in seconds (1 sample sam=
pling time) [s]
> > > 1000 * (1/Hz) =3D period in milliseconds (1 sample sampling time) [ms=
]
> > > n * 1000 * (1/Hz) =3D n times period in milliseconds (n times sample =
sampling time) [ms]
> > >
> > > In your case you assume bootime is in milliseconds.
> >
> > Yes, I assume that according to the original comment.
> >
> > >Maybe we can change the comment and use 'number of samples ...'.
> >
> > Making the meaning more clear is better.
> >
> > However, does the bootime of the measurement need as the long time to
> > be enabled?
> > If the sampling rate is 1Hz and n is 2, then they will do msleep with
> > 2000 ms for each st_sensors_read_info_raw.
>
> Superficially that seems correct as we need to be sure that a reading
> has occurred.  If you want it to be quicker than the ODR should be set
> faster so that the reading shows up reasonably quickly. At 1Hz and
> you want to drop 2 samples, it will indeed take 2 seconds.

Now, I understand with the description.  Thank you.

Jian-Hong Pan

> > > -----Original Message-----
> > > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.or=
g> On Behalf Of Jian-Hong Pan
> > > Sent: Sunday, November 18, 2018 10:12 PM
> > > To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx=
.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@=
pmeerw.net>; Dominique Martinet <asmadeus@codewreck.org>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@en=
dlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>
> > > Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
> > >
> > > According to the description of st_sensor_settings and st_sensor_data=
 structures' comments:
> > > - bootime: samples to discard when sensor passing from power-down to =
power-up.
> > > - odr: Output data rate of the sensor [Hz].
> > >
> > > The sleep time should be
> > > sdata->sensor_settings->bootime + 1000 / sdata->odr ms.
> > >
> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > > ---
> > >  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/driver=
s/iio/common/st_sensors/st_sensors_core.c
> > > index 26fbd1bd9413..6b87ea657a92 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > @@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indi=
o_dev,
> > >                 if (err < 0)
> > >                         goto out;
> > >
> > > -               msleep((sdata->sensor_settings->bootime * 1000) / sda=
ta->odr);
> > > +               msleep(sdata->sensor_settings->bootime + 1000 / sdata=
->odr);
> > >                 err =3D st_sensors_read_axis_data(indio_dev, ch, val)=
;
> > >                 if (err < 0)
> > >                         goto out;
> > > --
> > > 2.11.0
> > >
>
