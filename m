Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB850C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D8E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHGAgywN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D8E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeFTEwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:52:24 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39762 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTEwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:52:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id w12-v6so885213pgc.6;
        Tue, 19 Jun 2018 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rTayoUHFQPk74yrRHiIaVn1oiigtaccSv3voJecule8=;
        b=ZHGAgywNkjXCHOHl9aGzFcvNbcGD0zYCG6RvTeWMvg81tHKKue0WAAxuYzCsF6IhDT
         A9w6JuJG1/zgclPNeDGaDeFcq8BlzcDL7gf59w3nD9qrVmApcsmOfhfHp6lU0yeosGzZ
         Jsptiy+lbDTBbCJufkop3FyWuUXp11fRLqpT/4q0SEm90hvc/JRiayBpD6onfeaI03Ny
         aV1Q6d66gaM/T/uLaMGK7HJzJHwcIwAM5FftzvT0lGje//jjzMEvgzgq3G7Y+VlC7b0X
         YDnnFbFx8ScNEtlIFkShHZ2fayV3xwrAr1kX+kAMbALAzpadZu/2TJc4FRdaHhswUObH
         YgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTayoUHFQPk74yrRHiIaVn1oiigtaccSv3voJecule8=;
        b=QZzjcFXnLdvoDmXVteYp45vyTB9OTCeZOfg0pHPLVpA2zza8n+00IdwZqBFkCPDM7d
         mWDUebIz8AjAd5msTLaEHJwHcLq6bdxPj8IzdEqnHPevza6i6aKj2CFIR1pMSpKe2aIh
         Au3O0NUwYyrdE/835Kl8SgYJ+EifY+blSETXyL+BUVYahIMjYuF5PRLO09eKchunD8Zz
         c91SJLF6WmGoiilVM4FIzPasN9vOZwrabaV9jRXzGa0qTQvIXS2l3q0okFsz3dEU8cbz
         Umo/2wDXY9kmy8GgA1pJp4uTpN/wrJB7f6GGLi4+1Xqvs4d5R05RneJNkZrv3h9SzNi1
         Qs7g==
X-Gm-Message-State: APt69E3LEr8wlwwXdIJxrVtfUv1a+H9FUEPmUtLxTUjRs8R4sLrid6fr
        V4I5thwql8kOOt87TftJ/M8=
X-Google-Smtp-Source: ADUXVKLtnorE8pbtIg8SBA5ZjL3AoAEjHdWvgb4Rp5YT52mJpi7NJvlOdiit6In/JxoXEr5Xj46qnQ==
X-Received: by 2002:a62:4715:: with SMTP id u21-v6mr21079778pfa.89.1529470341654;
        Tue, 19 Jun 2018 21:52:21 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.79])
        by smtp.gmail.com with ESMTPSA id s5-v6sm512963pgo.65.2018.06.19.21.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 21:52:20 -0700 (PDT)
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        yamada.masahiro@socionext.com,
        "See, Chin Liang" <chin.liang.see@intel.com>
References: <20180619120719.26921-1-richard@nod.at>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ba7b5ee8-c9f0-45a1-67ec-3d1f510f6c24@gmail.com>
Date:   Wed, 20 Jun 2018 06:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619120719.26921-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 02:07 PM, Richard Weinberger wrote:
> The denali NAND flash controller needs at least two clocks to operate,
> nand_clk and nand_x_clk.
> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
> setup_data_interface()") nand_x_clk is used to derive timing settings.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
> is not present on this SoC.
> But my SoCFPGA knowledge is very limited.
> 
> Thanks,
> //richard

It looks sane, but I cannot test it right now, since I'm on vacation.
I hope Dinh/Chin can jump in.

> ---
>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 486d4e7433ed..562f7b375bbd 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -754,7 +754,8 @@
>  			reg-names = "nand_data", "denali_reg";
>  			interrupts = <0x0 0x90 0x4>;
>  			dma-mask = <0xffffffff>;
> -			clocks = <&nand_clk>;
> +			clocks = <&nand_clk>, <&nand_x_clk>;
> +			clock-names = "nand", "nand_x";
>  			status = "disabled";
>  		};
>  
> 


-- 
Best regards,
Marek Vasut
