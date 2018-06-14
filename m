Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 699F0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2784320693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2784320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965791AbeFNOf7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:35:59 -0400
Received: from mailoutvs9.siol.net ([185.57.226.200]:32995 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965735AbeFNOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:35:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 657265226FF;
        Thu, 14 Jun 2018 16:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5p-B6SnWQDI0; Thu, 14 Jun 2018 16:35:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A32235225B1;
        Thu, 14 Jun 2018 16:35:50 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id EBCD8522A78;
        Thu, 14 Jun 2018 16:35:47 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v2 00/27] Add support for R40 HDMI pipeline
Date:   Thu, 14 Jun 2018 16:34:45 +0200
Message-ID: <2742773.k39D243pH3@jernej-laptop>
In-Reply-To: <CAMty3ZC-Edg5XJQpqEuwLbSFzmam3zP3zUPak4K7ypyT2+arAg@mail.gmail.com>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <CAMty3ZC-Edg5XJQpqEuwLbSFzmam3zP3zUPak4K7ypyT2+arAg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 14. junij 2018 ob 09:12:41 CEST je Jagan Teki napisal(a):
> On Wed, Jun 13, 2018 at 1:30 AM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > This series adds support for R40 HDMI pipeline. It is a bit special
> > than other already supported pipelines because it has additional unit
> > called TCON TOP responsible for relationship configuration between
> > mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > and TV encoders.
> > 
> > However, it seems that TCON TOP will become a norm, since newer
> > Allwinner SoCs like H6 also have this unit.
> > 
> > I tested different possible configurations:
> > - mixer0 <> TCON-TV0 <> HDMI
> > - mixer0 <> TCON-TV1 <> HDMI
> > - mixer1 <> TCON-TV0 <> HDMI
> > - mixer1 <> TCON-TV1 <> HDMI
> > 
> > Please review.
> > 
> > Best regards,
> > Jernej
> > 
> > Changes from v1:
> > - Split DT bindings patch and updated description
> > - Split HDMI PHY patch
> > - Move header file from TCON TOP patch to dt bindings patch
> > - Added Rob reviewed-by tag
> > - Used clk_hw_register_gate() instead of custom gate registration code
> > - Reworked TCON TOP to be part of of-graph. Because of that, a lot of
> > 
> >   new patches were added.
> > 
> > - Droped mixer index quirk patch
> > - Reworked TCON support for TCON TOP
> > - Updated commit messages
> > 
> > Jernej Skrabec (27):
> >   clk: sunxi-ng: r40: Add minimal rate for video PLLs
> >   clk: sunxi-ng: r40: Allow setting parent rate to display related
> >   
> >     clocks
> >   
> >   clk: sunxi-ng: r40: Export video PLLs
> >   dt-bindings: display: sunxi-drm: Add TCON TOP description
> >   drm/sun4i: Add TCON TOP driver
> >   drm/sun4i: Fix releasing node when enumerating enpoints
> >   drm/sun4i: Split out code for enumerating endpoints in output port
> >   drm/sun4i: Add support for traversing graph with TCON TOP
> >   drm/sun4i: Don't skip TCONs if they don't have channel 0
> >   dt-bindings: display: sun4i-drm: Add R40 TV TCON description
> >   drm/sun4i: tcon: Add support for tcon-top gate
> >   drm/sun4i: tcon: Generalize engine search algorithm
> >   drm/sun4i: Don't check for LVDS and RGB when TCON has only ch1
> >   drm/sun4i: Don't check for panel or bridge on TV TCONs
> >   drm/sun4i: Add support for R40 TV TCON
> >   dt-bindings: display: sun4i-drm: Add R40 mixer compatibles
> >   drm/sun4i: Add support for R40 mixers
> >   dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
> >   drm/sun4i: Enable DW HDMI PHY clock
> >   drm/sun4i: Don't change clock bits in DW HDMI PHY driver
> >   drm/sun4i: DW HDMI PHY: Add support for second PLL
> >   drm/sun4i: Add support for second clock parent to DW HDMI PHY clk
> >   
> >     driver
> >   
> >   drm/sun4i: Add support for A64 HDMI PHY
> >   drm: of: Export drm_crtc_port_mask()
> >   drm/sun4i: DW HDMI: Expand algorithm for possible crtcs
> >   ARM: dts: sun8i: r40: Add HDMI pipeline
> >   ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
> 
> Tested whole series on top of linux-next.
> 
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>

Thanks!



