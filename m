Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B0FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6CA21536
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6CA21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeHOXX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:23:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42958 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeHOXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:23:59 -0400
Received: by mail-io0-f193.google.com with SMTP id n18-v6so2057096ioa.9;
        Wed, 15 Aug 2018 13:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IgQSkBxQZonxJguAA3ZV7mOYCPTJgHNP53D7dCfU8w=;
        b=YPpO5m+YXmywPc2DNzFCduNcyMoOtc/uq29Su+kfo7Kn22KEcLLiGTsy4kIjbLFaEJ
         CLf369hmPfaOmjfxBaolbkk6auhi+gh/Tgv7zHUwtSUTeTBOtZTLT/E7Grqy5GLlkq/i
         73E0bzOmBhqNy/DwmejbeQqeWhs0CpSmuLs29UwdlG/o2IMoqxRUM/sHwjGsHNBKpfaM
         Y+dDxsMtELIx6/oI5GesOlfCnelbVfrUD3kIzxc/AOH2Md05EBiSqVgrlTPmyG1T1Nhe
         f4ldkmrD5QuAk2krgk5aQOtU23mTij3BPLoS1qwEReLCCj/lhwcdT+LccTGSn73xGZ6c
         F+/g==
X-Gm-Message-State: AOUpUlFnZ6RmvLJuMQhHzcU50nAxjvZyK9kqaCpxXATqxAQH/sO0Zq8g
        hR8RKiymlkpQ9m5lg4ffHg==
X-Google-Smtp-Source: AA+uWPx9UOELM7aVqg/tu7YYr+Rf1r7NM1+HZUdtvo4H6NUjggPH9QiGHBoOe7MYr5/QIupHUzCdPw==
X-Received: by 2002:a6b:9e91:: with SMTP id h139-v6mr23322317ioe.185.1534365016505;
        Wed, 15 Aug 2018 13:30:16 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm18645481ioa.75.2018.08.15.13.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:30:15 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:30:15 -0600
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
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: npcm7xx: add binding for i2c
 controller
Message-ID: <20180815203015.GA19242@rob-hp-laptop>
References: <20180814182907.182139-1-tali.perry1@gmail.com>
 <20180814182907.182139-2-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814182907.182139-2-tali.perry1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 09:29:06PM +0300, Tali Perry wrote:
> 
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. This driver operates the controller.

s/contollers/controllers/

> This module also includes a slave mode, which will be submitted later on.
> 
> Any feedback would be appreciated.  
> 
> v3 -> v2:
> 	- fix dt binding: compatible name: ommit "bus"
> 
> v2 -> v1:
> 	- run check patch in strict mode.
> 	- use linux crc.
> 	- define regs in constant offset without base.
> 	- remove debug prints.
> 	- no declerations for local functions.
> 	
> v1: initial version

The version info normally goes below the '---' so it is not part of the 
commit msg.

> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
>  .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> new file mode 100644
> index 000000000000..2a474a2a5b3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> @@ -0,0 +1,29 @@
> +Nuvoton NPCM7XX I2C bus
> +
> +The NPCM750x includes sixteen I2C bus controllers. All Conterollers support

s/Conterollers/controllers/

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +both master and slave mode. Each controller has two 16 byte HW FIFO for TX and
> +RX.
> +
> +Required properties:
> +- compatible      : must be "nuvoton,npcm750-i2c"
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
> +	i2c0: i2c@80000 {
> +		compatible = "nuvoton,npcm750-i2c";
> +		reg = <0x80000 0x1000>;
> +		clocks = <&clk NPCM7XX_CLK_APB2>;
> +		bus-frequency = <100000>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&smb0_pins>;
> +	};
> -- 
> 2.14.1
> 
