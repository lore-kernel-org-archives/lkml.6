Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E137420840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWUlYmPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E137420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJaQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeJaQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:44:48 -0400
Received: from localhost (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EB820821;
        Wed, 31 Oct 2018 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540972068;
        bh=6Ej4xdjoDNmZTOMaRUKbn6lRwhxVTLMFpxddv5eZXe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWUlYmPn7XGj3cPgL8n6Q6P6fc1kaJro+8wYVjJWpEJqdUMvkadfTjb+ipjnd8zQ9
         FfkRlAYDr2sJRpzKF+4k7YUAYQD2OZ0NHDlfTWNDJ6krORh+O6Arq2XAe80c+Sbbye
         PTLfoMOCeud7H+wO5EhTQBrvd0s3FrDTOaDMDIkA=
Date:   Wed, 31 Oct 2018 13:17:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     andy.gross@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: qcs404: Add tsens controller
Message-ID: <20181031074740.GJ12092@vkoul-mobl>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
 <f1dccd5d6fa08572237ccb3716f2f0ddab54ba40.1539627762.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dccd5d6fa08572237ccb3716f2f0ddab54ba40.1539627762.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-18, 00:10, Amit Kucheria wrote:
> qcs404 has a single TSENS IP block with 10 sensors. The calibration data
> is stored in an eeprom (qfprom) that is accessed through the nvmem
> framework. We add the qfprom node to allow the tsens sensors to be
> calibrated correctly.

Andy,

These have dependency on the patch series adding The DT file I sent
yesterday[1]. Please apply these on top of that series

[1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=36319

Thanks

> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index e1e2ba9cbfcd..dfd65c53cf5f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -273,6 +273,26 @@
>  			status = "okay";
>  		};
>  
> +		qfprom: qfprom@a4000 {
> +			compatible = "qcom,qfprom";
> +			reg = <0xa4000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			tsens_caldata: caldata@d0 {
> +				reg = <0x1f8 0x14>;
> +			};
> +		};
> +
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			nvmem-cells = <&tsens_caldata>;
> +			nvmem-cell-names = "calib";
> +			#qcom,sensors = <10>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		apcs_glb: mailbox@b011000 {
>  			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>  			reg = <0xb011000 0x1000>;
> -- 
> 2.17.1

-- 
~Vinod
