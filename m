Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeBQAHA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:07:00 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52146 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeBQAG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:06:58 -0500
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
Subject: Re: [PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
Date: Sat, 17 Feb 2018 01:06:47 +0100
Message-ID: <7311922.FVjtJqota6@phil>
In-Reply-To: <20180216120956.19034-1-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Februar 2018, 13:09:51 CET schrieb Enric Balletbo i Serra:
> Adding properties for various register fields in the DT doesn't scale and
> this information should be in the driver instead.
> 
> Before this patch these registers (description below) were specified in
> the DT, every register node contained 3 sections: offset, enable bit,
> write mask bit.
> 
>  - rockchip,typec-conn-dir : the register of type-c connector direction,
>    for type-c phy0, it must be <0xe580 0 16>;
>    for type-c phy1, it must be <0xe58c 0 16>;
>  - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2 enable
>    control.
>    for type-c phy0, it must be <0xe580 3 19>;
>    for type-c phy1, it must be <0xe58c 3 19>;
>  - rockchip,external-psm : the register of type-c phy external psm clock
>    selection.
>    for type-c phy0, it must be <0xe588 14 30>;
>    for type-c phy1, it must be <0xe594 14 30>;
>  - rockchip,pipe-status : the register of type-c phy pipe status.
>    for type-c phy0, it must be <0xe5c0 0 0>;
>    for type-c phy1, it must be <0xe5c0 16 16>;
> 
> After this patch these register definitions are in the driver. So can be
> removed from the DT. Note that there are 2 type-c phys for RK3399 with
> different offsets, the driver checks the phy base address of the running
> instance and applies the right offsets.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v2:
> - Suggested by Heiko Stuebner:
>   - Prefix phy config struct with rk3399_ as is rk3399-specific.
>   - Create a new struct similar to things like the inno-usb2-phy
>   - Select phy config according to the compatible and remove the
>     specific constants.
> Changes since v1:
> - This patch is new in this series to accomplish the purpose of get rid
>   of some registers from the DT. Suggested by Rob Herring.

looks great now
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
