Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85D0218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawMuRX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfAXPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:03:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36847 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:03:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so5526989ljk.3;
        Thu, 24 Jan 2019 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O22bUm5jDHn7PG91NSWCT+/PGgDa8Sd/8pbGVjGcmuA=;
        b=KawMuRX9TD+ftxNlFMz+HRr+WvRmiT0tNe/zSVmWOL/38pKUQmuOsusSeChdC1Sy+H
         PPsiVOuUraVAX6mEPbC5RToOq2Yg+0fZeBPapUGb8sVkO4CP7c2XlJh/nPN4srt6cPT1
         Lzi9QK7afI9QUKYYsGW0y7aCDrqKIPsSO7s4F6Q/qUb8ntWb1Z/fpCNIDkrcbX/fUAKx
         0kU2GYoxo7FDaD9BJtDTfqf1hQ2UxAyCy63FpiARQ0oxBkW30P5+kypD7xw22ilQZ/zR
         K4oMtPPlxNn8dwDKaqu2rLmgb/wtCvVaDf3S3Xm8J6GKBoaRrjhD0RU44fU9ExRzx5rV
         s6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O22bUm5jDHn7PG91NSWCT+/PGgDa8Sd/8pbGVjGcmuA=;
        b=sAmRksFeRUEVRfptnbOnMviO2m3TtQnt7nfVhakv8u7lhdKCAx4cEFq5mgo4dY7ndo
         LS3aJI5c9gITgoOaMITSZFEXfyDLmIhNTpMbLSoFhYxuH0eaDlRFXui8ABbwkDCUIHDd
         eNK3LzaS1JFx0mFyPhpe0Uk/onXvNsh0Tmv1OsKVeWFLrNBgmH44BjUy0NlRIAS336NN
         xNXpEw8VvDMXmCYKkujHNmb+4OlkDIr9py7lgPaXgfxEv4QogSwY4IVmjFR2p+WeLvIg
         9dhT/eiKf7oSqpIdHWqqxkB/rykhL1b+yNmOdEqYe1uPVvQ9AUtslzEeXiEcRVMM9a1f
         4cBg==
X-Gm-Message-State: AJcUukeDR+QFuRJa9AP6S/s9e3LZItNHbzCeCRrI9m/4DpfVyTmqNfgh
        vL9PCiDCjCuB9vJ+4XzZZsjXx8pyjY873u0tV/w=
X-Google-Smtp-Source: ALg8bN5aU7zvLd9SitvbQqyX9kikPzBUQrGBCFgAlAC9DJKPIyybo/V/1iB9x/8w1k/J8Azogopo1Mxi3YlOl7w7NrE=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr5793210ljg.150.1548342215461;
 Thu, 24 Jan 2019 07:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-2-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-2-ben.whitten@lairdtech.com>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Thu, 24 Jan 2019 15:03:24 +0000
Message-ID: <CAF3==itV0RbEcUGM4b1hQYOOg5hddh9x+=SUiWaPuxYQPsgtQw@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 1/4] dt-bindings: lora: sx130x: add basic documentation
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-lpwan@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed linux-lpwan
On Thu, 24 Jan 2019 at 14:53, Ben Whitten <ben.whitten@gmail.com> wrote:
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
> v2 -> v3:
> * Corrected fallback notation
> * Limited radio node names from anything to 'radio@'
> v1 -> v2:
> * Dropped reset-gpios, radio-spi from required.
> * Dropped spi-max-frequency from binding.
> * Changed compatible to allow fallback from SX1308 to SX1301.
> * Wording changes in commit and descriptions.
> * Dual licence
> * Incorperate Robs comments on child node and spi wrapper
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml     | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx=
130x.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.ya=
ml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> new file mode 100644
> index 000000000000..24fad1218735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> @@ -0,0 +1,101 @@
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
> +    oneOf:
> +      - items:
> +        - enum:
> +          - semtech,sx1308
> +        - const: semtech,sx1301
> +      - items:
> +        - const: semtech,sx1301
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
> +      "^radio@[0-1]$":
> +        type: object
> +        properties:
> +          reg:
> +            maxItems: 1
> +            minimum: 0
> +            maximum: 1
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
> +          radio0: radio@0 {
> +            compatible =3D "semtech,sx1257";
> +            reg =3D <0>;
> +          };
> +
> +          radio1: radio@1 {
> +            compatible =3D "semtech,sx1257";
> +            reg =3D <1>;
> +          };
> +        };
> +      };
> +    };
> --
> 2.17.1
>
