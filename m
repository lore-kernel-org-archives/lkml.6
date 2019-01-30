Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6270C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80842084C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877655;
	bh=K4vKmPryPHUIUF0ogDUm+10BQv9DLZZzKVUvFTNPwv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0cWGf71sdSQirw2Q6eTgWoyOt69/nDCNbLUcUiGJ/yzojTgHWABWcZjSSBaw8pGkx
	 qmV1PHOliv5M6DSeo/FbViqN2baoQyiHZuYqgagn5RXffvM6uNL3DFtb02+Gsmg3rc
	 h+va2ThW8U8HQik5P/BDwjBwmEcUE+UNSIjMAPLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfA3Tre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:47:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38758 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfA3Trd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:47:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so684737oii.5;
        Wed, 30 Jan 2019 11:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjMUGRdk7uTy3O8KR8PAYf2S/FqvNXvJZCib2mjZJJo=;
        b=ofGgEnIyqfpZDSU5ZcP3h98/SGzmKGl0cr4pTSURc+7qwmrIkXVGJfuR4go1Z4yLjQ
         6HapESFew0Zg4IKTjb7G579JeweHqQY+2EnTZlfpNE2NqI9NJHbSQU3MJRsexCtle6iy
         8SZVCx/8zjQclPAsHSPh4yxlH8ZkqoIjGxSayfyUOK1nwieNfW5eqlfm2bstmi3PVo7D
         CwYQfOqn7xLfOGMqACtJ0MINp/zGOyLTseJpLPFeqtr3nnuuSJs1+v1gGvDN5SHyD7vk
         C14BnUL/kjcW06kRo7MwUX5JGEOx7hBLGJ5VGnd1RBOxPhn+mMHafFR30uE3mPgY1aok
         s5ww==
X-Gm-Message-State: AJcUukdnrHHwnusWehCzD0/Nm91VXuPrL4Sqsdm4nzRjPHaHLB9GfPYR
        nTS+waIVb5gjLFF1wrM8jA==
X-Google-Smtp-Source: ALg8bN5tUe9jtNR39b1LQMSxX7L2T09vH0A9S1PyUTq3rMRLwHpUzvCUe0ymhSyQZaXH+/w45VBCDg==
X-Received: by 2002:aca:d4d7:: with SMTP id l206mr13860831oig.320.1548877652155;
        Wed, 30 Jan 2019 11:47:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v141sm1077201oia.25.2019.01.30.11.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:47:31 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:47:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Add loongson-1 clock bindings
Message-ID: <20190130194731.GA25716@bogus>
References: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
 <20190128152052.3047-1-jiaxun.yang@flygoat.com>
 <20190128152052.3047-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128152052.3047-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:20:52PM +0800, Jiaxun Yang wrote:
> Loongson-1 is a series of MIPS MCUs.
> This patch add the clock bindings for loongson-1b and
> loongson-1c clock subsystem.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../bindings/clock/loongson1-clock.txt        | 11 ++++++++++
>  include/dt-bindings/clock/ls1b-clock.h        | 20 +++++++++++++++++++
>  include/dt-bindings/clock/ls1c-clock.h        | 17 ++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/loongson1-clock.txt
>  create mode 100644 include/dt-bindings/clock/ls1b-clock.h
>  create mode 100644 include/dt-bindings/clock/ls1c-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/loongson1-clock.txt b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
> new file mode 100644
> index 000000000000..f0119fbd0851
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
> @@ -0,0 +1,11 @@
> +* Clock bindings for Loongson-1 MCUs
> +
> +Required properties:
> +- compatible: Should be "loongson,ls1c-clock" or "loongson,ls1b-clock"

List one per line please.

> +- reg: Address and length of the register set
> +- #clock-cells: Should be <1>
> +- clocks: list of input clocks
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell. See include/dt-bindings/clock/ls1c-clock.h
> +or include/dt-bindings/clock/ls1b-clock.h for the full list of clocks.
> diff --git a/include/dt-bindings/clock/ls1b-clock.h b/include/dt-bindings/clock/ls1b-clock.h
> new file mode 100644
> index 000000000000..814227842ae0
> --- /dev/null
> +++ b/include/dt-bindings/clock/ls1b-clock.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier:	GPL-2.0

Headers should be /* */ style comments.

> +/*
> + * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
> +#define __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
> +
> +#define LS1B_CLK_PLL 0
> +#define LS1B_CLK_CPU_DIV 1
> +#define LS1B_CLK_CPU 2
> +#define LS1B_CLK_DC_DIV 3
> +#define LS1B_CLK_DC 4
> +#define LS1B_CLK_DDR_DIV 5
> +#define LS1B_CLK_DDR 6
> +#define LS1B_CLK_AHB 7
> +#define LS1B_CLK_APB 8
> +
> +#endif /* __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__ */
> diff --git a/include/dt-bindings/clock/ls1c-clock.h b/include/dt-bindings/clock/ls1c-clock.h
> new file mode 100644
> index 000000000000..40f386cb92ce
> --- /dev/null
> +++ b/include/dt-bindings/clock/ls1c-clock.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier:	GPL-2.0
> +/*
> + * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
> +#define __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
> +
> +#define LS1C_CLK_PLL 0
> +#define LS1C_CLK_CPU 1
> +#define LS1C_CLK_DC 2
> +#define LS1C_CLK_DDR 3
> +#define LS1C_CLK_AHB 4
> +#define LS1C_CLK_APB 5
> +
> +#endif /* __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__ */
> -- 
> 2.20.1
> 
