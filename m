Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FAEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEE020823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayav77qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfBFSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:18:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41391 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfBFSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:18:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id k15so3451746pls.8;
        Wed, 06 Feb 2019 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=me2gjw3P61qxjC7bEgmrE4tWQ9BLlID7ukLXYPFmxK8=;
        b=ayav77qm9C5/OFQmnSOrpNc2thE6d4SAWsnL89ExH6wfqQlPEgqSjmso8IIlLf6kTn
         9HFg5RaoFGWfuHANTXOwOQej01oVJyTvCsInRZppVlFmx/EPbtTQ1CoKCaVsUkhi75jn
         MTqK7JoT70Bd/yT8ZKMI1mJssp++3tV7TQkp7rNnTaTIv6meC3qHiDIaXu6kqfHcwdQB
         a3R3yQZtWHxmbCPNIjEppIGi9DEbfV6R2IANjXZj7JYhSP3Yk69+vD91nt1g02owzXSZ
         blItQFKekZAmalOb3SlR6z3EARfVYOGCFNk5bxGroXIVJ1I+FWNnz9Jj5VPIjAQRBByq
         d93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=me2gjw3P61qxjC7bEgmrE4tWQ9BLlID7ukLXYPFmxK8=;
        b=I/6dXGiQtsPE/yXKr4+L8hsTMOnwYz6X5fxoQ5L8qnVhUNipNzSWjepDO4yJXgohkl
         ZjV1UUn1CynQfShxjaMkax7fNLhu7U+PtSa4pDb0a0qvlinZAhY/9uQuRA6VyEgvrIST
         hPGrj7zDzEWPy1XuaeebSkQ4YbPZitygPtKRB2OTuMZfQMyw9ZhvzPIAdLHfF9ciZefR
         XC4kFjt6yrdPSu9P+LnX05Xt/DQikEkZ4C+egzN4sCYNXs2RGLdKGxx0cAXtV+o0+jy4
         MaNyA95zyt1qQq2BR8SKCj2C/MMmjH6ptl7v+Dh+OhFS8iACe6hYLs0PxlB3CaaF0NQ6
         bA6w==
X-Gm-Message-State: AHQUAubrpSUMwStPrHCr0pKLzQkygZv0zPL8zXlsFBgB+1a5PDNlxs88
        oT8mz4z0IdQbSksX19v4nmM=
X-Google-Smtp-Source: AHgI3IYXiysPLVHD3xnJwVqWU96hgv2SI7yneIlL6/QOP0lpoNho8LRJhOAhM9Mm2dLVFOW7QmzjmQ==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr11807733pld.147.1549477104399;
        Wed, 06 Feb 2019 10:18:24 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s9sm8461180pgl.88.2019.02.06.10.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:18:23 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:18:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: msm8974-hammerhead: add device
 tree bindings for vibrator
Message-ID: <20190206181822.GB174258@dtor-ws>
References: <20190206013329.18195-1-masneyb@onstation.org>
 <20190206013329.18195-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206013329.18195-4-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:33:29PM -0500, Brian Masney wrote:
> This patch adds device device tree bindings for the vibrator found on
> the LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

This should go through Qualcomm tree with the other bindings?

> ---
> Changes since v3:
> - None
> 
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index b3b04736a159..1fd9f429f34a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
>  
>  / {
>  	model = "LGE MSM 8974 HAMMERHEAD";
> @@ -306,6 +307,36 @@
>  				input-enable;
>  			};
>  		};
> +
> +		vibrator_pin: vibrator {
> +			pwm {
> +				pins = "gpio27";
> +				function = "gp1_clk";
> +
> +				drive-strength = <6>;
> +				bias-disable;
> +			};
> +
> +			enable {
> +				pins = "gpio60";
> +				function = "gpio";
> +			};
> +		};
> +	};
> +
> +	vibrator@fd8c3450 {
> +		compatible = "qcom,msm8974-vibrator";
> +		reg = <0xfd8c3450 0x400>;
> +
> +		vcc-supply = <&pm8941_l19>;
> +
> +		clocks = <&mmcc CAMSS_GP1_CLK>;
> +		clock-names = "pwm";
> +
> +		enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vibrator_pin>;
>  	};
>  
>  	sdhci@f9824900 {
> -- 
> 2.17.2
> 

-- 
Dmitry
