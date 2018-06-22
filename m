Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62603C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ECF24553
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ECF24553
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934149AbeFVP66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:58:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46592 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeFVP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:58:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9C76C60A04A1;
        Fri, 22 Jun 2018 17:58:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G8T62eDZgH1K; Fri, 22 Jun 2018 17:58:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3E14E609B29C;
        Fri, 22 Jun 2018 17:58:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1B7r3tT6uhxy; Fri, 22 Jun 2018 17:58:54 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 148076093352;
        Fri, 22 Jun 2018 17:58:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
Date:   Fri, 22 Jun 2018 17:58:46 +0200
Message-ID: <3320422.EJ8D6C0VHL@blindfold>
In-Reply-To: <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
References: <20180619120719.26921-1-richard@nod.at> <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,

Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:
> Hi Richard,
> 
> 
> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
> > The denali NAND flash controller needs at least two clocks to operate,
> > nand_clk and nand_x_clk.
> > Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
> > setup_data_interface()") nand_x_clk is used to derive timing settings.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
> > is not present on this SoC.
> > But my SoCFPGA knowledge is very limited.
> >
> > Thanks,
> > //richard
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index 486d4e7433ed..562f7b375bbd 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -754,7 +754,8 @@
> >                         reg-names = "nand_data", "denali_reg";
> >                         interrupts = <0x0 0x90 0x4>;
> >                         dma-mask = <0xffffffff>;
> > -                       clocks = <&nand_clk>;
> > +                       clocks = <&nand_clk>, <&nand_x_clk>;
> > +                       clock-names = "nand", "nand_x";
> 
> 
> IMHO, this should be
> 
>                           clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
>                           clock-names = "nand", "nand_x", "ecc";
> 
> 
> 
> A clock consumer (Denali in this case) should generally
> take the same number of clocks across SoCs.
> 
> It is just some SoCs tie clocks together.
> 
> It is the case for my UniPhier platform;
> "nand_x" and "ecc" are tied up because they are both 200MHz.
> 
> 
> SOCFPGA supports HW ECC correction, thus it surely needs ecc clock.

Good point!

Thanks,
//richard
