Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C3ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8F6208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf09V14G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8F6208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIPS2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbeIPS2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:28:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49FD2087B;
        Sun, 16 Sep 2018 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537103151;
        bh=r94hoSbxDnL+A5BPaV3pXl3x1LD/wJ3Wax1VmZXEQHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mf09V14GB+6iz6PrpAycXOFSG2uSYUxsSe2B1vHs3y34SZveSxnmJd1HiwXvJcTmx
         HLobhz5KjwSf1szmVjRqIYKOY2GiovvbBTwadUbOczsS7u+rRp2KIuIXdwQi5MCQKG
         HQgmeO+qcz0C5LouK18vn0H85NTPzUlZXLRs2fxk=
Date:   Sun, 16 Sep 2018 14:05:46 +0100
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
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: vadc: Fix documentation of
 'reg'
Message-ID: <20180916140546.264c4310@archlinux>
In-Reply-To: <20180910160301.237538-2-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
        <20180910160301.237538-2-mka@chromium.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 09:02:59 -0700
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
I've already tidied this up and applied.  It should hit linux-next
tomorrow.

Jonathan
> ---

> Changes in v3:
> - fixed separator in commit message
> - removed duplicate 'Signed-off-by' tag
> 
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

