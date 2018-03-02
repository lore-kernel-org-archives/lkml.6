Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeCBTuB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:50:01 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:41749 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932242AbeCBTuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:50:00 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 6/6] arm64: dts: rockchip: enable typec-phy0 for
 rk3399-puma-haikou.
From: klaus.goger@theobroma-systems.com
In-Reply-To: <20180301152515.20940-7-enric.balletbo@collabora.com>
Date: Fri, 2 Mar 2018 20:49:51 +0100
Cc: kishon@ti.com, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Will Deacon <will.deacon@arm.com>,
        Rask Ingemann Lambertsen <rask@formelder.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FF2D7ADA-3524-4811-921D-3AC6ABA2E588@theobroma-systems.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-7-enric.balletbo@collabora.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01.03.2018, at 16:25, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3. During
> boot, the following message appears a few times:
> 
>    dwc3: failed to initialize core
> 
> The driver is deferred waiting for the typec-phy, but this never
> happens beause is disabled. So, enable it.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> index 9a7486058455..2c9c696d1383 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> @@ -191,6 +191,10 @@
> 	status = "okay";
> };
> 
> +&tcphy0 {
> +	status = "okay";
> +};
> +
> &u2phy0 {
> 	status = "okay";
> };
> -- 
> 2.16.1


Tested-by: Klaus Goger <klaus.goger@theobroma-systems.com>

With usbdrd_dwc3_0 changed to dr_mode = "host"

[   37.176540] usb 6-1: new SuperSpeed USB device number 2 using xhci-hcd
[   37.203962] usb-storage 6-1:1.0: USB Mass Storage device detected
[   37.211837] scsi host1: usb-storage 6-1:1.0
[   38.249378] scsi 1:0:0:0: Direct-Access     SanDisk  Ultra            1.00 PQ: 0 ANSI: 6
[   38.259097] sd 1:0:0:0: [sdb] 122421248 512-byte logical blocks: (62.7 GB/58.4 GiB)
[   38.268890] sd 1:0:0:0: [sdb] Write Protect is off
[   38.274269] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
[   38.274582] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   38.295967]  sdb: sdb1
[   38.300787] sd 1:0:0:0: [sdb] Attached SCSI removable disk
< detaching>
[   45.192248] usb 6-1: USB disconnect, device number 2

— 
Klaus
