Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED508ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73B20684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="okSIkPap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKIDhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:37:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52068 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:37:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8I0GKO045668;
        Thu, 8 Nov 2018 12:00:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541700016;
        bh=nGkUEE3U00RiOrTXp61Xn/QktaC1mM2VBZMKG4OkLGM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=okSIkPap0Jr+5xZ1I4olnAjGa5/MMWFQ392ll6nqKangYeO5TzSiPsUxbtAR99ZKA
         OMJQedCAFKSAu13+cuJqRHX0SW19Veqx9hzI4RXvibYEroQJE5d6jYIZzJFC1IugzE
         /uRsBW0lF0ufc3LKMLZSR3yPVu3V9hM0tdyUVXUk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8I0Gwj049475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:00:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:00:16 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:00:16 -0600
Received: from [172.22.151.38] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8I0F5T015320;
        Thu, 8 Nov 2018 12:00:15 -0600
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <26714494-06f8-163d-1ef8-75f75c25a467@ti.com>
Date:   Thu, 8 Nov 2018 12:00:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
> Introduce dedicated properties for conveying information about
> LED function and color. Mark old "label" property as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>  1 file changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa13998..3efc826 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>  have to be tightly coupled with the LED device binding. They are represented
>  by child nodes of the parent LED device binding.
>  
> +
>  Optional properties for child nodes:
>  - led-sources : List of device current outputs the LED is connected to. The
>  		outputs are identified by the numbers that must be defined
>  		in the LED device binding documentation.
> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
> +	    from the header include/dt-bindings/leds/functions.h.
> +	    If there is no matching LED_FUNCTION available, add a new one.
> +- color : Color of the LED.

Should we define the colors too?  There are only really 4.  Red, green, blue and white.

Generally varying colors are created base on the primary colors.  Even the amber color

Dan

>  - label : The label for this LED. If omitted, the label is taken from the node
>  	  name (excluding the unit address). It has to uniquely identify
>  	  a device, i.e. no other LED class device can be assigned the same
> -	  label.
> +	  label. This property is deprecated - use 'function' and 'color'
> +	  properties instead.
>  
>  - default-state : The initial state of the LED. Valid values are "on", "off",
>    and "keep". If the LED is already on or off and the default-state property is
> @@ -87,29 +93,59 @@ Required properties for trigger source:
>  
>  * Examples
>  
> -gpio-leds {
> +#include <dt-bindings/leds/functions.h>
> +
> +led-controller@0 {
>  	compatible = "gpio-leds";
>  
> -	system-status {
> -		label = "Status";
> +	led0 {
> +		function = LED_FUNCTION_STATUS;
>  		linux,default-trigger = "heartbeat";
>  		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
>  	};
>  
> -	usb {
> +	led1 {
> +		function = LED_FUNCTION_USB;
>  		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>  		trigger-sources = <&ohci_port1>, <&ehci_port1>;
>  	};
>  };
>  
> -max77693-led {
> +led-controller@0 {
>  	compatible = "maxim,max77693-led";
>  
> -	camera-flash {
> -		label = "Flash";
> +	led {
> +		function = LED_FUNCTION_FLASH;
> +		color = "white";
>  		led-sources = <0>, <1>;
>  		led-max-microamp = <50000>;
>  		flash-max-microamp = <320000>;
>  		flash-max-timeout-us = <500000>;
>  	};
>  };
> +
> +led-controller@68 {
> +	compatible = "ti,tlc59116";
> +	reg = <0x68>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	led@0 {
> +		function = LED_FUNCTION_WAN;
> +		color = "amber";
> +		reg = <0x0>;
> +	};
> +
> +	led@2 {
> +		function = LED_FUNCTION_2G;
> +		color = "white";
> +		reg = <0x2>;
> +	};
> +
> +	led@9 {
> +		function = LED_FUNCTION_ALIVE;
> +		color = "green";
> +		reg = <0x9>;
> +		linux,default_trigger = "heartbeat";
> +	};
> +};
> 


-- 
------------------
Dan Murphy
