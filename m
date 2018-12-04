Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C06C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057D420672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057D420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLDSDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:03:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58566 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:03:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4I3jEo106775;
        Tue, 4 Dec 2018 12:03:45 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4I3jRp009467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 12:03:45 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 12:03:45 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 12:03:45 -0600
Received: from [172.22.101.186] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4I3i3P001297;
        Tue, 4 Dec 2018 12:03:44 -0600
Subject: Re: [PATCH 1/2] iio: ti-ads124s08: Add DT binding documentation
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
References: <20181204175955.8259-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <74b6db2a-bfc4-a7d3-3528-9ece2725520f@ti.com>
Date:   Tue, 4 Dec 2018 12:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181204175955.8259-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 12/04/2018 11:59 AM, Dan Murphy wrote:
> Adding binding documentation for Texas Instruments ADS124S08
> and ADS124S06 ADC.
> 
> S08 is a 12 channel ADC
> S06 is a 6 channel ADC
> 
> Datesheet can be found here:
> http://www.ti.com/lit/gpn/ads124s08
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/iio/adc/ti-ads124s08.txt         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> new file mode 100644
> index 000000000000..41ab67379ee1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
> @@ -0,0 +1,25 @@
> +* Texas Instruments' ads124s08 and ads124s06 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,ads124s08" or "ti,ads124s06"
> + - reg: spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> + - spi-cpha: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional properties:
> + - vref-supply: The regulator supply for ADC reference voltage
> + - reset-gpios: GPIO pin used to reset the device.
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads8688";

This is a copy/paste error I will fix in v2.

> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +	spi-cpha;
> +	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +};
> 


-- 
------------------
Dan Murphy
