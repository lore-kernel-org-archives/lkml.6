Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B5C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555CE20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555CE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbeGKTvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:51:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34092 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389892AbeGKTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:51:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so51473474ois.1;
        Wed, 11 Jul 2018 12:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h/9T8LUompaKxzDAef4zsndTTQ4tmzIj18CpLiLg9hE=;
        b=YphN730rMt6i1SwfOE94OoFKHkakzG8haZLQp0B5Atn0FX4ltwSSKk9bUQVp111ApD
         6uYDnOB61OMBXCBEDyj0wAJXtCQq2rKi73OjzaM0IHzIGq4ceQn6krcla9LNbd2rrFmr
         G1uXxfYepqDJkwFZO66guBgtvyYWjlW1yH8OOBF8PtuhoKBIFySk2fZskKFYlx4fgDQ4
         jkJuA2vjBr8oLrLz0qI/QKcNq4mC19Nqcl7Ai/kNWEsKQDkp39FuZz2c91qZws9Jcz+s
         NFpaJfgLWpPuzO1i0WOqg857wj5c/A8JUZyvcZ6SnBxlcpfcsyKru2M+K0DlWPS7INyM
         D8yA==
X-Gm-Message-State: AOUpUlFL2xIrG02tyBDgd51PytmrcTBaeksdQNtrkeTl2YizIFr5LagB
        k1lI+mJva3ZC9rGtPeyKwg==
X-Google-Smtp-Source: AAOMgpe77LINp9/IGTcz3R/sr3djAUhO02c7ji7+VyVF0yBo6x/SIvIabtgCGikAYGZ/nDrTrqtMFA==
X-Received: by 2002:aca:d00d:: with SMTP id h13-v6mr40569oig.50.1531338349634;
        Wed, 11 Jul 2018 12:45:49 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i132-v6sm2677408oif.20.2018.07.11.12.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:45:49 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:45:46 -0600
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
Subject: Re: [PATCH v2 2/3] clk: meson: add sub MMC clock dt-bindings IDs
Message-ID: <20180711194546.GA7090@rob-hp-laptop>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-3-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710163658.6175-3-yixun.lan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:36:57PM +0000, Yixun Lan wrote:
> Add two clock bindings IDs which provided by the MMC clock controller,
> These two clocks will be used by MMC or NAND driver.

I count 3 ids.

> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../dt-bindings/clock/amlogic,meson-mmc-clkc.h   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h

This can go with the binding patch.

> 
> diff --git a/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h b/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> new file mode 100644
> index 000000000000..2ae988ebc3ae
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson MMC sub clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#ifndef __MMC_CLKC_H
> +#define __MMC_CLKC_H
> +
> +#define CLKID_MMC_DIV				1
> +#define CLKID_MMC_PHASE_TX			3
> +#define CLKID_MMC_PHASE_RX			4
> +
> +#endif
> -- 
> 2.18.0
> 
