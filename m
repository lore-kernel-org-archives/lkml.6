Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B50C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D6D217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUHeix3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfBESNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:13:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33604 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBESNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:13:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1861068plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W94IvYw458qYovmkqSqKvaFGe/f53TsXtm50K08hs2U=;
        b=OUHeix3AEWtdFNoUfLWhfSAlEXLCRJECM/t9VRJ52IgqAdJcz5l0c4s+c0LAXl1qMC
         LLtoqxCpIIyS6tsNX7wTTpBJpONVdATWaskaUf5Mg34nSctZzA7rXOVFmdjEr9FBBln+
         /UqacuJuk6QcsCEwD/ovB0/YHEjCU2UKPTf/L2IIbfAm8rbBTrMB52h9+M1QwquPqOa6
         JWvLl5kME1Z+1T/I/fOI+hcRX/B0XA1HaoQM30oCL1uzpJsYYlWEbjZycVEI+wD7RRuQ
         GYCk2vZtViac24MTAGws5FeeXDBfoS82eF9xwD0us4ITMdtt75vRV6WKyQyMnwlcCACi
         16Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W94IvYw458qYovmkqSqKvaFGe/f53TsXtm50K08hs2U=;
        b=pBDzRB6rUQSKXE5UlxU43iO9/wz0a6j79D4ms3XI3AHhnNdZcI9QI5+L80wNJ9y6KH
         x7NVgaX7wv2N4KuJU2OQqE8WSl41mfVtI18wjc90ZuDUmVsCkJJ3U/qLuxcT8vO9FmCG
         cfEw6DOZhBlrExZmPRfTwfJl7+aTXO79+CfwU5rOfZK9EvfG9dnxGWA6A8WaGCZxfDSt
         vcpAviDV8Uc2nsoyjcrQTkbU+d9DUUklqG4iATkZbHXXUP0JD7b3DIjsrFpxqvchlxA2
         M0GqQCtqUMVV5EZbkivQ9aD/OY5hGQb7k4hJM/GkWy0DVNJ/5Qw04qZt/4rosMujIBb9
         9hvg==
X-Gm-Message-State: AHQUAuaGvHBCjXjBMIITktANq3MQMIr9AN1uRX+s8FQwsMf7V4ubhSKb
        4DS4zNp9FmnnNElhgSoBarO9kEPVQEo=
X-Google-Smtp-Source: AHgI3IYnhr0U3ti8s2qNQ+xODHqn285ilIiy6fbo2rxi3RiL80AGMyGygyxSbU2og7528UnJEBT9nw==
X-Received: by 2002:a17:902:e612:: with SMTP id cm18mr2846187plb.172.1549390411957;
        Tue, 05 Feb 2019 10:13:31 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a17sm5773224pgm.26.2019.02.05.10.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:13:30 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:13:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: Fix MSI IRQ type
Message-ID: <20190205181326.GA23363@builder>
References: <20190124130047.8071-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124130047.8071-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jan 05:00 PST 2019, Niklas Cassel wrote:

> The databook clearly states that the MSI IRQ (msi_ctrl_int) is a level
> triggered interrupt.
> 
> The msi_ctrl_int will be high for as long as any MSI status bit is set,
> thus the IRQ type should be set to IRQ_TYPE_LEVEL_HIGH, causing the
> IRQ handler to keep getting called, as long as any MSI status bit is set.
> 
> A git grep shows that ipq4019 is the only SoC using snps,dw-pcie that has
> configured this IRQ incorrectly.
> 
> Not having the correct IRQ type defined will cause us to lose interrupts,
> which in turn causes timeouts in the PCIe endpoint drivers.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Cc: stable@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 19635f91e2c4..48b3cb474ba0 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -398,7 +398,7 @@
>  			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
>  				  0x82000000 0 0x40300000 0x40300000 0 0x400000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
> -- 
> 2.20.1
> 
