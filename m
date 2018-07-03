Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF2CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565923C82
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565923C82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeGCWav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:30:51 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42506 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:30:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id c7-v6so6464ybk.9;
        Tue, 03 Jul 2018 15:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcawMRGgyn5yqqgB9JZ4UOoqIdafSX7kmok1KkgLQOQ=;
        b=uRv2zIR788brVsuujujtEa14d5/AbO4dXLnZ+5VIAnka7ZzBslTfct6K7tP0nYhtUl
         SoRKW2ixpYvmvf9iBt6xM+NTj2eab+Od+3gXuj4bZT8qHLvdBL9Gw56obwgTKfJsJnxC
         6dCaniwgfU3uUUCMUGlfrYvu2P9tkYQSxPNawpwkqF3xRWfIGNInEgmoHYQ5X3NOX1WK
         8ufsIoRGOVfOKnlfQoZ2r+BzoKjwbhGK61tZFACqqPMObDi/JxTbmEqj6aAqTtrw2qAM
         lNSQJN7Y7bO3eShHW1oIwAHPYZbVX4KST26OinjDUECJeV4Mk0HVgK52Zc7vr3SgZM4r
         F6/w==
X-Gm-Message-State: APt69E0I3V9LFx/OBomo8urNBSHT6Sw5tRBBozg+63LPXLQLHw22i7p5
        rkbyQ2Ik5Q38FIUKhhvNxA==
X-Google-Smtp-Source: AAOMgpc54UvaTpqr6h4rHJEc3y2LfSwS4B+M9BD+k9hbv0tF5FEesWR68WJGIgJNm+xd7NPCMxQMZQ==
X-Received: by 2002:a25:d894:: with SMTP id p142-v6mr7256409ybg.227.1530657049056;
        Tue, 03 Jul 2018 15:30:49 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g83-v6sm779705ywa.106.2018.07.03.15.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:30:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:30:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
Message-ID: <20180703223046.GA20184@rob-hp-laptop>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626232605.13420-12-benh@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:26:02AM +1000, Benjamin Herrenschmidt wrote:
> This isn't per-se a real device, it's a pseudo-device that
> represents the use of the Aspeed built-in ColdFire to
> implement the FSI protocol by bitbanging the GPIOs instead
> of doing it from the ARM core.
> 
> Thus it's a drop-in replacement for the existing
> fsi-master-gpio pseudo-device for use on systems for which
> a corresponding firmware file exists. It has most of the
> same properties, plus some more needed to operate the
> coprocessor.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> new file mode 100644
> index 000000000000..50913ae685cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> @@ -0,0 +1,36 @@
> +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> +------------------------------------------------------------------------
> +
> +Required properties:
> + - compatible =
> +   	      "fsi-master-ast-2400-cf" for an AST2400 based system
> +	    or
> +	      "fsi-master-ast-2500-cf" for an AST2500 based system

<vendor>,<soc>-<block>

> +
> + - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> + - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> + - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> + - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> + - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other

So the gpio info is pased to the CF? Otherwise, what's the point of 
having these in DT?

> +                                          functions (eg, external FSI masters)
> + - memory-region = <phandle>;		: Reference to the reserved memory for
> +                                          the ColdFire. Must be 2M aligned on
> +					  AST2400 and 1M aligned on AST2500

> + - sram = <phandle>;			: Reference to the SRAM node.
> + - cvic = <phandle>;			: Reference to the CVIC node.

Vendor prefixes.

> + - fw-name = <string>;			: The name used to construct the firmware
> +   	     				  file name (cf-fsi-<name>.bin)

firmware-name is used in some other places (and is the full filename).

> + - fw-platform-sig = <value>;		: A signature value that must match the one
> +   		     			  contained in the firmware image. Known
> +					  values are listed in the firmware interface
> +					  file cf-fsi-fw.h

Vendor prefix unless you think this could be common.

> +Examples:
> +
> +    fsi-master {
> +        compatible = "fsi-master-gpio", "fsi-master";

Forget to update the example?

> +        clock-gpios = <&gpio 0>;
> +        data-gpios = <&gpio 1>;
> +        enable-gpios = <&gpio 2>;
> +        trans-gpios = <&gpio 3>;
> +        mux-gpios = <&gpio 4>;
> +    }
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
