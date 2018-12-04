Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB482082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB482082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLDXWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:22:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37328 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:22:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so16910178oth.4;
        Tue, 04 Dec 2018 15:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FAbEasdJLd9uvlN46AwjM1ksyg5eRKVQUx73eR+hOAE=;
        b=Pke02XxgoYpEosPJTPHyQuY6r4Y+E6Loj8gu6kZkauXG+SEhPDB70BTY/ye995DKuT
         0Udwt/2VMwTRGwdUIHtx8vCx4nz2cPRX8qsAa5MRYsVNiPRNjZHPNQdEW0CI5UiEoBSY
         M667pqx/B8B5AQEb8oc6gK//RFPaJcSItxVSPe7xuHtW+gxcbSAuy8ySTEGETQpF8Xkj
         yJfP9bUeSt22/dOGWEV14SURIIfhkFmikLDHt2aiezjw4bimzA0llJbujrmCJVGuzksb
         jQuEiE4P3NSzKQUjDlNiX+WiOpfxjrWsqiiua0C9gFJK37oFsANCr4mb+QQ4FWGJlyjs
         zPxA==
X-Gm-Message-State: AA+aEWZJwl9SNrAXrmiF4j0eGKhxGeCsnrhq7XStuuiSdgtrxRJxQg2i
        IbI+7Xz9VMGuREoZpcTg1A==
X-Google-Smtp-Source: AFSGD/W6Rnj0oMMeDpql9fV6OZPm8z+RN6y342jDYDbFMg/N82gO7kHfoPrfyfFhdRXcB9HBsEEK/A==
X-Received: by 2002:a9d:501:: with SMTP id 1mr14826969otw.133.1543965758757;
        Tue, 04 Dec 2018 15:22:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm7676946oib.52.2018.12.04.15.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:22:37 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:22:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        Nicolas.Ferre@microchip.com, mark.rutland@arm.com,
        Ludovic.Desroches@microchip.com, Cristian.Birsan@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Message-ID: <20181204232237.GA16883@bogus>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:08:36AM +0000, Andrei.Stefanescu@microchip.com wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the SAMA5D2 PIOBU GPIO.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  .../bindings/gpio/gpio-sama5d2-piobu.txt           | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> new file mode 100644
> index 0000000..2e260e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt

microchip,sama5d2-piobu.txt for the file name.

> @@ -0,0 +1,31 @@
> +GPIO controller for SAMA5D2 PIOBU pins.
> +
> +These pins have the property of not losing their voltage
> +during Backup/Self-refresh mode.
> +
> +These bindings should be set to a node in the dtsi file.
> +
> +Required properties:
> +- compatible:		"syscon", "microchip,sama5d2-piobu"

syscon should be removed.

> +- #gpio-cells:		There are 2. The pin number is the
> +			first, the second represents additional
> +			parameters such as GPIO_ACTIVE_HIGH/LOW.
> +- gpio-controller:	Marks the port as GPIO controller.
> +
> +Note that the driver uses syscon and should be the child of
> +the syscon node.

child of the "atmel,sama5d2-secumod" node to be more specific.

But why do you need a child node? The parent can be a gpio provider. 
What other nodes does this need?

> +
> +Example:
> +
> +	secumod@fc040000 {
> +		compatible = "atmel,sama5d2-secumod", "syscon", "simple-mfd";

This is not documented as being a simple-mfd.

> +		status = "okay";
> +		reg = <0xfc040000 0x100>;
> +
> +		pioBU: piobu {

gpio {

Is there not a register range you can put here?

> +			status = "okay";
> +			compatible = "microchip,sama5d2-piobu";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +	};
> -- 
> 2.7.4
> 
