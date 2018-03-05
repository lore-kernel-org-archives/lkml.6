Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeCEP1s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeCEP1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:27:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BEB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=dinguyen@kernel.org
Subject: Re: [PATCH] arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts
To: Graham Moore <graham.moore@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519141127-22038-1-git-send-email-graham.moore@linux.intel.com>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <855c7ccd-d675-7d4f-f380-a2e11233d331@kernel.org>
Date: Mon, 5 Mar 2018 09:27:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519141127-22038-1-git-send-email-graham.moore@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/20/2018 09:38 AM, Graham Moore wrote:
> The Stratix10 SoCFPGA uses the PL330 DMAC.  This patch adds the PL330
> DMAC to the Stratix10 device tree.
> 
> Signed-off-by: Graham Moore <graham.moore@linux.intel.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index aa4080d..0666c0f 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -711,6 +711,25 @@
>  			reg = <0xffe00000 0x100000>;
>  		};
>  
> +		pdma: pdma@ffda0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0xffda0000 0x1000>;
> +			interrupts = <0 81 4>,
> +				     <0 82 4>,
> +				     <0 83 4>,
> +				     <0 84 4>,
> +				     <0 85 4>,
> +				     <0 86 4>,
> +				     <0 87 4>,
> +				     <0 88 4>,
> +				     <0 89 4>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +			clocks = <&l4_main_clk>;

This clock doesn't exist. Can you please resend this patch based on the
clock driver patch?

please base your updated patch with :

https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_for_next_v4.17_dts

Dinh
