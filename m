Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2583EC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC4E20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeL3RWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:22:11 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43498 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbeL3RWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:22:10 -0500
Received: from [46.183.103.17] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gdemo-0003gf-4o; Sun, 30 Dec 2018 18:22:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Date:   Sun, 30 Dec 2018 18:22:00 +0100
Message-ID: <154632658.xpTMZOjgxT@phil>
In-Reply-To: <20181229133318.18128-4-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com> <20181229133318.18128-4-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> This patch adds the rk3066 VOP definitions.
> 
> The VOP or LCD Controller serves as interface between
> framebuffer memory and a display device (LCD panel or TV set).
> 
> This SOC has two symmetrical LCDC's for a dual panel application.
> 
> A LCDC has 5 display layers.
> Only 3 are used here.
> 
> - Video layer 0 (Win0)
> - Video layer 1 (Win1)
> - OSD layer     (Win2)

Patch itself looks good, we'll need to wait a bit to give Rob a chance
to look at the (simple) dt-binding change and I'll drop the paragraph
about the display layers when applying.

Looking at the rk3066-manual, the lcdcs really only have 3 fully usable
layers + the special cursor layer which is right now not really usable in
a drm context, so the above paragraph is misleading, so I'll just drop it.

Heiko


> Win0 and Win1 are exchangeable.
> Maximum resolution is 1920x1080.
> 
> The LCDC0 output is connected to:
> - LCDC0 IO (without IOMUX)
> - HDMI TX video input
> 
> The LCDC1 output is connected to:
> - LCDC1 IO (with IOMUX)
> - HDMI TX video input
> 
> The HDMI TX input can switch between LCDC0 and LCDC1.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>



