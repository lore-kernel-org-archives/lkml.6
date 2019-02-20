Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86AC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69792086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBTK3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:29:06 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34041 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:29:06 -0500
X-Originating-IP: 109.212.12.126
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 31740C0016;
        Wed, 20 Feb 2019 10:29:01 +0000 (UTC)
Date:   Wed, 20 Feb 2019 11:29:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas.Ferre@microchip.com
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <20190220102901.GH11432@piout.net>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
 <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 10:20:28+0000, Nicolas Ferre wrote:
> On 19/02/2019 at 17:51, Alexandre Belloni wrote:
> > nck() looks at the last id in an array and unfortunately,
> > at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> 
> Well, the logic for all other SoC clk files is to not have such a 
> sentinel and deal differently with this type of array: why not modify 
> this file to match with others?
> 
> 
> > number of peripheral clocks is 1 instead of a maximum of 31.
> > 
> > Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >   drivers/clk/at91/at91sam9x5.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> > index 2fe225a697df..d37e7ed9eb90 100644
> > --- a/drivers/clk/at91/at91sam9x5.c
> > +++ b/drivers/clk/at91/at91sam9x5.c
> > @@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
> >   		return;
> >   
> >   	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
> > -					   nck(at91sam9x5_systemck),
> > -					   nck(at91sam9x35_periphck), 0);
> > +					   nck(at91sam9x5_systemck), 31, 0);
> 
> I would prefer like it's done on other SoC clk files.
> 

Well, that is not possible, what do you suggest?

> >   	if (!at91sam9x5_pmc)
> >   		return;
> >   
> > 
> 
> 
> -- 
> Nicolas Ferre

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
