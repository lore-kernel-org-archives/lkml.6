Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F70DECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4420831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E4420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJYIhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:37:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35538 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:37:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id 22-v6so5626109oiz.2;
        Wed, 24 Oct 2018 17:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OkZ7rWkGOhN1LDCNYnYrhnsdWqyBuJgrBIJEhDcSQOs=;
        b=n+lk5Y3ZJvba9EJL0Cg1dSy4rzYZhEl+OxAh9vHMYy5RL4/o/hYetjHhXdoEeAC5hl
         rrkHWB+D19FfjJIcvjrwRBhkOyxecB0gqjw7hb4XYqnX8U7fnANcrUQcEvDMdg5wrxEC
         drFBd41CHYQDs/t4u/WRx0AGMwxasvFt5BZpW6pZnWKof25Z0UzU5BhePIJXtIDhWuUk
         ZDdYrPnaJ0JNxWEoOlTJuznHYz/w2OQolAdb9fhSNCGmLkk/wKOY9p+lxGGeLJh35v1x
         v0gK7fuMioqLGEo7gvaKwI+aCobRm0xrssg8x1/mx6ol53MuewHYkA+k2JfMR+Nz1j5+
         qP/A==
X-Gm-Message-State: AGRZ1gL7zqvQ6dDKzWxUBsRhVM/3DNL4tTXm57wQp+37WgwKms2DfPuV
        fcqADEqGJfK9XfyEcpPpyg==
X-Google-Smtp-Source: AJdET5fHgjm0pbWiQBmbUwowNhcDSHyBqwJfubUR7BLF3O5gFptQB5r+nzxTqFFtGh9V/zS1ThDQUg==
X-Received: by 2002:aca:5c3:: with SMTP id 186-v6mr2713557oif.185.1540426020504;
        Wed, 24 Oct 2018 17:07:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e75-v6sm1352282oih.41.2018.10.24.17.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 17:06:59 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:06:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Van Asbroeck <svendev@arcx.com>
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
Message-ID: <20181025000658.GA26048@bogus>
References: <20181024142456.10084-1-svendev@arcx.com>
 <20181024142456.10084-3-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024142456.10084-3-svendev@arcx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:24:54AM -0400, Sven Van Asbroeck wrote:
> This patch adds devicetree binding documentation for the
> Arcx anybus bridge.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../bindings/mfd/arcx,anybus-bridge.txt       | 37 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> new file mode 100644
> index 000000000000..3c0399c4ed45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> @@ -0,0 +1,37 @@
> +* Arcx anybus bridge
> +
> +This chip communicates with the SoC over the WEIM bus. It is
> +expected that its Device Tree node is specified as the child of a node
> +corresponding to the WEIM bus used for communication.

By WEIM you are referring to i.MX external parallel bus? Presumably this 
can work on any parallel bus, not just i.MX.

> +
> +Required properties:
> +
> +  - compatible : The following chip-specific string:
> +        "arcx,anybus-bridge"

No version or part number?

> +
> +  - reg :
> +	weim memory area where the cpld registers are located,	followed by:
> +	weim memory area of the first  anybus-s slot,		followed by:
> +	weim memory area of the second anybus-s slot.
> +
> +  - enable-gpios : the gpio connected to the bridge's 'enable gpio'.
> +
> +  - pwms : the pwm connected to the bridge's 'pwm input'.
> +
> +  - irq-gpios : the gpios connected to the bridge's interrupt lines.
> +	note that there is no need to provide the 'interrupts' property here.

Why not? This should not be base on what the OS currently happens to 
support.

What are the functions of each line? The order must be defined.

> +
> +Example of usage:
> +
> +&weim {
> +	bridge@0,0 {
> +		compatible = "arcx,anybus-bridge";
> +		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
> +		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> +				0x00000000 0xa0000240 0x00000000>;
> +		enable-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm3 0 571>;
> +		irq-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>,
> +					<&gpio1 5 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc512e746..1bf07b20a8af 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -35,6 +35,7 @@ aptina	Aptina Imaging
>  arasan	Arasan Chip Systems
>  archermind ArcherMind Technology (Nanjing) Co., Ltd.
>  arctic	Arctic Sand
> +arcx	Arcx/Archronix Inc.
>  aries	Aries Embedded GmbH
>  arm	ARM Ltd.
>  armadeus	ARMadeus Systems SARL
> -- 
> 2.17.1
> 
