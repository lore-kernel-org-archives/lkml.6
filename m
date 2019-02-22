Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5267C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DF0206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgEfWSaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfBVTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:44:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45991 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:44:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so2695299edh.12;
        Fri, 22 Feb 2019 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifgmbiF78nCDyGMffIIt4o/UXgInFLCICGdB5cP+ybI=;
        b=tgEfWSaSsSkoqcih+eYfXW1/DJHz1x7wpX4y9P8fW07dO0ildyZdXlSw1wuL18lrjD
         HQIPZG0ZsZCqGQQKV2RWmI0b96kNhbvljHHWznwpqog/PWQM7oQAfT219y6b1HZ6A/IP
         KZ54XlucdlQRJCJOA7T8BRCHRUV+1BXOnQRJ9E+fr9nLLz3Xs0EaTJ7R5spqu9cTd5q4
         9FgTQQVmbXl1WiqiVCeDU9sBBS9p66CeENNulBiDSYWXAHikru7683QOIPjItf38M0g+
         tSHKSiGLpAHHDwdIqsbH+1/07wh+RNTg5UQwxi8g1C5UTcBdk7noKmUkv+JlFkeigA7y
         c5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifgmbiF78nCDyGMffIIt4o/UXgInFLCICGdB5cP+ybI=;
        b=LxuS2s+KvduSq5aQlXQm11lspLL4amUwCRQlujWJDr14jvYeKxubZLVp0OWaL2aipO
         wqyy521zH4yPhfd0ifSoiNcXnFUmA8bdWqTmH9NHLlyLNV1AkAkognJiwPru42SfU8/A
         xznDKk/jfEVd0QFHDHzyIRFNe1S5ETLVmDmEXpbQI2yrtGAAtR34n0djJYQ8mmSdB3Wj
         1TgCNiiBhfL1VrWKSTymXng6GQDfIEoDy6YKfNM3/RMl0fGxVaQJK+s2V1FMgOkg/fGp
         KVnNLmPr7mj8wiaDcsT05NVMcNiWkScYhMll8Sb75zuBS2KD8d+ao9osNYryj270mnOS
         hE3A==
X-Gm-Message-State: AHQUAuYuXf+fN8tj8O1HsYt9KgMylRDtq0f2qz1kJZ4EibWojZT2lXdX
        zU+P2fmtBfdPoUsLL8lOerJOVq2W/OUd+O5+O1l1sO4m
X-Google-Smtp-Source: AHgI3IZ2xw3XOcDwKAU/1ubCd2CQ6/HP4O/xdEwblamZ7OiD2fnoauIiXlcF0LMsEoUY9GDTPknQWcLW9CgYXmr8hRQ=
X-Received: by 2002:a50:b847:: with SMTP id k7mr4455826ede.265.1550864694231;
 Fri, 22 Feb 2019 11:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20190120015851.11797-1-angus@akkea.ca> <20190120015851.11797-4-angus@akkea.ca>
In-Reply-To: <20190120015851.11797-4-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 22 Feb 2019 21:44:43 +0200
Message-ID: <CAEnQRZD3YJqAUh+gh+PCpF+NMmyECiG=H8WA_hnKP7kPt2G8hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx8mq.dtsi: add the sdma nodes
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

What is the status of this patch? Most likely this should go through
Shwan's tree.

I noticed that I have also sent a similar patch to Shawn:
https://www.spinics.net/lists/arm-kernel/msg708424.html

So, lets coordinate and work better on this.

I am now preparing another series where I add SAI nodes and enable WM
codec on imx8MQ.

If you don't mind I will pick your relevant changes from this patch
and add them to my series, then send them to Shawn.

thanks,
Daniel.

On Sun, Jan 20, 2019 at 4:05 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add the sdma nodes to the base devicetree for the imx8mq
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index c0402375e7c1..0b9a9b5ae7b7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -336,6 +336,19 @@
>                                 clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
>                                 status = "disabled";
>                         };
> +
> +                       sdma2: sdma@302c0000 {
> +                               compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> +                               reg = <0x302c0000 0x10000>;
> +                               interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> +                                       <&clk IMX8MQ_CLK_SDMA2_ROOT>;
> +                               clock-names = "ipg", "ahb";
> +                               #dma-cells = <3>;
> +                               fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +                               fsl,ratio-1-1;
> +                               status = "disabled";
> +                       };
>                 };
>
>                 bus@30400000 { /* AIPS2 */
> @@ -370,6 +383,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART3_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -381,6 +396,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART2_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -432,6 +449,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART4_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -465,6 +484,18 @@
>                                 status = "disabled";
>                         };
>
> +                       sdma1: sdma@30bd0000 {
> +                               compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> +                               reg = <0x30bd0000 0x10000>;
> +                               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> +                                       <&clk IMX8MQ_CLK_SDMA1_ROOT>;
> +                               clock-names = "ipg", "ahb";
> +                               #dma-cells = <3>;
> +                               fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +                               status = "disabled";
> +                       };
> +
>                         fec1: ethernet@30be0000 {
>                                 compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
>                                 reg = <0x30be0000 0x10000>;
> --
> 2.17.1
>
