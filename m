Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545084408;
	bh=naF4U9nYfH5zhp8scg3+F5QXpKm0dUDBukNDAgsAxaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zhYh3LHQTThaf5Ldz0pnY2ytsSeRRGnVosi+V7kWezMIIcMI2/Q0yB/e/ZgfJ3GqV
	 GnfH5jHgYvPaxQH/OweyAqvWOXp1It1LTfvyNRGgQYRwrA+j4FcTA7ARKkqgKaL8EZ
	 0MKBgTVA+vMI6azg6xuTTBAgdthKCg+P4Bz8qIKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeLQWGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:06:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38502 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:06:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so329719oii.5;
        Mon, 17 Dec 2018 14:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsrVI+UQqYetR7FXHFIVqEUDCf1xzSqN+2Xw2fIvErA=;
        b=bGAX0a7eEqruOvu36qUUrXGFxYTWKnJaFkjFqTBhmz9RPb8pAaJ/ft7PwFB6HTQ3AS
         f7cEytkomfhJJnkqN+wtJjjmC7/AU9wGqGy8cpLSIQmm4XLlktoMtPvchk95ADNOLmwd
         dp+MNzMYTn07BFeaL1tdlQIHiHIjcn7pKcmktTONloIcic3YRh3HfBV2rOAZPEJQiX/W
         BWSAiIUK5BDx5AHsYKv0YyIf5+p87x9ZcWcMDsuskuodH9fX6rs8ons4WaYwDEMwujIo
         cE9PH41g7ydCvU/SkOrkTktjCWrLBB+KwezOfoPFO9H0Dln3MeX8U6tPx48O0XoNE5/T
         qjlw==
X-Gm-Message-State: AA+aEWa/MpqwjCS+Whd0Prf+TeVbCZmr5k1NPkNS/2EK2TPOz48YqejM
        3JFdcKzg6x5ppPLGNAsH/g==
X-Google-Smtp-Source: AFSGD/Vv14Lft5S8CMIfN78Hgsga270CLdVKj/7cJ4t8dKFx7y6UCDG0DSz5dwvdbyjB+nyxnQYV+A==
X-Received: by 2002:aca:f553:: with SMTP id t80mr6677458oih.358.1545084404983;
        Mon, 17 Dec 2018 14:06:44 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id v1sm6659324otq.80.2018.12.17.14.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:06:44 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:06:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        thierry.reding@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181217220643.GA26243@bogus>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:06:42PM +0100, Philippe Schenker wrote:
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Need to fix the author and S-o-b emails to match.

> ---
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 52 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++---
>  2 files changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 127baa31a77a..1d3f84308142 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,24 +5,40 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time: ADC converstion time in number of clock.  (0 -> 36 clocks, 1 ->
> -  44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks, 5 -> 96 clocks, 6
> -  -> 144 clocks), recommended is 4.
> -- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> -- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
> -  reference)
> -- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> -- st,ave-ctrl: Sample average control (0 -> 1 sample, 1 -> 2 samples, 2 -> 4
> -  samples, 3 -> 8 samples)
> -- st,touch-det-delay: Touch detect interrupt delay (0 -> 10 us, 1 -> 50 us, 2 ->
> -  100 us, 3 -> 500 us, 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms) recommended
> -  is 3
> -- st,settling: Panel driver settling time (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3
> -  -> 1 ms, 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms) recommended is 2
> -- st,fraction-z: Length of the fractional part in z (fraction-z ([0..7]) = Count of
> -  the fractional part) recommended is 7
> -- st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
> -  mA max, 1 -> 50 mA typical 80 mA max)
> +- st,sample-time	: ADC conversion time in number of clock.
> +				0 -> 36 clocks		4 -> 80 clocks (recommended)
> +				1 -> 44 clocks		5 -> 96 clocks
> +				2 -> 56 clocks		6 -> 144 clocks
> +				3 -> 64 clocks

Just make this a 1 column list

> +- st,mod-12b		: ADC Bit mode
> +				0 -> 10bit ADC		1 -> 12bit ADC
> +- st,ref-sel		: ADC reference source
> +				0 -> internal		1 -> external
> +- st,adc-freq		: ADC Clock speed
> +				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +				1 -> 3.25 MHz
> +- st,ave-ctrl		: Sample average control
> +				0 -> 1 sample
> +				1 -> 2 samples
> +				2 -> 4 samples
> +				3 -> 8 samples
> +- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
> +				0 -> 10 us		5 -> 5 ms
> +				1 -> 50 us		6 -> 10 ms
> +				2 -> 100 us		7 -> 50 ms
> +				3 -> 500 us
> +				4 -> 1 ms
> +- st,settling		: Panel driver settling time (recommended is 2)
> +				0 -> 10 us		5 -> 10 ms
> +				1 -> 100 us		6 for 50 ms
> +				2 -> 500 us		7 -> 100 ms
> +				3 -> 1 ms
> +				4 -> 5 ms
> +- st,fraction-z		: Length of the fractional part in z (recommended is 7)
> +			  (fraction-z ([0..7]) = Count of the fractional part)
> +- st,i-drive		: current limit value of the touchscreen drivers
> +				0 -> 20 mA (typical 35mA max)
> +				1 -> 50 mA (typical 80 mA max)
>  
>  Node name must be stmpe_touchscreen and should be child node of stmpe node to
>  which it belongs.
> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index c797c05cd3c2..a46e7177195d 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -4,15 +4,15 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
>  keypad, touchscreen, adc, pwm, rotator.
>  
>  Required properties:
> - - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
> - - reg                          : I2C/SPI address of the device
> + - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
> + - reg				: I2C/SPI address of the device
>  
>  Optional properties:
> - - interrupts                   : The interrupt outputs from the controller
> - - interrupt-controller         : Marks the device node as an interrupt controller
> - - wakeup-source                : Marks the input device as wakable
> - - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> - - irq-gpio                     : If present, which GPIO to use for event IRQ
> + - interrupts			: The interrupt outputs from the controller
> + - interrupt-controller		: Marks the device node as an interrupt controller
> + - wakeup-source		: Marks the input device as wakable
> + - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> + - irq-gpio			: If present, which GPIO to use for event IRQ
>  
>  Example:
>  
> -- 
> 2.19.2
> 
