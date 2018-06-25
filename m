Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E17C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C725BD3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7C725BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbeFYOzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:55:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55367 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934397AbeFYOzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:55:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7CE27203D9; Mon, 25 Jun 2018 16:55:16 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B01B20834;
        Mon, 25 Jun 2018 16:55:06 +0200 (CEST)
Date:   Mon, 25 Jun 2018 16:55:06 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek =?UTF-8?B?VmHFoXV0?= <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
Message-ID: <20180625165506.484e025f@bbrezillon>
In-Reply-To: <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
References: <20180619120719.26921-1-richard@nod.at>
        <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
        <3320422.EJ8D6C0VHL@blindfold>
        <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 09:50:18 -0500
Dinh Nguyen <dinguyen@kernel.org> wrote:

> On 06/22/2018 10:58 AM, Richard Weinberger wrote:
> > Masahiro,
> > 
> > Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:  
> >> Hi Richard,
> >>
> >>
> >> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:  
> >>> The denali NAND flash controller needs at least two clocks to operate,
> >>> nand_clk and nand_x_clk.
> >>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
> >>> setup_data_interface()") nand_x_clk is used to derive timing settings.
> >>>
> >>> Signed-off-by: Richard Weinberger <richard@nod.at>
> >>> ---
> >>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
> >>> is not present on this SoC.
> >>> But my SoCFPGA knowledge is very limited.
> >>>
> >>> Thanks,
> >>> //richard
> >>> ---
> >>>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> >>> index 486d4e7433ed..562f7b375bbd 100644
> >>> --- a/arch/arm/boot/dts/socfpga.dtsi
> >>> +++ b/arch/arm/boot/dts/socfpga.dtsi
> >>> @@ -754,7 +754,8 @@
> >>>                         reg-names = "nand_data", "denali_reg";
> >>>                         interrupts = <0x0 0x90 0x4>;
> >>>                         dma-mask = <0xffffffff>;
> >>> -                       clocks = <&nand_clk>;
> >>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
> >>> +                       clock-names = "nand", "nand_x";  
> >>
> >>
> >> IMHO, this should be
> >>
> >>                           clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
> >>                           clock-names = "nand", "nand_x", "ecc";  
> 
> No, it should be just the nand_x and ecc.
> 
> There's already a patch to use the nand_x_clk and not the nand_clk.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?h=socfpga_for_next_v4.19_fixes_v1&id=1709ab58eb79b19bceb2287d111bf1bd2df1cf6d

Hm, are you sure this is accurate? I might be wrong but I find it weird
that the denali NAND controller IP has been adapted by Xilinx to only
take one clk. Isn't that the same clk is feeding all clk inputs of the
denali block?
