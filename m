Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1306C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8842146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AqA/ikAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBKFkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:40:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35650 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKFkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:40:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1B5e44r054401;
        Sun, 10 Feb 2019 23:40:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549863604;
        bh=iqHS0P40nM+mjia0ZQ7kC83B2fcK82Mp2OcRu8R+Ucg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AqA/ikAQI3xyBh8FcrNNNxTpqtzCAIJdcbgv2RFJmwFw5Q7IvAqevOpxj1A0fkey8
         KOT1pzeKW3prVa5t0bGgKc620bIfdqH4K6XBcYjyncOA8e5V7TNjYWxUdk56Y1Bhjt
         mO3hN4674C3Wcbfiah1z1w8gCg8JTRfQAeSecNp0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1B5e4Zo120277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Feb 2019 23:40:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 10
 Feb 2019 23:40:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 10 Feb 2019 23:40:04 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1B5e1p3016023;
        Sun, 10 Feb 2019 23:40:02 -0600
Subject: Re: [PATCH v2] dt-bindings: input: ti-tsc-adc: Add new compatible for
 AM654 SoCs
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20190108052631.4169-1-vigneshr@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <3623af02-063d-9077-1e59-99d8cfe93ddd@ti.com>
Date:   Mon, 11 Feb 2019 11:10:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108052631.4169-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 08/01/19 10:56 AM, Vignesh R wrote:
> AM654 SoCs has ADC IP which is similar to AM335x, but without the
> touchscreen part. Add new compatible to handle AM654 SoCs. Also, it
> seems that existing compatible strings used in the kernel DTs were never
> documented. So, document them now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

If there are no comments, could you queue this bindings patch? This will
help me in getting ADC DT nodes to be merged into ARM SoC tree.

Regards
Vignesh

> v2:
> Fix subject line to include subsystem name
> Rebase onto v5.0-rc1
> v1: https://lkml.org/lkml/2018/11/19/313
> 
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
