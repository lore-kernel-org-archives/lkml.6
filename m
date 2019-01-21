Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D80C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A72089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098065;
	bh=PqvDfrB+iULN/C0zfex1UnmYhzFBnbRNlfaMDgFXkNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZrTYYi0Te7Pp5MtW5KpIEZN9e0Z6Q0xt0mvmJPu6jxl7ZRQbIIKSzpwDWmiWbHZL
	 B68Wcu8sX8LLz7QPuthfb7br9B9PMDOxST4xAe2MChstL7bJFdsGwkgxuK5J55eWnl
	 3Agmtwa2pkshfKqBEmFmTcAPq1HeSCm24meYNu6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAUTOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:14:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44732 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAUTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:14:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so21442495otl.11;
        Mon, 21 Jan 2019 11:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+hMm63c9ntcXS9vFDdWzQZYqYhCh7H/0FXYUZ6ODJwU=;
        b=dfoFwxPZRrjsw7OoMhnkSf01PAg6IIZpJy7Qz4RXOYL7gT8OkJUEqW2oAwBYlVvZRZ
         wtxt31ySyIQ7kv4fTaamDDIbgmfSBubcgRgtcRc1USb6z0rX8AR+1hizrBboo86RicX6
         c1zsm1v4whlj0STDimTjkkI8S2pKikt+jBBJrtCc0WB/881Gr9wmo9SKpHESkhRrNEER
         2Vh01MulaFrYI92+W9tarddTvuLiAi0qf+0Llb9yf66XcNeQT+S8NdWqd5O64YEFtVZ9
         zMt75BrQbCkJaVA437KZ0qx6NURpauJc2X5urombntRifT3M/kZE1e+os+Q5ZZtgW2vN
         TzRQ==
X-Gm-Message-State: AJcUukfMSfXmWkx7JQ6B7KYqdQwcGAzMYY8GlrKRTCi8sJfWD0dKLGyO
        r0nuRjk0QcL4O1tLTl1kDQ==
X-Google-Smtp-Source: ALg8bN6XbJEZ4TQJo3i9gboaNga2H52Civwu8zgan1dz+4leSs28Zghsv7gfpbP3wn0ShP7MVkCJlg==
X-Received: by 2002:a9d:3782:: with SMTP id x2mr7461403otb.13.1548098062125;
        Mon, 21 Jan 2019 11:14:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c23sm5723706otn.21.2019.01.21.11.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 11:14:21 -0800 (PST)
Date:   Mon, 21 Jan 2019 13:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-lpwan@lists.infradead.org, afaerber@suse.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
Message-ID: <20190121191420.GA7878@bogus>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108084132.10214-1-ben.whitten@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:41:29PM +0900, Ben Whitten wrote:
> Add basic documentation in YAML format for the sx130x series concentrators
> from Semtech.
> Required is; the location on the SPI bus, the reset gpio and the node for
> downstream IQ radios, typically sx125x.
> 
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
>  .../bindings/lora/semtech,sx130x.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/lora/semtech,sx130x.yaml

A schema binding. Yay!

> 
> diff --git a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> new file mode 100644
> index 000000000000..ad263bc4e60d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/lora/semtech,sx130x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech LoRa concentrator
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Ben Whitten <ben.whitten@gmail.com>
> +
> +description: |
> +  Semtech LoRa concentrator sx130x digital baseband chip is capable of
> +  demodulating LoRa signals on 8 channels simultaneously.
> +
> +  It is typically paired with two sx125x IQ radios controlled over an
> +  SPI directly from the concentrator.
> +
> +  The concentrator itself it controlled over SPI.

s/it/is/

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - semtech,sx1301
> +        - semtech,sx1308
> +
> +  reg:
> +    maxItems: 1
> +    description: The chip select on the SPI bus.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: A connection of the reset gpio line.
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +    default: 8000000
> +    description: The frequency of the SPI communication to the concentrator,
> +      in Hz. Maximum SPI frequency is 10MHz although 8MHz is typically used
> +      on a number of cards.
> +
> +  radio-spi:

child nodes should have 'type: object'

> +    description: The concentrator has two radios connected which are contained
> +      within the following node.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0

You need the grandchildren here too to define 'reg' should be 0-8. 
You'll need to use 'patternProperties' since there's a unit-address.

You could maybe get rid of the radio-spi node. You don't need it unless 
you wanted to add other types of child nodes.

> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - radio-spi
> +
> +examples:
> +  - |
> +    concentrator0: lora@0 {
> +      compatible = "semtech,sx1301";
> +      reg = <0>;
> +      reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
> +      spi-max-frequency = <8000000>;
> +
> +      radio-spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        radio0: lora@0 {
> +          compatible = "semtech,sx1257";
> +          reg = <0>;
> +        };
> +
> +        radio1: lora@1 {
> +          compatible = "semtech,sx1257";
> +          reg = <1>;
> +        };
> +      };
> +    };
> -- 
> 2.17.1
> 
