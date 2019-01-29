Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5318C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933C720855
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aTLdYJBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfA2LBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:01:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34863 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfA2LBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:01:48 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so3842922itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1+8MmN+ZgcnDLCUxKujb3Vh6HqkhqAQnHxttMRtWN18=;
        b=aTLdYJBhej/DOxkOVMQcDXrZk1uZg9jzFc8QCi8xRf3cHwId1VgjWKTtv+RnB4a1JF
         7ChKVKwrRxbrXLy0vkrDcaVy5OrdQd3HvypGKgXi+aBRZqoZvzBDX2Abggt8lZWGvrJf
         31N2/LoRF4HWLpCTl0KOlny5iG4FROz9L/towdXolZJoF2SQgKkFajgTiQy+UuPux+jw
         qrHxrP+jmjgLY65gLQsVSCj21jxPAqM41Txlj9v0Ohi4dEsj2COehNUdHLHDXXQ3AD/c
         cwpkaIdjppd0nR264av7a5+XietRYnyHZsXfCQEj0o24EiqX0MdnMozuDYF/36XoJ5dI
         GRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+8MmN+ZgcnDLCUxKujb3Vh6HqkhqAQnHxttMRtWN18=;
        b=hekENmRAiv2qY70xrHKpaqs7RoMCByoJzG6DoqL9pwzCAzrNcEHBmB/S5OyEj8woKH
         LUlh6ccNc+VW9RPJjyTuz84+9cJaUqivyHbCb353PGU01RKEMzkSz/Jn7n+r+g2PQd7Y
         d1bfuDWB1L4LtA9N/rjPQ1YhOLU3ohbgh9KH9+KkiMd5rmtHJM9qkd3CHqDBpdV1GpHB
         o5ayWd/MY8BqOqWOgG36JKtB5JoZR3GCo0HrEIuyB8aQcP58VGrbhXgU/677vfHZEU/w
         ZlLvwxKD9TkKqRFKUv1T1OB+DPKxMnDBnOFhBah5RT2Q7uK9W6GKSJYJh5789TfShv+C
         o3WA==
X-Gm-Message-State: AJcUuke7IGbpEOqKSid4qgNo1qnvI8JGBo11YOyUkz7NPkDohJyDuIdb
        awIlk4T7xUXC7hDFvLd0xljA48A0CccFczBq9/DnJQ==
X-Google-Smtp-Source: ALg8bN6PWHvCLTKMkFXJgznZ+y8CGAuWKSWfUNd4iHewZl4ZQHQGoGb3gdksJIcAyoxIPaHBDborQvk5cFe0ld4s50M=
X-Received: by 2002:a24:7284:: with SMTP id x126mr13805771itc.96.1548759707944;
 Tue, 29 Jan 2019 03:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <20190129090706.33wcxb6d2c64yx7c@pengutronix.de>
In-Reply-To: <20190129090706.33wcxb6d2c64yx7c@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Jan 2019 12:01:37 +0100
Message-ID: <CAMRc=Me6bGaGiiwvGNXbcr+fxarYsrgH-3MhQpSKjOjKQ6BtTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 29 sty 2019 o 10:07 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Tue, Jan 29, 2019 at 09:44:05AM +0100, Bartosz Golaszewski wrote:
> > -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > +void irq_sim_fire_type(struct irq_sim *sim,
> > +                    unsigned int offset, unsigned int type)
> >  {
> >       struct irq_sim_irq_ctx *ctx =3D irq_sim_get_ctx(sim, offset);
> >
> > -     if (ctx->enabled) {
> > +     /* Only care about relevant flags. */
> > +     type &=3D IRQ_TYPE_SENSE_MASK;
> > +
> > +     if (ctx->enabled && (ctx->type & type)) {
> >               set_bit(offset, sim->work_ctx.pending);
> >               irq_work_queue(&sim->work_ctx.work);
> >       }
> >  }
> > -EXPORT_SYMBOL_GPL(irq_sim_fire);
> > +EXPORT_SYMBOL_GPL(irq_sim_fire_type);
>
> This looks better than the previous variant. I wonder if it would be
> still more sensible to have type only in the mockup driver. But I don't
> have the complete picture here and it might be easier this way.
>

I'm afraid I don't follow. Wasn't that the way it was done in v1?

Bart
