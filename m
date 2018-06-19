Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59988C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041CA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041CA20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937301AbeFSGwY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:52:24 -0400
Received: from muru.com ([72.249.23.125]:48058 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965149AbeFSGuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:50:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D49F78128;
        Tue, 19 Jun 2018 06:53:02 +0000 (UTC)
Date:   Mon, 18 Jun 2018 23:50:18 -0700
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
Message-ID: <20180619065018.GX112168@atomide.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180612222356.GD38773@dtor-ws>
 <69494657.T0PeNZxiFJ@z50>
 <20180613044152.GB112168@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613044152.GB112168@atomide.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180613 04:44]:
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180613 01:18]:
> > On Wednesday, June 13, 2018 12:23:56 AM CEST Dmitry Torokhov wrote:
> > > Hi Janusz,
> > > 
> > > On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> > > > GPIO lookup table for ams-delta-serio device was introduced by commit
> > > > 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> > > > Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> > > > lookup table" was not accepted by subystem maintainer who requested
> > > > conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> > > > pin with IRQ resource, replacement of GPIO pin providing keyboard power
> > > > with a regulator and removal of remaining GPIO pins from the driver as
> > > > not handled by it.
> > > > 
> > > > Let's start with removal of no the longer needed GPIO lookup table from
> > > > the board init file.
> > > > 
> > > > Series created and tested on top of next-20180608 tag from linux-next
> > > > tree.
> > > 
> > > This all is really nice (modulo a couple of questions), thank you for
> > > implementing this. How do you want to merge this? Through OMAP tree or
> > > input?
> > 
> > Hi Dmitry,
> > 
> > If Tony doesn't mind, I would prefer it merged through OMAP tree as I still 
> > have a few board patches built on top of it in my queue.
> 
> Works for me once Dmitry is happy with the patches.

And please repost the whole series with acks collected so
I know what I need to apply :)

Regards,

Tony

