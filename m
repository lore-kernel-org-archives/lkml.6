Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75273C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C5205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218C5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeIFJlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:41:05 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:43148 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbeIFJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:41:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 8AED3521135;
        Thu,  6 Sep 2018 07:07:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kfLiooMTmUCo; Thu,  6 Sep 2018 07:07:25 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E27C8521133;
        Thu,  6 Sep 2018 07:07:24 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 8DB82520F7C;
        Thu,  6 Sep 2018 07:07:21 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI
Date:   Thu, 06 Sep 2018 07:07:19 +0200
Message-ID: <1794260.muFTeCcfyt@jernej-laptop>
In-Reply-To: <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180905075136.chumwosx76o2n66l@flea> <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Dne sreda, 05. september 2018 ob 09:57:54 CEST je Jagan Teki napisal(a):
> On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> 
wrote:
> > On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
> >> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >> > From: Jagan Teki <jagan@amarulasolutions.com>
> >> > 
> >> > Enable all necessary device tree nodes and add connector node to device
> >> > trees for all supported A64 boards with HDMI.
> >> > 
> >> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> > [Icenowy: squash all board patches altogether and change supply name]
> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> > ---
> >> > Changes in v4:
> >> > - Rebase some device trees.
> >> > Changes in v3,1:
> >> > - Squash all enablement patches altogether.
> >> > - Change supply name to match DT binding & driver change.
> >> > Changes for v3:
> >> > - Enable all pipeline components
> >> > Changes for v2:
> >> > - none
> >> > 
> >> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
> >> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
> >> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
> >> >  6 files changed, 204 insertions(+)
> >> 
> >> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
> >> A64-Olinuxino, NPI-A64
> >> 
> >> Pine64 boards look unable by saying
> >> [drm] Cannot find any crtc or sizes
> >> 
> >> May be someone can confirm, it.
> > 
> > Then we should drop the pine64 additions until someone figures it out,
> > as it has been already discussed.
> 
> That is fine, but If anyone have pine64 can confirm this.

What is your monitor default resolution and more importantly, what is it's 
pixel clock?

Pine64 has U-Boot support for DE2/HDMI, which has some pixel clock issues 
which can influence Linux, unfortunately. At the time, there wasn't enough 
knowledge to do it properly. I plan to update it after A64 DE2/HDMI support is 
finished in kernel.

Meanwhile, can you test if it works for you either with disabled DE2/HDMI in 
U-Boot or if you apply this patch to Linux:
https://github.com/jernejsk/linux-1/commit/
019121f953229ca2d624ac39300289a24e5389a1

Best regards,
Jernej



