Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3990B218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfB0JGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:06:05 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:35663 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfB0JGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:06:04 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 8B1C813F8ED;
        Wed, 27 Feb 2019 10:05:45 +0100 (CET)
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add GEN2 PCIe controller and
 PHY
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190226070525.22453-1-bjorn.andersson@linaro.org>
 <20190227070022.31975-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <31974548-f786-125f-c897-4b8a4d615559@free.fr>
Date:   Wed, 27 Feb 2019 10:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227070022.31975-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 08:00, Bjorn Andersson wrote:

> SDM845 sports two PCIe controller/phy pairs; one GEN2 and one GEN3. Add
> the nodes for the GEN2 pair.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - "reg" is spelled without a 't'
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 103 +++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5308f1671824..35887fedfd0e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1024,6 +1024,109 @@
>  			};
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";

$ git grep "qcom,pcie-sdm845\|qcom,sdm845-qmp-pcie-phy" drivers/
/* Nada */

Are you planning on landing more patches later?
In particular, the PHY init sequence...
