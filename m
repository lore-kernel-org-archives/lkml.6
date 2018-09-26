Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B745C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0712151C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0712151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeIZW0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:26:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35924 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeIZW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:26:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so2408533edq.3;
        Wed, 26 Sep 2018 09:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ChEcBb039jVtC914zvslNwtK7ESMBLs9q6cxVUKWf4=;
        b=Z6zw8Xkb+xz+GsIFzTPePi/CnRuV9SzRnU882boKxRrrsTaX+ZkfntMeaDwOpH7yhI
         AoRQH56a3VxqEBzEQla3GrE8/K6tShvNajZOgSKtsXXUg/zpAQ15Biy0xc1yGTjz71F5
         UKPYAME6beydF8Paqq3PwG0TRJwHEXd+BsgFN6XAIbYgNT7iL7AFpVWc6ViuT63KhTxx
         FjdUAgzse2PQ6AYeARsqE9VN+qQIvl2jkMJcZgqgwFalygLh/uIGFS0+o9MCrt4itGXA
         EE0GlC4YcLJiwg6sPoGEnoXXRc+C0+1KnvxD9jigr6bKxB/bMPB80cjeFRKNXiHmdlq3
         GtrQ==
X-Gm-Message-State: ABuFfoicHeKCIGNEq49ZC50vZcQuowv2HW3fz1hPpdnLoRqWK/+qEz8/
        ENCt21AFi3CN0Z0k2ISmLfg=
X-Google-Smtp-Source: ACcGV60rirz9dBRXbB1ePKAf+Ya+l5J8XdJpkpJlrgRqSZ/bvGrQzqvkn5wehlZGFQx5iURninyLlw==
X-Received: by 2002:a50:908d:: with SMTP id c13-v6mr10931896eda.179.1537978385235;
        Wed, 26 Sep 2018 09:13:05 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id i19-v6sm8909843edg.64.2018.09.26.09.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 09:13:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:13:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add CD and WP pins to Odroid XU SD card
Message-ID: <20180926161302.GA10041@kozik-lap>
References: <CGME20180921210332epcas3p423aaeeb84ec3d8a44c5a898949f992e8@epcas3p4.samsung.com>
 <20180921210321.12404-1-krzk@kernel.org>
 <20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:04:52PM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-09-21 23:03, Krzysztof Kozlowski wrote:
> > Defining card-detect and write-protect GPIO pins in Odroid XU SD Card
> > does not change anything from functional point of view - dw-mmc driver
> > was reading the state from registers.  Adding cd-gpios and wp-gpios
> > properties changes only internal driver behavior to access the pins
> > directly.
> >
> > Add them to DTS only to comprehensively describe the hardware.  Minor
> > benefit is that write-protect pin configuration makes sure that it will
> > be properly pulled up to indicate write access.
> >
> > This also removes debug messages:
> >      dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> >      dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > index a2046f5f998c..dae360f29a47 100644
> > --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > @@ -525,12 +525,14 @@
> >   
> >   &mmc_2 {
> >   	status = "okay";
> > +	wp-gpios = <&gpm5 0 GPIO_ACTIVE_LOW>;
> > +	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> >   	card-detect-delay = <200>;
> >   	samsung,dw-mshc-ciu-div = <3>;
> >   	samsung,dw-mshc-sdr-timing = <0 4>;
> >   	samsung,dw-mshc-ddr-timing = <0 2>;
> >   	pinctrl-names = "default";
> > -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;
> 
> IMHO there is no point adding cd-gpios property if CD line is already 
> assigned to this device via respective pin ctrl entry (as special function).
> 
> Handling of WP line is even more controversial imho. Ideally the drivers 
> or mmc core should check somehow if WP line is available or not and act 
> respectively. WP line is not available on uSD card connector so there is 
> no point describing it.

Thanks for comments. In that case I'll add only the pin configuration to
be sure that pin stays pulled up.

Best regards,
Krzysztof

> 
> >   	bus-width = <4>;
> >   	cap-sd-highspeed;
> >   	vmmc-supply = <&ldo21_reg>;
> > @@ -573,6 +575,14 @@
> >   		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> >   		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> >   	};
> > +
> > +	sd2_wp: sd2-wp {
> > +		samsung,pins = "gpm5-0";
> > +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +		/* Pin is floating so pull it up to disable write-protect */
> > +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +	};
> >   };
> >   
> >   &pwm {
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
