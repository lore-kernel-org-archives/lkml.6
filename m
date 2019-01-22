Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA068C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19B7217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548187466;
	bh=koJJaclCQXIF7ABw4OggJQsEhP4spKzRESafbMwrurs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=azY9RjeCw7hhQbXsCyzNBqh5wTWwqoX0U80kjmP17cmjq1oqOcqi27I6PX3h4+oaf
	 TzsKBylFueGP5RnD6XRtZ3KX1J/idWghMwVs0wONZQq/lzI7wKHxrrvHtKPG3IylYR
	 RqLjOGBdvKC2E/sgS9NHMpKPEM1JfcCsm97zPegU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAVUEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfAVUEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:04:24 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22F62184A;
        Tue, 22 Jan 2019 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548187463;
        bh=koJJaclCQXIF7ABw4OggJQsEhP4spKzRESafbMwrurs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Grs+XzWwCNiOC2hscKzxx/HNwh2CUaS187t1RzwCkGTQqwBaUMcGgK6UMSG1hqE3B
         tqgZ1h1KmArSbmtBCAT2mxFxTLqWH+4Sz5qsu0sG9Fy88Fw9XBdtm4nlXGLWtp7Y6b
         cLr3uiiPYYiQvncrgXBtW6kUHb7FdKSon/BOwXuE=
Received: by mail-qt1-f173.google.com with SMTP id v11so29164996qtc.2;
        Tue, 22 Jan 2019 12:04:22 -0800 (PST)
X-Gm-Message-State: AJcUukfg8pB/r62HMdnFYRQBMXzF/oVaNlp+44O36OTwIwZjs06tm8BU
        gy+SQYZaD4+MtpO6MIEcjgGeEsVYGS9smaAAxA==
X-Google-Smtp-Source: ALg8bN5uvpFmef3QYPZQeu3IST67In4wX0IZ5WUWOAT6e1IP6xNnnHC9IiiZT6afr0lXJQHNtjqgeZk2dxlCQppuQ5Y=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr32259869qtj.76.1548187462082;
 Tue, 22 Jan 2019 12:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20190122180729.1834-1-ben.whitten@lairdtech.com> <20190122180729.1834-2-ben.whitten@lairdtech.com>
In-Reply-To: <20190122180729.1834-2-ben.whitten@lairdtech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Jan 2019 14:04:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJK_UN1pqce-VxJ=gog9OMoz9nUZ6XeQD9jJf+3aLBaUA@mail.gmail.com>
Message-ID: <CAL_JsqJK_UN1pqce-VxJ=gog9OMoz9nUZ6XeQD9jJf+3aLBaUA@mail.gmail.com>
Subject: Re: [PATCH v2 lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-lpwan@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:07 PM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> Add basic documentation in YAML format for the SX130x series concentrator=
s
> from Semtech.
> Required is; the location on the SPI bus and the compatible string.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v1 -> v2:
> * Dropped reset-gpios, radio-spi from required.
> * Dropped spi-max-frequency from binding.
> * Changed compatible to allow fallback from SX1308 to SX1301.
> * Wording changes in commit and descriptions.
> * Dual licence
> * Incorperate Robs comments on child node and spi wrapper
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx=
130x.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.ya=
ml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> new file mode 100644
> index 000000000000..41919fb67ec4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/lora/semtech,sx130x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech LoRa concentrator
> +
> +maintainers:
> +  - Andreas F=C3=A4rber <afaerber@suse.de>
> +  - Ben Whitten <ben.whitten@gmail.com>
> +
> +description: |
> +  Semtech LoRa concentrator SX130x digital baseband chip is capable of
> +  demodulating LoRa signals on 8 channels simultaneously.
> +
> +  It is typically paired with two SX125x IQ radios controlled over an
> +  SPI directly from the concentrator.
> +
> +  The concentrator itself is controlled over SPI.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - semtech,sx1308
> +      - enum:
> +        - semtech,sx1301

I think you want:

oneOf:
  - items:
      - enum:
          - semtech,sx1308
      - const: semtech,sx1301
  - items:
      - const: semtech,sx1301

That covers these 2 cases:
"semtech,sx1308", "semtech,sx1301"
"semtech,sx1301"

> +
> +  reg:
> +    maxItems: 1
> +    description: The chip select on the SPI bus.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: A connection of the reset gpio line.
> +
> +  radio-spi:
> +    type: object
> +    description: The concentrator can have two radios connected which ar=
e
> +      contained within the following node.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^[a-zA-Z0-9]@[0-1]$":

Is any node name allowed? We like to have generic names. 'lora' is
fine for me, but I'm don't know if other devices could be attached?

I thought up to 8 concentrators was supported? Or channels and radios
aren't 1-1?

This too should have 'type: object' since it is a node name.

> +        properties:
> +          reg:
> +            maxItems: 1

You can add:
minimum: 0
maximum: 1 (or 7?)

> +        required:
> +          - reg
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      concentrator0: lora@0 {
> +        compatible =3D "semtech,sx1301";
> +        reg =3D <0>;
> +        reset-gpios =3D <&pioB 27 GPIO_ACTIVE_HIGH>;
> +        spi-max-frequency =3D <8000000>;
> +
> +        radio-spi {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          radio0: lora@0 {
> +            compatible =3D "semtech,sx1257";
> +            reg =3D <0>;
> +          };
> +
> +          radio1: lora@1 {
> +            compatible =3D "semtech,sx1257";
> +            reg =3D <1>;
> +          };
> +        };
> +      };
> +    };
> --
> 2.17.1
>
