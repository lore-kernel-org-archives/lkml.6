Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2CBBBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203D20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E203D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeFLTMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:12:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38699 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbeFLTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:12:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so28580pgf.5;
        Tue, 12 Jun 2018 12:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrXbs0ROq4mHLiKhhrtGkVCISu/kyRsFJ1bqwnZPpLU=;
        b=mNDSYyGvMOxoyajeuGYEycOntZaFBEfMrMlZo9W/9MOBZ6UtpAQasGrcEYeMcvSdUd
         EoSfcAdrNXOmUzCLBVj2aBFLFN15WEFUjp4VhUiq276FGMgK216dOzuOY6fO92Yo4XE7
         +7ZBcfjZih1zXfvsRQOHn3FAwiSYtFiSykcYT7Anoz/V7D6oQKsG+xwJh0owV3uyrdvB
         re3Unboq6knU6u7ym+e+SpWXAB+zwufSxjRAJZnUqdC1ySsPnWpWEr0beS+tmko/hUHN
         CDse6q4fn01VHv5a5RRb34USJfYgXNjceSoWcdMmhNkhxyFG9Cj0s8xByHhmUlUSSJgw
         TYEg==
X-Gm-Message-State: APt69E36+VQkrLn0/ARKSDkhUge7fsdqXgArH5wNJxzYsFdt/oL000Xy
        /ql5qzZrfuR2rsEC9Sb8Ng==
X-Google-Smtp-Source: ADUXVKIg8I0vQqwn8vPx6SotOehG5eqsFCjOtZMTXSYYl65xOrTscqiPAYg71/F1fhEXz04tGNsjow==
X-Received: by 2002:a62:c0cb:: with SMTP id g72-v6mr1693021pfk.226.1528830742776;
        Tue, 12 Jun 2018 12:12:22 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r188-v6sm963313pgr.78.2018.06.12.12.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:12:21 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:12:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     heiko@sntech.de, sboyd@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 1/4] dt-bindings: add bindings for px30 clock
 controller
Message-ID: <20180612191220.GA27984@rob-hp-laptop>
References: <1528439519-30135-1-git-send-email-zhangqing@rock-chips.com>
 <1528439519-30135-2-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528439519-30135-2-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:31:56PM +0800, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,px30-cru.txt           | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
> new file mode 100644
> index 000000000000..af5a45b680d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
> @@ -0,0 +1,67 @@
> +* Rockchip PX30 Clock and Reset Unit
> +
> +The PX30 clock controller generates and supplies clock to various
> +controllers within the SoC and also implements a reset controller for SoC
> +peripherals.
> +
> +Required Properties:
> +
> +- compatible: PMU for CRU should be "rockchip,px30-pmu-cru"
> +- compatible: CRU should be "rockchip,px30-cru"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +- #reset-cells: should be 1.
> +
> +Optional Properties:
> +
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +  If missing, pll rates are not changeable, due to the missing pll lock status.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume. All available clocks are defined as
> +preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
> +used in device tree sources. Similar macros exist for the reset sources in
> +these files.
> +
> +External clocks:
> +
> +There are several clocks that are generated outside the SoC. It is expected
> +that they are defined using standard clock bindings with following
> +clock-output-names:
> + - "xin24m" - crystal input - required,
> + - "xin32k" - rtc clock - optional,
> + - "i2sx_clkin" - external I2S clock - optional,
> + - "gmac_clkin" - external GMAC clock - optional
> +
> +Example: Clock controller node:
> +
> +	pmucru: pmu-clock-controller@ff2bc000 {

s/pmu-clock-controller/clock-controller/

> +		compatible = "rockchip,px30-pmucru";
> +		reg = <0x0 0xff2bc000 0x0 0x1000>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +	cru: clock-controller@ff2b0000 {
> +		compatible = "rockchip,px30-cru";
> +		reg = <0x0 0xff2b0000 0x0 0x1000>;
> +		rockchip,grf = <&grf>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +Example: UART controller node that consumes the clock generated by the clock
> +  controller:
> +
> +	uart0: serial@ff030000 {
> +		compatible = "rockchip,px30-uart", "snps,dw-apb-uart";
> +		reg = <0x0 0xff030000 0x0 0x100>;
> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&pmucru SCLK_UART0_PMU>, <&pmucru PCLK_UART0_PMU>;
> +		clock-names = "baudclk", "apb_pclk";
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		status = "disabled";

Don't show status in examples.

> +	};
> +
> -- 
> 1.9.1
> 
> 
