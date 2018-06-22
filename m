Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AB824619
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AB824619
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeFVQxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:53:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33581 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeFVQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:53:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6896C203B0; Fri, 22 Jun 2018 18:53:44 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9283020DC1;
        Fri, 22 Jun 2018 18:53:10 +0200 (CEST)
Date:   Fri, 22 Jun 2018 18:53:09 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/5] dt-binding: mtd: denali_dt: document clock
 property
Message-ID: <20180622185309.3eef3383@bbrezillon>
In-Reply-To: <1529683598-25783-4-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
        <1529683598-25783-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 01:06:36 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit 30f9f2fb7ba0 ("mtd: denali: add a DT driver") supported the
> clock enablement, but did not document it in the DT binding.
> 
> In addition to the existing clock, this commit adds more clocks based
> on the IP specification.
> 
> According to the Denali User's Guide, this IP needs three clocks:
> 
>  - clk: controller core clock
> 
>  - clk_x: bus interface clock
> 
>  - ecc_clk: clock at which ECC circuitry is run
> 
> The driver should accept the current single clock for the backward
> compatibility, but the DT binding should represent the real hardware,
> and future platforms must follow this.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> 
> Changes in v4:
>   - split into a separate patch
> 
> 
>  Documentation/devicetree/bindings/mtd/denali-nand.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> index 0ee8edb..f33da87 100644
> --- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> @@ -8,6 +8,9 @@ Required properties:
>    - reg : should contain registers location and length for data and reg.
>    - reg-names: Should contain the reg names "nand_data" and "denali_reg"
>    - interrupts : The interrupt number.
> +  - clocks: should contain phandle of the controller core clock, the bus
> +    interface clock, and the ECC circuit clock.
> +  - clock-names: should contain "nand", "nand_x", "ecc"
>  
>  Optional properties:
>    - nand-ecc-step-size: see nand.txt for details.  If present, the value must be
> @@ -31,5 +34,7 @@ nand: nand@ff900000 {
>  	compatible = "altr,socfpga-denali-nand";
>  	reg = <0xff900000 0x20>, <0xffb80000 0x1000>;
>  	reg-names = "nand_data", "denali_reg";
> +	clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
> +	clock-names = "nand", "nand_x", "ecc";
>  	interrupts = <0 144 4>;
>  };

