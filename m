Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C494C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708F3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708F3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeK0Mff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:35:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33981 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0Mff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:35:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so18696830otk.1;
        Mon, 26 Nov 2018 17:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHLboXN2yIDvH2P8iJdn3CUKqJItvwKFPpIamSx5GIw=;
        b=UPeyepT1Mj3cl1aKa8ap+e8hoYiT/lMcs9DRjv8ESFssokdVV643dxVQ+VwpJC7wH0
         MPJ2Rw99xTtZ3ICuhoAItK/U0CE6iCHbmzSbgxfyyPJ36Mj7FkSROdD6HP4qkmT8ltgn
         trTaBScXHi/45+rtiWl4VG9TtXoU0GBxochj3StD6IdrAB0oEmhlgBWGjtBRVvOv2ROH
         XHGluytSKnJ0RJcbDdS7k4hY68iMFnUaZesDfrTqU4+0Hb+EyaAUWeNkEo0RJIE3CVDm
         bn6dZiy7cshiH7YKy1gSTAfIOODCxEk/cYxPdb5/dnM28Tmz2+nr+qJcwEnbA0jYalLX
         gqqw==
X-Gm-Message-State: AA+aEWaK3mFDVb72KvtaXx0URMnfvBcB3aabqyYCaxiaVfYPggkkUMLb
        zlsgnaTRUVm6yqq0q4cKPw==
X-Google-Smtp-Source: AFSGD/Wgw9J8M3vR1Ys5kuGfTMZ9W61/PSDAR9vgx3d7DmPRNIeYuHhAPIPcmnEtghztUWlyXhFEow==
X-Received: by 2002:a9d:2062:: with SMTP id n89mr16054579ota.244.1543282766122;
        Mon, 26 Nov 2018 17:39:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i22sm630037otp.7.2018.11.26.17.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:39:25 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:39:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 12/17] dt-bindings: clock: Add Allwinner suniv
 F1C100s CCU
Message-ID: <20181127013924.GA23537@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <c2e6e3f510d5663ecf25262126dcff1df112af15.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e6e3f510d5663ecf25262126dcff1df112af15.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:43:15AM +0300, Mesih Kilinc wrote:
> Add compatiple string for Allwinner suniv F1C100s CCU.
> Add clock and reset definitions.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 69 ++++++++++++++++++++++
>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 37 ++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index 47d2e90..e3bd88a 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -22,6 +22,7 @@ Required properties :
>  		- "allwinner,sun50i-h5-ccu"
>  		- "allwinner,sun50i-h6-ccu"
>  		- "allwinner,sun50i-h6-r-ccu"
> +		- "allwinner,suniv-f1c100s-ccu"
>  		- "nextthing,gr8-ccu"
>  
>  - reg: Must contain the registers base address and length
> diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
> new file mode 100644
> index 0000000..56f6d0d
> --- /dev/null
> +++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Goes on 1st line.

> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
> +#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
> +
> +#define CLK_CPU			11
> +
> +#define CLK_BUS_MMC0		14
> +#define CLK_BUS_MMC1		15
> +#define CLK_BUS_DRAM		16
> +#define CLK_BUS_SPI0		17
> +#define CLK_BUS_SPI1		18
> +#define CLK_BUS_OTG		19
> +#define CLK_BUS_VE		20
> +#define CLK_BUS_LCD		21
> +#define CLK_BUS_DEINTERLACE	22
> +#define CLK_BUS_CSI		23
> +#define CLK_BUS_TVD		24
> +#define CLK_BUS_TVE		25
> +#define CLK_BUS_DE_BE		26
> +#define CLK_BUS_DE_FE		27
> +#define CLK_BUS_CODEC		28
> +#define CLK_BUS_SPDIF		29
> +#define CLK_BUS_IR		30
> +#define CLK_BUS_RSB		31
> +#define CLK_BUS_I2S0		32
> +#define CLK_BUS_I2C0		33
> +#define CLK_BUS_I2C1		34
> +#define CLK_BUS_I2C2		35
> +#define CLK_BUS_PIO		36
> +#define CLK_BUS_UART0		37
> +#define CLK_BUS_UART1		38
> +#define CLK_BUS_UART2		39
> +
> +#define CLK_MMC0		40
> +#define CLK_MMC0_SAMPLE		41
> +#define CLK_MMC0_OUTPUT		42
> +#define CLK_MMC1		43
> +#define CLK_MMC1_SAMPLE		44
> +#define CLK_MMC1_OUTPUT		45
> +#define CLK_I2S			46
> +#define CLK_SPDIF		47
> +
> +#define CLK_USB_PHY0		48
> +
> +#define CLK_DRAM_VE		49
> +#define CLK_DRAM_CSI		50
> +#define CLK_DRAM_DEINTERLACE	51
> +#define CLK_DRAM_TVD		52
> +#define CLK_DRAM_DE_FE		53
> +#define CLK_DRAM_DE_BE		54
> +
> +#define CLK_DE_BE		55
> +#define CLK_DE_FE		56
> +#define CLK_TCON		57
> +#define CLK_DEINTERLACE		58
> +#define CLK_TVE2_CLK		59
> +#define CLK_TVE1_CLK		60
> +#define CLK_TVD			61
> +#define CLK_CSI			62
> +#define CLK_VE			63
> +#define CLK_CODEC		64
> +#define CLK_AVS			65
> +
> +#endif
> diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
> new file mode 100644
> index 0000000..95f1ed0
> --- /dev/null
> +++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

ditto

> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
> +#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
> +
> +#define RST_USB_PHY0		0
> +#define RST_BUS_MMC0		1
> +#define RST_BUS_MMC1		2
> +#define RST_BUS_DRAM		3
> +#define RST_BUS_SPI0		4
> +#define RST_BUS_SPI1		5
> +#define RST_BUS_OTG		6
> +#define RST_BUS_VE		7
> +#define RST_BUS_LCD		8
> +#define RST_BUS_DEINTERLACE		9
> +#define RST_BUS_CSI		10
> +#define RST_BUS_TVD		11
> +#define RST_BUS_TVE		12
> +#define RST_BUS_DE_BE		13
> +#define RST_BUS_DE_FE		14
> +#define RST_BUS_CODEC		15
> +#define RST_BUS_SPDIF		16
> +#define RST_BUS_IR		17
> +#define RST_BUS_RSB		18
> +#define RST_BUS_I2S0		19
> +#define RST_BUS_I2C0		20
> +#define RST_BUS_I2C1		21
> +#define RST_BUS_I2C2		22
> +#define RST_BUS_UART0		23
> +#define RST_BUS_UART1		24
> +#define RST_BUS_UART2		25
> +
> +#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
> -- 
> 2.7.4
> 
