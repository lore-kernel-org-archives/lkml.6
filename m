Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CADDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06864206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvmzZ2LJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAER7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:59:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41566 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfAER7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:59:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so18875564plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2WFsovOrz+XQlVmJQCbgrpLMlA6JmvTuuh4sSWJ7pQ0=;
        b=hvmzZ2LJqw3bR89HTHMAK0bPKd/sw2rXx2OsjqdoHOuEUxmWFVNivb60ZwVZmOC0hJ
         ZvNMc/P0YhHoylDpsK4WMhEKsYHnDO8VFj5qCG4kTGwIrwcERDfsYND8GE1rIycHTtGA
         hS/ibBePuvFxxDq46TlqSUlYs2kK/4v0VgcqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2WFsovOrz+XQlVmJQCbgrpLMlA6JmvTuuh4sSWJ7pQ0=;
        b=PurVdd3lsTqmm6jRM+g0efe6I4OyxvjW6SrI1yDdW61JBemXFhC4MjuORibitQMkBl
         u2eefm3w1Foj+q+HYmYUtmWrVrR0PFdeBcjISBzNfopwd0twPHD7AytLXeJwZpAnKhHd
         poDNP0C/REUd7H6tT9Z8b0JhGeHjj9rOqTib5QiJexhya6Bp+NDbrnXijTGAr+BWEQ5s
         Gh1KL88xZv4ZKs0oH+RX8RhvCtN4ZjiYOX77BptUG6B4s6lbrPS9MAONvascaaRbwHPp
         WaoErgqwR/9WDxMSG8aaa9b2arJDZqRGx7n6aGM+tiu5I+ozpvSg/a1USIuFJ0HPGIRi
         MKIw==
X-Gm-Message-State: AJcUukdEwqwyi8ykN/IoEgFFy+rZpUQBqMGBPb1wdUd9ZbuML9DzDP7e
        UkUpA+1RIgDg1OhPmVImw+Z9
X-Google-Smtp-Source: ALg8bN6M7WPTCYcxgJJBLW0VgK8nR4RIPpoQLUdMWoknq81QqOp8+/t//wZf/FTkuhvwb0hZnY+1ow==
X-Received: by 2002:a17:902:b90b:: with SMTP id bf11mr54668212plb.284.1546711152661;
        Sat, 05 Jan 2019 09:59:12 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730c:d904:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id e65sm111842360pfc.74.2019.01.05.09.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 09:59:12 -0800 (PST)
Date:   Sat, 5 Jan 2019 23:29:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable
 I2C0 and I2C1
Message-ID: <20190105175904.GB32306@Mani-XPS-13-9360>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-5-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-5-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:04:48AM +0100, Parthiban Nallathambi wrote:
> Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
> Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Applied to dt-next branch where I have been collecting patches for
Andreas.

Thanks,
Mani

> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 28f3f4a0f7f0..63e375cd9eb4 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -30,6 +30,59 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &timer {
>  	clocks = <&hosc>;
>  };
> -- 
> 2.17.2
> 
