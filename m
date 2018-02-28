Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935126AbeB1Vnf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:43:35 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:42589 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932597AbeB1Vne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:43:34 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 06/16] drm/sun4i: Don't process LVDS if TCON doesn't support it
Date: Wed, 28 Feb 2018 22:43:30 +0100
Message-ID: <5333678.QYsGi30oEL@jernej-laptop>
In-Reply-To: <20180228073608.r2zd3qkiudm2uarm@flea>
References: <20180227222701.9716-1-jernej.skrabec@siol.net> <20180227222701.9716-7-jernej.skrabec@siol.net> <20180228073608.r2zd3qkiudm2uarm@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Dne sreda, 28. februar 2018 ob 08:36:08 CET je Maxime Ripard napisal(a):
> On Tue, Feb 27, 2018 at 11:26:51PM +0100, Jernej Skrabec wrote:
> > TCON checks for LVDS properties even if it doesn't support it. Add a
> > check to skip that part of the code if TCON doesn't support channel 0.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> I have already sent a similar patch here:
> https://lists.freedesktop.org/archives/dri-devel/2018-February/166665.html

Right. However, check last chunk in my patch. There is no need to call 
sun4i_rgb_init() if TCON doesn't support channel 0. It doesn't do anything, 
except producing warning. Will you add that this change to your patch and then 
I can remove this patch from next revision?

BTW, your patch won't apply cleanly, since you didn't base it on latest code 
(every TCON variant has at least one entry now).

Best regards,
Jernej
