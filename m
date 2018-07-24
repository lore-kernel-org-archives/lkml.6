Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A356ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC3020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeGXS2R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:28:17 -0400
Received: from mailoutvs61.siol.net ([185.57.226.252]:39897 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388465AbeGXS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:28:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 821BD52232B;
        Tue, 24 Jul 2018 19:20:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gQUyT9fk8gPb; Tue, 24 Jul 2018 19:20:46 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id E4619522334;
        Tue, 24 Jul 2018 19:20:45 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id F3C6252232B;
        Tue, 24 Jul 2018 19:20:42 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Date:   Tue, 24 Jul 2018 19:20:42 +0200
Message-ID: <2421648.YmhYGBseh5@jernej-laptop>
In-Reply-To: <f77bcb551d60e9d5332dad20c1ef1a1e83ddcc5b.camel@aosc.io>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180724123741.bbkjgy2uwmzsj45k@flea> <f77bcb551d60e9d5332dad20c1ef1a1e83ddcc5b.camel@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 24. julij 2018 ob 18:04:49 CEST je Icenowy Zheng napisal(a):
> 在 2018-07-24二的 14:37 +0200，Maxime Ripard写道：
> 
> > On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej Škrabec wrote:
> > > Hi Maxime,
> > > 
> > > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard
> > > 
> > > napisal(a):
> > > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > > > This series fixes several issues found in R40 HDMI patch series
> > > > > after
> 
> > > > > it was applied. Conversation can be found here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
> 
> > > > > l
> > > > > 
> > > > > Patches are based on latest linux-next (next-20180710) and are
> > > > > ordered
> > > > > in such way that they don't break R40 HDMI at any time. Because
> > > > > of that
> > > > > I suggest that whole series goes through drm-misc to preserve
> > > > > that order.
> > > > > 
> > > > > I also tested those patches on H3 to make sure it doesn't break
> > > > > other
> > > > > platforms. However, it would be nice to test for regressions
> > > > > also on
> > > > > older SoCs (with DE1).
> > > > > 
> > > > > Best regards,
> > > > > Jernej
> > > > 
> > > > Applied all patches but the patch 10, thanks!
> > > > Maxime
> > > 
> > > It seems that you forgot to merge some patches:
> > > 
> > > [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching
> > > mixers with
> > > tcon
> > > [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
> > > 
> > > Without them, R40 display pipeline can't work.
> > > 
> > > Maybe they are in your spam folder?
> > 
> > Thanks for telling me, I'm not quite sure what happened.
> > 
> > I've applied them.
> 
> BTW without them the board cannot boot because of dead loop in
> sun4i_drv_probe().

Does it work for you now?

> 
> > Sorry,
> > Maxime
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel




