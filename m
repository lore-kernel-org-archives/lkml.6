Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105EC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6590B2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dMlROKjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfATRnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:43:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49422 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfATRnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Wk0vnTqjEzUIggUvR/+Yi8eoLas/8m4LD17CwUhvH9E=;
        b=dMlROKjvzz7uVBC9Ic8YBLcACYKFMZdoGgH2sVnyTxoqF8b1f39Oh4WlBcs162ih3rF274fkRix+eH8e3ynGMScaeRtC4eSv2LYlVpaucYUG0QyqWtutPfzvXnMkiNIYLi1WAMO5tGtpC1/ey9BKRuCwfzAX+5RR6GoJwwZGcVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glH7o-0004o7-Ef; Sun, 20 Jan 2019 18:43:12 +0100
Date:   Sun, 20 Jan 2019 18:43:12 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, netdev@vger.kernel.org,
        fthain@telegraphics.com.au, geert@linux-m68k.org,
        f.fainelli@gmail.com, linux-m68k@vger.kernel.org,
        Michael.Karcher@fu-berlin.de, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [v4,1/9] net-next: phy: new Asix Electronics PHY driver
Message-ID: <20190120174312.GC15048@lunn.ch>
References: <1524103526-12240-2-git-send-email-schmitzmic@gmail.com>
 <alpine.DEB.2.21.1901181121101.1647@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901181121101.1647@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:22:39AM +0100, Thomas Gleixner wrote:
> Michael,
> 
> On Thu, 19 Apr 2018, Michael Schmitz wrote:
> 
> > --- /dev/null
> > +++ b/drivers/net/phy/asix.c
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Driver for Asix PHYs
> > + *
> > + * Author: Michael Schmitz <schmitzmic@gmail.com>
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + *
> > + */
> 
> This license information is broken. The SPDX license identifier and the
> boiler plate text are contradicting. The SPDX id is GPL v2 only and the
> boiler plate says v2 or later.

Hi Thomas

Please see:

https://www.spinics.net/lists/netdev/msg544312.html

The first two patches are simple SPDX converstions. Then it gets
interesting trying to sort out license inconsistencies.

	Andrew
