Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeCNIOx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:14:53 -0400
Received: from gloria.sntech.de ([95.129.55.99]:42070 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932567AbeCNIOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:14:49 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, kishon@ti.com
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] phy: rockchip-typec: fall back to working in host-mode if extcon is missing.
Date: Wed, 14 Mar 2018 09:14:43 +0100
Message-ID: <20019382.PXhIOVQJGo@diego>
In-Reply-To: <20180301152515.20940-2-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com> <20180301152515.20940-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Am Donnerstag, 1. März 2018, 16:25:10 CET schrieb Enric Balletbo i Serra:
> Right now the rockchip type-c phy does fail probing when no extcon is
> detected. Some boards get the cable-state via the extcon interface and
> have this supported, other boards seem to use the fusb302 chip or
> another but the driver currently does not seem to utilize the extcon
> interface to report the cable-state. And, other, just connect the type-c
> to a standard USB-A port so use no controller at all. A missing extcon
> shouldn't fail to probe, instead, should just fall back to working in
> host-mode if it cannot get the extcon.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") Reported-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I did revert the original commit mentioned in the fixes tag for 4.16-rc
but it would nevertheless be really cool if these 2 patches (code + binding)
could make it into your tree for 4.17 :-)

And ideally also with the other 5 patches from Enric starting at
	[PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.

from 2018-02-16.


Thanks
Heiko
