Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0211C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A025420878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A025420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeLCM0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:26:25 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLCM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:26:25 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gTnHu-0002aR-08; Mon, 03 Dec 2018 13:25:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: gpu: add Allwinner H6 Mali Midgard binding
Date:   Mon, 03 Dec 2018 13:25:21 +0100
Message-ID: <11894938.HOUtrQJeEF@phil>
In-Reply-To: <20181127074249.15204-2-icenowy@aosc.io>
References: <20181127074249.15204-1-icenowy@aosc.io> <20181127074249.15204-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 27. November 2018, 08:42:49 CET schrieb Icenowy Zheng:
> Allwinner H6 SoC uses a Mali T720 GPU, which is one of the GPUs in the
> Midgard GPU product line.
> 
> Add binding for the H6 Mali Midgard GPU.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 02f870cd60e6..c897dd7be48f 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -18,6 +18,7 @@ Required properties:
>      + "amlogic,meson-gxm-mali"
>      + "rockchip,rk3288-mali"
>      + "rockchip,rk3399-mali"
> +    + "allwinner,sun50i-h6-mali"

I'd think you might want to keep an alphabetical sorting here, aka
above amlogic, otherwise the list will probably become hard to read
at some later point.


>  - reg : Physical base address of the device and length of the register area.
>  
> @@ -44,6 +45,18 @@ Optional properties:
>    for details.
>  
>  
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accomodate those differences, you have the option
> +to specify one more vendor-specific compatible, among:
> +
> +  - allwinner,sun50i-h6-mali
> +    Required properties:
> +      * resets: phandle to the reset line for the GPU

While this paragraph is similar to how it is done in Utgard, I'm
wondering why we cannot just describe the "resets" as regular
optional property above that.


Heiko


