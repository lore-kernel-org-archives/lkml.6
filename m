Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE0C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3432D23E66
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432D23E66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeF0HUx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:20:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58542 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752741AbeF0HUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:20:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A8BA12079C; Wed, 27 Jun 2018 09:20:47 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id E60E8206D8;
        Wed, 27 Jun 2018 09:20:36 +0200 (CEST)
Date:   Wed, 27 Jun 2018 09:20:36 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 02/10] docs: driver-api: Add I3C documentation
Message-ID: <20180627092036.605dbf12@bbrezillon>
In-Reply-To: <4898e391-f954-a399-0bca-7588942280b9@infradead.org>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-3-boris.brezillon@bootlin.com>
        <4898e391-f954-a399-0bca-7588942280b9@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, 26 Jun 2018 14:07:49 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:


> > +
> > +I3C Private SDR transfers
> > +-------------------------
> > +
> > +Private SDR (Single Data Rate) transfers should be used for anything that is
> > +device specific and does not require high transfer speed.
> > +
> > +It is the equivalent of I2C transfers but in the I3C world. Each transfer is
> > +passed the device address (dynamic address assigned during DAA), a payload
> > +and a direction.
> > +
> > +The only difference with I2C is that the transfer is much faster (typical SCL  
> 
> what is SCL?  It's not used anywhere else in this doc.

It's an acronym used by I²C, it means Serial Clock Line. I'll just
replace that by "typical clock frequency is 12.5MHz".

> 
> > +frequency is 12.5MHz).
> > +
> > +I3C HDR commands
> > +----------------
> > +
> > +HDR commands should be used for anything that is device specific and requires
> > +high transfer speed.
> > +
> > +The first thing attached to an HDR command is the HDR mode. There are currently
> > +3 different modes defined by the I3C specification (refer to the specification
> > +for more details):
> > +
> > +* HDR-DDR: Double Data Rate mode
> > +* HDR-TSP: Ternary Symbol Pure. Only usable on busses with no I2C devices
> > +* HDR-TSL: Ternary Symbol Legacy. Usable on busses with I2C devices
> > +
> > +When sending an HDR command, the whole bus has to enter HDR mode, which is done
> > +using a broadcast CCC command.
> > +Once the bus has entered a specific HDR mode, the master sends the HDR command.
> > +An HDR command is made of:
> > +
> > +* one 16-bits command word
> > +* N 16-bits data words  
> 
> I supposed the I3C spec will tell me the byte order of these words on the bus?
> or this doc could tell us here.

It's big endian. I'll make it clear in this doc.

I'll also fix all the other mistakes you pointed out.

> 
> and you can add (if you want to):
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I'll definitely add your R-b. Thanks for the review.

Boris
