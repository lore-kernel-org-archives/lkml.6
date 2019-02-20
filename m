Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EBC10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6ED2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F42v8VeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfBTToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:44:07 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37423 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBTToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:44:07 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so9683060ywe.4;
        Wed, 20 Feb 2019 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQB61uwHnSl3NkeJPsOwHj2N+ljtIFfoj1M7VZlO8fU=;
        b=F42v8VeBTiYfxj+TPPNO9z9CvHjhxUWnOUmgPk+F2j/q1VKd7SQQpE4ohrCMd7NiXG
         mYmm2aauCxdudWrYuWPGk3jtcJ6Lbc9VUbB56mpYZ8O4Ie2/2UTkY73w7ezintJSgINx
         XyzrKh7Q+oFwm2VebBNsXVsQDEYsoPVRs8dwUexXqLxLHdHtVDZXHZcxwyQty47rHn2q
         V5+EV7xGFO/Fk3zM8DkPo8rla3Tk7mu1SjohOiI0ozfuN9fJVkPViiBuhSzAFRMUZwid
         Tqp912GIMuKR6xhRu3FK/4jyH/Xv+2Q88ke9MBgrTc7nvb0MyZ9DiqMyu9z9WLZDXUxi
         SKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQB61uwHnSl3NkeJPsOwHj2N+ljtIFfoj1M7VZlO8fU=;
        b=Pe8Ka2wWMrwLPpQmSfnt3oOShSYo5ZVDqFld85+NlowCF/hD9mxqf3VAfsWk79o4QV
         GycLm+CYGshj3vZwauNvaPtXjfXP4+V48zvss0jLqf4HhHa0zW9vwI/YLNoVL5XNBoEu
         jBuK7gaxlr+JbiFePftxKwFIlA2hTm7s64wTFutJcYUD9DJTsDsGtZNaxK6bGKf8tejd
         Swl8Vqh+Vl5WOXuWVfXBY+6Y7fQFg21g42/S6Lk617OOx8KvFRTFzBG+QIFz+bd+tkEL
         dnoycs+1tftYN9UJONSugnUf9YzZtMSOgOBNyF8qfAiEwAFWpFuoJxnsZ/8zbkiH2YJ0
         zZ5w==
X-Gm-Message-State: AHQUAuZhNeQv51OYrvtsMv4H3W82hqxr75LrW9oSmpRCoOALNEj1XBDn
        7FgUVn+gCekgmcF3fLXGZ7De3qsQ/0KOpoyjrZU=
X-Google-Smtp-Source: AHgI3IZWc4BjUtICdNIkV4UL2szMBjEvUitsO8bcGnJPG2Eh1qO7bQYubJYYG3RnC48xTCd1VSnIwVlIehzu2+A7NNo=
X-Received: by 2002:a81:2ed6:: with SMTP id u205mr29453047ywu.176.1550691845917;
 Wed, 20 Feb 2019 11:44:05 -0800 (PST)
MIME-Version: 1.0
References: <1550030242-5241-1-git-send-email-justinpopo6@gmail.com>
 <9e0a8a08-9636-906b-08cf-d99947d6f51a@lechnology.com> <20190220120021.65c91b83@archlinux>
 <96ec33f3-6e58-325f-9c55-4f1a92f635f7@lechnology.com> <20190220172331.40d7cbf0@archlinux>
In-Reply-To: <20190220172331.40d7cbf0@archlinux>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 20 Feb 2019 11:43:54 -0800
Message-ID: <CAJx26kVjseUjT-89v=wb7+kq_o6OUuN7acTAkRQ_oCSDJzrNDg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: ti-ads7950: add GPIO support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bgolaszewski@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 9:23 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 20 Feb 2019 10:48:49 -0600
> David Lechner <david@lechnology.com> wrote:
>
> > On 2/20/19 6:00 AM, Jonathan Cameron wrote:
> > > On Wed, 13 Feb 2019 09:10:53 +0100
> > > David Lechner <david@lechnology.com> wrote:
> > >
> > >> On 2/12/19 9:57 PM, justinpopo6@gmail.com wrote:
> > >>> From: Justin Chen <justinpopo6@gmail.com>
> > >>>
> > >>> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> > >>> pins using the GPIO chip framework.
> > >>>
> > >>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > >>> ---
> > >>
> > >> It will be better to split this up into two patches[1]. One to replace
> > >> all uses of indio_dev->mlock with the new local lock and then another to
> > >> add GPIO support.
> > >>
> > >> How are you using/testing this patch? Do we need device tree bindings?
> > >>
I have a custom board with a SoC that is connected to the ADC with
SPI. You don't need any addition device tree binding. Just whatever is
already necessary for the ti-ads7950 driver.
> > >> It will also help reviewers if you add a note about what you changed in
> > >> each revision of the patch when you resubmit. The usual way to do this
> > >> is something like:
> > >>
> > >>       v3 changes:
> > >>
> > >>       - Fixed unlocking mutex too many times in ti_ads7950_init_gpio()
> > >>
> > >> It also is nice to wait a few days at least before submitting the next
> > >> revision to give people some time to respond.
Will do.
> > >
> > > Agreed with all comments except the endian one.
> > > SPI doesn't define an endianness of data on the wire, so we may need
> > > to convert to match whatever ordering the ti chip expects.
> > > I would expect things to be thoroughly broken if we remove those
> > > conversions - particularly as I doubt this is being tested with a
> > > big endian host!
> > >
> > > Jonathan
> >
> > I'm a bit confused then. I got this idea from include/linux/spi.h, which
> > says:
> >
> >   * In-memory data values are always in native CPU byte order, translated
> >   * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
> >   * for example when bits_per_word is sixteen, buffers are 2N bytes long
> >   * (@len = 2N) and hold N sixteen bit words in CPU byte order.
> >
> >
> > And in the most recent patches to the ti-ads7950 driver where we switched
> > from 8-bit words to 16-bit words, I had to remove the calls to cpu_to_be16()
> > to keep things working.
> Ah, my apologies, I didn't look at this closely enough.
>
> I was assuming we weren't in 16 bit mode here - oops.
>
> Otherwise this wouldn't have any hope of working... Except I'm assuming it is...
> hohum.
>
> Hmm. Given the result of that cpu_to_be16 will be to swap (as almost certainly
> on le system), I'm going to hazzard a guess that the ti device is expecting
> little endian and we should be setting SPI_LSB_FIRST.
> Which is odd because the data sheet definitely looks MSB first. Not to mention
> this isn't be done elsewhere in the driver.
>
> So only option I can fall back on is that it is being used on a be system
> (hence noop) or is a forward port of an older patch for the driver that missed
> your 16 bit change...
>
Yes sorry! This was my mistake. I was juggling two different kernel
versions and one of them didn't have those changes.

Thanks for the review, will address the comments and submit a v4:)

Justin

> >
> > I realize that I am only using one SPI controller, so I may be making a bad
> > assumption here, but it seems to me that it is up to the SPI controller to
> > make sure the bits get sent over the wire in the correct order and we
> > shouldn't have to worry about it here. We are implicitly telling the SPI
> > controller that we need big-endian over the wire by omitting the SPI_LSB_FIRST
> > flag here:
> >
> >       spi->bits_per_word = 16;
> >       spi->mode |= SPI_CS_WORD;
> >       ret = spi_setup(spi);
> >
> You are entirely correct, I was too lazy and had forgotten your change to
> move to 16 bits.
>
> Jonathan
>
