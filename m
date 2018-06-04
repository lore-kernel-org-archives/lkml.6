Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFDVp4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:45:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:34481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbeFDVpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:45:52 -0400
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vagrant Cascadian <vagrant@debian.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pierre-Hugues Husson <phh@phh.me>, Jianqun Xu <jay.xu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180604171523.28454-1-xypron.glpk@gmx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <1d5c4a57-c89c-07e9-e4ad-1bda2247e2be@gmx.de>
Date: Mon, 4 Jun 2018 23:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604171523.28454-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hq6lf+LhYLjHrWQ2zo5Gea48gkGIc+vTpo3dR/5STrOhrga01LA
 d/UDheueRuesCr7agfhd6fOZtU7i5ZzfQNeAq2H1dx2dZPnyoWBhR5Dx+xVkNbU8HI4UtPL
 ehRIBFbL7rmakGn4ZGgxy1Xs6ip0NlNwV+fbHVgYK9IUlBwtKO257T/3eR0VHjZyjL77uta
 0GDWs6KhWh2NVaQsvCYRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IUlhoz5a/a8=:g5FBY5vpM4NBwzfNOFgQyG
 vT5gOT+gr9BjuQbQ48qi6+JI9VSLFJUAmzRcWS/NO99kDmp5R29QZtMPfa58eS11Y0KCFoi0G
 gDhoGH+gw7OvyP761ATwaqCpv4JI/pi5H1U6RcYAKcY82DTsImy9APLR0bYuI36/rUzk64/EH
 gBGoyRlKThiCDxiafL7avTV7RB7827FZQmnIcMHK7u2nREZDp99H8YGAu4IoXAU15rPsOqaZw
 gyOGuV03+w32bFM2zTWryOagKhX3dC2YxLZJzdIYIa3QVF+SYyvuSViSqyA/CWd6WBMoVciWb
 lh2mwUlFQv3QfdYWydW3HjTuipqKylpHiQqusoOUAeY3QZHiIT68FzpGo49+LzLk+Bzw3F/GA
 PTkgDUZlA3ycoUbKcGoXbzQCuA3doQHlxNusqHj2etULJxvoVL7ECLPCwFnZzX6WwGGPXai01
 EqxLBCvj7BkFjlvbHj4cFtHXUcbJmf4UYrw+yIGyZulm8UXNcNpQEuh5vRmUjFHQ9Ax51SLtr
 Et5MwG+aPZGC7avLDm0SKCOgFeWzB1GRWhU3Zvjkgds4x3uK6UsJNn/uy8Wg/j4Ha6MUQ6FPt
 pjYVNSGd952sdJrRjr7115KBwAJl7GQlwkQs+frQg3uDdcI4ZkNg2pVaNV0pxM7AnR4iV4J16
 ZvJIbcwe4cgVOGoKmwnxxYtWTx/w1tcycWVCLFTFp1tAPcpyQlfYz6OfUD33RRVTnXDmCFssL
 W08qnZ87jkWncsP03Os81Z2LQJJRDhue+LIk42aj0cUgyNpxMtJFN0OvGa29NKy1GAJInGXJS
 EzvaC/I
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 07:15 PM, Heinrich Schuchardt wrote:
> Without this patch the Firefly-RK3399 board boot process hangs after these
> lines:
> 
>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
>    fan53555-reg: supplied by vcc_sys
>    vcc1v8_s3: supplied by vcc_1v8
> 
> Blacklisting driver fan53555 allows booting.
> 
> The device tree uses a value of fcs,suspend-voltage-selector different to
> any other board.
> 
> Changing this setting to the usual value is sufficient to enable booting.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> index 4f28628aa091..50940ef844a7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> @@ -458,7 +458,7 @@
>  	vdd_cpu_b: regulator@40 {
>  		compatible = "silergy,syr827";
>  		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <0>;
> +		fcs,suspend-voltage-selector = <1>;

The same value <1> is used in the legacy kernel:

https://github.com/rockchip-linux/kernel/blob/release-4.4/arch/arm64/boot/dts/rockchip/rk3399-firefly-linux.dts

	vdd_cpu_b: syr827@40 {
		compatible = "silergy,syr827";
		reg = <0x40>;
		vin-supply = <&vcc5v0_sys>;
		regulator-compatible = "fan53555-reg";
		regulator-name = "vdd_cpu_b";
		regulator-min-microvolt = <712500>;
		regulator-max-microvolt = <1500000>;
		regulator-ramp-delay = <1000>;
		vsel-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
		fcs,suspend-voltage-selector = <1>;
		regulator-always-on;
		regulator-boot-on;
		regulator-initial-state = <3>;
			regulator-state-mem {
			regulator-off-in-suspend;
		};
};

Best regards

Heinrich


>  		regulator-name = "vdd_cpu_b";
>  		regulator-min-microvolt = <712500>;
>  		regulator-max-microvolt = <1500000>;
> 
