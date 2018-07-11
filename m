Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B41C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A9F20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A9F20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbeGKQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:17:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46256 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:17:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so50245569oie.13;
        Wed, 11 Jul 2018 09:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFmqhv4JezXb19lxbI7UxOzIBdY3+24cmbvqJ6IvEa0=;
        b=WeFgS0F+NZhnKwmlDyDrLplTODUNVzwqK02HUxIwEu7ijEzFcHNuiAMnymo1lQReqs
         iGefgCSTXsDKWIt4yhwnZ6p6s9BnVqQEqvNZ4D+rwWLPm3N+rmRvYJpxdCkIef4tqhAr
         jXwKkC/qJvMd5vjQgeFQofx2a5eIWIy0uPZFWNJWNu1hh1yULBOnc2WEEL67EIbWp8cP
         281dPKOtjExaXi8oEIck9+cUSzeKu8DGAJVuMjzKrZXD1LyERAcNtudXOGbw10tnnLfk
         U/WXO4HK99vGQXATVgs0+wmWEMSXAGrDnreRcm9vp1x4hxyaQTsKwE8TRvlcYDcAjgH6
         z9jA==
X-Gm-Message-State: APt69E1N5uOaXLIY/6Iv/AXlK+EUS/YYpwqxYSK1X+Cf0UscsHmUeV4C
        pvvf3T9QF/+IQg3ZrADDFA==
X-Google-Smtp-Source: AAOMgpcy+3TAvqoO6J1Uv1o2MAQX/X1MlTwE7yS0cNcBcxIO/5cTdAomtRLsQ1QTeFaeP7MxFCo3cQ==
X-Received: by 2002:aca:cd41:: with SMTP id d62-v6mr29983145oig.207.1531325529102;
        Wed, 11 Jul 2018 09:12:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id y85-v6sm11281773oie.25.2018.07.11.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:12:07 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:12:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manjunath M B <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys DWC
 MSHC
Message-ID: <20180711161206.GA1558@rob-hp-laptop>
References: <20180706151930.78b3024b@xhacker.debian>
 <20180706152047.0b0a4944@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706152047.0b0a4944@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> Controller can support eMMC/SD/SDIO. Add the bindings.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> new file mode 100644
> index 000000000000..ee4253b33be2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> @@ -0,0 +1,20 @@
> +* Synopsys DesignWare Cores Mobile Storage Host Controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "snps,dwcmshc-sdhci"

Needs to note that there must also be an SoC specific compatible.

> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: Array of clocks required for SDHCI; requires at least one for
> +    core clock.
> +- clock-names: Array of names corresponding to clocks property; shall be
> +    "core" for core clock and "bus" for optional bus clock.
> +
> +Example:
> +	sdhci2: sdhci@aa0000 {
> +		compatible = "snps,dwcmshc-sdhci";
> +		reg = <0xaa0000 0x1000>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&emmcclk>;
> +		bus-width = <8>;
> +	}
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
