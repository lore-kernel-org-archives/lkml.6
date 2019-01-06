Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36277C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0ED21907
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO5ouN8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAFDgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 22:36:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44129 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAFDgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 22:36:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so44382151qte.11;
        Sat, 05 Jan 2019 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+CWlxp8EbiwD8QfSFV+99cd7SCsmuiiQMoyrVvSXyPY=;
        b=rO5ouN8UPI9xCmThohGKdyW7by2Cood0aLIVFyDkeHZnJd8iYL8JG4p8mGPduj3Hxy
         6nIJvXavymGEX8COWcGDLotBLsYb7TAQSZZeu9rG+fr64Jzo3UsmUHwKixSA/jZg/r7S
         4fqajQLB4ilVhVk5TcsH1b1j3LRsXT0Mvm7FaKchOPbDbjpYNIa4KRt7zStjV7PA2XR9
         Z1yohZSf/gj7KMaQMpbdo4vCKq03tPcTfVVZVQINCBz6N1Mo6w2pbFN66XKT3bKwYCa8
         t6KFbGQgNEIYTShL6zmLH31o6+rvq5Ue3F15QnTBybaqEf6RnDdznuWUxDTteZxoitYp
         90MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+CWlxp8EbiwD8QfSFV+99cd7SCsmuiiQMoyrVvSXyPY=;
        b=Dxg/2ZQatxQhlx5zaG6VA1TAtd71nJs5+JeVSAzLxsB21wVLFZTcqBh37wD0S3xjnq
         yQJBZlj+fl3NX5xpJ95LTTixfstZNogHxOM1BkfrJ8jLoZInnEEMFlV21mETATxKsYcO
         7ru/0jXL9FqtwHOpBzlvJZgZD53WHGhJFSL03nIgIIl+SXrHOlLe2nmNr+8gc7rc44Eq
         D91Oj1YCDkRkyvdnvP0j0G3BQxEsiE2JAa3HjuPMRfYimaAJm7LsKqHL9zzd9Aq6AxUu
         iX5E+IKWlvGqmWpyvjjyBBTWfAnfF0I8o4pDXN33y6RNMrpcZPGfHHsdEZvjvITRZ8UT
         qJkA==
X-Gm-Message-State: AJcUukdHHgig/eskdEYCsckjepS3JfOAJKdn4Uoch6MMhVd+Yd9VhYqH
        rIrbfe6/zS4RnBEz4YrD9xHUQoDS7OdI9E/CDpU=
X-Google-Smtp-Source: ALg8bN7GRdhnVeuD8nm1BYrRu1DBhA/eivQAsfPXQZ856J6Ap+YQLxEHr8koOVKWhAqcsvlNEAofgR5ANAeL37OTHoQ=
X-Received: by 2002:a0c:b6c3:: with SMTP id h3mr57673901qve.128.1546745800492;
 Sat, 05 Jan 2019 19:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-2-nazgul33@gmail.com>
 <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com>
In-Reply-To: <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com>
From:   nazgul33 <nazgul33@gmail.com>
Date:   Sun, 6 Jan 2019 12:36:29 +0900
Message-ID: <CAEo1Rizj_HC5f+TWMP8ogrsXVhMDrxA+Nyo2h4KJJ4admtmanQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: rotary_encoder - Support key events
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Daniel Mack <daniel@caiaq.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

input_sync() is there, at the end of the function.

static void rotary_encoder_report_event(struct rotary_encoder *encoder)
{
    if (encoder->relative_axis) {
        input_report_rel(encoder->input,
            encoder->axis, encoder->dir);
    } else if (encoder->relative_keys) {
        u32 keycode =3D encoder->keycodes[encoder->dir > 0];
        input_event(encoder->input, EV_KEY, keycode, 1);
        input_event(encoder->input, EV_KEY, keycode, 0);
    } else {
        unsigned int pos =3D encoder->pos;

        if (encoder->dir < 0) {
            /* turning counter-clockwise */
            if (encoder->rollover)
            pos +=3D encoder->steps;
            if (pos)
                pos--;
            } else {
               /* turning clockwise */
               if (encoder->rollover || pos < encoder->steps)
                      pos++;
           }

           if (encoder->rollover)
               pos %=3D encoder->steps;

           encoder->pos =3D pos;
           input_report_abs(encoder->input, encoder->axis, encoder->pos);
        }

        input_sync(encoder->input);
}

On Sun, Jan 6, 2019 at 8:12 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
> >
> > From: Steven Han <nazgul33@gmail.com>
> >
> > Support generating EV_KEY pair, instead of EV_REL.
> >
> > Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> > ---
> >  drivers/input/misc/rotary_encoder.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
> > index 72eee6d55527..180e35884289 100644
> > --- a/drivers/input/misc/rotary_encoder.c
> > +++ b/drivers/input/misc/rotary_encoder.c
> > @@ -41,6 +41,8 @@ struct rotary_encoder {
> >         u32 steps;
> >         u32 axis;
> >         bool relative_axis;
> > +       bool relative_keys;
> > +       u32 keycodes[2];
> >         bool rollover;
> >         enum rotary_encoder_encoding encoding;
> >
> > @@ -79,6 +81,10 @@ static void rotary_encoder_report_event(struct rotar=
y_encoder *encoder)
> >         if (encoder->relative_axis) {
> >                 input_report_rel(encoder->input,
> >                                  encoder->axis, encoder->dir);
> > +       } else if (encoder->relative_keys) {
> > +               u32 keycode =3D encoder->keycodes[encoder->dir > 0];
> > +               input_event(encoder->input, EV_KEY, keycode, 1);
>
> You need input_sync() here.
>
> > +               input_event(encoder->input, EV_KEY, keycode, 0);
> >         } else {
> >                 unsigned int pos =3D encoder->pos;
> >
> > @@ -237,6 +243,16 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
> >         device_property_read_u32(dev, "linux,axis", &encoder->axis);
> >         encoder->relative_axis =3D
> >                 device_property_read_bool(dev, "rotary-encoder,relative=
-axis");
> > +       encoder->relative_keys =3D
> > +               device_property_read_bool(dev, "rotary-encoder,relative=
-keys");
> > +       if (encoder->relative_keys) {
> > +               err =3D device_property_read_u32_array(dev,
> > +                                       "rotary-encoder,relative-keycod=
es",
> > +                                       encoder->keycodes, 2);
> > +               if (err)
> > +                       dev_err(dev, "unable to get keycodes: %d\n", er=
r);
> > +               return err;
> > +       }
> >
> >         encoder->gpios =3D devm_gpiod_get_array(dev, NULL, GPIOD_IN);
> >         if (IS_ERR(encoder->gpios)) {
> > @@ -260,9 +276,12 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
> >         input->id.bustype =3D BUS_HOST;
> >         input->dev.parent =3D dev;
> >
> > -       if (encoder->relative_axis)
> > +       if (encoder->relative_axis) {
> >                 input_set_capability(input, EV_REL, encoder->axis);
> > -       else
> > +       } else if (encoder->relative_keys) {
> > +               input_set_capability(input, EV_KEY, encoder->keycodes[0=
]);
> > +               input_set_capability(input, EV_KEY, encoder->keycodes[1=
]);
> > +       } else
> >                 input_set_abs_params(input,
> >                                      encoder->axis, 0, encoder->steps, =
0, 1);
> >
> > --
> > 2.17.1
> >
>
> Thanks.
>
> --
> Dmitry



--=20
=ED=95=9C=EB=8F=99=ED=9B=88 =EB=93=9C=EB=A6=BC.
