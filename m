Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589FC2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589FC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIGNgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:36:17 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33326 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGNgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:36:17 -0400
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="19532699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 01:56:13 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Fri, 7 Sep 2018
 01:56:12 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
References: <20180907081851.15911-1-ludovic.desroches@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8ff626a5-8f8a-1e75-ec3d-2a6004289747@microchip.com>
Date:   Fri, 7 Sep 2018 10:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907081851.15911-1-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 at 10:18, Ludovic Desroches wrote:
> The drive strength has to be set to medium otherwise some data
> corruption may happen.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> 
> Hi,
> 
> This fix depends on the support of the drive-strength for the atmel pio4
> pinctroller. It has been added in v4.19 but I omitted to send it at the
> same time.

Could be good to be queued for "4.19-fixes".

Best regards,
   Nicolas

> Ludovic
> 
>   arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> index b10dccd0958f..3b1baa8605a7 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
> @@ -11,6 +11,7 @@
>   #include "sama5d2-pinfunc.h"
>   #include <dt-bindings/mfd/atmel-flexcom.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/at91.h>
>   
>   / {
>   	model = "Atmel SAMA5D2 PTC EK";
> @@ -299,6 +300,7 @@
>   							 <PIN_PA30__NWE_NANDWE>,
>   							 <PIN_PB2__NRD_NANDOE>;
>   						bias-pull-up;
> +						atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
>   					};
>   
>   					ale_cle_rdy_cs {
> 


-- 
Nicolas Ferre
