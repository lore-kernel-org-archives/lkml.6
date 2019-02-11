Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCC9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429D218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549916721;
	bh=ZU8mpCMtSWR3dTI5Qdrc+P5N3tyVKzyPGycxg4RONzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ta2DP7lkrSYImiswlfbav3euZEOJq4gid0Re0V8ne7B4I7EK61MgloZWwHN6/YLhC
	 nBuX9a5FTt4pTBils7P7N6+8Ic6PKuEVallxulhYGuJjigDK7RlDCN14VZiM+u35t7
	 r2AaBXAEJIgEyW73VMcABDbW5vt9w/UD80ZxVcgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfBKUZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfBKUZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:25:18 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88054218A4;
        Mon, 11 Feb 2019 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549916717;
        bh=ZU8mpCMtSWR3dTI5Qdrc+P5N3tyVKzyPGycxg4RONzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYXcDnWJ5U+LH4kgLKvpP0P9eJHwaX88rukhOhso/1gvFMyogHd1HJHcFTnPCju+3
         a6AAPXrO8C0XzSX2NOFnAvFwGPXm+oU0UiXvfWQwggXYSZ24bBluiEVqhbpu3PXnXe
         a5H8iFfPIcTl7Nam2J0zKDuOB4AC2KMTTy/EZlxg=
Date:   Mon, 11 Feb 2019 20:25:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dt-binding: iio: remove rst node from NPCM ADC
 document
Message-ID: <20190211202511.622d4c48@archlinux>
In-Reply-To: <20190210204749.381445-1-tmaimon77@gmail.com>
References: <20190210204749.381445-1-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 22:47:49 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Remove NPCM7xx rst node for preparing the NPCM ADC
> document to describe ADC reset binding.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it. Hopefully just in time
for this cycle as I'll do a final pull request in a day or two.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt          | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> index 1b8132cd9060..eb939fe77836 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> @@ -14,11 +14,6 @@ Optional properties:
>  			   vref-supply is not added the ADC will use internal voltage
>  			   reference.
>  
> -Required Node in the NPCM7xx BMC:
> -An additional register is present in the NPCM7xx SOC which is
> -assumed to be in the same device tree, with and marked as
> -compatible with "nuvoton,npcm750-rst".
> -
>  Example:
>  
>  adc: adc@f000c000 {
> @@ -27,9 +22,3 @@ adc: adc@f000c000 {
>  	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>  	clocks = <&clk NPCM7XX_CLK_ADC>;
>  };
> -
> -rst: rst@f0801000 {
> -	compatible = "nuvoton,npcm750-rst", "syscon",
> -	"simple-mfd";
> -	reg = <0xf0801000 0x6C>;
> -};

