Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4344C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806472086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806472086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeKQJDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:03:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34036 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:03:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so22853689otk.1;
        Fri, 16 Nov 2018 14:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KOeGkpGNfS6oeikwKcfAcUhvyaJkR2+cwZuLdV0hXs=;
        b=Pn13B0nITeh7MqYGHahMDrc6WI5COb+qiBgRyQaEWT0xC5mfyTDVgB7pxIEIAuxvgU
         WyFqompMniZtPeeKVgsq/xZbzMWR31Apg89szefpuR53pbHLpS8NcqMohua5/Gd9iTqu
         2+GTB+0iwx8QAPygmG5XQNsm5pLmujAylm98Jtk27UlLWIvavkpbG1FZZ4DQ13X4BcTI
         tnqoCCcr/lSzBaC14wYdMlpuq9OcyShO3Dk3rthpakYbFudbLIAxqEAjkflUMNpCHMgr
         W+m2q3GNmR0i5m8PYnZxn3ykg/3/2EOd8kiGZyloXcCydKpheMWkv5QWBkzokhkeC5lu
         hL8g==
X-Gm-Message-State: AGRZ1gIxsX0spJyVMiSCPYFkFZvUsEz98+nKYVGkUg1JW5QoWsa9zxnk
        bovJwkYB+LXvmFHtl6Ep0ikRSaYiKw==
X-Google-Smtp-Source: AJdET5fkejdgU08GdiMB1ICk1+mvXMhno/HYtJplN5pX1tJCxd/U6wuA2zci+h37EWPOchsFRIzqvQ==
X-Received: by 2002:a9d:3d0b:: with SMTP id a11mr8116658otc.43.1542408561974;
        Fri, 16 Nov 2018 14:49:21 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id h53sm11974168otd.41.2018.11.16.14.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:49:21 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:49:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tom Burkart <tom@aussec.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: pps: descriptor-based gpio,
 capture-clear addition
Message-ID: <20181116224919.GA18008@bogus>
References: <20181114125432.16044-1-tom@aussec.com>
 <20181114125432.16044-2-tom@aussec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114125432.16044-2-tom@aussec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
> This patch changes the devicetree bindings for the pps-gpio driver
> from the integer based ABI to the descriptor based ABI.

? That has nothing to do with DT.

>  It also adds
> documentation for the device tree capture-clear option.  The legacy
> device tree entry for the GPIO pin is supported.
> 
> Signed-off-by: Tom Burkart <tom@aussec.com>
> ---
>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> index 3683874832ae..6c9fc0998d94 100644
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> @@ -5,19 +5,23 @@ a GPIO pin.
>  
>  Required properties:
>  - compatible: should be "pps-gpio"
> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> +- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> +Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
> +- gpios: one PPS GPIO as above
>  
>  Optional properties:
>  - assert-falling-edge: when present, assert is indicated by a falling edge
>                         (instead of by a rising edge)
> +- capture-clear: when present, also capture the PPS clear event

Is this a h/w thing? or driver configuration?

>  
>  Example:
>  	pps {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pps>;
>  
> -		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +		pps-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
>  		assert-falling-edge;
> +		capture-clear;
>  
>  		compatible = "pps-gpio";
>  	};
> -- 
> 2.12.3
> 
