Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C4720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C4720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeGSHVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:21:20 -0400
Received: from muru.com ([72.249.23.125]:52018 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeGSHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:21:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DA87C80BF;
        Thu, 19 Jul 2018 06:42:58 +0000 (UTC)
Date:   Wed, 18 Jul 2018 23:39:43 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup table
Message-ID: <20180719063943.GH99251@atomide.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-3-jmkrzyszt@gmail.com>
 <20180718092041.1d49094a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718092041.1d49094a@xps13>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miquel Raynal <miquel.raynal@bootlin.com> [180718 07:24]:
> Hi Janusz, Tony
> 
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Wed, 18 Jul 2018
> 01:14:47 +0200:
> 
> > Now as Amstrad Delta board - the only user of this driver - provides
> > GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> > use the table to locate required GPIO pins.
> > 
> > Declare static variables for storing GPIO descriptors and replace
> > gpio_ function calls with their gpiod_ equivalents.
> > 
> > Pin naming used by the driver should be followed while respective GPIO
> > lookup table is initialized by a board init code.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> As suggested by Boris, we expect this series to go through the OMAP
> tree so we'll need an immutable tag, there are more changes on this
> driver coming in.

Let's wait for v4.19-rc1 to clear the dependencies. I'm not applying
new patches at this point only dealing with the pending pull requests
I have.

Regards,

Tony
