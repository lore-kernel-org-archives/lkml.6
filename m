Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A71C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A932C20833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqFOvshg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A932C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeH1ShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:37:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45755 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeH1ShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:37:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so1630796lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aD7y8HEmqSRSbl6Rqo91KmIvIJgDy/amWk/KbSw9hE=;
        b=LqFOvshgkDgGPiD3VwWZ9zVJsrhL2tMegX4Sd6jzCYCTop3odCwV9mMgR6qEL03iPx
         k0SiZiRqDqzj1rov8hcV+Q/q51zshVpq4zN/fjFml30e4eMigQL4nv3HeTdh1/Q1L2UN
         k2nDdG3Pn1pUD+1aYO+mV6gySsK5vZs2fMC9R2u6CZ8GloXKYXrjri9FsFDTNvh54mlK
         aljIWxtCpWxSeNMeaZrZnNKuW2qlHy4HnCad78fnUZLOybziwRcDl4w0+NAjy1fsrSzF
         VSack95UCx+FXayFt7w738+v7RrUGevwcmqZCC3/Geg/0vAs4AQ9OGgFpedIUDfB8aPV
         lrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aD7y8HEmqSRSbl6Rqo91KmIvIJgDy/amWk/KbSw9hE=;
        b=N54Z7NSU9icGSQEcGlIvFZbGnrnFKstjmVYDlxRC0Z85jm9nRXOwLfle8h1iZ4FzhY
         Ih7eKxxcQN3MaAfqvdeMichExtRqkfNSCUDPTca3D0c2QsZcpM7IDAf6kKHx+5M3zLIs
         iy6LmFzAjcSn4Ms4dXkYHF2NV7XhuTiTodhVjmX2q20VKSPaFViTAWoGsgfU/QxKtLyI
         rLYN+eG5GzoTJGUS523OxXvGviLAhX4sF6CT1SuW3+p3gA5YXOdakj3yT17LCZEULfBs
         o2H9jKd7/uJy9iSvE7BX5AvwPfpaT0nzAClx9dEe41QCIv1Z0J96nK0zOuVoEBilAcQQ
         anKQ==
X-Gm-Message-State: APzg51A82JuC7gQLzXQG2Aa29YXKw3kEi2i3f+U5pVh2FUlRxGl5QDc2
        Qp2IcIQXd3vN/4OgiteNLihbo2x459RMaSENLnk=
X-Google-Smtp-Source: ANB0VdbjuEXMa7xH1Fk7qVtK1V1gTTcVPS81T1+BBl60mSSZyhUnQsnLBPZfmlDt6A0owlov25sVINzok9JydJj9JLo=
X-Received: by 2002:a2e:4782:: with SMTP id u124-v6mr1611758lja.40.1535467514290;
 Tue, 28 Aug 2018 07:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
 <20180821143152.32293-3-ricardo.ribalda@gmail.com> <20180828162611.2f45e5c9@bbrezillon>
In-Reply-To: <20180828162611.2f45e5c9@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Tue, 28 Aug 2018 16:44:57 +0200
Message-ID: <CAPybu_0yRQunWVoTKffm4NZaCNbiHpBQV11tJ3z62TpDGo1rVw@mail.gmail.com>
Subject: Re: [PATCH 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Tue, Aug 28, 2018 at 4:26 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Tue, 21 Aug 2018 16:31:46 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > We should only iomap the area of the chip that is memory mapped.
> > Otherwise we could be mapping devices beyond the memory space or that
> > belong to other devices.
> >
>
> Can you add
>
> Fixes: ebd71e3a4861 ("mtd: maps: gpio-addr-flash: fix warnings and make more portable")


Sure, I have some other changes for the patchset at
https://github.com/ribalda/linux/tree/gpio-addr-flash-v2

I will wait a couple of days for more reviews and I will resend the patches


>
> and in case you want to backport the fix:
>
> Cc: <stable@vger.kernel.org>
>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/mtd/maps/gpio-addr-flash.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> > index 17be47f72973..6de16e81994c 100644
> > --- a/drivers/mtd/maps/gpio-addr-flash.c
> > +++ b/drivers/mtd/maps/gpio-addr-flash.c
> > @@ -234,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
> >       state->map.copy_to    = gf_copy_to;
> >       state->map.bankwidth  = pdata->width;
> >       state->map.size       = state->win_size * (1 << state->gpio_count);
> > -     state->map.virt       = ioremap_nocache(memory->start, state->map.size);
> > +     state->map.virt       = ioremap_nocache(memory->start, state->win_size);
> >       if (!state->map.virt)
> >               return -ENOMEM;
> >
>


-- 
Ricardo Ribalda
