Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeCPKUh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:20:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeCPKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:20:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Mar 2018 15:50:28 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <1521193101-4586-5-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <cd6561684acadd92d2112831abc0abd4@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 15:08, Sricharan R wrote:
> Adds missing memory, reserved-memory nodes.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 
> +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> index e413b21e..ad0fbc9 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> @@ -20,6 +20,34 @@
>  	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
>  	compatible = "qcom,ipq4019";
> 
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256MB */
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rsvd1@87000000 {
> +			/* Reserved for other subsystem */
> +			reg = <0x87000000 0x500000>;
> +			no-map;
> +		};
> +
> +		wifi_dump@87500000 {
> +			reg = <0x87500000 0x600000>;
> +			no-map;
> +		};
> +
> +		rsvd2@87B00000 {
> +			/* Reserved for other subsystem */
> +			reg = <0x87B00000 0x500000>;
> +			no-map;
> +		};
> +	};
> +
>  	soc {
>  		rng@22000 {
>  			status = "ok";
