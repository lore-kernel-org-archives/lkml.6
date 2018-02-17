Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBQAIQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:08:16 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52238 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbeBQAIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:08:15 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/6] phy: rockchip-typec: enable usb3 host during usb3 phy power on
Date: Sat, 17 Feb 2018 01:08:07 +0100
Message-ID: <3430653.U8tW0J7X0D@phil>
In-Reply-To: <20180216120956.19034-3-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com> <20180216120956.19034-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Februar 2018, 13:09:53 CET schrieb Enric Balletbo i Serra:
> From: William wu <wulf@rock-chips.com>
> 
> We have forced usb3 to work in usb2 only mode in firmware by setting
> usb3tousb2_en (bit3 of GRF_USB3PHY0/1_CON0) to 1, and setting
> host_u3_port_disable (bit0 of GRF_USB3OTG0/1_CON1) to 1 and host_u3_port
> (bit15~12 of GRF_USB3OTG0/1_CON1) to 0. So we need to re-enable usb3
> host.
> 
> Note that the RK3399 TRM suggests that we should keep the whole usb3
> controller in reset for the duration of the Type-C PHY initialization.
> However, it's hard to assert the reset in the current framework of
> reset. And according to the TRM, it doesn't require that we should
> clear the usb3tousb2 bit before pipe ready. So let's enable the usb3
> host after pipe ready to avoid the Type-C PHY initialization failure.
> 
> Signed-off-by: William wu <wulf@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
