Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SUSPICIOUS_RECIPS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 505D8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC7208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC7208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934838AbeFMJZf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:25:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45878 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754478AbeFMJZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:25:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C7BEA20A23; Wed, 13 Jun 2018 11:25:32 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91ED220A20;
        Wed, 13 Jun 2018 11:25:22 +0200 (CEST)
Date:   Wed, 13 Jun 2018 11:25:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] rtc: ftrtc010: let the core handle range
Message-ID: <20180613092522.GS10521@piout.net>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
 <20180604141528.15635-3-alexandre.belloni@bootlin.com>
 <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 11:10:35+0200, Linus Walleij wrote:
> On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > The current range handling is highly suspicious. Anyway, let the core
> > handle it.
> 
> Hmmm. I have datasheets, do you need some input about the hardware?
> Something I should patch?
> 

Nothing to do as you seemed to confirm what I did was OK. I could find
why it was set to 2148 in the first place. Maybe it correspond to the
default days, hours minutes, second values on the SoC.

> > The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
