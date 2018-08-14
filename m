Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1157C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8F42171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8F42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeHNXhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:37:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44016 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeHNXhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:37:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so9766977pfi.10;
        Tue, 14 Aug 2018 13:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gu060dqIshp5cKXw+E5FhPpNcmWPOIqBAaBRFFo46Xk=;
        b=RzyM6qiNSs+WJcd8K1mzvLoX8akA5o0cZrqnhNgxUruRDVea49Kp5hQ01F1qfPPZxF
         D7k3GUdzmZGHMvQR3tpASzP1Y3rHdjYj2TpwO5QHKApaJ1aqb4zcXgFatYizRWiuU7sG
         Ez36CJgVMgxqGG39ZnLlOId3Z3IC8m3ImqjoG3HAf4m9RvXHyu8XtldQ66iOoz2G6Emq
         SiBkGdsRReg3/pricR6bi5GESmTAPLDc+gj056UF0xptdvrGbj2ASK8b83zYz/Z11DwS
         2qWY2doQv0tc96R4i9tGnc1iKuJysL/AdpkRMbN6N8gZ8AfFTvifRDr8r5+U+BxZHCal
         j0GA==
X-Gm-Message-State: AOUpUlF3bzlo0zJGA8Zn43Y2VxYsAc8po6T8YEXROzNgu9jSda8DgP3x
        /VZq9zlzX2aevUi4o02aNQ==
X-Google-Smtp-Source: AA+uWPwDlBxecc2MQ+GApGVHaurENPzuqmukwMOYwJnYMAAZ947XNb0bzVJ4kUEs3BytMQWVm9TBPQ==
X-Received: by 2002:a63:7b1b:: with SMTP id w27-v6mr21643875pgc.199.1534279683765;
        Tue, 14 Aug 2018 13:48:03 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id s66-v6sm20526333pgc.67.2018.08.14.13.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:48:03 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:48:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clk: meson-g12a: Add G12A AO Clock
 Bindings
Message-ID: <20180814204801.GA9362@rob-hp-laptop>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-2-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533894868-85815-2-git-send-email-jian.hu@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:54:27PM +0800, Jian Hu wrote:
> Add new clock controller compatible and dt-bingdings headers
> for the Always-On domain of the g12a SoC
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  1 +
>  include/dt-bindings/clock/g12a-aoclkc.h            | 28 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100755 include/dt-bindings/clock/g12a-aoclkc.h

checkpatch says wrong mode.

> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> index 3a88052..6f02288 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> @@ -10,6 +10,7 @@ Required Properties:
>  	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
>  	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
>  	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
> +	- G12A (S905D2, S905X2) : "amlogic,g12a-aoclkc"
>  	followed by the common "amlogic,meson-gx-aoclkc"
>  
>  - #clock-cells: should be 1.
> diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
> new file mode 100755
> index 0000000..6b3f921
> --- /dev/null
> +++ b/include/dt-bindings/clock/g12a-aoclkc.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Jian Hu<jian.hu@amlogic.com>
> + */
> +
> +#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
> +#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
> +
> +#define CLKID_AO_AHB_BUS		0
> +#define CLKID_AO_REMOTE			1
> +#define CLKID_AO_I2C_MASTER		2
> +#define CLKID_AO_I2C_SLAVE		3
> +#define CLKID_AO_UART1			4
> +#define CLKID_AO_PROD_I2C		5
> +#define CLKID_AO_UART2			6
> +#define CLKID_AO_IR_BLASTER		7
> +#define CLKID_AO_SAR_ADC		8
> +#define CLKID_AO_CLK81			9
> +#define CLKID_AO_SAR_ADC_SEL		10
> +#define CLKID_AO_SAR_ADC_DIV		11
> +#define CLKID_AO_SAR_ADC_CLK		12
> +#define CLKID_AO_ALT_XTAL		13
> +
> +#endif
> -- 
> 1.9.1
> 
