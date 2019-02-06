Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BC52080F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFNGYi13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfBFPPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:32 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45364 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfBFPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:10 -0500
Received: by mail-vs1-f67.google.com with SMTP id x28so4557006vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jrx3J8g78HNKbcyIhNwW/cIsTpfQf3NvO+d20dftCfo=;
        b=QFNGYi133XP51tWeU74MBEYaVAwFVprvPSz58noO+rkYLr5hJnDz5QD0K2seBsg6D5
         uKQsd57NqNJql+XYceciq2lFv48QihQk6nXuLLylgXMuGwz8p9JjFx1dsarLbhw2ATiq
         v6FWkyXAqI1UD+HYEU68UVPjRorWdaQKXAcNEgTaIil0OkNltOqRWoSzGafeIWosaqYM
         E76JzQv0/qJ0+VWm3/rFbj5wPnnvzhepShvC8pHuN6DZClEaJF/eZkPv2EM4vNtDCDAR
         FFM6vOXYDf2+mVuzPvCJkpl+TswAGrKd23szZHr978UlOZ9TYBB2FrOnyACGjszIr1ca
         DGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jrx3J8g78HNKbcyIhNwW/cIsTpfQf3NvO+d20dftCfo=;
        b=jtPVdGlJgpX10fcc4Khx8YBe0KRchrd2NJErKmig/EfukTcwPMKjdf02vE+8jTpjzp
         lIPv8NNu6/cZQOvtrNAuqdQ76V4cccRirGgIAUVT4Bb4A8CFK26nL6fs/nGImB2kyot5
         cidb/5GVBDEhg9mr2OR0E1Su0L+XxGV8wr63jyqDNIlcJhi5tTU/2jMMvrYtgyaR0qf2
         EYKfRI5dCdULY+YA+2/ZuEZlFCKUrCv4wDbBdwsCnMfMYY+SUewvjrG91wrYQriF4+tT
         G9YX/tZIK3OvW0r5LRbtwRR5JVs2Iy1VVJRNG/jXoOjGadVnnetF/s9Z3OBLIb/XJjXo
         tW5g==
X-Gm-Message-State: AHQUAuZ65KOkQWGi8nwvhKhjTzuFIy1EoRItDKH5at17CRsOsHNLhYUo
        Ly52pH4nMSdwkQWWuhNJIbfQA0Ek2kqlRuaoO4ou5w==
X-Google-Smtp-Source: AHgI3IZZYAtg5s12Ud90R3bvVoRnr4n3usuMfUADjKPW9ElCIFdhflS44o1wDq5RB+TEvYwQPnbuwgDblz3psyF+nZY=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr3039586vsi.191.1549466109322;
 Wed, 06 Feb 2019 07:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20190205154225.14264-1-wens@csie.org> <20190205154225.14264-3-wens@csie.org>
In-Reply-To: <20190205154225.14264-3-wens@csie.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 16:14:33 +0100
Message-ID: <CAPDyKFoZYY4O_eXExvZQvJcnyHLc+JfQMbDmUe9mxJwR6QtchA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported modes declared
 in the device tree
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 at 16:42, Chen-Yu Tsai <wens@csie.org> wrote:
>
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> This should be backported to stable kernels in case people try to run
> new device trees (that declare newly supported modes) with old kernels.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7415af8c8ff6..70fadc976795 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1415,6 +1415,21 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto error_free_dma;
>
> +       /*
> +        * If we don't support delay chains in the SoC, we can't use any
> +        * of the higher speed modes. Mask them out in case the device
> +        * tree specifies the properties for them, which gets added to
> +        * the caps by mmc_of_parse() above.
> +        */
> +       if (!(host->cfg->clk_delays || host->use_new_timings)) {
> +               mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> +                              MMC_CAP_1_2V_DDR | MMC_CAP_UHS);
> +               mmc->caps2 &= ~MMC_CAP2_HS200;
> +       }
> +
> +       /* TODO: This driver doesn't support HS400 mode yet */
> +       mmc->caps2 &= ~MMC_CAP2_HS400;
> +
>         ret = sunxi_mmc_init_host(host);
>         if (ret)
>                 goto error_free_dma;
> --
> 2.20.1
>
