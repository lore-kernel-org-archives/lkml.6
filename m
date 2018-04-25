Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeDYWFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:05:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36340 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbeDYWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:05:17 -0400
X-Google-Smtp-Source: AIpwx4/dUd5C1dTK41Zq2vxIJsYK8ayXmo5VZlK0Soo9KiSt4VMe9nV+a+ZvYN5PoW/Cr+t31+h+VQ==
Date: Wed, 25 Apr 2018 15:06:26 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add SDM845 SMEM nodes
Message-ID: <20180425220626.GM2052@tuxbook-pro>
References: <20180425144631.19731-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425144631.19731-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 07:46 PDT 2018, Sibi Sankar wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9be763da0664..bea985045759 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -21,6 +21,27 @@
>  		reg = <0 0x80000000 0 0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		memory@85fc0000 {
> +			reg = <0 0x85fc0000 0 0x40000>;

The region 0x85fe0000 + 0x20000 seems to be command db, which should be
described on its own. So please reduce the size to 0x20000.

> +			no-map;
> +		};
> +
> +		smem_mem: smem-mem@86000000 {

smem_mem: memory@86000000 ?

> +			reg = <0x0 0x86000000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		memory@86000000 {

memory@86200000

> +			reg = <0 0x86200000 0 0x2d00000>;
> +			no-map;
> +		};
> +	};
> +

The rest looks good.

Regards,
Bjorn
