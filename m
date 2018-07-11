Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA3C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5122420878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5122420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbeGKTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:49:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38063 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbeGKTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:49:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so51453871oie.5;
        Wed, 11 Jul 2018 12:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BmQ/J/VMfuQCAZ8QCnQTjTnB9EMpYcq8DLgJgpYJUX0=;
        b=UaJKC7elpUPTOcCadKmbnm3xHMYXWrGcSheJu6oIfoX+9IKcaANk1BUdkl7zHjDy47
         7HT1zFWQomlT0mXDBlZi0Xh+PiMuZ95qLP6xq8XIH+CteaQx3TTdtE7DF6BaXD/c2iUK
         I+PtRJ+1sqLtNNMWUdPoM9NjoamY+1BBf++ClBqZVbrOKGyJytU97Wa1bPO69ujmgHug
         JaQzB6UUteL9aevmgylNL0S9c8o9EpXYB012fJlJduCmXE0WIZOliaRsT7JRcMaVdQuu
         Bc50/sAZqu2b0luAG4TtXmSuD716Ny+mCEo5sdVoZXmZsqVXzyUfMBtuKNJoBY4Z6gra
         vPSA==
X-Gm-Message-State: AOUpUlFT9JMA7Iq87M8iu80ivXF9NxBlhZBYcDeeMOdPEhZEY7NTpOKP
        bBOpOSpzdaHByZJBCqsDUw==
X-Google-Smtp-Source: AAOMgpdDOkiu6UK0c4NLV86UVV0sPsL97UIUrgBtdaP/g46wOjB/MM5imQ7GrMeJR+zxYe0UdD3GFg==
X-Received: by 2002:aca:171a:: with SMTP id j26-v6mr250780oii.277.1531338227667;
        Wed, 11 Jul 2018 12:43:47 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b63-v6sm17079293oia.4.2018.07.11.12.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:43:46 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:43:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
Message-ID: <20180711194346.GA32414@rob-hp-laptop>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710163658.6175-2-yixun.lan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND.

So you all have decided to properly model this now?

> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> new file mode 100644
> index 000000000000..ff6b4bf3ecf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> @@ -0,0 +1,31 @@
> +* Amlogic MMC Sub Clock Controller Driver
> +
> +The Amlogic MMC clock controller generates and supplies clock to support
> +MMC and NAND controller
> +
> +Required Properties:
> +
> +- compatible: should be:
> +		"amlogic,meson-gx-mmc-clkc"
> +		"amlogic,meson-axg-mmc-clkc"
> +
> +- #clock-cells: should be 1.
> +- clocks: phandles to clocks corresponding to the clock-names property
> +- clock-names: list of parent clock names
> +	- "clkin0", "clkin1"
> +
> +Parent node should have the following properties :
> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"

You don't need "simple-mfd" and probably not syscon either. The order is 
wrong too. Most specific first.

> +- reg: base address and size of the MMC control register space.
> +
> +Example: Clock controller node:
> +
> +sd_mmc_c_clkc: clock-controller@7000 {
> +	compatible = "amlogic,mmc-clkc", "syscon", "simple-mfd";

Doesn't match the binding...

> +	reg = <0x0 0x7000 0x0 0x4>;
> +	#clock-cells = <1>;
> +
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
> +			<&clkc CLKID_FCLK_DIV2>;
> +};
> -- 
> 2.18.0
> 
