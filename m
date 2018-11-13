Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05542C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9576216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9576216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeKNFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:48:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:48:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so6603778pfk.0;
        Tue, 13 Nov 2018 11:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTYl1YEZsWlo48zpcSGeS0opwdJMNJLCJODJ4Tvr1/E=;
        b=loFJKwtbX2Avl68NLXPkdHg7E0obeNnLD/zp9G+FEWIq5xlxgNtFE+SMakzyH2Pxmz
         3y+ayaFXWy8eKiUn3DrdRvQPxSGyJMuEK3QnZk6hc89Xnz4B/4ZXASFxs0XmgceBasCr
         +ogC0VTsASfnG4+LEwf17G27lc9BtM5gC5ciwEosFJg4JxDFI+q5SJvpNAfkpyEUyeJ6
         b8x2yu3xVKAYFyKowzB0Lj4SaRQNOoGhe10RUmZa0LhDiK8Js71Ysx+EqHe/GBYA/aGj
         PKkT/aG5tMm5C7JO5wgas0HdjJe1utXY4RtIx5oKahvyf7DAXejTIfjayyKy9E2y2E8C
         zItA==
X-Gm-Message-State: AGRZ1gJUMcWwiSt5YCciCYqO1LmV1fnNWdhdk4CcTlyMazIfruz939aA
        HaP+8nn0nDKs1SGvh5c2AINEhtTjVSSsuOoOO6M=
X-Google-Smtp-Source: AJdET5fv0h02rVrg3ksvYPdjXrHayvNi6L92+6zAvOEynNaI9fIqUqaIHqPc5ebAXyWjZR3YSE35fw+qMsK3F4ft6Y0=
X-Received: by 2002:a62:de06:: with SMTP id h6-v6mr6554715pfg.36.1542138534634;
 Tue, 13 Nov 2018 11:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20181112142736.15009-1-kernel@esmil.dk> <20181113183527.GG2089@sirena.org.uk>
In-Reply-To: <20181113183527.GG2089@sirena.org.uk>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 13 Nov 2018 20:48:43 +0100
Message-ID: <CANBLGcxF-WgsBVFHf4jGRR+Ox2vz=ewzhwGP1CZX-R5HpDAVBg@mail.gmail.com>
Subject: Re: [RFC PATCH] spi: add driver for the SiFive SPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
On Tue, 13 Nov 2018 at 19:35, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Nov 12, 2018 at 03:27:36PM +0100, Emil Renner Berthing wrote:
>
> > I know the discussions about the sifive devicetree compatible
> > strings haven't come to a conclusion, so I'm sending this as
> > an RFC to get some feedback on the rest of the code.
>
> I've not seen any of these discussions or earlier versions of this
> driver so I've no idea what's going on here :(

No, sorry. This has been discussed on linux-riscv for other drivers
like the uart. See my last answer.

> > +Optional properties:
> > +- sifive,fifo-depth          : Depth of hardware queues; defaults to 8
> > +- sifive,max-bits-per-word   : Maximum bits per word; defaults to 8
> > +
>
> If the hardware isn't fixed yet making these enumerable from the
> hardware would be good...

Agreed, but unfortunately this is already in the FU540-C000 chip on
the HiFive Unleashed board sold by SiFive.

> > @@ -0,0 +1,442 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SiFive SPI controller driver (master mode only)
> > + *
>
> Please make the entire comment a C++ one to make this look more
> intentinal.

Will do.

> > +/* for consistency we need this symbol */
> > +#ifdef REG_FMT
> > +#undef REG_FMT
> > +#endif
>
> We do?  For consistency with what?

Below all the register offsets are defined as
REG_<register name>. This is is a pattern I
copied from other drivers, but here we have a
register called "fmt" - hence REG_FMT.
If you have a better pattern that doesn't clash
with REG_FMT please let me know.

> > +static void sifive_spi_init(struct sifive_spi *spi)
> > +{
>
> > +     /* Set CS/SCK Delays and Inactive Time to defaults */
> > +
> > +     /* Exit specialized memory-mapped SPI flash mode */
>
> ...or not?

Right. Will add that or just delete the comment.

> > +     /* Set frame format */
> > +     cr = FMT_LEN(t->bits_per_word);
> > +     switch (mode) {
> > +     case SPI_NBITS_QUAD:
> > +             cr |= FMT_PROTO_QUAD;
> > +             break;
>
> Some namespacing on the driver #defines would be a bit safer against the
> possibility of collision with future changes in headers.

Right.

> > +static void sifive_spi_wait(struct sifive_spi *spi, u32 bit, int poll)
> > +{
> > +     if (poll) {
> > +             u32 cr;
> > +             do cr = sifive_spi_read(spi, REG_IP);
> > +             while (!(cr & bit));
>
> Please add some braces, indentation or something to make it more clear
> that the read is part of a do/while loop - right now it's not
> immediately obvious that this is correct.

Good point. Will do.

> > +static int sifive_spi_transfer_one(struct spi_master *master,
> > +             struct spi_device *device, struct spi_transfer *t)
> > +{
> > +     struct sifive_spi *spi = spi_master_get_devdata(master);
> > +     int poll = sifive_spi_prep_transfer(spi, device, t);
> > +
> > +     sifive_spi_execute(spi, t, poll);
> > +
>
> Why not just inline the execute function here?  It's the only caller
> AFAICT.

Yeah, it is. Will do.

> > +static void sifive_spi_set_cs(struct spi_device *device, bool is_high)
> > +{
> > +     struct sifive_spi *spi = spi_master_get_devdata(device->master);
> > +
> > +     /* Reverse polarity is handled by SCMR/CPOL. Not inverted CS. */
> > +     if (device->mode & SPI_CS_HIGH)
> > +             is_high = !is_high;
>
> spi_set_cs() will handle CS_HIGH for you.
>
> > +     master->bits_per_word_mask = SPI_BPW_MASK(8);
>
> I thought the device supported other bits per word values?

It does, but the driver doesn't yet. When bits per word is < 8
we need to shift the bits in each byte to be "left-aligned"
(unless SPI_LSB_FIRST is set).

> > +     /* If mmc_spi sees a dma_mask, it starts using dma mapped buffers.
> > +      * Probably it should rely on the SPI core auto mapping instead.
> > +      */
> > +     pdev->dev.dma_mask = NULL;
>
> If this is a problem please fix it in the MMC core, don't bodge it like
> this.

Gotcha. Will remove this.

> > +static const struct of_device_id sifive_spi_of_match[] = {
> > +     { .compatible = "sifive,spi0", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
>
> spi0 is a *weird* compatible name.

Exactly. Hence the discussion about the compatible strings.
Once this discussion comes to a conclusion I'll update this.

Thank you for the review!
/Emil
