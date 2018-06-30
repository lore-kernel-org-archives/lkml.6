Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FFC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6525549
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCd76F8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6525549
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeF3Rcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbeF3Rcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:32:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C897525485;
        Sat, 30 Jun 2018 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530379959;
        bh=FQvpQBeJqzwOJrfHsbTi5iRFtPN/48uHiZ0YohsTcdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pCd76F8lm2LUJLXekJQeLjQqdRbWuSgp0gmujYUO8cdRDwSh8lMy3M6i54WPgFO/l
         sIbpdeIVLvcjETzIFV3iay5GKp79soC3pC2T0SrRRF0kCX3+Dv1Lejk92ocTjuGbzg
         dNm3QAKa/55L2d9SMJ7kKqFTpmPsXY83ai1m4EKA=
Date:   Sat, 30 Jun 2018 18:32:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: hx711: add data-ready-delay-ns property in
 DT
Message-ID: <20180630183232.540ce031@archlinux>
In-Reply-To: <20180625151802.GA6369@arbeit>
References: <20180625151802.GA6369@arbeit>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 17:18:02 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add data-ready-delay-ns property for hx711 ADC
> this is the delay after rising PD_SCK until DOUT is read and assumed to be
> ready
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hmm. It's not particularly generic... I think this should have
have vendor prefix until we have some visibility of whether it
is a common thing we want to standardise around or not.

I'll also be waiting for a devicetree ack on this one as it's a
tiny bit unusual.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index b3629405f568..d0c066e3df69 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -8,11 +8,18 @@ Required properties:
>  		See Documentation/devicetree/bindings/gpio/gpio.txt
>   - avdd-supply:	Definition of the regulator used as analog supply
>  
> +Optional properties:
> + - data-ready-delay-ns:	additional delay in nanoseconds between rising of
> +			PD_SCK until DOUT is ready
> +			should be less then maximum PD_SCK high time which
> +			is 50000 in the datasheet
> +
>  Example:
>  weight@0 {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>  	avdd-suppy = <&avdd>;
> +	data-ready-delay-ns = <1000>;
>  };
>  

