Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBHRxQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbeBHRxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:53:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCA0217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227tkHAyDtc9AHsOktLU2y33NfJWvF2Ci+6308rbDETGU3lPcew8X8gcTobeOQaSdxYqGQUAmV8vGYz7k7N9ZGw=
MIME-Version: 1.0
In-Reply-To: <20180208152028.9997-2-enric.balletbo@collabora.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com> <20180208152028.9997-2-enric.balletbo@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Feb 2018 11:52:52 -0600
X-Gmail-Original-Message-ID: <CABGGisyaqV5HtTUL5LdjH3ZcU3_RTPmzMvEAhv5wZjCD_XCujg@mail.gmail.com>
Message-ID: <CABGGisyaqV5HtTUL5LdjH3ZcU3_RTPmzMvEAhv5wZjCD_XCujg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: bindings: add usb3-host-disable and
 usb3-host-port for Rockchip USB Type-C PHY
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 9:20 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: William wu <wulf@rock-chips.com>
>
> rockchip,usb3-host-disable is the register of type-c phy disable usb3 host
> rockchip,usb3-host-port is the register of type-c phy usb3 port number
>
> Signed-off-by: William wu <wulf@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> index c3be83be9615..9085d95d0079 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -36,6 +36,12 @@ offset, enable bit, write mask bit.
>   - rockchip,uphy-dp-sel : the register of type-c phy enable DP function
>     for type-c phy0, it must be <0x6268 19 19>;
>     for type-c phy1, it must be <0x6268 3 19>;
> + - rockchip,usb3-host-disable : the register of type-c phy disable usb3 host
> +   for type-c phy0, it must be <0x2434 0 16>;
> +   for type-c phy1, it must be <0x2444 0 16>;
> + - rockchip,usb3-host-port : the register of type-c phy usb3 port number
> +   for type-c phy0, it must be <0x2434 12 28>;
> +   for type-c phy1, it must be <0x2444 12 28>;

When does this list stop? Adding properties for various register
fields doesn't scale. This information should be in the driver and
based on the compatible string if necessary.

Rob
