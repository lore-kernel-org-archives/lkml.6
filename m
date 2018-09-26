Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19B204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE19B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeIZP6L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:58:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39928 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeIZP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:58:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AFA7208D1; Wed, 26 Sep 2018 11:46:00 +0200 (CEST)
Received: from localhost (nat-240.udc.es [193.144.61.240])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8C5520737;
        Wed, 26 Sep 2018 11:45:25 +0200 (CEST)
Date:   Wed, 26 Sep 2018 11:45:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix
 ethernet
Message-ID: <20180926094525.e4fepvonmy7ykdbb@flea>
References: <20180919141938.18791-1-rodrigo@tjader.xyz>
 <20180921142941.5ymp7ksphgboxrwz@flea>
 <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Sep 21, 2018 at 12:25:53PM -0300, Rodrigo Exterckötter Tjäder wrote:
> On Fri, Sep 21, 2018 at 11:30 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Wed, Sep 19, 2018 at 11:19:36AM -0300, Rodrigo Exterckötter Tjäder wrote:
> > > Without "allwinner,tx-delay-ps = <600>;" on the DTP it can receive packets
> > > but not send.
> > >
> > > Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>
> >
> > Again, that commit log would be nice if it was a bit more
> > explicit. What is a DTP? How did you come up with that value? What is
> > the value used by Allwinner/Olimex, and why did you use another one if
> > you did?
> 
> Thanks for the feedback.
> 
> DTP is a typo, it should have been DT for "device tree".
> 
> Olimex's provided device tree uses a different driver for ethernet,
> but it has a property named "tx-delay" with value 6 and the range of
> the property is 0-7. On dwmac-sun8i's bindings documentation it says
> allwinner,tx-delay-ps has a range of 0-700 and must be a multiple of
> 100, so I tried 600 and it works.
>
> I'm not sure how much of that I should include in the commit log,
> perhaps something like this:
> 
> ---
> arm64: dts: allwinner: OLinuXino: PHY TX clock delay
> 
> The PHY requres a delay on the TX clock, otherwise it is not able to send
> any packets on the interface.
> 
> Olimex's device tree uses 6 in a range of 0-7, dwmac-sun8i requires a
> multiple of 100 in the range 0-700.
> 
> Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>

There's no need to be so specific though :)

Something like that would work:

arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay

The PHY found on the A64-Olinuxino requires a TX delay in order to
operate properly. Olimex uses a 600ps second delay in their BSP, and
that has been found to work, so let's use that value in the current
DT.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
