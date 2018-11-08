Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5F020825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FP0ZgP01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKIDtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:49:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43240 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIDtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:49:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8ICne1025369;
        Thu, 8 Nov 2018 12:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541700769;
        bh=ERNmcnYAmFn6To9XOFgjAFjo5piKxjwb2HzVbQGklpY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FP0ZgP012T2jqXh2gOmEdBFF3TMvDDjt4kZEWmjaT0S3v5t768T7dfo2w4SztblVq
         N7jF/aWEoH3LmN//QaDjqe8+3uC0u/qpteeqQHCaXkZxVBuVqKhDn/GUubqea5nxUG
         /GQZCcxpCW21D7iByS6cMnVigZiX2WvrFSSzi9XA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8ICntU026286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:12:49 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:12:48 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:12:48 -0600
Received: from [172.22.151.38] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8ICmad001595;
        Thu, 8 Nov 2018 12:12:48 -0600
Subject: Re: [PATCH 11/24] dt-bindings: lm3692x: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-12-git-send-email-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7924d38c-bdde-6c1e-d79c-fa1a9d13ed8b@ti.com>
Date:   Thu, 8 Nov 2018 12:12:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-12-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---

Acked-by: Dan Murphy <dmurphy@ti.com>

>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> index 08b3528..62c8fe5 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> @@ -26,12 +26,16 @@ Required child properties:
>  		3 - Will enable the LED3 sync (LM36923 only)
>  
>  Optional child properties:
> -	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- function : see Documentation/devicetree/bindings/leds/common.txt
> +	- color : see Documentation/devicetree/bindings/leds/common.txt
> +	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
>  	- linux,default-trigger :
>  	   see Documentation/devicetree/bindings/leds/common.txt
>  
>  Example:
>  
> +#include <dt-bindings/leds/functions.h>
> +
>  led-controller@36 {
>  	compatible = "ti,lm3692x";
>  	reg = <0x36>;
> @@ -43,7 +47,8 @@ led-controller@36 {
>  
>  	led@0 {
>  		reg = <0>;
> -		label = "white:backlight_cluster";
> +		function = LED_BACKLIGHT_CLUSTER;
> +		color = "white";
>  		linux,default-trigger = "backlight";
>  	};
>  }
> 


-- 
------------------
Dan Murphy
