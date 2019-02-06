Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBADC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14622080F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzJesEv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfBFPPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:11 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35362 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfBFPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:08 -0500
Received: by mail-vk1-f194.google.com with SMTP id r127so312240vkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOLpN+UPyqi3jWVs1lK5bodoiB7hCCj3LPiz8kTnc9U=;
        b=GzJesEv8L88m2tX+QPApEgdEind3pCZzlPeZWVXX/rQbwYocOfQBQi3cqOA0H21On1
         sHqmTkoHLpLVw0ysf3TPQaw2KYfjlkTT0AplL7H3DBNsDUSJlgZVjdGH4ihmKlgaEp4y
         jL/ZIoZW1dGIMUe5YHG6n0vKJRH4XDs1b38wkBsG7QXsuJO+ThtgJaR6uvxMus6Ttew9
         DmQieTmSYxHilM+mtfhdPBbLnJxzpbpd8ocial5a9TV9O39m1vn+j0972r4eRXPd0t58
         POlA8gh6jaRJm9XIiqjQc6BiU8Z/vROztYQNxzCi1x6+RWobZF4+Ejh6fJSxMMpxHKij
         qLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOLpN+UPyqi3jWVs1lK5bodoiB7hCCj3LPiz8kTnc9U=;
        b=q9lKJwEjMXY8+ZxxxcT8Qaxt/ABY8fNw4EUE5OxwG7dBA0QW00Zlb9Qf3AFMGC/fuI
         53i2uRte0v8qWs063qjoTr5Pd5/sY7SZFggpcoBQN03CIqljSnBYIsr4FlAqlxjn4kj9
         g3Whf6mnFh9zHdpE1XNnGqI2nKgD1htGY7NUGNc4R0C4HAaEhxUexRAJNOfqxrx3zTnB
         o2xIHCMQnqy9mtTlxPJxrvHKW2sqS14VjXBm/9bDVJ3A9fU+s1eSBCjraXNVaIvO49pR
         EGZPZXbhkDG1qhVWZg7Lqs2VSzlJS1KNOl8tlu9D5MGmhDwDMJF+G1Mdj6Jne9Hg3bhX
         RSfw==
X-Gm-Message-State: AHQUAub8Iq1g6lsRd9I5wZsM/Qq8KYdTsBxaAIc2Wi0o7/2UhKkksPrl
        wvMZBTtT84DSJQZKo8aHkj2PJwXli6AhO5mjP6R8xw==
X-Google-Smtp-Source: AHgI3Ib3ugbbM2J77i0603ijXnbiapcjFbQgHQTN4TnBePBlhST/J7RnZhON4+u8AImspWH8bjlE+ROCaUmN54zHp3w=
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr2914628vkd.40.1549466106949;
 Wed, 06 Feb 2019 07:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190205154225.14264-1-wens@csie.org> <20190205154225.14264-2-wens@csie.org>
In-Reply-To: <20190205154225.14264-2-wens@csie.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 16:14:29 +0100
Message-ID: <CAPDyKFq0RbeFXcK71x_NUE6=EbqGyoCp-ac5vuTgYh85o+X61Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC
 controller by default
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
> Some H5 boards seem to not have proper trace lengths for eMMC to be able
> to use the default setting for the delay chains under HS-DDR mode. These
> include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
> Computer ALL-H3-CC-H5 works just fine.
>
> For the H5 (at least for now), default to not enabling HS-DDR modes in
> the driver, and expect the device tree to signal HS-DDR capability on
> boards that work.
>
> Reported-by: Chris Blake <chrisrblake93@gmail.com>
> Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
> Cc: <stable@vger.kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 279e326e397e..7415af8c8ff6 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         mmc->caps              |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
> -       if (host->cfg->clk_delays || host->use_new_timings)
> +       /*
> +        * Some H5 devices do not have signal traces precise enough to
> +        * use HS DDR mode for their eMMC chips.
> +        *
> +        * We still enable HS DDR modes for all the other controller
> +        * variants that support them.
> +        */
> +       if ((host->cfg->clk_delays || host->use_new_timings) &&
> +           !of_device_is_compatible(pdev->dev.of_node,
> +                                    "allwinner,sun50i-h5-emmc"))
>                 mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
> --
> 2.20.1
>
