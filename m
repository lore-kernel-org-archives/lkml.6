Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11BC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9012086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhNCoqeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9012086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeIHS5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeIHS5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:57:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A43B1206BB;
        Sat,  8 Sep 2018 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536415908;
        bh=mOEcpzbQdZ8+v5mHZy0tDp2nX2oVTqmHYBoNq3KFq0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qhNCoqeWKnBZAbh6O25MSd/RaDXDbOTUw2iImuK+fpguKI+QRTM+CjgPMi17tiIUO
         YzxtpswO+wm2Q0uFp8wobSnEd2Uvu3fsw7Bb1jhe5zLrnrvOoDPGyrO4fHhZTQt7Et
         FRkm2Q6VUp4vszJ3OB5yvWDduoYFUnTdg7br53Hk=
Date:   Sat, 8 Sep 2018 15:11:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: vadc: Fix documentation of
 'reg'
Message-ID: <20180908151142.465a1b7b@archlinux>
In-Reply-To: <20180906210454.247219-2-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
        <20180906210454.247219-2-mka@chromium.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Sep 2018 14:04:52 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> --
> Changes in v2:
> - none
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index 0fb46137f936..d0c188e5c922 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -13,7 +13,7 @@ VADC node:
>  - reg:
>      Usage: required
>      Value type: <prop-encoded-array>
> -    Definition: VADC base address and length in the SPMI PMIC register map.
> +    Definition: VADC base address in the SPMI PMIC register map.
>  
>  - #address-cells:
>      Usage: required
> @@ -104,7 +104,7 @@ Example:
>  	/* VADC node */
>  	pmic_vadc: vadc@3100 {
>  		compatible = "qcom,spmi-vadc";
> -		reg = <0x3100 0x100>;
> +		reg = <0x3100>;
>  		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;

