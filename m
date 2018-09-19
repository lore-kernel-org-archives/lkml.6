Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57086ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EDF208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EDF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeISOXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:23:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42163 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbeISOXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:23:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2387520798; Wed, 19 Sep 2018 10:46:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB9F920379;
        Wed, 19 Sep 2018 10:46:39 +0200 (CEST)
Date:   Wed, 19 Sep 2018 10:46:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: rawnand: ams-delta: Cleanups and
 optimizations
Message-ID: <20180919104639.6b5339e9@xps13>
In-Reply-To: <20180907164524.GH5662@atomide.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20180820213904.13475-1-jmkrzyszt@gmail.com>
        <20180905084757.432e7c19@xps13>
        <1855340.fVHtouTg44@z50>
        <20180907164524.GH5662@atomide.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Tony Lindgren <tony@atomide.com> wrote on Fri, 7 Sep 2018 09:45:24
-0700:

> Hi,
> 
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180905 20:56]:
> > On Wednesday, September 5, 2018 8:47:57 AM CEST Miquel Raynal wrote:  
> > > Patch 2/3 does not apply on nand/next. Indeed the driver does not look
> > > the same as in the diff.  
> > 
> > That's because I built it on top of my former series from the mid of July, 
> > containing "[PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup table". 
> > It was acked by you, Miquel, and supposed to be merged via linux-omap tree.  
> 
> Hmm I thought the plan was for dependencies to clear and then
> merge the rest via various driver trees.. Or at least I don't have
> the patch above tagged anywhere for me to merge. Then again, I
> try to forget everything posted before -rc1 just to stay sane :)
> 
> > > I don't see any changes on my side that could
> > > explain this so perhaps you could rebase on top of 4.19-rc2 (or
> > > nand/next, as you wish) and resend the series?  
> > 
> > As far as I can see, Tony hasn't applied that series yet, so maybe I can still 
> > move that patch out of there and insert it into this series in front of the 
> > other 3 patches and resend. That would however make patch 3/3 of that old 
> > series depend on this one.
> > 
> > Tony, what do you think?  
> 
> Yes please resend based on v4.19-rc1 or MTD next. If there
> are still pending dependencies, please let us know and we can
> set up an immutable branch against v4.19-rc1 with those for
> MTD and me to merge in as needed.
> 
> Regards,
> 
> Tony

AFAIR I didn't received any new patches from you since Tony suggestion.
If you haven't done it already, please rebase against nand/next before
sending patches (internal API changed a bit, it might be worth fixing
the conflicts before sending them).


Thanks,
Miquèl
