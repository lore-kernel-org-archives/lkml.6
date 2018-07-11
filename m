Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C43C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA52083B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA52083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGKJi1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:38:27 -0400
Received: from mailoutvs33.siol.net ([185.57.226.224]:54626 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbeGKJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:38:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4219E520FEF;
        Wed, 11 Jul 2018 11:35:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JxrsA1_UPdJZ; Wed, 11 Jul 2018 11:34:59 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B461752244E;
        Wed, 11 Jul 2018 11:34:59 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id A0A4D52220D;
        Wed, 11 Jul 2018 11:34:58 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Date:   Wed, 11 Jul 2018 11:34:58 +0200
Message-ID: <5673885.I9ZBC4zXdg@jernej-laptop>
In-Reply-To: <20180711093016.bcnsnogbj26azoo7@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <2406320.TaIT7vHipu@jernej-laptop> <20180711093016.bcnsnogbj26azoo7@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 11. julij 2018 ob 11:30:16 CEST je Maxime Ripard napisal(a):
> On Wed, Jul 11, 2018 at 10:41:54AM +0200, Jernej Škrabec wrote:
> > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > > This series fixes several issues found in R40 HDMI patch series after
> > > > it was applied. Conversation can be found here:
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011
> > > > .htm
> > > > l
> > > > 
> > > > Patches are based on latest linux-next (next-20180710) and are ordered
> > > > in such way that they don't break R40 HDMI at any time. Because of
> > > > that
> > > > I suggest that whole series goes through drm-misc to preserve that
> > > > order.
> > > > 
> > > > I also tested those patches on H3 to make sure it doesn't break other
> > > > platforms. However, it would be nice to test for regressions also on
> > > > older SoCs (with DE1).
> > > > 
> > > > Best regards,
> > > > Jernej
> > > 
> > > Applied all patches but the patch 10, thanks!
> > > Maxime
> > 
> > Ok, I'll send patch 10 separately. However,  patch 4 needs a fix according
> > to test build robot:
> > 
> > if (IS_ERR_VALUE(index))
> > should be:
> > if (index < 0)
> 
> Yeah, sorry, I forgot to say it, but I fixed it locally (and the
> return below as well).
> 
> > Additionally, due to Arnds patch merged (drm/sun4i: fix build failure with
> > CONFIG_DRM_SUN8I_MIXER=m), sun4i_tcon.c needs additional handling if
> > TCON_TOP driver is not build.
> 
> I'll drop it then, I haven't pushed it yet.

Which one? This series or patch from Arnd?

Best regards,
Jernej



