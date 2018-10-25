Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F09C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJZEdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:33:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45455 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZEdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:33:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id e14-v6so4825200oie.12;
        Thu, 25 Oct 2018 12:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v63zYMrQVkYufRJ7KC8EXtkiQleAdQACsw3XM22niBQ=;
        b=knLuVGBJfI7PPo9AuXJXmAuDE0n9UsOJo2kLyS30sV2HpA1pyWE7Ms2lCnGvoW/L9F
         L5evwLycL3wQDfHDe3A//5ORh1i15hjx+VW6QMBxg+GtaaxWpevXOc8RPImvDA/SZBL/
         C8egKyXSi0g1DwOSv/sA0XUvIrCuvJfujrnT7OcgCQCkI424iVrN2EJHQbZ2FbW9rycx
         +yoYt3EAcW9F+ORC8kEmQHnRVjvzvzIJ6w1mDLNfGk8J1JgMQOvIbRA//+VvHFiWFpm0
         Ftme/TWyl1PoQq/AOj27a5gUEAQQmJbMz/nVvB3MI0GR248yPi3IQuCkb9QKde8GKHwP
         I+PA==
X-Gm-Message-State: AGRZ1gIYUtnnr9yZvTdBa1UuDYm9w/Sq4uKtaq9FVJfAx0X3P+Hmftf7
        BR0qXhCWqXxNZC+QdMZ0LA==
X-Google-Smtp-Source: AJdET5da3h0YFN/u/8it1qgGvjaRObDMJfcJXkXVCc3yQ+iwPouDjlSN+g8MIEgKctijNyo37peYMA==
X-Received: by 2002:aca:3904:: with SMTP id g4-v6mr360557oia.145.1540497549114;
        Thu, 25 Oct 2018 12:59:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z199-v6sm3302684oig.32.2018.10.25.12.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:59:07 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:59:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: uniphier: fix incorrect property items
Message-ID: <20181025195906.GA22391@bogus>
References: <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 06:34:29PM +0900, Keiji Hayashibara wrote:
> This commit fixes incorrect property because it was different
> from the actual.
> The parameters of '#address-cells' and '#size-cells' were removed,
> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.
> 
> Fixes: 4dcd5c2781f3 ("spi: add DT bindings for UniPhier SPI controller")
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> index 504a4ec..b04e66a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> @@ -5,18 +5,20 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
>  Required properties:
>   - compatible: should be "socionext,uniphier-scssi"
>   - reg: address and length of the spi master registers
> - - #address-cells: must be <1>, see spi-bus.txt
> - - #size-cells: must be <0>, see spi-bus.txt

How is removing these correct? They are needed if you have any child 
devices.

> - - clocks: A phandle to the clock for the device.
> - - resets: A phandle to the reset control for the device.
> + - interrupts: a single interrupt specifier
> + - pinctrl-names: should be "default"
> + - pinctrl-0: pin control state for the default mode
> + - clocks: a phandle to the clock for the device
> + - resets: a phandle to the reset control for the device
>  
>  Example:
>  
>  spi0: spi@54006000 {
>  	compatible = "socionext,uniphier-scssi";
>  	reg = <0x54006000 0x100>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> +	interrupts = <0 39 4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi0>;
>  	clocks = <&peri_clk 11>;
>  	resets = <&peri_rst 11>;
>  };
> -- 
> 2.7.4
> 
