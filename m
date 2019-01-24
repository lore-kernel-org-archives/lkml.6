Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C0C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A4321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq9ww657"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfAXKff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:35:35 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40915 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfAXKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:35:33 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so3648171ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DxbJL4ZzcPGmo3x32HRFW7MZrbBGNIu7eISt3vQRymM=;
        b=Tq9ww657YOwU12AEbCe37UjZ4NLzUL24vEbQxQrQ6o++y+pyJvRiFIUUYDsdrUB6fp
         /4wt8YoVZ+GcxepKy/eOukDXHRve4ys1xTW+8Es8wSLuXpgCDQLiP3n87Qe49GhK2Nhn
         4IU7VIMUpQC5gbf6Ww1QJG97CNsU1ZumhGAsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxbJL4ZzcPGmo3x32HRFW7MZrbBGNIu7eISt3vQRymM=;
        b=Qk2irBuLZ4PJ68vFHOTOHMXApy9oi86vqw1gp6hsDsvgwTc2SmJI7Ob4wNGY/OgeSX
         eJFyb7V+gzEAGt8SC5vhOb2QfmP0odR4MfowklKzKFFnpVTc/0vTK5QjRJcFlo2oUvvu
         Emc0PXYonW2ZTMqU+SslrUlCsbPGlYXVvTqQEqSJXuiQFDelEbQvhc5+xI7ddfVD+sOu
         zQkDKT+aLY9nM/GnyiLBP8fSn/Ym1zGA2F7UcEceXhTN2LTZaMde+q8ZtXugetkXKwaw
         sSIeKhB2mRZjbJ4mAmvBYWMYGSTzDTLQF9dc9btli5TNYBr+/S/aPKCWi8f/DJ8VD8tW
         nwWQ==
X-Gm-Message-State: AJcUukd0ilTFmcvnD+Sx5OoHQ17wDUbvM6+oKuJNTuUTBiIsF8f86O81
        nW3/xjm4dFINb0TX9NA/kkUOUoDdoA==
X-Google-Smtp-Source: ALg8bN4OtsPTuqWnMQqX6ejMX/LeJMhDLMZBstV0CXMlDbTm/au6/Yh7KxfKb8oUh8HtDx4S+X/n5w==
X-Received: by 2002:a24:55d4:: with SMTP id e203mr1008435itb.36.1548326132324;
        Thu, 24 Jan 2019 02:35:32 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73c6:b855:b411:39cd:c90d:867f])
        by smtp.gmail.com with ESMTPSA id y8sm10626613ita.5.2019.01.24.02.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 02:35:31 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:05:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH][RESEND] arm64: dts: hikey: Add DMA entries for Bluetooth
 UART
Message-ID: <20190124103523.GA20854@Mani-XPS-13-9360>
References: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:30:37PM -0800, John Stultz wrote:
> Add dma0 references for bluetooth uart to enable dma
> for bt transfers.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index aec9e37..fa15a08 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -319,6 +319,8 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
> +			dmas = <&dma0 8 &dma0 9>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  
> -- 
> 2.7.4
> 
