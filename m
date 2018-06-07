Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 09KrBTlKGVuWVAAAmS7hNA
	; Thu, 07 Jun 2018 15:09:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B99C6089E; Thu,  7 Jun 2018 15:09:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q8rPvJWM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAD0E601B4;
	Thu,  7 Jun 2018 15:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAD0E601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965061AbeFGPJq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:09:46 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:35747 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935276AbeFGPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:16 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w57F33C3031281;
        Thu, 7 Jun 2018 10:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528383783;
        bh=hkop1PlKYyKy1uMHIpUAo7VOwypf+qQMWwrTdtf9Suc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q8rPvJWM6ULvQXaFcU+nHbuyEjT4JseKhfq5kk2PqvKFQUpBbF07wlRHSSN3BlY/M
         +QXW1vMsty5/sB5tObBptTNTni0CqB+MarEoqx3eIR3YTwWHwqMZcmKhWbM1J71IBO
         /2K7aI7I28za8bpv7tg6H6AAvun91OL4I3A51cyw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57F32OB014546;
        Thu, 7 Jun 2018 10:03:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 7 Jun
 2018 10:03:01 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 7 Jun 2018 10:03:01 -0500
Received: from [128.247.59.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57F31eV005665;
        Thu, 7 Jun 2018 10:03:01 -0500
Subject: Re: [PATCH 3.16 070/410] ARM: dts: omap3-n900: Fix the audio CODEC's
 reset pin
To: Ben Hutchings <ben@decadent.org.uk>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>
References: <lsq.1528380321.59534108@decadent.org.uk>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <7e63eb22-6477-37b6-93fb-fd0170615f64@ti.com>
Date: Thu, 7 Jun 2018 10:03:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <lsq.1528380321.59534108@decadent.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 09:05 AM, Ben Hutchings wrote:
> 3.16.57-rc1 review patch.  If anyone has any objections, please let me know.
> 


This relies on a patch that may not have been back-ported this far back,
it is more safe to not take this patch.


> ------------------
> 
> From: "Andrew F. Davis" <afd@ti.com>
> 
> commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.
> 
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.
> 
> Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X support")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -427,7 +427,7 @@
>  	tlv320aic3x: tlv320aic3x@18 {
>  		compatible = "ti,tlv320aic3x";
>  		reg = <0x18>;
> -		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> +		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
>  		ai3x-gpio-func = <
>  			0 /* AIC3X_GPIO1_FUNC_DISABLED */
>  			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> @@ -444,7 +444,7 @@
>  	tlv320aic3x_aux: tlv320aic3x@19 {
>  		compatible = "ti,tlv320aic3x";
>  		reg = <0x19>;
> -		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> +		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
>  
>  		AVDD-supply = <&vmmc2>;
>  		DRVDD-supply = <&vmmc2>;
> 
