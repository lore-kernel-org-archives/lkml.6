Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbeGXQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:53:28 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43278 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbeGXQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:53:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id s17-v6so2261671vke.10;
        Tue, 24 Jul 2018 08:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oa7UlTiloXoc6U/EcthojwxasXcOuDWL7biSXvLmbsM=;
        b=WtAqTPQfUXQ91k0phXSxk3yV/V4TOTpOK1TmqZPn/W6T6qCmH3WeMWqqWttaBbmMsR
         vzlySAzAeTdy4+wVMldnQRH/evW7kd4KjNAcqXn3vhBZO/jAYMxn/c5XFwlSpVYbAHAV
         Ji40kI4bkrLcdFs7KYo/eRGTYQojmkn+htuYwyysHF+mZfwLODtT/eDJvr4uXxCrcsN4
         2SzjSw/ENkjhtaDmWYR7TPWV2ekFGnVS72Rub1nOXNGr0sO2XAYxQm0ikRbuJTwZ23Zn
         33QlHPtx3ZW7v79PYMJxw2tBKv1Iipx2tQcKTKw5v//P+bSjxGclIELnkM8zJJL430aH
         enSg==
X-Gm-Message-State: AOUpUlGB0PL7hp2ittyiHuoH8ywaweSE/wVePF8NAb2io/8Alu3ZImDQ
        oqTDWUA9FQZErcvbzYNw+CiMMZv0s2wBoUXLMg8=
X-Google-Smtp-Source: AAOMgpcU60zKK0qSYG0cTym8Png/z7Ymcjt9IAF/gltFoVGGagMcKNO5pc9zoawf8PGQRMGuLaL1cBW36dAdM14BVPY=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr11025960vkd.132.1532447182109;
 Tue, 24 Jul 2018 08:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com> <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jul 2018 17:46:09 +0200
Message-ID: <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jul 24, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> >> That's not the case I was describing here, I was thinking of what
> >> Wolfram described with the Renesas SoC that has two i2c masters
> >> multiplexed through the pinmux layer. I would assume that we
> >> can still do the same thing in i3c by shutting down the current
> >> master without a handover, and reprobing everything from scratch.
> >
> > The major disadvantage of reprobing is that it may cause visual disturbances
> > when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
> > etc.).
>
> Do you mean we should reuse the device pointer and association with
> the driver even when we switch out the i3c master using the pinmux?
>
> Or do you mean we need to be prepared for driving a single
> slave through multiple masters over the lifetime of that device,
> but using the i3c master handover protocol?
> In the second case, how do we decide which master to use
> for accessing a device for a given request?

I'll have to defer to Wolfram. He's the i2c and muxing expert.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
