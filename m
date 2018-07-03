Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30637218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30637218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeGCXhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:37:52 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34351 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGCXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:37:50 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so1307585ywg.1;
        Tue, 03 Jul 2018 16:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTBstq1TFHWyYO4B2RMFO8i7rwLYVEbS/9UVOrGfJ1U=;
        b=Muk2ZGF8I0SqzLF55YurTMChUEC9CGHVnIhDtvJg+sAa34JAdcGG+wWi4wgJLGeFxc
         1Ol3DOozcogB5tCI/Fa3izvqs68oJcGQBmNbybWfXcvsNsdlBcIvRND0V318790z+4TE
         V5CYIokWlfJrQjVo1pnJ22pYskahIRZiL+FWyrc8mSBKBIDEfjN5B9oYR/SPcQ3aUV/N
         5Z8u8rAjNd0AW70Jb0AC/dH4KAqgh31iecS5GvxCEwtM6Z+aewp9tvaWHfUthoAcN9ZT
         s9KcR6luxONjmXLp4Flo6mMmjTC+otm116eSAUuGMhPJVBe7NCJJkQu4zV+pzgjhbVgc
         b72g==
X-Gm-Message-State: APt69E2PwNzOAVfUhUA2UjahWLd6ntzHcf64p7hJvoiX8AyCXBZnESaa
        wQH6W5ySyA5fWc5bGwDlNg==
X-Google-Smtp-Source: AAOMgpds6gBhG0kT4sw6LIj1XlcUDq/L2iy7VtNNY7bG13I7FqRSJkAx9QeOJfRq8tYaxK8c1LIFaw==
X-Received: by 2002:a0d:cd86:: with SMTP id p128-v6mr16177777ywd.211.1530661069899;
        Tue, 03 Jul 2018 16:37:49 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i129-v6sm882459ywf.25.2018.07.03.16.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:37:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:37:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: uniphier: add USB3 controller
 reset support
Message-ID: <20180703233747.GA850@rob-hp-laptop>
References: <1530259891-18822-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1530259891-18822-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530259891-18822-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:11:30PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for reset control of USB3 controller implemented in
> UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index 93efed6..f21d81c 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -118,3 +118,48 @@ Example:
>  
>  		other nodes ...
>  	};
> +
> +
> +USB3 controller reset
> +---------------------
> +
> +Required properties:
> +- compatible: Should be
> +    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC
> +    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC
> +    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC
> +    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC
> +- #reset-cells: Should be 1.
> +- reg: Specifies offset and length of the register set for the device.
> +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> +	According to the clock-names, appropriate clocks are required.
> +- clock-names: Should contain
> +    "gio", "link" - for Pro4 SoC
> +    "link"        - for others
> +- resets: A list of phandles to the reset control for USB3 glue layer.
> +	According to the reset-names, appropriate resets are required.
> +- reset-names: Should contain
> +    "gio", "link" - for Pro4 SoC
> +    "link"        - for others
> +
> +Example:
> +
> +	usb-glue@65b00000 {
> +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> +			     "simple-mfd";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x65b00000 0x400>;
> +
> +		usb_rst: reset@0 {
> +			compatible = "socionext,uniphier-ld20-usb3-reset";

This looks weird. You have a reset controller within the USB block? And 
then a parent reset controller too?

> +			reg = <0x0 0x4>;
> +			#reset-cells = <1>;
> +			clock-names = "link";
> +			clocks = <&sys_clk 14>;
> +			clock-names = "link";
> +			resets = <&sys_rst 14>;
> +		};
> +
> +		other nodes ...

What other nodes?

> +	};
> -- 
> 2.7.4
> 
