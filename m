Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AAB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBgbbkJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVUgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:36:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfAVUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:36:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so28965544wrw.5;
        Tue, 22 Jan 2019 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jwHJoW4ME9CQP02zwm7KcPUs0g3IDmkfJllJgJY5Dco=;
        b=iBgbbkJsF74yKgMzXMOwGl/s/aRkFenlW8DNlQjOWp5F7NsGSOppRWdteY1wA7zBKS
         AUhX9OfWgUdNQ/BDV4P71opfHXizdqrBegSmT3sKl7f0Vozrk2KQ3BYSXlrhEcLpxcgA
         IfUiEUxkSdRaYxy4V9fMmYHduv6Elei6u6cqSvdSj3yGQryBVYtdUQpJk67kirpeBa8+
         hWaWA57FzWv/E8jZ+sxGz9HSoBqJg81C4Hi42jY7LY/Yls8VCv/+e0ph84mTpAE6cX9t
         A14a1/9bji8OTrdPG1AsCx8fWoOwSCOFWVtKWQbJX1NQt/7+7Ne15eA/3yQ+5pykypBO
         j6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwHJoW4ME9CQP02zwm7KcPUs0g3IDmkfJllJgJY5Dco=;
        b=WfTb3ts9v4KxiwQzuMdAwY0/Hiir3w6D9lKao5MlKwdY1WM8puG6vlsRf/Gj78Izp1
         2bU8O6N5YFyfFrZfwrV4aeoQmDt/SWz+bl8S+RhZyudVNnDbktAn6z3zklfS813huzBM
         g7twSKke87RptgW2pRmjH68FDDy9jkc1vyhRoKwryw3ngKNluSAieqYYzlQ1L6cDaR1V
         hjvR94Q5g/dBgA1R67jk+FHbnU6X74Jcu7fMCznAAjj9kphXr/CP/ES2oBjjtM+L3qy+
         UwXZOpykBlUAP9CcXaCE2sYPhBh+crJP3sHOE7McxLDJGJDqRsvf1zAQUxrCfNnZtad0
         P5Cw==
X-Gm-Message-State: AJcUukfgzjSmV39X5N1eIcl3ZPP0P3ZuLkYn+9eGtZfC00Go94M5octs
        C/zf9iRNvHi0CIKleKGwsoLLUdfNFFEFlA==
X-Google-Smtp-Source: ALg8bN6j8uKWHjuhimAqlHaFmhTCX0VWquYZP4lhPoQhyJGLGn5fWmtUTDjtaReBZazLi77CFnj9QA==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr35334373wru.152.1548189379584;
        Tue, 22 Jan 2019 12:36:19 -0800 (PST)
Received: from [192.168.1.69] (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id y1sm69913818wme.1.2019.01.22.12.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 12:36:18 -0800 (PST)
Subject: Re: [PATCH v2 lora-next 1/4] dt-bindings: lora: sx130x: add basic
 documentation
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-lpwan@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
References: <20190122180729.1834-1-ben.whitten@lairdtech.com>
 <20190122180729.1834-2-ben.whitten@lairdtech.com>
 <CAL_JsqJK_UN1pqce-VxJ=gog9OMoz9nUZ6XeQD9jJf+3aLBaUA@mail.gmail.com>
From:   Ben Whitten <ben.whitten@gmail.com>
Message-ID: <60e26fa6-079d-5380-f139-e177c4012e33@gmail.com>
Date:   Tue, 22 Jan 2019 20:36:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJK_UN1pqce-VxJ=gog9OMoz9nUZ6XeQD9jJf+3aLBaUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/01/2019 20:04, Rob Herring wrote:
> On Tue, Jan 22, 2019 at 12:07 PM Ben Whitten <ben.whitten@gmail.com> wrote:
>>
>> From: Ben Whitten <ben.whitten@gmail.com>
>>
>> Add basic documentation in YAML format for the SX130x series concentrators
>> from Semtech.
>> Required is; the location on the SPI bus and the compatible string.
>>
>> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
>> ---
>> v1 -> v2:
>> * Dropped reset-gpios, radio-spi from required.
>> * Dropped spi-max-frequency from binding.
>> * Changed compatible to allow fallback from SX1308 to SX1301.
>> * Wording changes in commit and descriptions.
>> * Dual licence
>> * Incorperate Robs comments on child node and spi wrapper
>> ---
>>   .../bindings/net/lora/semtech,sx130x.yaml     | 96 +++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
>> new file mode 100644
>> index 000000000000..41919fb67ec4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/lora/semtech,sx130x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Semtech LoRa concentrator
>> +
>> +maintainers:
>> +  - Andreas Färber <afaerber@suse.de>
>> +  - Ben Whitten <ben.whitten@gmail.com>
>> +
>> +description: |
>> +  Semtech LoRa concentrator SX130x digital baseband chip is capable of
>> +  demodulating LoRa signals on 8 channels simultaneously.
>> +
>> +  It is typically paired with two SX125x IQ radios controlled over an
>> +  SPI directly from the concentrator.
>> +
>> +  The concentrator itself is controlled over SPI.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +        - semtech,sx1308
>> +      - enum:
>> +        - semtech,sx1301
> 
> I think you want:
> 
> oneOf:
>    - items:
>        - enum:
>            - semtech,sx1308
>        - const: semtech,sx1301
>    - items:
>        - const: semtech,sx1301
> 
> That covers these 2 cases:
> "semtech,sx1308", "semtech,sx1301"
> "semtech,sx1301"
> 

Ah yes, that is what I was after. Thanks!

>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: The chip select on the SPI bus.
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description: A connection of the reset gpio line.
>> +
>> +  radio-spi:
>> +    type: object
>> +    description: The concentrator can have two radios connected which are
>> +      contained within the following node.
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^[a-zA-Z0-9]@[0-1]$":
> 
> Is any node name allowed? We like to have generic names. 'lora' is
> fine for me, but I'm don't know if other devices could be attached?
> 

This sub bus will only have IQ radios attached to it, perhaps 'radio@0'
as the system can handle other modulations.

> I thought up to 8 concentrators was supported? Or channels and radios
> aren't 1-1?

You can have multiple concentrator chips (SX130x) however each one may 
have up to two IQ radios (SX125x) attached to its bus.
And in terms of channels the system can listen on, the concentrator has 
9 LoRa demodulators and 1 (G)FSK demodulator.

> 
> This too should have 'type: object' since it is a node name.
> 

Ah yes

>> +        properties:
>> +          reg:
>> +            maxItems: 1
> 
> You can add:
> minimum: 0
> maximum: 1 (or 7?)
> 
>> +        required:
>> +          - reg
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    spi {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      concentrator0: lora@0 {
>> +        compatible = "semtech,sx1301";
>> +        reg = <0>;
>> +        reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
>> +        spi-max-frequency = <8000000>;
>> +
>> +        radio-spi {
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          radio0: lora@0 {
>> +            compatible = "semtech,sx1257";
>> +            reg = <0>;
>> +          };
>> +
>> +          radio1: lora@1 {
>> +            compatible = "semtech,sx1257";
>> +            reg = <1>;
>> +          };
>> +        };
>> +      };
>> +    };
>> --
>> 2.17.1
>>

Thanks!
Ben Whitten
