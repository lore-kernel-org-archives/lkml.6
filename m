Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DCCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625E820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo2un52r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625E820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGXNWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388301AbeGXNWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:22:25 -0400
Received: from localhost (unknown [106.201.120.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D633420874;
        Tue, 24 Jul 2018 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532434572;
        bh=AyhUL07q62Yr8x39qhOd1Bm2NH9qEtXIcCoNfzOVqQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo2un52rz+29aV6aa4lH7SPcUflaQIN4wiKbWazZsrTyhuYB03T9FalaIoc2eiSzC
         PqGG07HL2x2mw9nxLKEQLKHDNVF1uqIdu81kfDDohwZFGf9CMru28hL/jPuqF9/3ed
         YWx9CsG/8VU0r8dQpcbk4J+LcMzNE6ba+PccJWQ0=
Date:   Tue, 24 Jul 2018 17:46:04 +0530
From:   Vinod <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: Add binding for Actions Semi
 Owl SoCs
Message-ID: <20180724121604.GA2587@vkoul-mobl>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
 <20180723041743.32024-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723041743.32024-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Patch title should be dmaengine: ... Please always use the apt tags and
one can find them using git log <subsystem>

On 23-07-18, 09:47, Manivannan Sadhasivam wrote:
> Add devicetree binding for Actions Semi Owl SoCs DMA controller.


It would help for review to describe the controller here

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/dma/owl-dma.txt       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
> new file mode 100644
> index 000000000000..dd6ce237b216
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/owl-dma.txt
> @@ -0,0 +1,46 @@
> +* Actions Semi Owl SoCs DMA controller
> +
> +This binding follows the generic DMA bindings defined in dma.txt.
> +
> +Required properties:
> +- compatible: Should be "actions,s900-dma".
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Should contain 4 interrupts shared by all channel.
> +- #dma-cells: Must be <1>. Used to represent the number of integer
> +              cells in the dmas property of client device.
> +- dma-channels: Physical channels supported.
> +- dma-requests: Virtual channels supported.

not really, virtual channel is a software concepts. On the other hand
you may have request lines in hw and you can describe that, if not skip
this one

> +- clocks: Phandle and Specifier of the clock feeding the DMA controller.
> +
> +Example:
> +
> +Controller:
> +                dma: dma-controller@e0260000 {
> +                        compatible = "actions,s900-dma";
> +                        reg = <0x0 0xe0260000 0x0 0x1000>;
> +                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +                        #dma-cells = <1>;
> +                        dma-channels = <12>;
> +                        dma-requests = <46>;
> +                        clocks = <&clock CLK_DMAC>;
> +                };
> +
> +Client:
> +
> +DMA clients connected to the Actions Semi Owl SoCs DMA controller must
> +use the format described in the dma.txt file, using a two-cell specifier
> +for each channel.
> +
> +The two cells in order are:
> +1. A phandle pointing to the DMA controller.
> +2. The channel id.
> +
> +uart5: serial@e012a000 {
> +        ...
> +        dma-names = "tx", "rx";
> +        dmas = <&dma 26>, <&dma 27>;
> +        ...
> +};
> -- 
> 2.17.1

-- 
~Vinod
