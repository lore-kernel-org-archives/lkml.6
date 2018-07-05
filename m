Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B2CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75423FCB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D75423FCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeGEVaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:30:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42956 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeGEVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:30:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so19619477oib.9;
        Thu, 05 Jul 2018 14:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QG7XVmFgq3p+lZ3E/BJK2vciA8k8L0pvkN4dXULKQyM=;
        b=UITNELc7CvFI+Nd+QkoMeYSomN9ahdl0bldMwEFVHZVWLwv1mzsjNdFm444PkFmnG8
         3Wl/nI0hH3gx4fZxWp5jYDBIwwyaJQkZva05sFyA0Ktf+w40y2/zsbe6cCGVZwfzUegx
         Ici+vkV/vFuRR3JsUT0Lg+Uu2v/EyUFFr6AuwLJSC89bT1roXHz9MCa7t3oo2E/2T03x
         oDSTB2r4HLX2g7r3jwIqRTL61vkYO6WUaULvosQz5l0C4V4kTWvqX5yOZqorV+tADgT+
         2bLPJ1OU/RDKrLdx4aG1mDjB12ghUnYVrThXgrZ34KaHr/ZWWk0uOToz+N2Qm7ry9Bwx
         yAUw==
X-Gm-Message-State: APt69E2C7ikmkR3mzkoRuPLmIUhHu2wCC3bFDMQ+4dNzfGv9MDotW1A0
        ZriC8h+y75XNdXozWPyyPQ==
X-Google-Smtp-Source: AAOMgpec1P20VgZoAUfcnaZ2MJs+DlEZFOcmnoYV+Uwyiy4Moqj2Gbbk7y79ciH0oXdmUEfeplLsFg==
X-Received: by 2002:aca:578b:: with SMTP id l133-v6mr9193706oib.329.1530826220846;
        Thu, 05 Jul 2018 14:30:20 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 6-v6sm8525329oig.57.2018.07.05.14.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:30:19 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:30:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180705213019.GA12792@rob-hp-laptop>
References: <20180704123638.GA30535@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704123638.GA30535@arbeit>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:36:38PM +0200, Andreas Klinger wrote:
> Add clock-frequency property for hx711 ADC
> 
> This is the frequency of PD_SCK. It affects only the high value duration
> since low value duration is not relevant and we are not able to switch
> faster than the minimum duration specified.
> 
> After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> This is necessary because of parasitic capacities on the wiring.

s/capacities/capacitance/

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index b3629405f568..4bee51d536e1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -8,11 +8,21 @@ Required properties:
>  		See Documentation/devicetree/bindings/gpio/gpio.txt
>   - avdd-supply:	Definition of the regulator used as analog supply
>  
> +Optional properties:
> + - clock-frequency:	Frequency of PD_SCK
> +			This setting affects the duration of the high value
> +			phase of the clock (PD_SCK). The low value phase is
> +			not affected since it is not relevant for the
> +			measurement.

That's not how frequency works. The high time should be equal to the low 
time. If you have parasitic capacitance affecting the rise time, then it 
is going to affect the fall time too.

Perhaps there could be some reason not to have a square wave, but I 
didn't see one in the datasheet.

> +			Minimum value allowed is 20 kHz because of maximum
> +			high time of 50 microseconds.

So 10kHz should be minimum.

> +
>  Example:
>  weight@0 {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>  	avdd-suppy = <&avdd>;
> +	clock-frequency = <100000>;
>  };
>  
> -- 
> 2.1.4
