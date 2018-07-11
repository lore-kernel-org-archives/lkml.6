Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96419C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D25720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D25720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeGKOuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:50:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387979AbeGKOuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:50:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AE2D320775; Wed, 11 Jul 2018 16:45:30 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0A8452073D;
        Wed, 11 Jul 2018 16:45:30 +0200 (CEST)
Date:   Wed, 11 Jul 2018 16:45:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
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
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: i3c: Document core bindings
Message-ID: <20180711164529.3388d045@bbrezillon>
In-Reply-To: <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-5-boris.brezillon@bootlin.com>
        <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 16:10:10 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> >  
> 
> > +I2C devices
> > +===========
> > +
> > +Each I2C device connected to the bus should be described in a subnode. All
> > +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> > +valid here, but several new properties have been added.
> > +
> > +New constraint on existing properties:
> > +--------------------------------------  
> ...
> > +  + third cell: should be 0  
> 
> What for? Just to be future-proof, or do you have something specific
> in mind here?

Even if I2C devices only need 1 cell, I3C devices need 3 (1 for the
static address and 2 for the PID). Since both type of devices are
described under the same bus node, and we can have different
#address-cells, I had to put 0-padding in the last cell.
