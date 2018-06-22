Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21FB2434E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yT2qNQ/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21FB2434E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeFVOiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:38:14 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:25165 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:38:12 -0400
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5MEc2ON005045;
        Fri, 22 Jun 2018 23:38:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5MEc2ON005045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529678283;
        bh=w5saxrNzFJQtqbuk85wK/rxKz9ReAIeeNbGSxwsl0zU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yT2qNQ/7SLGHhG2Jshn3kGWxE8vRF4FzA5CCWup6UA+GjiFamMB3E+jdyx+h6e8V6
         6fP+0+3qhceEFaJiTWc5b6Jz98kQOy0REr6iqe+7wOWmC1Y1SkSfdHEc86GRlm0h6b
         NWjlDuIlYbOILPKgbbbxxN3Q+y74s0du1fcC91avH0IOqeXfcERFyqIa302YtMGitU
         nRhGrRqGqukRlrXXXlhvOAwXLhG0Ao0T2Yo1U9E0iYNFLWGyoZr3X3djvB4i2JgQS2
         eDKGR73LR+78ZLjVBj4GT1GAm/ArG8/UE0RH5/qQLMKjEAHg4JK9S2jxC+2fvf77L/
         HFCmqM1f2rFug==
X-Nifty-SrcIP: [209.85.217.171]
Received: by mail-ua0-f171.google.com with SMTP id l11-v6so4421758uak.7;
        Fri, 22 Jun 2018 07:38:03 -0700 (PDT)
X-Gm-Message-State: APt69E2na/epoLmXu/4IvFlyP9vQW89lqQVhEkUvnVr8Wzu316d9zHJQ
        CzYaLxgLh5kBBhGRQzs2uFNQOBrdgU8lNpbI78A=
X-Google-Smtp-Source: ADUXVKJMoPrxhGirwtcudyVuvanXV4Njqnp2D7SlpMy1gyVijAvReQd9UKuNS03zaTTa1wCYkDp/KEkkx6slHcsMoRo=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr1220901uae.140.1529678282248;
 Fri, 22 Jun 2018 07:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 07:37:21
 -0700 (PDT)
In-Reply-To: <20180619120719.26921-1-richard@nod.at>
References: <20180619120719.26921-1-richard@nod.at>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Jun 2018 23:37:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
Message-ID: <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Richard Weinberger <richard@nod.at>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,


2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
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
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 486d4e7433ed..562f7b375bbd 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -754,7 +754,8 @@
>                         reg-names = "nand_data", "denali_reg";
>                         interrupts = <0x0 0x90 0x4>;
>                         dma-mask = <0xffffffff>;
> -                       clocks = <&nand_clk>;
> +                       clocks = <&nand_clk>, <&nand_x_clk>;
> +                       clock-names = "nand", "nand_x";


IMHO, this should be

                          clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
                          clock-names = "nand", "nand_x", "ecc";



A clock consumer (Denali in this case) should generally
take the same number of clocks across SoCs.

It is just some SoCs tie clocks together.

It is the case for my UniPhier platform;
"nand_x" and "ecc" are tied up because they are both 200MHz.


SOCFPGA supports HW ECC correction, thus it surely needs ecc clock.


>                         status = "disabled";
>                 };
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
