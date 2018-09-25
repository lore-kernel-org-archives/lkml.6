Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00006C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC762089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HVQ7TdES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC762089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeIZCtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:49:24 -0400
Received: from onstation.org ([52.200.56.107]:40784 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIZCtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:49:24 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3547C187;
        Tue, 25 Sep 2018 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1537908003;
        bh=He2qgyQ6jArtAQF/EaYfO5yScHcJaeHccU2RuA0AqII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVQ7TdESWmXKfOBx/i2B2OEuPTDXm5qDzqBSLfz4vKXiHB16+ZmmucJm32SvijbMu
         xCzGYFBcpg2p85ckXs0kwp7nVWBVGhGJPyG8GOE3j3QEY4wofcBNSo3by6LsGxKiT8
         L9uQjO4BF7IHKrvYTjt4xueI9YuQW3YQlWxlvHgk=
Date:   Tue, 25 Sep 2018 16:40:02 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk
Subject: Re: [PATCH 1/3] dt-bindings: pwm: msm-vibrator: new bindings for MSM
 vibrator driver
Message-ID: <20180925204002.upoxfm5udmepgz4e@232b6f9c30d0>
References: <20180919150912.8948-1-masneyb@onstation.org>
 <20180919150912.8948-2-masneyb@onstation.org>
 <5baa1af9.1c69fb81.73ad9.3bd5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baa1af9.1c69fb81.73ad9.3bd5@mx.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Sep 24, 2018 at 03:01:11PM -0700, Rob Herring wrote:
> On Wed, Sep 19, 2018 at 11:09:10AM -0400, Brian Masney wrote:
> > This patch adds the device tree bindings for the pwm-msm-vibrator.c
> > driver that supports the vibrator found on various Qualcomm MSM SOCs.
> 
> Bindings are for h/w, not some driver.

OK, I will fix this and the other references in v2.

> > +Required properties:
> > +
> > +  - compatible: Should be one of
> > +		"qcom,msm8226-pwm-vibrator"
> > +		"qcom,msm8974-pwm-vibrator"
> 
> The block only works for a vibrator?

Yes.

I cannot find a publicly-available datasheet for the MSM8974 to see if
there are other uses for this particular PWM available. The only thing
that I have to work with right now is the downstream Android sources at
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c.

> > +  - reg: the base address and length of the IO memory for the registers.
> > +  - #pwm-cells: set to 3.
> > +  - pinctrl-names: set to default.
> > +  - pinctrl-0: phandles pointing to pin configuration nodes. See
> > +               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > +  - clock-names: set to pwm
> > +  - clocks: phandle of the clock used by the PWM module. See
> > +            Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +  - enable-gpios: GPIO that enables the vibrator.
> 
> Shouldn't this go in the vibrator node as it is connected to the 
> vibrator.

This should be labeled "GPIO that enables the PWM".

Brian


> > +
> > +Optional properties:
> > +
> > +  - vcc-supply: phandle to the regulator that provides power to the sensor.
> > +
> > +Example from a LG Nexus 5 (hammerhead) phone:
> > +
> > +msm_pwm_vibrator_enable: msm_pwm_vibrator@fd8c3450 {
> 
> pwm@...
> 
> > +	reg = <0xfd8c3450 0x400>;
> > +	compatible = "qcom,msm8974-pwm-vibrator";
> > +	#pwm-cells = <3>;
> > +
> > +	vcc-supply = <&pm8941_l19>;
> > +
> > +	clocks = <&mmcc CAMSS_GP1_CLK>;
> > +	clock-names = "pwm";
> > +
> > +	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&vibrator_pin>;
> > +};
> > -- 
> > 2.17.1
> > 
