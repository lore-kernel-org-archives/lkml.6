Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E81220844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E81220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeGXROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:14:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39162 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbeGXROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:14:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 95B1220733; Tue, 24 Jul 2018 18:07:30 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D9145203D9;
        Tue, 24 Jul 2018 18:07:29 +0200 (CEST)
Date:   Tue, 24 Jul 2018 18:07:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180724180729.4aed4a7a@bbrezillon>
In-Reply-To: <20180724155717.aodl6xehacparo7b@katana>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
        <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
        <20180720101206.tv7nsoanwo5ftnia@ninjato>
        <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
        <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
        <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
        <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
        <20180720154132.2fwmwpiwtxa73ljf@ninjato>
        <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
        <20180724155717.aodl6xehacparo7b@katana>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 17:57:17 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> > I think an SoC design we will likely see is an i3c master multiplexed with
> > an i2c master to access one bus. The i2c master can then use clock
> > stretching and other things that may not work in the i3c master, and it
> > may be used in the absence of proper i3c drivers in the OS.  
> 
> Multiplexed? Well, as soon you want to use I3C features like IBI, this
> is not going to work, right? It will not even work with Linux being an
> I2C slave itself. Or do you mean running the I3C and I2C controller
> simultaneously using the same wires?

I think we should switch to an I3C mindset. It seems the use cases
we're discussing so far are I2C use cases. Keep in mind that I3C bus
management is completely different from I2C one (event if I3C is
backward compatible with I2C, it's just a feature, not the foundation
of the I3C protocol).
