Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B2B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B2B20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeKSTba convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:31:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38673 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKSTba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:31:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D752E20CFD; Mon, 19 Nov 2018 10:08:26 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46C0C20791;
        Mon, 19 Nov 2018 10:08:26 +0100 (CET)
Date:   Mon, 19 Nov 2018 10:08:25 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        devicetree <devicetree@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/25] at24: remove
Message-ID: <20181119100825.277b1f97@bbrezillon>
In-Reply-To: <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
        <20181118170329.788778a8@bbrezillon>
        <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 09:58:46 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> niedz., 18 lis 2018 o 17:03 Boris Brezillon
> <boris.brezillon@bootlin.com> napisał(a):
> >
> > On Tue, 13 Nov 2018 15:01:08 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> > > As far as merging of this series goes: I'd like to avoid dragging it over
> > > four releases. The series is logically split into five groups:
> > >
> > > patches 1-2: nvmem and mtd changes
> > > patches 3-9: davinci arch-specific changes
> > > patches 10-13: networking changes
> > > patches 14-24: davinci specific again
> > > patch 25: final at24 change
> > >
> > > With that I believe we can do the following: Greg KH could pick up the
> > > first two patches into his char-misc tree.  
> >
> > The char-misc tree? Why not the MTD or NVMEM tree?
> >  
> 
> There is no NVMEM tree - Srinivas sends his patches to Greg to be
> applied to char-misc.

Okay, I didn't know that.

> 
> The second patch depends on the first one so in order to avoid more
> merging problems I suggested that the MTD patch go through char-misc
> as well. If you see a better solution, please let me know.

No that's fine, as long as I have an immutable tag/branch I can pull if
needed.
