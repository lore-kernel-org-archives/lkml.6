Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B3323C92
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U7Q9LIaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B3323C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeFZCjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:39:13 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36704 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965281AbeFZCjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:39:09 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5Q2d2p0017638;
        Tue, 26 Jun 2018 11:39:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5Q2d2p0017638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529980743;
        bh=+3SThStuenbMYTdh+CVRdC5wXFzQKsVaZcH56ZF2jRw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=U7Q9LIawFapIxx6NbHMWftTprer4BZtQB3ynSniLO1KhJ0iZCGFhDI8dv88BMOwgo
         /56MktB0usMFGmBHKagC6XA8ne1iemOa2XA425rpOAEBb+7RUTEnTBjYuO6Nzq617T
         zMhwdnnXiS05BcgYyDfXNr9ciqKN/y6MrIQ3jSSJ9vwQomrQKeucUzYYMYXDol2gW0
         i2e24NPLLKxtUWJKj/rVY1uTaChsXc5OwIbyIVljOZibqTfF5uPLmcgppKXuDCYA8R
         keUmZBDL8WAEmYF9qxxzxopPelM50PQnH5Ot/KDnY2D0rVhnjxkLHuvrvMdWc1JK4h
         q9V2GsRGLGbUA==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id a5-v6so9957980uao.8;
        Mon, 25 Jun 2018 19:39:02 -0700 (PDT)
X-Gm-Message-State: APt69E0g4/Z1j/bH3ZkzBNExV2WCHG/ThlmDq7tVy4/kcrzSH7M1u9AE
        ga4RwyqpHUEd3e5kL5tTVUgS9emX5h2yk+mmO+Y=
X-Google-Smtp-Source: ADUXVKJy4c/ndDULjC4RElN8saYhxBoBBcuDKORT5I5krs5J5MjWIsoes+sB1GKccuK3vD0wGs5lcqVoku+MyLUL8N8=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr9402189uae.140.1529980741685;
 Mon, 25 Jun 2018 19:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 19:38:21
 -0700 (PDT)
In-Reply-To: <20180625165506.484e025f@bbrezillon>
References: <20180619120719.26921-1-richard@nod.at> <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
 <3320422.EJ8D6C0VHL@blindfold> <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
 <20180625165506.484e025f@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Jun 2018 11:38:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyo+7gauyQcRmNfCs8CagU1XdpHHgREMeTvf4rqxpeNQ@mail.gmail.com>
Message-ID: <CAK7LNATyo+7gauyQcRmNfCs8CagU1XdpHHgREMeTvf4rqxpeNQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 23:55 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 25 Jun 2018 09:50:18 -0500
> Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>> On 06/22/2018 10:58 AM, Richard Weinberger wrote:
>> > Masahiro,
>> >
>> > Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:
>> >> Hi Richard,
>> >>
>> >>
>> >> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
>> >>> The denali NAND flash controller needs at least two clocks to operate,
>> >>> nand_clk and nand_x_clk.
>> >>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
>> >>> setup_data_interface()") nand_x_clk is used to derive timing settings.
>> >>>
>> >>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> >>> ---
>> >>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
>> >>> is not present on this SoC.
>> >>> But my SoCFPGA knowledge is very limited.
>> >>>
>> >>> Thanks,
>> >>> //richard
>> >>> ---
>> >>>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> >>> index 486d4e7433ed..562f7b375bbd 100644
>> >>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> >>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> >>> @@ -754,7 +754,8 @@
>> >>>                         reg-names = "nand_data", "denali_reg";
>> >>>                         interrupts = <0x0 0x90 0x4>;
>> >>>                         dma-mask = <0xffffffff>;
>> >>> -                       clocks = <&nand_clk>;
>> >>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
>> >>> +                       clock-names = "nand", "nand_x";
>> >>
>> >>
>> >> IMHO, this should be
>> >>
>> >>                           clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
>> >>                           clock-names = "nand", "nand_x", "ecc";
>>
>> No, it should be just the nand_x and ecc.
>>
>> There's already a patch to use the nand_x_clk and not the nand_clk.


Different people try to fix the problem in different ways.

I think it is due to miscommunication across sub-systems.


>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?h=socfpga_for_next_v4.19_fixes_v1&id=1709ab58eb79b19bceb2287d111bf1bd2df1cf6d


This does not break your board.
However, it is not helpful any more.

I already fix the Denali driver
to use the hard-coded clock frequency
if the old binding is used.


BTW, Marek issued Reviewed-by to this patch.



> Hm, are you sure this is accurate? I might be wrong but I find it weird
> that the denali NAND controller IP has been adapted by Xilinx to only

Xilinx?

Do you mean Altera (Intel)?


> take one clk. Isn't that the same clk is feeding all clk inputs of the
> denali block?




-- 
Best Regards
Masahiro Yamada
