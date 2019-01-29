Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B70C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05B72183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkFdKJ5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfA2Jfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:35:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33070 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfA2Jfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:35:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so14140968lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGvwDn6/tMvtCS6ptoLoph2KvlgvoUPE78AHl1VExmI=;
        b=EkFdKJ5ZTVVcfxssoBo54OMzMylPZAjsocw9suGcuD+KdG4ekcoo1w81doGtV2hUi+
         21ml53BXV9a11uu4XDDUYW9w8yC02iEgHTrkkUtIQygmMo1e0IMSVWo64hry+wLmtGjg
         gFx9IT+QGcIXzivGI2q7YVOaV89clso1CM/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGvwDn6/tMvtCS6ptoLoph2KvlgvoUPE78AHl1VExmI=;
        b=lcEjnhXtWhxJ8pFqrx8OYegudKmxB8uIqqvMX4PgFBAv+CHvdvjNrnBVHV65KXh+Jd
         /AWB3E+Ckjynki2bH+o2X48B0+VPyEIsnB3fEqxHVzt+AZ3jV09z+5yKD9PnfeuOXDpx
         deryY52Vo39/kku/bgCcGqoaYHfRjXBFAiJZLDV/I2pYUdDXIXJxAip+Xh0Az55Zamtr
         sMNADIWhmeVgc7T/+dqyV11Ep38UtEKy8wBZs7r08CEJagLG1nBCbKM9djKiR0G85ZgP
         c6wlhAuXlEEadbYm9g2vNAqQNSiTD2MfsbljBlwvMyVaTBFH0pj1PXN63oSo1znevUJq
         /n0g==
X-Gm-Message-State: AJcUukeax3A68Zf57A0k2INdjJkH4VBJ3V0MtIVPi86cgXvxSXGU3kqj
        /+EN/l9y3/CJCVqLMVI9UX3TFWcXhxCCv1GjSyD1FqilZlmOWQ==
X-Google-Smtp-Source: ALg8bN5/JqU6rGEE5nxf2NZgVHfati9/6X3drEeNVeuXcpGMBUhTpZg1dnfLj11oX5ITJC8MMGJF6+k1xk3FaZ2Z5KM=
X-Received: by 2002:a19:7018:: with SMTP id h24mr19219366lfc.162.1548754528394;
 Tue, 29 Jan 2019 01:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20190126163220.26421-1-jonas@norrbonn.se> <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk> <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
 <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com> <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
In-Reply-To: <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 29 Jan 2019 17:35:16 +0800
Message-ID: <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 17:14, Jonas Bonn <jonas@norrbonn.se> wrote:
>
>
>
> On 29/01/2019 10:04, Baolin Wang wrote:
> > Hi Jonas,
> > On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
> >>
> >> Hi,
> >>
> >> On 28/01/2019 19:10, Mark Brown wrote:
> >>> On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
> >>>
> >>>> @@ -164,6 +166,7 @@ struct spi_device {
> >>>>       char                    modalias[SPI_NAME_SIZE];
> >>>>       const char              *driver_override;
> >>>>       int                     cs_gpio;        /* chip select gpio */
> >>>> +    uint16_t                word_delay;     /* inter-word delay (us) */
> >>>
> >>> This needs some code in the core joining it up with the per-transfer
> >>> word delay similar to what we have for speed_hz and bits_per_word in
> >>> __spi_validate().  Then the controller drivers can just look at the
> >>> per-transfer value and support both without having to duplicate logic.
> >>>
> >>
> >> So spi_transfer already has a field word_delay and it's defined as
> >> _clock cycles_ to delay between words.  I defined word_delay in
> >> spi_device as _microseconds_ to delay along the lines of delay_usecs.
> >>
> >> Given that the inter-word delay is a function of the slave device speed
> >> and not of the SPI bus speed, I'm inclined to say that a time-based
> >> delay is what we want (to be independent of bus speed).  As such, I want
> >> to know if I should add word_delay_usecs to _both_ spi_transfer and
> >> spi_device?
> >>
> >> There's only one user of word_delay from spi_transfer.  Just looking at
> >> it quickly, it looks like it wants the word_delay in
> >> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
> >> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
> >> that to be microseconds and do the calculation in the driver?
> >
> > The Spreadtrum SPI controller's word delay unit is clock cycle of the
> > SPI clock, since the SPI source clock can be changed, we can not force
> > user to know the real microseconds. But can we change it to a union
> > structure? not sure if this is a good way.
>
> OK, so it is the SPI clock.  That's good.  There's a comment in the
> driver that makes it look like it should be the source clock.

Sorry for my unclear description, what I mean is that it is the SPI
source clock cycles.

> The problem with a delay in clock cycles is that the faster the clock,
> the shorter the delay.  The delay is a property of the slave and the
> slave has a fixed internal clock.  This means that if we increase SCK we
> also need to increase the word_delay (in cycles) in order to give the
> slave the same amount of breathing room.

Sorry for my confusing description, our case requires source clock
cycles for word delay.

>
> >
> > union {
> >       int word_delay_us;
> >       int word_delay_cycle;
> > } w;
> >
>
> I don't think that's a practical solution.
>
> The register setting in the spi-sprd driver is what... SCK cycles?  So
> you'd want word_delay_us * max_speed_hz?
>
> The register setting on my Atmel board is in SPI-clock cycles
> (effectively).  So I want word_delay_us*clk_get_rate(spi-clk).

Okay, so your case is different with Spreadtrum SPI.

-- 
Baolin Wang
Best Regards
