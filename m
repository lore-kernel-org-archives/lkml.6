Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCHXVr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:21:47 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11099 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeCHXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:21:45 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Mar 2018 15:21:45 -0800
Subject: Re: [PATCH v3 07/11] dt-bindings: tegra: Update DFLL binding for PWM
 regulator
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-8-git-send-email-pdeschrijver@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c747bc00-8c04-c297-e945-784e45655421@nvidia.com>
Date: Thu, 8 Mar 2018 23:21:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517934852-23255-8-git-send-email-pdeschrijver@nvidia.com>
X-Originating-IP: [10.26.11.23]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/18 16:34, Peter De Schrijver wrote:
> Add new properties to configure the DFLL PWM regulator support. Also
> add an example and make the I2C clock only required when I2C support is
> used.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt        | 76 +++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index dff236f..a4903f7 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -23,7 +23,8 @@ Required properties:
>  - clock-names: Must include the following entries:
>    - soc: Clock source for the DFLL control logic.
>    - ref: The closed loop reference clock
> -  - i2c: Clock source for the integrated I2C master.
> +  - i2c: Clock source for the integrated I2C master (only required when
> +	 using I2C mode).
>  - resets: Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names: Must include the following entries:
> @@ -45,10 +46,28 @@ Required properties for the control loop parameters:
>  Optional properties for the control loop parameters:
>  - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
>  
> +Optional properties for mode selection:
> +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> +

Do we need this property? Seems that we should be able to detect if it
is I2C or PWM based upon the other properties.

Cheers
Jon

-- 
nvpublic
