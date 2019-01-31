Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B368C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F182184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ScClUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAaFP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:15:58 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39476 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaFP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:15:58 -0500
Received: by mail-yw1-f67.google.com with SMTP id k188so811880ywa.6;
        Wed, 30 Jan 2019 21:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbexUhY9aqcT+1SE9D/xYA5ED9xHab81qjVL0E3Ao0k=;
        b=B2ScClUQNBBiaRyChUU0FpZdhHExy5iO5jHeEfHzFL2Lk6BNLNq2uEZzHuhU5pOjAk
         Vs13m3x5b+8ZzQY0dEVlvTHVJebJhpvPzzm6Ksw08F+R85/+6hSdNqx8ILYKIpBWdzIF
         tWqpt2/2OgSr7WJ/6/WSwtRfD5g8L5n1ulGwxwfpNOmC4DMbNI+LRoZs0OIljNrqnk/y
         Z+prA72Tv4FGFCD22Pk5s0WBc9/GHo5xKabje3Ky3kqzMdKIy5cDeetwb3TGrXGf8Jna
         1ovNITaLhXSAmjgt4oRA1RICHxv7q+a4QZnqbMdeBErPOaaZYzBdAepNquDHktObb3uH
         tRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbexUhY9aqcT+1SE9D/xYA5ED9xHab81qjVL0E3Ao0k=;
        b=XVw1CgKAGickIjvT69OhjFN89evVixyAk3xKCR4y1eKyNjqAUDDNV1v4biG4FUzmfz
         MC0+98P5tO2gSFiEFUGWXnEnkT/zn1Bw0I+jJqGPf2jtlUI4ByLkWtr3Njl3kIEnFWaP
         qBtwPlNYqjJy88ZLtc25Wm3lpF4vi9L6ugOUAC2TPIiecm1Y9ojJt0eanS5Of2+XZDyK
         eRWw3rnU7YCdvjteK4s5xCkHwz5hJRW8+grilOQ6K5U8XN/f0Cl95PaAMJFvBePktoLB
         F3HfOM1hN3iYXAX3KyVkKd4xt8JYPp+wyHIEXS9pbEazXHNvbHs0/zPBBDpMNLn4FUNG
         Pvrw==
X-Gm-Message-State: AJcUukcoIdVhK564/h80N/7mKYHrQ3OVPT8PoXkfWm+jt1WJddWgSj72
        16HNjMiPtvmQta5BQKsj2MHCd/lUUDqRZQAsr1Y=
X-Google-Smtp-Source: ALg8bN4fpGRlWgaAiiaPJbKIGGTZK5eCvdadJ+zuC0hXVW3dwC27xN+jTMs6o01O8z+9HsL2JK64lbn4RQej2ZUYYGE=
X-Received: by 2002:a81:a87:: with SMTP id 129mr32238076ywk.195.1548911757198;
 Wed, 30 Jan 2019 21:15:57 -0800 (PST)
MIME-Version: 1.0
References: <1548440422-27943-1-git-send-email-justinpopo6@gmail.com> <20190126183011.00f03cc3@archlinux>
In-Reply-To: <20190126183011.00f03cc3@archlinux>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 30 Jan 2019 21:15:45 -0800
Message-ID: <CAJx26kXY+Hg-M11LJ-ATP8y_-8RJ=gQ2DPn2Y9YDJHDkQNh=Kw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: inconsistency with spi msg
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 10:30 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 25 Jan 2019 10:20:22 -0800
> justinpopo6@gmail.com wrote:
>
> > From: Justin Chen <justinpopo6@gmail.com>
> >
> > To read a channel we require 3 cycles to send, process, and receive
> > the data. The transfer buffer for the third transaction is left blank.
> > This leaves it up to the SPI driver to decide what to do.
> Interesting.  I think that means you may have a bug in your SPI driver.
> The pointer in question is always left set to NULL in the adc
> driver (not explicitly but it will be because ultimately comes from
> a kzalloc).
>
> Documentation for an SPI message makes it clear that NULL is
> allowed.  From include/linux/spi/spi.h
>
> "* Those segments always read the same number of bits as they
>  * write; but one or the other is easily ignored by passing a null buffer
>  * pointer. "
>
> Hmm. It does say 'ignored'.  My assumption has always been that
> means it would be filled with zeros, but maybe I'm wrong.
>
> Mark?
>
I looked more into this and other SPI drivers do fill it with zeros.
I'll submit a patch for the SPI driver instead and see what the SPI
maintainers say.

Thanks,
Justin
> >
> > In one particular case, if the tx buffer is not set the spi driver
> > sets it to 0xff. This puts the ADC in a alarm programming state,
> > therefore the following read to a channel becomes erroneous.
> >
> > Instead of leaving us to the mercy of the SPI driver, we send the
> > ADC cmd on the third transaction to prevent inconsistent behavior.
> >
> > Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > ---
> >  drivers/iio/adc/ti-ads7950.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > index 0ad6359..1255d8b 100644
> > --- a/drivers/iio/adc/ti-ads7950.c
> > +++ b/drivers/iio/adc/ti-ads7950.c
> > @@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >       st->scan_single_xfer[1].tx_buf = &st->single_tx;
> >       st->scan_single_xfer[1].len = 2;
> >       st->scan_single_xfer[1].cs_change = 1;
> > +     st->scan_single_xfer[2].tx_buf = &st->single_tx;
> >       st->scan_single_xfer[2].rx_buf = &st->single_rx;
> >       st->scan_single_xfer[2].len = 2;
> >
>
