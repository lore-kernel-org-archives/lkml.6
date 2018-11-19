Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6633AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED9A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED9A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeKSXtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:49:04 -0500
Received: from shell.v3.sk ([90.176.6.54]:44613 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeKSXtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:49:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A3AE6C6C7D;
        Mon, 19 Nov 2018 14:25:23 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bjcSM453nNLq; Mon, 19 Nov 2018 14:25:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 63DDAC6C7E;
        Mon, 19 Nov 2018 14:25:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x6PQmzZtBQwK; Mon, 19 Nov 2018 14:25:18 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1140AC6C7D;
        Mon, 19 Nov 2018 14:25:18 +0100 (CET)
Message-ID: <26d225cd1ed93faff6e0a0513680fa5385f05f2d.camel@v3.sk>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Date:   Mon, 19 Nov 2018 14:25:17 +0100
In-Reply-To: <20181119104046.GC28607@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-7-lkundrak@v3.sk>
         <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
         <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
         <20181119104046.GC28607@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I've addressed some of Andy's concerns you're replying to below in a
follow-up version of the patch. To many points I'm generally
indifferent and prefer to lean towards making things easy for whoever
may be likely to deal with the code in past. It's not clear to me who
that might be, or how important either of you consider your remarks to
be. I'll be thankful if anyone makes this clearer to me.

(I hoped that you're in the Cc list; thought git send-mail will see
your address in the Acked-by tags and add you. I failed to notice that
it's not the case. I apologize. Here's the v2 posting: [1].)

[1] https://lore.kernel.org/lkml/20181116162403.49854-1-lkundrak@v3.sk/


On Mon, 2018-11-19 at 11:40 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/ctype.h>
> > > > +#include <linux/olpc-ec.h>
> > > > +#include <linux/spi/spi.h>
> > > > +#include <linux/reboot.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/kfifo.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/power_supply.h>
> > > 
> > > Easy to maintain when it's sorted.
> 
> No / it depends.

I've sorted it in the new files; following a rule of keeping things
sorted at the very least has an advantage of being unambiguous.

I'm not sorting things where they currently are not in order, since it
would obscure real changes.

> > > > +       channel = priv->rx_buf[0];
> > > > +       byte = priv->rx_buf[1];
> > > 
> > > Maybe specific structures would fit better?
> > > 
> > > Like
> > > 
> > > struct olpc_ec_resp_hdr {
> > >  u8 channel;
> > >  u8 byte;
> > > ...
> > > }
> 
> Structures have padding and other nastyness...

I've turned them into structs. It perhaps looks a bit better -- the
structure members serving as a documentation for the protocol.

> > > > +                       pm_wakeup_event(priv->pwrbtn-
> > > > >dev.parent,
> > > > 1000);
> > > 
> > > Magic number.
> 
> Nothing wrong with magic numbers.

Turned it into a define, but it's not like it's any clearer why that
particular value works...

I actually have little idea. I've copied this from the vendor's
original driver.

> > > > +       args[0] = mask & 0xff;
> > > > +       args[1] = (mask >> 8) & 0xff;
> > > 
> > > ...mask >> 0;
> > > ...mask >> 8;
> 
> No, please.

I've done this too, but I don't see much point either. Perhaps those
within the OCD spectrum may appreciate :)

> > > __maybe_unused  instead of ugly #ifdef?
> > > 
> > > > +{
> > > > +       struct platform_device *pdev = to_platform_device(dev);
> > > > +       struct olpc_xo175_ec *priv =
> > > > platform_get_drvdata(pdev);
> > > 
> > > dev_get_drvdata() or how is it called?
> > > 
> > > > +       unsigned char hintargs[5];
> > > 
> > > struct olpc_ec_hint_cmd {
> > > u8 ...
> > > u32 ...
> > > };
> > > 
> > > ?
> 
> No, unless you want to break the code. Or add __attribute__ packed
> and
> deal with endianness.
> 
> Just no.

Turned it into a packed struct too for the same reasons as above.

The endianness of the hints argument doesn't actually matter, since the
EC firmware actually uses this in a debugging printf. It's not even
cleat what endianness did EC expect initially.

> > > > +       static unsigned int suspend_count;
> > > 
> > > u32 I suppose.
> 
> You know, there's semantic difference between unsigned int and
> u32. And this sounds like candidate for unsigned int.
> 
> > > > +       /* Enable all EC events while we're awake */
> > > > +       olpc_xo175_ec_set_event_mask(0xffff);
> > > 
> > > #define EC_ALL_EVENTS GENMASK(15, 0)
> 
> Actually that's less readable. Just don't.

Done this too, and, like the points above, I am indifferent too. Both
seem equal to me.

> > > > +static const struct of_device_id olpc_xo175_ec_of_match[] = {
> > > > +       { .compatible = "olpc,xo1.75-ec" },
> > > > +       { },
> > > 
> > > No comma for terminators.
> 
> Comma is fine.

Removed it. Perhaps the lack of a comma could be understood as an
indication that no further initializers shall follow.

> 	Pavel

Just in case I didn't stress that enough: I'm much more interested in
things working well than style issues that too often are just matter of
tast. I happily accept advice on those though.

Take care,
Lubo

