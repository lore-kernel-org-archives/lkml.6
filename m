Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED4CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2520989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlpAoJ6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfA2UGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:06:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2UGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:06:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so23445104wrt.13;
        Tue, 29 Jan 2019 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XANxRdtzY0dA5UAtf3QTQ9gymCVFcqjr8kzMOWEcOxg=;
        b=YlpAoJ6SdAOdY9bONsy8TaFixN5ALxOxXNXR6FcZE+kjEfr8ydLcx/lnI75xG+XgSt
         O65pMPCEzKWkqJV8RGMG1ObIBPm22NEUGf2O5N3YIRRXp4b5Qyfn+vNgEoh/vvSGTuwD
         ujRgtW7HZ0TXZSuGZVBy8pEK2Az0eLl6825/uyGghH0xsoPASCISUX+PYVEitCHso+7H
         9ssqRwE8ldNSVfnxKuj2LhKZcSrTmyiFdpcHa/p2rSkEiU7iVLMkumubsoibMpqgka7U
         rkx8ZHAHgv83HhOaLiyQzF17k+cySJDOlWwujQtqvm8Z6lI+gcoxbH46sxMxGl76gLhd
         2VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XANxRdtzY0dA5UAtf3QTQ9gymCVFcqjr8kzMOWEcOxg=;
        b=pl3+xN+cffyWeugWjTwhQUh7rW2ltI1+b+IUHZZjyomEJnkcMjMQ6kJ/ScDvbdKWF/
         fmGsyUnyjM1J1embryGRn4EmKsX1sODRH6WVIuf5/HXKKYG4O0+JPbiOGM6IGr0BCsxv
         nKrsy3U5gmVCdfOTCdVGYc879a2a5S6f84hMVNrh2fdekQVHB5m4E77IabYRpqV3q7ow
         Nxzfe5vmP/kmm1dLGFhEXlRm1ER0Q2QzUHWHo65e+Zp9qy69vqM1qdtB1QkJwMlmC1af
         jK4RMxFk3BTR1AguU6SJdcP0mfchJG8EHy+wdvzmVJBLAwEb9FawKlaIQdklIVg8Uji0
         XaHQ==
X-Gm-Message-State: AJcUukenFf4azXaMyNqZGgEUi0vIKQKN3NzEJAV8e8ry5dbovpt3Pw4S
        nS49cfh5xr2z/0Gf6Q8StAY6OYDR
X-Google-Smtp-Source: ALg8bN68xAiwi3BcXmXZaAzlDeFctY56fZqvnHz8Vkg8RLZJ35gJJbmt0I2EAJTJeBb4HdynxWJaqw==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr25757692wrb.167.1548792363598;
        Tue, 29 Jan 2019 12:06:03 -0800 (PST)
Received: from ?IPv6:2a02:8071:6a3:700:e52b:4fa:c59b:a6af? ([2a02:8071:6a3:700:e52b:4fa:c59b:a6af])
        by smtp.gmail.com with ESMTPSA id z14sm84949505wrm.48.2019.01.29.12.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:06:03 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: socfpga: update more missing reset properties
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Simon Goldschmidt <goldsimon@gmx.de>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20190129194625.19218-1-goldsimon@gmx.de>
Message-ID: <d2080ae3-8bc9-1346-8ef6-3bba0274a425@gmail.com>
Date:   Tue, 29 Jan 2019 21:05:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129194625.19218-1-goldsimon@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.01.2019 um 20:46 schrieb Simon Goldschmidt:
> Add reset property for dma, can and sdram on socfpga gen5.
> 
> Signed-off-by: Simon Goldschmidt <goldsimon@gmx.de>

That should have been:
Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>

Regards,
Simon

> 
> ---
> This series applies on top of  kernel/git/dinguyen/linux.git,
> branch socfpga_for_next_v5.1_dts_v1
> 
>   arch/arm/boot/dts/socfpga.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index f365003f0..ec1966480 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -84,6 +84,7 @@
>   				#dma-requests = <32>;
>   				clocks = <&l4_main_clk>;
>   				clock-names = "apb_pclk";
> +				resets = <&rst DMA_RESET>;
>   			};
>   		};
>   
> @@ -100,6 +101,7 @@
>   			reg = <0xffc00000 0x1000>;
>   			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
>   			clocks = <&can0_clk>;
> +			resets = <&rst CAN0_RESET>;
>   			status = "disabled";
>   		};
>   
> @@ -108,6 +110,7 @@
>   			reg = <0xffc01000 0x1000>;
>   			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
>   			clocks = <&can1_clk>;
> +			resets = <&rst CAN1_RESET>;
>   			status = "disabled";
>   		};
>   
> @@ -791,6 +794,7 @@
>   		sdr: sdr@ffc25000 {
>   			compatible = "altr,sdr-ctl", "syscon";
>   			reg = <0xffc25000 0x1000>;
> +			resets = <&rst SDR_RESET>;
>   		};
>   
>   		sdramedac {
> 

