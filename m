Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CFAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C1C21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C1C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDBwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:52:41 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:49195 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbeJDBwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:52:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0EE66182CED2A;
        Wed,  3 Oct 2018 19:03:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest59_36ba49960b458
X-Filterd-Recvd-Size: 3878
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Oct 2018 19:02:55 +0000 (UTC)
Message-ID: <e62f978f8d6fc3486c35818432d118358b32c58a.camel@perches.com>
Subject: Re: [PATCH v8 05/10] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Date:   Wed, 03 Oct 2018 12:02:54 -0700
In-Reply-To: <CAMuHMdVA7eKD+qfzzCqrXus69NPb3Qd_G0k=TYvrdt=2pRG51A@mail.gmail.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
         <20181003132212.12619-6-boris.brezillon@bootlin.com>
         <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
         <CAMuHMdVA7eKD+qfzzCqrXus69NPb3Qd_G0k=TYvrdt=2pRG51A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 20:45 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Wed, Oct 3, 2018 at 8:37 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-10-03 at 15:22 +0200, Boris Brezillon wrote:
> > > The reg property of devices connected to an I3C bus have 3 cells, and
> > > filling them manually is not trivial. Provides macros to help doing
> > > that.
> > 
> > This patch logic seems excessively fragile.
> > > --- /dev/null
> > > +++ b/include/dt-bindings/i3c/i3c.h
> > > +
> > > +#define I3C_PID(manufid, partid, instid, extrainfo)          \
> > > +     ((manufid) << 1)                                        \
> > > +     (((partid) << 16) | ((instid) << 12) | (extrainfo))
> > 
> > This macro doesn't make any sense.  Missing a shift and an or?
> 
> No, it generates two of the three cells.
> 
> > > +
> > > +#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,              \
> > > +                              instid, extrainfo)             \
> > > +     (addr) I3C_PID(manufid, partid, instid, extrainfo)
> > > +
> > > +#define I3C_DEV(manufid, partid, instid, extrainfo)          \
> > > +     I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,          \
> > > +                              instid, extrainfo)
> 
> And the above two macros generate all three cells.

It seems none of the other include/dt-bindings/ .h files
have unusual macros like these.

Perhaps this file should not have a .h extension but
something be named like i3c_reg_property.macros



