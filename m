Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C5921582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C5921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeI1DGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:06:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46425 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1DGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:06:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so3381196oia.13;
        Thu, 27 Sep 2018 13:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7grPJdgahmJM099fqKfK21N79/QzQi7xpxnyKPJhS0=;
        b=snAdo/xWwobXRpVhjB55aIyNsACM5hWBVWqRc8Ox1EZt5cBl8yAlfQesuN5hI/SCET
         Vixqaeb9MHLr24AR8VKrUTmlLGaiVDtR3Njr3jR203wS7IqEx4e7TrOzmswYwMJu5Ke4
         ZCWlLLZX6SR3vE33HrOfSk/slIbEqPHM0UIMhR5XTDk4QW6oB2+qs/FF+y+JZoKKwXCl
         agSYdMMafl2qa6tkR7dt0xBh6KJlTmEifiVbwFt7K4WMsVDt1DDWCbAvEH8n0/4yKTE1
         0Ef1+65ORa3ux7vPIgn/8Bf0b/g1iFemlTl7QYtYh0iFlCoAbrtcawAuim9Md2JmmfHN
         /uxg==
X-Gm-Message-State: ABuFfohOKvhtlXiEiPjnW4AncYAZ3ltla7LZnaayNGvI3L85TeQ9XGP3
        njxvxjp1jkLhseN91QLF2A==
X-Google-Smtp-Source: ACcGV621Kr8IJx53l/JcCaPx4gLlvNelyAa1sAz2LyzeUrSVmMMaTjLcxRy8IrpQ3w30mjYEaTOxhA==
X-Received: by 2002:a54:478c:: with SMTP id o12-v6mr3954226oic.101.1538081185358;
        Thu, 27 Sep 2018 13:46:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l60-v6sm1017134otl.52.2018.09.27.13.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:46:24 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:46:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Message-ID: <20180927204624.GA7072@bogus>
References: <20180926205204.184898-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926205204.184898-1-ryandcase@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:52:03PM -0700, Ryan Case wrote:
> From: Girish Mahadevan <girishm@codeaurora.org>
> 
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
> 
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
> 
> Changes in v3:
> - Added generic compatible string in addition to specific SoC
> 
> Changes in v2:
> - Added commit text
> - Removed invalid property
> - Updated example to match sdm845 with attached spi-nor
> 
>  .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 000000000000..e13f5bb314ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +Qualcomm Quad Serial Peripheral Interface (QSPI)
> +
> +The QSPI controller allows SPI protocol communication in single, dual, or quad
> +wire transmission modes for read/write access to slaves such as NOR flash.
> +
> +Required properties:
> +- compatible:	An SoC specific identifier followed by "qcom,qspi-v1", such as
> +		"qcom,sdm845-qspi", "qcom,qspi-v1"
> +- reg:		Should contain the base register location and length.
> +- interrupts:	Interrupt number used by the controller.
> +- clocks:	Should contain the core and AHB clock.
> +- clock-names:	Should be "core" for core clock and "iface" for AHB clock.
> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +	qspi: qspi@88df000 {

spi@...

> +		compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
> +		reg = <0x88df000 0x600>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-names = "iface", "core";
> +		clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +			 <&gcc GCC_QSPI_CORE_CLK>;
> +
> +		device@0 {

flash@0

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <25000000>;
> +			spi-tx-bus-width = <2>;
> +			spi-rx-bus-width = <2>;
> +		};
> +	};
> -- 
> 2.19.0.605.g01d371f741-goog
> 
