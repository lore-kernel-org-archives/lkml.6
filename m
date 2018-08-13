Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A83C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AAE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AAE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeHMVmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:42:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35144 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeHMVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:42:01 -0400
Received: by mail-it0-f65.google.com with SMTP id 139-v6so15716014itf.0;
        Mon, 13 Aug 2018 11:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXFZPFsQxi2b90JOi4z4hcsFfMnZ/H6g/J1Zgk0O934=;
        b=GmQzIMvJ1txqT/Y7j1E2d+16EDrj21BqT7JxoVN2/pS6nXmhodbJJav1yxYWQJ6A2i
         8Jzs2hg+06yIYr3CjgJN5P/Hw2oQWpJnly3affBZu9CDWox4soq7z0d5q+y5bk/xcPJv
         lLX6A3XUkgwl6ijv54mgN95R1iaAnNMyNYBmabEKMyuR1TtNxm25EqOTAM2mkSQD4EYd
         IRTWPd+3KqLsBLl5IXPDiydoB5I85nyGYGyrzlEP7k8U/yJtdE15XkNbPvX7Ge5GyiAv
         fW6OJFisXqivgRH4BOsZdmAL/lYQ/rqfc352YI3hdGlF6zUKPv7P3INZuWmn0ntdDcLr
         rIuw==
X-Gm-Message-State: AOUpUlHO0SZ6w3iaLABfUm4RsrCbgGEzaIlLZ2B4Z8hijrOcKTcg0UTF
        YqvSZnlIG3SDIvXa7CjmGA==
X-Google-Smtp-Source: AA+uWPzAzIgi+EimhacLpyqlKzDjI6U0kcfS6CTg/AVtxCan3RZOWq2X830PmKJbL5UIZRybm7T3mg==
X-Received: by 2002:a02:b4a4:: with SMTP id k33-v6mr15644308jaj.53.1534186712110;
        Mon, 13 Aug 2018 11:58:32 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w64-v6sm2164032ita.7.2018.08.13.11.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:58:31 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:58:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com, mark.rutland@arm.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        arnd@arndb.de, wsa@the-dreams.de,
        andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com,
        cedric.madianga@gmail.com, baolin.wang@spreadtrum.com,
        jarkko.nikula@linux.intel.com, hdegoede@redhat.com,
        rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org,
        thor.thayer@linux.intel.com, geert@linux-m68k.org,
        heikki.krogerus@linux.intel.com, tglx@linutronix.de,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: i2c: npcm7xx: add binding for i2c
 controller
Message-ID: <20180813185830.GA18453@rob-hp-laptop>
References: <20180807110709.31847-1-tali.perry1@gmail.com>
 <20180807110709.31847-2-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807110709.31847-2-tali.perry1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:07:08PM +0300, Tali Perry wrote:
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
> This module also includes a slave mode, which will be submitted later on.
> 
> Any feedback would be appreciated.  
> 
> v2 -> v1:
> 	- run check patch in strict mode.
> 	- use linux crc.
> 	- define regs in constant offset without base.
> 	- remove debug prints.
> 	- no declerations for local functions.
> 	
> v1: initial version
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
>  .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 27 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> new file mode 100644
> index 000000000000..e2ee45d7a41e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> @@ -0,0 +1,27 @@
> +Nuvoton NPCM7XX I2C bus
> +
> +The NPCM750x includes sixteen I2C busses
> +
> +Required properties:
> +- compatible      : must be "nuvoton,npcm750-i2c-bus"

Is 'bus' how the datasheet calls it? If not, I'd drop the '-bus' part as 
it is really a controller.

> +- reg             : Offset and length of the register set for the device.
> +- interrupts      : Contain the I2C interrupt with flags for falling edge.
> +- clocks          : phandle of I2C reference clock.
> +
> +Optional:
> +- bus-frequency   : Contain the I2C bus frequency,
> +			the default I2C bus frequency is 100000.
> +- pinctrl-0       : must be <&smbX_pins>, X is module number
> +			(on NPCM7XX it's 0 to 15)
> +- pinctrl-names   : should be set to "default"
> +Example:
> +
> +	i2c0: i2c-bus@80000 {

Should be 'i2c@80000'

> +		compatible = "nuvoton,npcm750-i2c-bus";
> +		reg = <0x80000 0x1000>;
> +		clocks = <&clk NPCM7XX_CLK_APB2>;
> +		bus-frequency = <100000>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&smb0_pins>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 192d7f73fd01..13bac916d21d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1244,6 +1244,14 @@ F:	drivers/i2c/busses/i2c-aspeed.c
>  F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
>  F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>  
> +ARM/NUVOTON I2C DRIVER
> +M:	Tali Perry <tali.perry1@gmail.com>
> +L:	linux-i2c@vger.kernel.org
> +L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/i2c/busses/i2c-npcm7xx.c
> +F:	Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> +
>  ARM/ASPEED MACHINE SUPPORT
>  M:	Joel Stanley <joel@jms.id.au>
>  R:	Andrew Jeffery <andrew@aj.id.au>
> -- 
> 2.14.1
> 
