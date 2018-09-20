Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E9721535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E9721535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeIUDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:08:58 -0400
Received: from muru.com ([72.249.23.125]:56690 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeIUDI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:08:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C3B1C8105;
        Thu, 20 Sep 2018 21:27:44 +0000 (UTC)
Date:   Thu, 20 Sep 2018 14:23:26 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for
 MODEM
Message-ID: <20180920212326.GS5662@atomide.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
 <2690911.AdkODg5D9b@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2690911.AdkODg5D9b@z50>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 21:52]:
> On Monday, September 10, 2018 1:44:16 AM CEST Janusz Krzysztofik wrote:
> > 
> > Convert modem related GPIO setup from integer space to GPIO descriptors.
> > Also, restore original initialization order of the MODEM device and its
> > related GPIO pins.
> > 
> > Cleanup of MODEM relaated regulator setup is postponed while waiting for
> > upcoming conversion of fixed regulator API to GPIO descriptors.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
> >       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
> >       ARM: OMAP1: ams-delta: register MODEM device earlier
> > 
> > 
> > Changelog:
> > v2:
> > - rebased on v4.19-rc1
> 
> Hi Tony,
> 
> I forgot to mention: please apply on top of "[PATCH v3 0/3] ARM: OMAP1: ams-
> delta: Complete driver gpiod migration" series. Sorry.

Hmm but then in that thread you said that it won't apply.. So I'm applying
this series into omap-for-v4.20/omap1 branch. I just modified the second
patch in this series for the unchanged header location.

I suggest you send the mtd patch separately to mtd maintainers, the fb patch
separately to fb maintainers and then let's do the header move after all
those are merged as a clean-up. That avoids some dependencies between these
branches.

Regards,

Tony
