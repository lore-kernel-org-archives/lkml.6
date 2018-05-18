Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-371457-1526679664-2-17518316531719378333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526679663; b=fcxiSj5iyOfm3OfINx/eTXM9DhoQc97rwfWx8ofo778m01a65d
    Q/7uM54U/clP06qxg7373Uy3kuZ3WQEglKaG2PwGGbsIerpYwiyAJFTBzd0BpBGs
    m4hNvjrEq9h0fveXGmqtdnLlAZWj4OmzJ1d1+5HfBDHkd2q0o0sNz4lgEsycsE8I
    l7JWC1/NyzRPLJ7P5N3HMCU4735snMu4f4IxPuCcB+VXatuxpQ0QYTC5eFY7l3bm
    fE/c439s6Pm47k7F8S1cXr98WN/79JGnRIjb2MylxAuKFFnWRF48v42z6XEvs1ud
    AWrOfykMCIO3SqRK2q1Ix9gXWxHRC5LgoR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526679663; bh=Lit36LDvHSCxFwl3QjYPgzRZ7sJuU2
    oPS7Lf5CpeaV4=; b=hzez50RGulBSXtImzMJR3GCABKkfZbKtNGfXo1we3C0Ust
    usznC5aZj9tbx7uzgiJiunlO2kobvImzNihg6yBb6aZEN+Aen42QOEF0LqLypuKl
    raftT+EDZt4Bh0gdJeVRmljb+xe12WLWIFT+8kVICytreaAoqVvq4wzuJO1Cb9EE
    YmnncL2D2lkxmC8qgVnS1udkwAQ6i6usov8Q6xY/RJvfiwnOTAuDz3iLQ/6J+ahs
    hwbdwqub2wwK1i0vhspJR+l5NoHK+ye7rpPapzsJ1dgK4kMLtENE9WZ9WA56LLdh
    YsESBgAWeuZ+BEx8cABygm53ZnBj/TwnBeMLQIqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=iFqE/nuf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=iFqE/nuf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHA+L06TvYPmXJwPEu7n5bNdjSHD1koxoIV4poDzMA0to4NaIOYJzinWwyA5BG0MMjxsqhxoxIwMuGvTs9ge0BntkXI1MaVaFiQFnBGHo55T3LfjMs4W
    o32hY7n3+EREVbBZN/eTm+XWEZ5Uc+Lg+gZBc7Zwpk0aqwr3BiywMWXe1cxinZXXDJcYr8+AX8ogb78YrcEk6zC/PU7cRj6u97F6OWqHNMiPEwk4mzflGRdv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=R7ptlpefyDX00AopJQ8A:9
    a=eD8sEPeXBktnyS60:21 a=uK5gg3l22tip6Tfl:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeERVlA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 17:41:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40558 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeERVkx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 May 2018 17:40:53 -0400
X-Google-Smtp-Source: AB8JxZqjjlM2fUv6SdIWeJmXphTOcFmhTs7aMw6VC99pxeh6/JGLZyPTXa2kiv6aXUH51ftcHkYsUw==
Date: Fri, 18 May 2018 16:40:51 -0500
From: Rob Herring <robh@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, broonie@kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: add binding for at91-usart in spi
 mode
Message-ID: <20180518214051.GA29868@rob-hp-laptop>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-5-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511103822.31698-5-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 01:38:20PM +0300, Radu Pirea wrote:
> These are bindings for at91-usart IP in spi spi mode. There is no support for

s/spi spi/SPI/

> internal chip select. Only kind of chip selects available are gpio chip

GPIO

> selects.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/spi/microchip,at91-usart-spi.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> new file mode 100644
> index 000000000000..b68a3bec4121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

So now we have 2 copies of the same thing that varies by 2 properties?
Please make this one doc.

> @@ -0,0 +1,28 @@
> +* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
> +
> +Required properties:
> +- #size-cells      : Must be <0>
> +- #address-cells   : Must be <1>
> +- compatible: Should be "atmel,at91rm9200-usart" or "atmel,at91sam9260-usart"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- clocks: phandles to input clocks.
> +- clock-names: tuple listing input clock names.
> +	Required elements: "usart"
> +- cs-gpios: chipselects (internal cs not supported)
> +- at91,usart-mode: AT91_USART_MODE_SPI (found in dt-bindings/mfd/at91-usart.h)

at91 is not a vendor.


> +
> +Example:
> +	#include <dt-bindings/mfd/at91-usart.h>
> +
> +	spi0: spi@f001c000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
> +		at91,usart-mode = <AT91_USART_MODE_SPI>;
> +		reg = <0xf001c000 0x100>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&usart0_clk>;
> +		clock-names = "usart";
> +		cs-gpios = <&pioB 3 0>;
> +	};
> -- 
> 2.17.0
> 
