Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBCLRo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:17:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBCLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:17:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Feb 2018 16:47:39 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 06/15] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <1517202689-14212-7-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <a32d3a776c7a3f5c88a9a26200bff915@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 10:41, Sricharan R wrote:
> Add the common parts for the dk04 boards.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 147

  <snip>
> +
> +			nand_pins: nand_pins {
> +				pullups {
> +					pins = "gpio52", "gpio53",
> "gpio58",
> +						"gpio59";
> +					function = "qpic";
> +					bias-pull-up;
> +				};
> +
> +				pulldowns {
> +					pins = "gpio54", "gpio55",
> "gpio56",
> +						"gpio57", "gpio60",
> "gpio61",
> +						"gpio62", "gpio63",
> "gpio64",
> +						"gpio65", "gpio66",
> "gpio67",
> +						"gpio68", "gpio69";
> +					function = "qpic";
> +					bias-pull-down;
> +				};
> +			};

  Can you please check once why do we need pull-up and
  pull-down for NAND pins. The NAND chip will be mounted
  over board itself so board design should take care of
  required pull up and pull downs.

  Also, some of the above pins like gpio52 will be only used
  for LCD so we can remove those pins. Later on, when LCD
  support will be added, we can add those pins.

  Thanks,
  Abhishek
