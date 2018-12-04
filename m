Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38604208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bh7FOoRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38604208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLDIaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:30:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40314 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLDIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:30:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB48U6TL050144;
        Tue, 4 Dec 2018 02:30:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543912206;
        bh=iLtf2ADv6/p7rWdfNwgav/qYd5trThreO4g6vv8dkd8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bh7FOoRFAUdHdB852Kn1unSdr8KZiM+58isLcqTQlzutLkd0qckQAmDbkrrD1EBOi
         BJEg2lfYW2Td6xLQ+qAaHi2wBzxECdT2qPknjqAsRwOchvU01Yk5RsrQhCYx5Rxwey
         WelL3LA125xOJkyQ2GNcHan6HJruhvOeOkQCrpzk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB48U6jk112007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 02:30:06 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 02:30:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 02:30:06 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB48U3Ak012834;
        Tue, 4 Dec 2018 02:30:04 -0600
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-input@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181119094509.22542-1-vigneshr@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
Date:   Tue, 4 Dec 2018 14:00:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119094509.22542-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/11/18 3:15 PM, Vignesh R wrote:
> AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> handle AM654 SoCs. Also, it seems that existing compatible strings used
> in the kernel DTs were never documented. So, document them now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---

Gentle ping on this patch..

>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> index b1163bf97146..aad5e34965eb 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> @@ -2,7 +2,12 @@
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Required properties:
> +- mfd
> +	compatible: Should be
> +		"ti,am3359-tscadc" for AM335x/AM437x SoCs
> +		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
>  - child "tsc"
> +	compatible: Should be "ti,am3359-tsc".
>  	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
>  		  support on the platform.
>  	ti,x-plate-resistance: X plate resistance
> @@ -25,6 +30,9 @@ Required properties:
>  			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>  			XP  = 0, XN = 1, YP = 2, YN = 3.
>  - child "adc"
> +	compatible: Should be
> +		    "ti,am3359-adc" for AM335x/AM437x SoCs
> +		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
>  	ti,adc-channels: List of analog inputs available for ADC.
>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>  
> 

-- 
Regards
Vignesh
