Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EC7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJDQKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:10:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58280 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDQKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:10:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF121208B5; Thu,  4 Oct 2018 11:18:31 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7AE152072C;
        Thu,  4 Oct 2018 11:18:21 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:18:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Message-ID: <20181004111822.48ab1f5c@bbrezillon>
In-Reply-To: <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Oct 2018 14:18:40 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Flash mt35xu512aba connected to FlexSPI controller supports
> 1-1-8 protocol.
> Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> 8 and 1 respectively for both flashes connected at CS0 and CS1.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 901ca346..817175a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -42,6 +42,8 @@
>  		m25p,fast-read;
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <1>;

Why 1? The flash is already flagged with SPI_NOR_OCTAL_READ, which
means only the read path will use 1-1-8 mode, so you can safely set
spi-tx-bus-width here and let the framework choose the appropriate mode
based on the flash capabilities.

>  	};
>  
>  	mt35xu512aba1: flash@1 {
> @@ -51,6 +53,8 @@
>  		m25p,fast-read;
>  		spi-max-frequency = <20000000>;
>  		reg = <1>;
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <1>;
>  	};
>  };
>  

