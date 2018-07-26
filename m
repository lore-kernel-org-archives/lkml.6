Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C79BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0072020671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYs+DjuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0072020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbeGZSNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:13:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32879 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbeGZSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:13:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so550495pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7okqI/VRpzY5rLkQFUYLG8NoDQ7uGjWn4Z5xHZb06BQ=;
        b=kYs+DjuT9lL/wKQuGCxkaSFNN/605m/1+Nw7Wa8F1Q4+IjPA2D3Y0gRymU2CGJtkp+
         ffd1GnxJLXOTROXWSuvmCk1PsDUtwiDPEmfFkski6cFQRJUqmJkBtIJmO0j2b2KK8n/+
         nnyttAtAZyMAeAlWg+vJ0jngnoMS0JwGJFjHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7okqI/VRpzY5rLkQFUYLG8NoDQ7uGjWn4Z5xHZb06BQ=;
        b=YJ6JzclQByWAvcTCWiICrKGTu4L6+zhcsm9RcGA2GjLaBFDjuwcozrX6RsksgOvShJ
         enXn1hHrfpm+lZTDgrkJGnUiVVhRDCxUpfh4r4odRISlrrObdeYzuZSVFonbPRg4e9am
         oNWOfH2PeLMMKwa+4fBYbPqfmruFE6OyJkDnA2O8ATfa8B7jFvqtaILCcAiuxlnY5Z/c
         FwXuUhN4hQEAYkCIwDITIA0x5cAfyRkX9MN8pe1607Ch323c2vbqR1XHlRIlI3wx+bp3
         YUl5vgcwlAxSxT/I1uRDYvlSe4R0oLsKHrNWcvW6z9a3vLKsb5tm5KGURmnYL33HhgE0
         43Cg==
X-Gm-Message-State: AOUpUlF8ROU1Xr3UBUySZ75KO1dgupx+uiEcjTFygcCiMNri7dB5ZeUf
        CP7N2N84YUrCIn82P2eHu5+O
X-Google-Smtp-Source: AAOMgpeyne19xw7NIbfO0RfszjjS2xd3vdf3D9Ioaj4Cpch4ngzaFaelWvjYidAGZswxB29iX2yGkw==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr2669503pgh.161.1532624165149;
        Thu, 26 Jul 2018 09:56:05 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id n24-v6sm6232019pfi.161.2018.07.26.09.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:56:04 -0700 (PDT)
Date:   Thu, 26 Jul 2018 22:25:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, linux@armlinux.org.uk,
        Guilherme =?iso-8859-1?B?Ry4gU2lt9WVz?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com
Subject: Re: [PATCH] clk: actions: Add custom delay option to Actions Semi
 OWL pll clock driver
Message-ID: <20180726165555.GB5220@Mani-XPS-13-9360>
References: <CADHB5bAztBFgWe-1v5vFfsxJgW1S3OOpV1Jkjrgk2h+pJBFw9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHB5bAztBFgWe-1v5vFfsxJgW1S3OOpV1Jkjrgk2h+pJBFw9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edgar,

On Tue, Jul 17, 2018 at 02:02:00PM -0300, Edgar Bernardi Righi wrote:
> This patch adds custom delay support to Actions Semi OWL pll clock driver.
> It is required for future Actions Semi Owl series S500 SoC clock support
> 
> Currently, the driver waits a fixed amount of time defined by the
> macro PLL_STABILITY_WAIT_US.
> The default delay (50us) is not enough for Actions Semi Owl S500 SoC.
> It needs up to 150us.
> A new field called "delay" was added to "struct owl_pll_hw". The rest
> of the code was updated accordingly.
> Old macros "OWL_PLL_HW", "OWL_PLL" and "OWL_PLL_NO_PARENT" were kept
> (same usage), but updated to set "delay" value to
> PLL_STABILITY_WAIT_US (50us).
> New macros "OWL_PLL_HW_DELAY", "OWL_PLL_DELAY" and
> "OWL_PLL_NO_PARENT_DELAY" were created with an extra argument to set a
> custom "delay".
> This does not break S700 and S900 code and was tested on S500 based
> Lemaker Guitar Board.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/owl-pll.c
> linux/drivers/clk/actions/owl-pll.c
> --- vanilla/drivers/clk/actions/owl-pll.c    2018-07-17 13:07:16.667704000 -0300
> +++ linux/drivers/clk/actions/owl-pll.c    2018-07-17 13:42:07.396785603 -0300
> @@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_h
> 
>      regmap_write(common->regmap, pll_hw->reg, reg);
> 
> -    udelay(PLL_STABILITY_WAIT_US);
> +    udelay(pll_hw->delay);
> 
>      return 0;
>  }
> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/owl-pll.h
> linux/drivers/clk/actions/owl-pll.h
> --- vanilla/drivers/clk/actions/owl-pll.h    2018-07-17 13:07:16.667704000 -0300
> +++ linux/drivers/clk/actions/owl-pll.h    2018-07-17 13:42:11.116765089 -0300
> @@ -27,6 +27,7 @@ struct owl_pll_hw {
>      u8            width;
>      u8            min_mul;
>      u8            max_mul;
> +    u32            delay;
>      const struct clk_pll_table *table;
>  };
> 
> @@ -35,6 +36,51 @@ struct owl_pll {
>      struct owl_clk_common    common;
>  };
> 
> +#define PLL_STABILITY_WAIT_US    (50)
> +

You don't need this here. Please see below.

> +#define OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,            \
> +           _width, _min_mul, _max_mul, _table, _delay)            \
> +    {                                \
> +        .reg        = _reg,                    \
> +        .bfreq        = _bfreq,                \
> +        .bit_idx    = _bit_idx,                \
> +        .shift        = _shift,                \
> +        .width        = _width,                \
> +        .min_mul    = _min_mul,                \
> +        .max_mul    = _max_mul,                \
> +        .table        = _table,                \
> +        .delay        = _delay,                \
> +    }
> +
> +#define OWL_PLL_DELAY(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
> +        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
> +    struct owl_pll _struct = {                    \
> +        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
> +                     _width, _min_mul,            \
> +                     _max_mul, _table, _delay),            \
> +        .common = {                        \
> +            .regmap = NULL,                    \
> +            .hw.init = CLK_HW_INIT(_name,            \
> +                           _parent,            \
> +                           &owl_pll_ops,        \
> +                           _flags),            \
> +        },                            \
> +    }
> +
> +#define OWL_PLL_NO_PARENT_DELAY(_struct, _name, _reg, _bfreq, _bit_idx,    \
> +        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
> +    struct owl_pll _struct = {                    \
> +        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
> +                     _width, _min_mul,            \
> +                     _max_mul, _table, _delay),            \
> +        .common = {                        \
> +            .regmap = NULL,                    \
> +            .hw.init = CLK_HW_INIT_NO_PARENT(_name,        \
> +                           &owl_pll_ops,        \
> +                           _flags),            \
> +        },                            \
> +    }
> +

No need to have DELAY and non DELAY defines. You can just add delay
as a parameter to the OWL_PLL_NO_PARENT and OWL_PLL defines for the
whole Owl family. Then use the corresponding delays in board specific
owl-sx00.c file.

>  #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,            \
>             _width, _min_mul, _max_mul, _table)            \
>      {                                \
> @@ -46,6 +92,7 @@ struct owl_pll {
>          .min_mul    = _min_mul,                \
>          .max_mul    = _max_mul,                \
>          .table        = _table,                \
> +        .delay        = PLL_STABILITY_WAIT_US,\

As said above, delay should come from board specific file. No need to
worry about touching the S900/S700 part. As long as your change not breaking
the functionality, it is fine.

Thanks,
Mani

>      }
> 
>  #define OWL_PLL(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
> @@ -78,7 +125,6 @@ struct owl_pll {
>      }
> 
>  #define mul_mask(m)        ((1 << ((m)->width)) - 1)
> -#define PLL_STABILITY_WAIT_US    (50)
> 
>  static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
>  {
