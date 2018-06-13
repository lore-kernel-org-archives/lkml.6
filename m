Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B72DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEE8208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE8208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeFMEl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:41:58 -0400
Received: from muru.com ([72.249.23.125]:46920 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933328AbeFMEl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:41:56 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1924F80E4;
        Wed, 13 Jun 2018 04:44:31 +0000 (UTC)
Date:   Tue, 12 Jun 2018 21:41:52 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for
 serio device
Message-ID: <20180613044152.GB112168@atomide.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180612222356.GD38773@dtor-ws>
 <69494657.T0PeNZxiFJ@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69494657.T0PeNZxiFJ@z50>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180613 01:18]:
> On Wednesday, June 13, 2018 12:23:56 AM CEST Dmitry Torokhov wrote:
> > Hi Janusz,
> > 
> > On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> > > GPIO lookup table for ams-delta-serio device was introduced by commit
> > > 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> > > Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> > > lookup table" was not accepted by subystem maintainer who requested
> > > conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> > > pin with IRQ resource, replacement of GPIO pin providing keyboard power
> > > with a regulator and removal of remaining GPIO pins from the driver as
> > > not handled by it.
> > > 
> > > Let's start with removal of no the longer needed GPIO lookup table from
> > > the board init file.
> > > 
> > > Series created and tested on top of next-20180608 tag from linux-next
> > > tree.
> > 
> > This all is really nice (modulo a couple of questions), thank you for
> > implementing this. How do you want to merge this? Through OMAP tree or
> > input?
> 
> Hi Dmitry,
> 
> If Tony doesn't mind, I would prefer it merged through OMAP tree as I still 
> have a few board patches built on top of it in my queue.

Works for me once Dmitry is happy with the patches.

Regards,

Tony
