Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE022147D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE022147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeI0TJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:09:49 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46098 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbeI0TJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:09:49 -0400
Received: from wd0267.dip.tu-dresden.de ([141.76.109.11] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g5VlZ-0000p4-Lj; Thu, 27 Sep 2018 14:51:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v4] drm/panel: add Kingdisplay kd097d04 panel driver
Date:   Thu, 27 Sep 2018 14:51:37 +0200
Message-ID: <2158911.CuyhVEUmpb@phil>
In-Reply-To: <20180927120721.GF29102@ulmo>
References: <20180817093731.9850-1-heiko@sntech.de> <20180927120721.GF29102@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Am Donnerstag, 27. September 2018, 14:07:21 CEST schrieb Thierry Reding:
> On Fri, Aug 17, 2018 at 11:37:31AM +0200, Heiko Stuebner wrote:
> > From: Nickey Yang <nickey.yang@rock-chips.com>
> > 
> > Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> > it is a MIPI dual-DSI panel.
> > 
> > v4:
> > - address Philipp's comments
> >   - real range for usleep_range and
> >   - poweroff ordering in kingdisplay_panel_prepare
> >   - return value beautification in panel_probe
> > - update author naming for full name
> > v3:
> > - address Thierry's comments
> >   - error handling for init dsi writes in init
> >   - unconditionally remove the panel
> >   - don't use drm_panel_detach
> >   - a bit of variable signednes wiggling
> > - I did talk to ChromeOS people and the delays really should be as short
> >   as possible, so dropped the 100ms from the delay comments
> > v2:
> > - update timing + cmds from chromeos kernel
> > - new backlight API including switch to devm_of_find_backlight
> > - fix most of Sean Paul's comments
> >   enable/prepare tracking seems something all panels do
> > - document origins of the init sequence
> > - lanes per dsi interface to 4 (two interfaces). Matches how tegra
> >   and pending rockchip dual-dsi handle (dual-)dsi lanes
> > - spdx header instead of license boilerplate
> > 
> > Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |  11 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../drm/panel/panel-kingdisplay-kd097d04.c    | 473 ++++++++++++++++++
> >  3 files changed, 485 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> 
> This is missing device tree bindings.

nope it isn't ... as you already applied those from v3 [0]

Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt


