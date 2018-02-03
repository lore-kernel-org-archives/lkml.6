Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBCLds (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:33:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBCLdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:33:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Feb 2018 17:03:40 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 08/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c5
 board file
In-Reply-To: <1517202689-14212-9-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-9-git-send-email-sricharan@codeaurora.org>
Message-ID: <87d9fe82685c00e331b7c1156d2967eb@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 10:41, Sricharan R wrote:
> dk04.1-c5 has a spinand connected to spi bus0 chipselect 1.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c5.dts | 23
> +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)

  <snip>

> +		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
> +			status = "ok";
> +			cs-gpios = <&tlmm 12 0>, <&tlmm 45 0>;

  Same applies here also. We need to add pinumx
  for gpio45.

  Thanks,
  Abhishek

> +			num-cs = <2>;
> +
> +			mt29f@1 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "spinand,mt29f";
> +				reg = <1>;
> +				spi-max-frequency = <24000000>;
> +			};
> +		};
> +	};
> +};
