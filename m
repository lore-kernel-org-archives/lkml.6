Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA0EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E35020661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeHaQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:25:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40418 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeHaQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:25:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so1220745qkd.7;
        Fri, 31 Aug 2018 05:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uSrrw/nU2O9WQq8Wped+WhUmZqRBqHoSybXy1z+cCYc=;
        b=ahwCzcXNbv5x9iEQ/lEDQj2NIEfzq/aBR58/QXEBNaHd2H8NJZuK0GLD3zzQc9eTh7
         iCc13Nd3ZQyvpGxyOLuy54e8nNsUEP5XMO929ofL2d1KflF4SLIJqyo9U8tfcsgGK6Dy
         EG0IWvnKnlOfCIJWaWa8N7sBStrGqmJHbxj3EGUwPteYS0fMqqeTP2nK11N4vEw37505
         3FWbXKWQKAtxdI1mwgHuolqkTiecHINNer5T7+eTrAj/YGQoRSAs3eyz+g2N/R9zTqWD
         tVZixAshuh/cJXtsDTp4vI89OvLQwmrZhxEDFjzo9RZoCEFZDzgYHOvAfP6DR8xcKg4o
         GUpg==
X-Gm-Message-State: APzg51B44v3kDuleqJuL3qVi5+aRqz68+P/SVoERWcoPfMdgVAKmFguE
        zLmzMQg1SvugfmLIfZXC9Q==
X-Google-Smtp-Source: ANB0VdZR3j2QHUQHOMfvHxQ33Q08txP3EJlFN5BfhzhcFir08/xAlJiV3mKRG/wFj6Ghuf+XV0hnSg==
X-Received: by 2002:a37:c91b:: with SMTP id q27-v6mr15079453qki.191.1535717894467;
        Fri, 31 Aug 2018 05:18:14 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id c11-v6sm5509690qkb.22.2018.08.31.05.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:18:14 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:18:09 -0400
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Message-ID: <20180831121809.GA22507@bogus>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:38:52PM +0200, Michal Vokáč wrote:
> Output of the PWM block of i.MX SoCs is always zero volts when the block
> is disabled. This can caue issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle = 0% corresponds to solid high level
> on the output. If the PWM is dissabled its output instantly goes to solid
> zero which corresponds to duty cycle = 100%.
> 
> To have a trully inverted PWM output configure the PWM pad as a GPIO
> with pull-up. Then switch the pad to PWM output whenever non-zero
> duty cycle is needed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> index c61bdf8..3b1bc4c 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -14,6 +14,12 @@ See the clock consumer binding,
>  	Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
>  
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
> +  pin to gpio function.  It allows control over the pin output level when the
> +  PWM block is disabled. This is meant to be used if inverted polarity of the
> +  PWM signal is required. See "Inverted PWM output" section bellow.
> +
>  Example:
>  
>  pwm1: pwm@53fb4000 {
> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>  	clock-names = "ipg", "per";
>  	interrupts = <61>;
>  };
> +
> +Inverted PWM output
> +-------------------
> +
> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
> +output, the output level is always zero volts when the PWM block is disabled.
> +The zero output level is actively driven by the output stage of the PWM block
> +and can not be overridden by pull-up. It also does not matter what PWM polarity
> +a PWM client (e.g. backlight) requested.
> +
> +To gain control of the PWM output level in disabled state two pinctrl states
> +can be used. The "default" state and the "pwm" state. In the default state the
> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
> +is configured as a PWM output. This setup assures that the PWM output is at
> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
> +E.g. at boot.
> +
> +Example:
> +
> +&pwm1 {
> +	pinctrl-names = "default", "pwm";
> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
> +}
> +
> +pinctrl_backlight_gpio: pwm1grp-gpio {
> +	fsl,pins = <
> +		/* GPIO with 22kOhm pull-up */
> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008

There's a slight problem here if I remember the i.MX pin muxing. In GPIO 
mode, doesn't the GPIO block control the direction and level if an 
output. I guess as long as unused GPIOs are all initialized to inputs it 
will be okay.

Rob
