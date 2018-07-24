Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794220844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2794220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbeGXRM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:12:28 -0400
Received: from hermes.aosc.io ([199.195.250.187]:55580 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388361AbeGXRM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:12:28 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7D6BB9F734;
        Tue, 24 Jul 2018 16:05:03 +0000 (UTC)
Message-ID: <f77bcb551d60e9d5332dad20c1ef1a1e83ddcc5b.camel@aosc.io>
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej =?gb2312?Q?=810=947krabec?= <jernej.skrabec@siol.net>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 25 Jul 2018 00:04:49 +0800
In-Reply-To: <20180724123741.bbkjgy2uwmzsj45k@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
         <20180711083036.7attjq4hm5ay5gmn@flea> <2309112.TTVI9Fv1ar@jernej-laptop>
         <20180724123741.bbkjgy2uwmzsj45k@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-07-24二的 14:37 +0200，Maxime Ripard写道：
> On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej Škrabec wrote:
> > Hi Maxime,
> > 
> > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard
> > napisal(a):
> > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > > This series fixes several issues found in R40 HDMI patch series
> > > > after
> > > > it was applied. Conversation can be found here:
> > > > 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
> > > > l
> > > > 
> > > > Patches are based on latest linux-next (next-20180710) and are
> > > > ordered
> > > > in such way that they don't break R40 HDMI at any time. Because
> > > > of that
> > > > I suggest that whole series goes through drm-misc to preserve
> > > > that order.
> > > > 
> > > > I also tested those patches on H3 to make sure it doesn't break
> > > > other
> > > > platforms. However, it would be nice to test for regressions
> > > > also on
> > > > older SoCs (with DE1).
> > > > 
> > > > Best regards,
> > > > Jernej
> > > 
> > > Applied all patches but the patch 10, thanks!
> > > Maxime
> > 
> > It seems that you forgot to merge some patches:
> > 
> > [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching
> > mixers with 
> > tcon
> > [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
> > 
> > Without them, R40 display pipeline can't work.
> > 
> > Maybe they are in your spam folder?
> 
> Thanks for telling me, I'm not quite sure what happened.
> 
> I've applied them.

BTW without them the board cannot boot because of dead loop in
sun4i_drv_probe().

> 
> Sorry,
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

