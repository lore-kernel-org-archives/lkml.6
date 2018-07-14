Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE1CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DE62086E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DE62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeGNQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:43:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54446 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeGNQnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:43:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B1CF207AB; Sat, 14 Jul 2018 18:24:19 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id E46962072D;
        Sat, 14 Jul 2018 18:24:18 +0200 (CEST)
Date:   Sat, 14 Jul 2018 18:24:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
Message-ID: <20180714162419.GX16084@piout.net>
References: <20180713151424.13000-1-paul@crapouillou.net>
 <20180714131920.GU16084@piout.net>
 <1531574734.2831.0@smtp.crapouillou.net>
 <20180714133250.GW16084@piout.net>
 <1531576208.2831.1@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531576208.2831.1@smtp.crapouillou.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2018 15:50:08+0200, Paul Cercueil wrote:
> > >  > This would avoid that change (and the test would preferably be
> > >  > (rtc->type == ID_JZ4780))
> > > 
> > >  That branch should be taken if the SoC is JZ4760, JZ4770 or JZ4780.
> > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
> > 
> > Sure but you can achieve that with only 2 ids...
> > 
> > > 
> > >  > >   		ret = jz4780_rtc_enable_write(rtc);
> > >  > >   	if (ret == 0)
> > >  > >   		ret = jz4740_rtc_wait_write_ready(rtc);
> > >  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
> > >  > >
> > >  > >   static const struct of_device_id jz4740_rtc_of_match[] = {
> > >  > >   	{ .compatible = "ingenic,jz4740-rtc", .data = (void
> > > *)ID_JZ4740 },
> > >  > >  +	{ .compatible = "ingenic,jz4725b-rtc", .data = (void
> > > *)ID_JZ4725B
> > >  > > },
> > >  > >  +	{ .compatible = "ingenic,jz4760-rtc", .data = (void
> > > *)ID_JZ4760 },
> > >  > >  +	{ .compatible = "ingenic,jz4770-rtc", .data = (void
> > > *)ID_JZ4770 },
> > 
> > By doing the correct mapping here e.g:
> > 
> > { .compatible = "ingenic,jz4725b-rtc", .data = (void *)ID_JZ4740 },
> 
> Not very pretty and future-proof if you ask me...
> But you're the boss...
> 

I think it makes the code simpler to follow . Regarding future
proofness, you will have to add code and probably use a switch case at
the time you need to handle an RTC differently. At that time, the >=
test trick will not work anymore anyway.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
