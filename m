Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDFC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DCC21721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548101517;
	bh=WLymUVExhd7IuVTlxHOqmfNZyh2qzU1wJipyefQNB2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCL28ao949thclTXVMQ3dZDiv6frGDFdOdlMVWgeU9aH3Yii+/gIfgcQhHxZDZnra
	 XCm5UYr3JcMzCTHB2+h6Aq1ZQnarqzuJFS/KD5QXn5tMFPt321VO0oHoHKpcv4re4X
	 d49QODYIfH7IjF28xH801ZhGVQM6bKi2CYNm9L48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAUULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:11:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35071 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfAUULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:11:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so21660946otj.2;
        Mon, 21 Jan 2019 12:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OX4oH04F9XnZ4XhGjG/Tb+3tcPifCjDXDkzAcZNGN30=;
        b=ETpDXtXRfhjdkSP93yFf7UIQApsr8PL8/TA5yzOCEIACYlhdKhd5cLNzUpRZHqqCfq
         l8yC2P7GGw32lkvKIpVNVeuzj7m0E7ONrCSTzVoujSg3qK2trqLjnQpTckx9S5KTbU4a
         f2Y0YH+7d0KTUvuZvuWf5vZ6ReQFj64IzwhM9J1/2tfHNroNauIXwJ5w/4zQXHCWa8Zx
         3N8UC+8s5ozNFz2FQ++naMh8RUINLDmnceKQdp+HSUhc9hswyN7KKbfNeXXnB1sFVwV5
         Z2GWrmGMb98oJgM9VFqrW1IjS3biWVpJ8MPm5IhNafM2H3z6wx78BhQtmvVpdbNtS1Ze
         0VDw==
X-Gm-Message-State: AJcUukefJuAGwsXRDqI4tYyN6UUdL62aNW7G0gf9TpBbOF7T6KMm4k12
        2HUo9TpTePxkk14SrdREmg==
X-Google-Smtp-Source: ALg8bN5MVaGC60AbaXKqsfw0ZbQRoUA3pa3/0ncU+BPPMhsFSjBFFg1LTX4bfEeAGglBb5rlY+Jn7w==
X-Received: by 2002:a9d:6c3:: with SMTP id 61mr21786933otx.314.1548101514174;
        Mon, 21 Jan 2019 12:11:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm6185694oil.15.2019.01.21.12.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 12:11:53 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:11:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-lpwan@lists.infradead.org, afaerber@suse.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
Message-ID: <20190121201152.GA2512@bogus>
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
> +    description: The concentrator has two radios connected which are contained
> +      within the following node.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
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

One more comment. Make sure you "build" the schema with 
'dt_binding_check' target. That builds the examples.

It is also checked by a CI job and the status is added to patchwork[1]. 
(Though it didn't work correctly for this one and I just fixed it.)

> +    concentrator0: lora@0 {

This example doesn't build because there's an expectation of the top 
level nodes being MMIO if there's a reg prop. You just need to wrap this 
in a parent node representing a spi controller:

spi {
  #address-cells = <1>;
  #size-cells = <0>;

  ...

};

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

[1] https://patchwork.ozlabs.org/patch/1021773/
