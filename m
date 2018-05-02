Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEBSK6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:10:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59791 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbeEBSK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:10:57 -0400
Date: Wed, 2 May 2018 20:10:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] clocksource: rework Atmel TCB timer driver
Message-ID: <20180502181046.GG19273@piout.net>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
 <20180426164623.tlv6kz5yopk6voxx@breakpoint.cc>
 <20180426185233.GU4813@piout.net>
 <20180502133418.xa26c5ta2ytxxjcn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502133418.xa26c5ta2ytxxjcn@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 15:34:18+0200, Sebastian Andrzej Siewior wrote:
> On 2018-04-26 20:52:33 [+0200], Alexandre Belloni wrote:
> > 
> > I don't remember you posted anything for the TCB. Wasn't it focused on
> > getting rid of the PIT irq?
> 
> the PIT irq which was shared with the UART one some devices, yes this
> was part of it. The other essential piece was using a higher frequency
> for the device:
>   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/clocksource-tclib-allow-higher-clockrates.patch?h=linux-4.14.y-rt-patches
> 
> > As said below, this is solving multiple issues, including the one for
> > SoCs that don't have the PIT.
> will the PIT be removed? Where it needs the PIT?
> 

The last patch is unselecting the PIT driver so by default it is not
enabled. The PIT driver will stay just in case someone has to use it
e.g. when they are using all the TCB channels for something else.
However, recent Atmel SoC have a TCB without any output so it can ony be
used as a timer. Some other SoCs don't have a PIT at all.

> > I don't think you ending up with nothing but probably you removed the
> > PIT and kept ATMEL_TCLIB which is the combination that is really
> > difficult to protect from. I don't think it is worth the added Kconfig
> > complexity.
> 
> TCLIB was still enabled yes. It is 'oldconfig'.
> 

Hum, ok, I'll try to provide a cleaner path.

> > The remaining one would be "clocksource: TCLIB: Allow higher clock rates
> > for clock events"
> 
> I see. So I would need to keep that patch in queue after it was
> dismissed from duty…

Boris suggested a DT binding to allow changing the rate but it didn't
reach consensus at the time. this is something that will ne to be
revived at some point and I would very much like having that upstream
too.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
