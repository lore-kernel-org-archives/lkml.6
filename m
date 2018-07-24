Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F11C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D264020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdPBOFhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D264020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbeGXRMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:12:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46510 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388361AbeGXRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:12:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id d4-v6so4618928qtn.13;
        Tue, 24 Jul 2018 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1w9pC2fbBCNAcULw7MsRyCA+ppCJSj519xcHvbe50do=;
        b=BdPBOFhb8tgFvAAKDwYnXJ0eEc0q/rLcoXH58LnCNsnY0pJ8nz/RA23M7HYmzhLW7j
         iDAK+xZMywDguziiFwPJ044v1rVAvdvwSLt5PUvMVY64Y59aItUdhLoodMwU+G0HFxbe
         xxWdvC1f2/gbrdp2DGryp7LzN4augKxHOd/gwvDpBL2jaxtmsGz+z81lRcz5wAp/8dkh
         tqV8tQ2dkAEbB9HaOzttwrDSS6pegNv+4cwxJ3um4dYr4MqgeqsttGA9ZlPlEbTL+Zgz
         9axngNc3YYvkYAvL26PUHwRhX+LF4Hy8TXYKIJSpoPuw2qHdCMP560vo6Rx3sGuxoJli
         VRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1w9pC2fbBCNAcULw7MsRyCA+ppCJSj519xcHvbe50do=;
        b=oB9WZ7Bqft25LKf/1FeZKw9I7JEWKeIcHnD0MIzTWvxaqcRZxEZ83009XvadEAUfTN
         gg/tITjQFOSi7CRO/42Gjum+NpNFiFxkpR70pem3Xzw4kq/JLnfOfqbnzxItuj8ItMev
         dYgrB2qXAp/RcZUxYxBS/YjDHfoyP93ghHOIcLQ5ZhlANm+w46wsKFFiD96IlIVQcBvx
         AOy+wonf7rQY0I7DSG4St6NvTORWRH0cIrlPt9WxiGsZFlzsXsO+Yaz9SX/ogZLu0rVP
         qAxECJ6Up8WCy1cUmFcOfC1JyieVz25csKWmRG5s4NvA2GXAvJ0gXBqmJ/Ix8jNUVyxO
         kxmQ==
X-Gm-Message-State: AOUpUlFRoseUlNdpmmeKm9XgUhGwRHlhgz+/AAwF1atbrMQNuKzjAbnq
        k1cD9KzWWL7TsqEAfma947KVgEVA5IStRU8RnFM=
X-Google-Smtp-Source: AAOMgpdnESjff44sHH9SIYwq5GbqsdnLO691jLH9Dh9ddo8xxCr6k0WO72hgDnUObPOjOg1HyVinYMKEVdszpd3SjUY=
X-Received: by 2002:ac8:3676:: with SMTP id n51-v6mr16927376qtb.163.1532448293734;
 Tue, 24 Jul 2018 09:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 09:04:52
 -0700 (PDT)
In-Reply-To: <20180724155717.aodl6xehacparo7b@katana>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se> <20180720154132.2fwmwpiwtxa73ljf@ninjato>
 <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com> <20180724155717.aodl6xehacparo7b@katana>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 18:04:52 +0200
X-Google-Sender-Auth: -XVV6IL7yeAQkuo5mzE1K2QBOvM
Message-ID: <CAK8P3a1KU+KMOQ+iqpmsn2MqQpOdH-tiN0tbOmSKeaBs8DMVgw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 5:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > Renesas R-Car Gen2 has two I2C IP cores. One can do DMA and automatic
>> > transfers to the PMIC, the other has I2C slave functionality. One cannot
>> > do I2C_SMBUS_QUICK, the other can. And some more kind of quirks.
>> > Sometimes you can mux the pins to GPIO, so you have a third option.
>> >
>> > This setup is the reason the demux driver exists.
>>
>> Have you run into scenarios where you dynamically switch between
>> the two masters in order to do different things (on one slave, or
>> on multiple slaves), or could you always decide on one of them
>> at boot time with that particular chip?
>
> My personal use case is debugging. R-Car H2 is great because I can
> always pinmux this or that I2C IP core to the same set of pins, and in 2
> out of 4 cases even GPIO bitbang on top of that. So, it is great to
> compare behaviour, do scopes with the same type of setup, etc...
> For that, I do runtime switches, but the slaves are not really under
> real usage.

Ok, so runtime here still means it's chosen by an operator (i.e. you),
not part of regular operation.

> I have absolutely no idea how $customers use it, sadly.

Right.

>> I think an SoC design we will likely see is an i3c master multiplexed with
>> an i2c master to access one bus. The i2c master can then use clock
>> stretching and other things that may not work in the i3c master, and it
>> may be used in the absence of proper i3c drivers in the OS.
>
> Multiplexed? Well, as soon you want to use I3C features like IBI, this
> is not going to work, right? It will not even work with Linux being an
> I2C slave itself. Or do you mean running the I3C and I2C controller
> simultaneously using the same wires?

I meant multiplexing it through the pinmux framework, with one of the
two being active at any time. Obviously this makes no sense for
i3c slaves, but it can be useful if the bus only contains i2c slaves.

>> However, that case cannot be handled with the abstraction in the
>> proposed i3c framework, which can only deal with multiple i3c
>> standard compliant masters. I'm also not sure if it can be added
>> to the i2c-demux-pinctrl driver.
>
> The I2C demuxer maps the whole bus to an i2c_adapter. You cannot select
> a master per client.

What I meant here was switching the bus between an i2c master and an
i3c master like you do with the i2c demuxer. Right now, this wouldn't
work because i2c and i3c use different representations in DT and in
Linux for the same devices.

     Arnd
