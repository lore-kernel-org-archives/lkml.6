Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBIMry (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:47:54 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:30682 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeBIMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:47:52 -0500
Subject: Re: [PATCH v6 41/41] ARM: dts: da850: Add clocks
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-42-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <075d9f68-ad82-c8c0-c302-3b07162ecb2e@ti.com>
Date: Fri, 9 Feb 2018 18:16:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-42-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index c66cf78..7f4acd7 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -21,6 +21,36 @@
>  			#interrupt-cells = <1>;
>  			ti,intc-size = <101>;
>  			reg = <0xfffee000 0x2000>;
> +			clocks = <&psc0 6>;
> +		};
> +	};
> +	clocks: clocks {
> +		ref_clk: ref_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-output-names = "ref_clk";
> +		};

The ref_clk clock-frequency should rather be added in each board file
since its not fixed by the SoC. In general we dont want any SoC defined
properties to be overwritten by board files (except the status = property).

Thanks,
Sekhar
