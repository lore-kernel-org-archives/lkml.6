Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC09C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1162086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZpD+7V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1162086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeKQE1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQE1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:27:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9F4206BA;
        Fri, 16 Nov 2018 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542392024;
        bh=XBIAbSuVTF2LPW6cnRwx+QIO1/G0UuEvHUWlKVKCzKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jZpD+7V7chvHILQT1hxfe8eKvOmJxsm3/i+qFu6NRQew8PDsfmw+/dkcRLZ6NNIKK
         OYxd5T+9f1rx2rQK3dRjDYHuQheZuSTnCQDk55j7LQvgFxVU5MX5mG+KnkrbG5PHIS
         9z6uXoL+bkAt5WbbHCyw7yScdYgG+poB1ycOiCwU=
Date:   Fri, 16 Nov 2018 18:13:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: vadc: Add unit address to ADC
 channel node in example
Message-ID: <20181116181338.52674a46@archlinux>
In-Reply-To: <20181112221126.27142-2-mka@chromium.org>
References: <20181112221126.27142-1-mka@chromium.org>
        <20181112221126.27142-2-mka@chromium.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 14:11:25 -0800
Matthias Kaehlcke <mka@chromium.org> wrote:

> The node has a reg property, therefore its name should include a unit
> address. Also change the name from 'usb_id_nopull' to 'adc-chan', which
> is the preferred name for ADC channel nodes.
> 
> Include headers for constants used in the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
Looks good to me.  I'd just like to leave it a little longer
to give Rob or other device tree specialists a change
to take one last look at it.

Ping me if I seem to have forgotten about it!

Thanks,

Jonathan
> ---
> Changes in v6:
> - changed node name to adc-chan@
> - added includes for constants used in the example
> - updated commit message
> - added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag
> 
> Changes in v5:
> - patch added to the series
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index b3c86f4ac7cdb..c81993f8d8c39 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -140,6 +140,10 @@ VADC_GND_REF and VADC_VDD_VADC.
>  
>  Example:
>  
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <linux/irq.h>
> +/* ... */
> +
>  	/* VADC node */
>  	pmic_vadc: vadc@3100 {
>  		compatible = "qcom,spmi-vadc";
> @@ -151,7 +155,7 @@ Example:
>  		io-channel-ranges;
>  
>  		/* Channel node */
> -		usb_id_nopull {
> +		adc-chan@VADC_LR_MUX10_USB_ID {
>  			reg = <VADC_LR_MUX10_USB_ID>;
>  			qcom,decimation = <512>;
>  			qcom,ratiometric;

