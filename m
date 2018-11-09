Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC20920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="teyNSHAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC20920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeKJH6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:58:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40190 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:58:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id u130-v6so2780159oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELgrtEXcs6cb8ETxNYp2vyBBc5bX0KK02L7f+8jGKC0=;
        b=teyNSHAzVb5YziUcx5Z+UsFUCb22ulH7oVZw/Atyxp8Bl/L8zUUZjQaL1gS554l/kG
         LQHZhpQn+rvNhc253IZq9PxWdpi1SSxvNzLS9DzIRnFAuxYSS4s4ZH6VvWjx+OGVY7CX
         s+uJ7fD2WBbtWzSrA4apfD2KXFgbkt9PKg3Ye0RAkBTjOSuG4VYSSBegaCmGPzYUk1I7
         hPEnBnf/6qKrOxO/qN0X9VAlNmf7StiGdBVbcwZ2zGYU0RZqZe5TLOHOvkxl7DN4okZQ
         d3nPlnQH9xNr5KwHWqHGlrQHFh7aQZNhUfLtvTdJ4g43kfvzdG5PHMKpv5nVtbQcyyPp
         0xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELgrtEXcs6cb8ETxNYp2vyBBc5bX0KK02L7f+8jGKC0=;
        b=ZNumtT3TjsQ3Wks4ldU/u0got9AcckCsx5u0vnPIl4Cm8oADh56FEca2GyTSgiqTTQ
         cesbtuJVLN84L01bnt4AoHK59c3kT6daKxeU/aEtDnVY6PWNDQMW/l0zZoxDbz+QHE4d
         vLq38vvH3TgdrEUHcau+hEaFzkwR11JXT+noEdUlu6BpF293C3w1gYERoJTm/PBfrDcv
         HGTGtgDt2jU6rY1h+5Dle9hYp15MPMXWFi+zs1D5BuprJDoZ8hA60TmcOuJhtdmuBKMh
         SQntrTF/MSAxsIZFrIT+cn/Uc51GRdUwRBasHGXGbLuXBw8EzOd+ccZuclAMfW9bN2Km
         PA+w==
X-Gm-Message-State: AGRZ1gK1VCLl65Gg2SjXnaY5clKKkDC0saCPqhrTOCPFySoA5rbNlA9D
        IBEqicA+D+Rb2P/p2z0m0r9GddZYw0PZZ5aGDUrFlw==
X-Google-Smtp-Source: AJdET5fipVJ+SF6RCEwVL7lgOIxe3W1Znk9fF5Fh68R7DRhHjXhzws/6BgPmNv5wMp88mlI9wiExrjApDSFU6s9/pCc=
X-Received: by 2002:aca:3246:: with SMTP id y67-v6mr1201235oiy.165.1541801757289;
 Fri, 09 Nov 2018 14:15:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
 <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
 <55b5de74-a607-94b9-8c85-40658e38fbb5@gmail.com>
In-Reply-To: <55b5de74-a607-94b9-8c85-40658e38fbb5@gmail.com>
From:   Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Date:   Fri, 9 Nov 2018 20:15:45 -0200
Message-ID: <CAEFO=4BVP9GH7-swQHMevuPjfJ=RyaySQmvr2qo+DK5xPB3VjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before gain update
To:     tduszyns@gmail.com
Cc:     giuliano.belinassi@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, Renato Geh <renatogeh@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Kernel USP <kernel-usp@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just some random though. Instead of introducing extra level of indentation you
> can simply check whether is_ad778x is asserted and simply return.

I agree that the patch would be smaller if I do that, but is it really
an issue? If yes, then I will update the patch with this change

> Any reason for setting this explicitly? That's going to be false anyway

It seems clearer to me :-)
On Thu, Nov 8, 2018 at 4:26 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Hi Giuliano,
>
> Comment inline.
>
> On 11/8/18 2:03 PM, Giuliano Belinassi wrote:
> > Only the ad778x have the 'gain' status bit. Check it before updating
> > through a new variable is_ad778x in chip_info.
> >
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > ---
> > Changes in v2:
> >       - Squashed is_ad778x declaration commit with the ad778x checkage
> >       - Changed is_ad778x type to bool
> >
> >  drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> > index 91e016d534ed..9ec2b002539e 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -35,6 +35,7 @@ struct ad7780_chip_info {
> >       struct iio_chan_spec    channel;
> >       unsigned int            pattern_mask;
> >       unsigned int            pattern;
> > +     bool                    is_ad778x;
> >  };
> >
> >  struct ad7780_state {
> > @@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> >           ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
> >               return -EIO;
> >
> > -     if (raw_sample & AD7780_GAIN)
> > -             st->gain = 1;
> > -     else
> > -             st->gain = 128;
> > +     if (chip_info->is_ad778x) {
> > +             if (raw_sample & AD7780_GAIN)
> > +                     st->gain = 1;
> > +             else
> > +                     st->gain = 128;
> > +     }
>
> Just some random though. Instead of introducing extra level of indentation you
> can simply check whether is_ad778x is asserted and simply return.
>
> >
> >       return 0;
> >  }
> > @@ -135,21 +138,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> >               .channel = AD7780_CHANNEL(12, 24),
> >               .pattern = 0x5,
> >               .pattern_mask = 0x7,
> > +             .is_ad778x = false,
>
> Any reason for setting this explicitly? That's going to be false anyway.
>
> >       },
> >       [ID_AD7171] = {
> >               .channel = AD7780_CHANNEL(16, 24),
> >               .pattern = 0x5,
> >               .pattern_mask = 0x7,
> > +             .is_ad778x = false,
> >       },
> >       [ID_AD7780] = {
> >               .channel = AD7780_CHANNEL(24, 32),
> >               .pattern = 0x1,
> >               .pattern_mask = 0x3,
> > +             .is_ad778x = true,
> >       },
> >       [ID_AD7781] = {
> >               .channel = AD7780_CHANNEL(20, 32),
> >               .pattern = 0x1,
> >               .pattern_mask = 0x3,
> > +             .is_ad778x = true,
> >       },
> >  };
> >
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/55b5de74-a607-94b9-8c85-40658e38fbb5%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
