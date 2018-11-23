Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B044E20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B044E20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410180AbeKXDsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:48:40 -0500
Received: from muru.com ([72.249.23.125]:54916 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388557AbeKXDsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:48:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B068080D4;
        Fri, 23 Nov 2018 17:03:37 +0000 (UTC)
Date:   Fri, 23 Nov 2018 09:03:33 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
Message-ID: <20181123170333.GH53235@atomide.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
 <20181121155639.77873f7f@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121155639.77873f7f@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Boris Brezillon <boris.brezillon@bootlin.com> [181121 14:56]:
> On Wed, 21 Nov 2018 12:08:02 +0100
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Finalize implementation of the idea suggested by Artem Bityutskiy and
> > Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
> > request_mem_region() failure"). Use pure GPIO consumer API, as reqested
> > by Boris Brezillon.
> > 
> > Janusz Krzysztofik (4):
> >       ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
> >       mtd: rawnand: ams-delta: Request data port GPIO resource
> >       mtd: rawnand: ams-delta: Use GPIO API for data I/O
> >       ARM: OMAP1: ams-delta: Drop obsolete NAND resources
> > 
> >  arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
> >  drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
> >  2 files changed, 80 insertions(+), 62 deletions(-)
> > 
> > Performance on Amstrad Delta is now acceptable after recent extensions
> > to GPIO API and rawnanad enhancements.
> > 
> > Series intented to be merged via mtd tree, should not conflict with
> > other OMAP1 patches submitted for 4.21.
> 
> We'll prepare an immutable tag, just in case.

Sounds good to me thanks:

Acked-by: Tony Lindgren <tony@atomide.com>
