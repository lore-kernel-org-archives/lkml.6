Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D804AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A364921479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546550092;
	bh=ccciDNEgpCNid3FhDBnKNOjiebGCvlaWC4kPMMov8bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DKMUgTxnsUYAvLVYwq9r4vyq08JPJJDwLXuPNl3AwKh4Qkm0M3TDifrmhMb2AvYT
	 o/mHYMZWmWWNTjXiBfnq048M583Mtsu8L/2z5KG3oL8RA6bJlA2s926cHeRB2NY/Z4
	 877VT5EJctRV41E+smAHuexRWORDT9sSd0t+NV8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfACVOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:14:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52709 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfACVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:14:51 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so47176569itg.2;
        Thu, 03 Jan 2019 13:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RFJv2pEtzMnCmHqpwbHFcL8CG7J04WnCqNMgo/+qLPk=;
        b=VqgC8l4Lp2U8eSvCt0nQySWOkOGXowmJhaN89x4xGOpgmHnWTn9QQGYxUsI+cLRum/
         zd34mS0a8d8M/5AGFeAzMEqyjYZGgC0NDn0OstqUQN774J7DpEG/sSKlJbQV/4qEcSY7
         NXY0dQ0ilfzMSx4GYfRH07tPawNZ3YwK7y8g6E7JvyW2/eyTybPIMMWJeE9Zip5ncOGq
         Z3u0AguQ4qhCoASUn50YSCzOA0BslcFnCym1wzGABHQAbrh7MnSIbWgprcsarWK97KL7
         yXx6pHXu+b9P4YG6FUCXUCCLq6DvlKpsAtSLok8Qrpwi0Hck+97ANtDWixsQG2HKF8OR
         bBHg==
X-Gm-Message-State: AA+aEWZPobu29LhyKacZSkRRgajD7IH828KGvQZ+9USpPBzlrf2lGsMZ
        PRK43FhKi3/lAojmM/jYYQ==
X-Google-Smtp-Source: AFSGD/UCiBXdQyBzaX30++tCxEnw5Oh61kbQIcMtaE22/WZG+KWgHmzQwzOsJa5YAxDjoZNpxMFPIA==
X-Received: by 2002:a02:910a:: with SMTP id a10mr34057589jag.116.1546550089548;
        Thu, 03 Jan 2019 13:14:49 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id f13sm25041184iol.82.2019.01.03.13.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:14:48 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:14:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: iio: add NPCM ADC documentation
Message-ID: <20190103211447.GA4618@bogus>
References: <20181224164755.286932-1-tmaimon77@gmail.com>
 <20181224164755.286932-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224164755.286932-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 06:47:54PM +0200, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM Analog-to-Digital Converter(ADC).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> new file mode 100644
> index 000000000000..6f0843d837cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> @@ -0,0 +1,35 @@
> +Nuvoton NPCM Analog to Digital Converter (ADC)
> +
> +The NPCM ADC is a 10-bit converter for eight channel inputs.
> +
> +Required properties:
> +- compatible	: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
> +- reg			: specifies physical base address and size of the registers.
> +- interrupts	: Contain the ADC interrupt with flags for falling edge.
> +
> +Optional properties:
> +- clocks		: phandle of ADC reference clock, in case the clock is not
> +				  added the ADC will use the default ADC sample rate.
> +- vref-supply	: The regulator supply ADC reference voltage, in case the
> +				  vref-supply is not added the ADC will use internal voltage
> +				  reference.
> +
> +Required Node in the NPCM7xx BMC:
> +An additional register is present in the NPCM7xx SOC which is
> +assumed to be in the same device tree, with and marked as
> +compatible with "nuvoton,npcm750-rst".
> +
> +Example:
> +
> +adc: adc@f000c000 {
> +	compatible = "nuvoton,npcm750-adc";
> +	reg = <0xf000c000 0x8>;
> +	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clk NPCM7XX_CLK_ADC>;
> +};
> +
> +rst: rst@f0801000 {

Why is this node here?

> +	compatible = "nuvoton,npcm750-rst", "syscon",
> +	"simple-mfd";
> +	reg = <0xf0801000 0x6C>;
> +};
> -- 
> 2.14.1
> 
