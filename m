Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755129AbeD3QsF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:48:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57482 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755105AbeD3QsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:48:04 -0400
Date: Mon, 30 Apr 2018 18:47:51 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as
 chipselect
Message-ID: <20180430184751.574550cc@bbrezillon>
In-Reply-To: <CAMRc=Mf2TKsuiudxPdEFStrstHH65jHb6JFJ0Ort9GvWDSo9bQ@mail.gmail.com>
References: <20180430082453.8091-1-brgl@bgdev.pl>
        <20180430120930.4768a7cb@bbrezillon>
        <CAMRc=Mf2TKsuiudxPdEFStrstHH65jHb6JFJ0Ort9GvWDSo9bQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 18:45:06 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-04-30 12:09 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > Hi Bartosz,
> >
> > On Mon, 30 Apr 2018 10:24:41 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> We have the 'ti,davinci-chipselect' property in the device tree, but
> >> when using platform data the driver silently uses the id field of
> >> struct platform_device as the chipselect. This is confusing and we
> >> almost broke the nand support again recently after converting the
> >> platform to common clock framework (which changed the device id in the
> >> clock lookup - the problem is gone now that we no longer acquire the
> >> clock in the nand driver.
> >>
> >> This series adds a new field to davinci-nand platform data, then makes
> >> all board use it and finally modifies the two drivers that make use of
> >> it.
> >>
> >> Bartosz Golaszewski (12):
> >>   mtd: nand: davinci: store the core chipselect number in platform data
> >
> > Raw NAND related patches (that is, everything that is not onenand or
> > SPI NAND) should use the "mtd: rawnand: " prefix now. Other than that,
> > I'm fine with the patch series, just let me know how you want to have it
> > merged (through the MTD tree or the davinci tree).
> >
> > Thanks,
> >
> > Boris
> 
> I think Sekhar could pick all those patches up for 4.18.

Okay, then I'd need an immutable branch containing these changes.

> 
> Sekhar - do you want me to resend the series with the commit message
> changed as requested by Boris, or can you fix it when applying the
> series?
> 
> Best regards,
> Bartosz Golaszewski
