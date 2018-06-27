Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE27C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1C725B33
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1C725B33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965596AbeF0U1I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:27:08 -0400
Received: from mailoutvs13.siol.net ([185.57.226.204]:41313 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932723AbeF0U1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:27:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C534B52187B;
        Wed, 27 Jun 2018 22:27:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LaqQsrLZrMYK; Wed, 27 Jun 2018 22:27:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2AAB552189A;
        Wed, 27 Jun 2018 22:27:03 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id BF32752187B;
        Wed, 27 Jun 2018 22:27:01 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/24] Add support for R40 HDMI pipeline
Date:   Wed, 27 Jun 2018 22:25:37 +0200
Message-ID: <4275695.oLYl8XEDF6@jernej-laptop>
In-Reply-To: <20180627195043.hfasvppfm2cbudx7@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180627180215.y5kvvdqeriadxwte@flea> <20180627195043.hfasvppfm2cbudx7@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 27. junij 2018 ob 21:50:43 CEST je Maxime Ripard napisal(a):
> 1;5202;0c
> 
> On Wed, Jun 27, 2018 at 08:02:15PM +0200, Maxime Ripard wrote:
> > On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> > > This series adds support for R40 HDMI pipeline. It is a bit special
> > > than other already supported pipelines because it has additional unit
> > > called TCON TOP responsible for relationship configuration between
> > > mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> > > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > > and TV encoders.
> > > 
> > > However, it seems that TCON TOP will become a norm, since newer
> > > Allwinner SoCs like H6 also have this unit.
> > > 
> > > I tested different possible configurations:
> > > - mixer0 <> TCON-TV0 <> HDMI
> > > - mixer0 <> TCON-TV1 <> HDMI
> > > - mixer1 <> TCON-TV0 <> HDMI
> > > - mixer1 <> TCON-TV1 <> HDMI
> > > 
> > > Please review.
> > 
> > I just applied it. It didn't apply cleanly, so please make sure it
> > does next time, or at least state what the dependencies are.
> 
> And it didn't compile either, because of the compile error that was
> reported to the previous version by kbuild... Those shouldn't be
> ignored and simply fixed.

Sorry about that. I forgot to rebase and had same linux-next base for all 3 
versions.

I actually take a look at that kbuild message, but it just didn't make much 
sense and it worked for me without issues. Merge conflicts would explain that.

Best regards,
Jernej




