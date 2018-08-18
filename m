Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E39C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4157B21581
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur0OL4E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4157B21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeHRLoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 07:44:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33814 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHRLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 07:44:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so8092980ljk.1;
        Sat, 18 Aug 2018 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOmliarxb5K2sWe6ilv9hzTwybhTm96ipEQZC4s3Bxw=;
        b=ur0OL4E+VBBadMT3Rq0qnygbgJwfVYk4w6D0XOvOZ/yXHlS80J15wW0AyZOTtLRQt5
         6r23F9JZ9KUkRk4vn4brb2XZP/b2ElfbT/wDI+MulROVTz4sYSV5osT59blXUqHG1Tlm
         sZfWWdhWHD2gBpDfrueMr3WPh7b0A+Cm70OGEGZShh9CIBKgLVqPDjvXpfi39qRlkk6I
         F0t+QK1Rq3qE4u3bMSEV2PMqLFgOPVEphuMjxBOl3V1VHlH7tmmm0oCwef3jwwf30UJP
         VKdBosRqFQ6ZLz7cqSpuvqOa5qVkbsKw985FvlcRwLsq9ZRqLohKna5M1YLHFz08BiIj
         W+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOmliarxb5K2sWe6ilv9hzTwybhTm96ipEQZC4s3Bxw=;
        b=LUAJlxi/aCgdufOu0KRIOeF1dq4fR/bXMU6huxMbYi1wROpLs7UET/IFTvdaKJA7zm
         kr2ydom3WKO3OjBX7E4g/KMOSu/VckFYDM3V83ll4Y/Pfdyo5fKpHm6FJsbLHQySys1k
         U6LsxLYGrFwGG2mrSdt/u8e0D2x5gu7/d9RxRZ4hPREM6sJgltb9J1M7ppKRsWG01ra9
         iuQaggmhS97c6qx9jUwkpOGSe5Qv49C5mn8Abox2FbA3Jf+py93LQypqP5cVb8snLgSJ
         y7nMvsY51poX5ZrEAoJzUtkeiw/cEmXY3MHiueOKRn1zVeYtbhjLq7ggkzPGBRNUf7rC
         30FQ==
X-Gm-Message-State: AOUpUlFX4pyRqp5BTNS4/BOCL51rigWcqKFYmVkezJXo5WEe02HtlU6/
        di8Espnjrf/TxIbvWNZaLPgKUFWn42sf4Pc6O/Y=
X-Google-Smtp-Source: AA+uWPxea4KKNZ9TdgLFS1Sbuswtx0qRxH3F7rNZaFfl/674DqUgmpAfxELJAKOEhjPvn5wOkGgv9TCYmxHck+5h+sc=
X-Received: by 2002:a2e:990b:: with SMTP id v11-v6mr25700095lji.87.1534581449406;
 Sat, 18 Aug 2018 01:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
 <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com> <1534523550.2283.397.camel@impinj.com>
In-Reply-To: <1534523550.2283.397.camel@impinj.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Sat, 18 Aug 2018 10:37:01 +0200
Message-ID: <CAAh8qszwWsSTPhK_aLziy8px9hOyixGN50m6YMA_5Rb2w23zaw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dw: support 4-16 bits per word
To:     tpiepho@impinj.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 6:32 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Fri, 2018-08-17 at 09:01 +0200, Simon Goldschmidt wrote:
> > The spi-dw driver currently only supports 8 or 16 bits per word.
> >
> > Since the hardware supports 4-16 bits per word, adapt the driver
> > to also support this.
> >
> >
>
> > @@ -307,15 +307,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
> > +
> > +     if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
> >               return -EINVAL;
> > -     }
>
> You don't need this check as the spi core validates the transfer
> against master->bits_per_word_mask.

Ok.

>
> >       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> > -     master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
> > +     master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
> >       master->bus_num = dws->bus_num;
> >
