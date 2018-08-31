Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45DD2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp56eKHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45DD2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIAC4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:56:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:56:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so6128615pfk.8;
        Fri, 31 Aug 2018 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7KhP0ZODw70hsC3cN0wmAKQGerc8f6gtdGCiOB9Ybs=;
        b=Gp56eKHdMOVwUGyYXPcbrhOgxbut7NJPlvQZoHLGsL0g7E1l8wG/zHYWNP/ZR7kDTN
         NS2C7JERs4TbPI2nS+0QQu8dI/WpLEyBSHOygVmcZhZA5whBJ19oCtCqkjH1Nmqf/eQ+
         uVgIwtg4nnt/fUq/Fv5gHCpcg19CLFI6tcDTBb0zhLAXMN92TFuyr6wa5qRoPgYT+4xd
         UHNUyjCPhkKpbNtEyerTDfS48N56pU6q264YyCDJB6T/FPSBuObKAOSSbsi6d/ZKp9/s
         vLMQ18ejKv6HMWsuRB7qAqnV+xgfWRhLH5uE+o0rp72lttRnp/WxgKEGuUo/hePhwDsV
         77Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7KhP0ZODw70hsC3cN0wmAKQGerc8f6gtdGCiOB9Ybs=;
        b=Xw9kr+9TncG7kvNw9tTDWYCv3XkmO7jxEjRe+RDzZ5S7/32gzoNgeClHxI9mNYduXG
         vVZQ8E0ipHGBkq3S2Tpl3M1YMnhc9EUxtSBJdpq6uRXxJkK3geDEPAaTVQca9cwRaal6
         SHBxHYXXRhZLfM8G2+JiM0F4acuwLt0sWmai/I7pe5dlwreFaqlFOrT15sys3PDxkA4O
         nfqwrOjXIUKxKn8e2zQxA7Bk+l84s0Tp8AuBkb0HyjpQ6L+C3gcB5EY7HHpHKmLUSlvp
         hwW+SepPR1ZBGmN//zwv0fCTa0bL2pwTmALvIGpDJmNaUhCJlEqwxzXTAGpjxcgg1CTf
         qhMQ==
X-Gm-Message-State: APzg51BwmqfizVpwHbO9qaXpDTdjaAIk3zYIn9U+IOv3KlQBswFG+YxS
        hcdhxpNqyjD9YeAZtltUd14=
X-Google-Smtp-Source: ANB0VdbqJ0fitfvMt1BZm8PDTlYpI+mpZMg6ARKB2rIPI7AtOZ9YI2xbJtFvq7BOrXifzHemtWRpkw==
X-Received: by 2002:a63:4e25:: with SMTP id c37-v6mr16209811pgb.6.1535755615408;
        Fri, 31 Aug 2018 15:46:55 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c85-v6sm23227782pfd.110.2018.08.31.15.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:46:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
To:     "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
Date:   Fri, 31 Aug 2018 15:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,


On 02/03/15 04:17, Ivan T. Ivanov wrote:
> Add SPMI PMIC Arbiter configuration nodes for APQ8084 and MSM8974.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 1f130bc..dbedf64 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -226,5 +226,21 @@
>  			clock-names = "core", "iface";
>  			status = "disabled";
>  		};
> +
> +		spmi_bus: spmi@fc4cf000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg-names = "core", "intr", "cnfg";
> +			reg = <0xfc4cf000 0x1000>,
> +			      <0xfc4cb000 0x1000>,
> +			      <0xfc4ca000 0x1000>;
> +			interrupt-names = "periph_irq";
> +			interrupts = <0 190 0>;> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index e265ec1..2d11641 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -247,5 +247,21 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		spmi_bus: spmi@fc4cf000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg-names = "core", "intr", "cnfg";
> +			reg = <0xfc4cf000 0x1000>,
> +			      <0xfc4cb000 0x1000>,
> +			      <0xfc4ca000 0x1000>;
> +			interrupt-names = "periph_irq";

> +			interrupts = <0 190 0>;

The final value in this interrupts property means IRQ_TYPE_NONE.

A WARN_ON() was added early this year to complain about use of
IRQ_TYPE_NONE: 83a86fbb5b56 "irqchip/gic: Loudly complain about
the use of IRQ_TYPE_NONE", resulting in many warnings spewing
forth when I boot an APQ8074 Dragonboard.  I am trying to
determine whether the warning is overly aggressive, or whether
the IRQ TYPE is incorrectly specified for the spmi node.

The interrupt-parent for the spmi node is intc: interrupt-controller@f9000000,
which has compatible = "qcom,msm-qgic2".  I do not know the architecture
or implementation of this interrupt controller.  Is an IRQ_TYPE_NONE
valid in this case, or should a specific type be provided?

Thanks!

-Frank


> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
>  	};
>  };
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

