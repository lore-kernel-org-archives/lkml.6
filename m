Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F0EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701DC205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjeZMTvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeH3QcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:32:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34540 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeH3QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:32:19 -0400
Received: by mail-io0-f195.google.com with SMTP id c22-v6so7401818iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y+ti2KZ69iZTKM3pLlD6GjINKXLsWissg8Rv9bx1P7g=;
        b=FjeZMTvrng5bXBRQkRItQmNcVWx9+nTQH+zLaJNTHSmDdk/z59LFnFW+hmkz+8Y97e
         U+kMhj9FAiVOTNNs41FecEq5BvnieVM97DPAmcCKW5UsB9/gIiDmDkOFUhjWYJ+h+mt6
         iYpGXzlZPCcYBToOL4aTouDDlcobm1MTRYBzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y+ti2KZ69iZTKM3pLlD6GjINKXLsWissg8Rv9bx1P7g=;
        b=sWmrtzgMj6BJj6/mv1mEKH4V58xBIBkhiM87Ovc5bu1r4e2cKQ1vUzSv9xbi5t7XP8
         8MI0KZK+HSkYXgayxQ5B9GJkb+PUSQgfTp0+Crr+rFs1evZVzOuAxAMwE1oI4ly85b9D
         doE/a404GQZ2HZ+1mX2yEbbSjJi2VycAW1rsXwjY90q3ocsfmX9pYGLcj1hH+kCY0hsY
         pb1+KVGyq+3HgN58A/3SgKoTgAOcqAQhXTTueIfIR12Yx9h6RHpREQrkS401Q8GYTt2f
         yje3I2QTWsM3zZlg+m493/Oj/wa3ejqkW9nK5mQXobie86lnNq8omwJW+/r1rI3TIpZB
         4egg==
X-Gm-Message-State: APzg51Aq2erKJfalhr0esS0vHpjBdbT9Kj4oYsoM30yBTYnTyBOV+lVZ
        5+C22pJ70W3GzOYLT60duSsQI/ESob6RTx1lJrpGZg==
X-Google-Smtp-Source: ANB0Vdazm0pZYg/n2+aMEloY5fju2DppFRStwmFIQWEV70NBXf2gPx98/rM0VKoJNvpRbzMoWrhp2PUgt3Q6sBf+MH0=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr8652902iou.218.1535632223607;
 Thu, 30 Aug 2018 05:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 05:30:23
 -0700 (PDT)
In-Reply-To: <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com> <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 14:30:23 +0200
Message-ID: <CAPDyKFp-ziw_4zQGAj06YtHZbToiOenWXgxNLpsToPDtuU9tPw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mmc: renesas_sdhi: merge clk_{start,stop}
 functions to set_clock
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 06:44, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> renesas_sdhi_clk_start() and renesas_sdhi_clk_stop() are now only
> called from renesas_sdhi_set_clock().  Merge them.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/mmc/host/renesas_sdhi_core.c | 38 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index cb6e889..0e88737 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -155,35 +155,17 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
>         return ret == 0 ? best_freq : clk_get_rate(priv->clk);
>  }
>
> -static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
> +static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> +                                  unsigned int new_clock)
>  {
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> -               sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> -
> -       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> -       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               usleep_range(10000, 11000);
> -}
> +       u32 clk = 0, clock;
>
> -static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
> -{
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> -       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               usleep_range(10000, 11000);
> -}
> -
> -static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> -                                  unsigned int new_clock)
> -{
> -       u32 clk = 0, clock;
> +       if (new_clock == 0)
> +               goto out;
>
> -       if (new_clock == 0) {
> -               renesas_sdhi_clk_stop(host);
> -               return;
> -       }
>         /*
>          * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
>          * set 400MHz to distinguish the CPG settings in HS400.
> @@ -206,13 +188,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>                         clk &= ~0xff;
>         }
>
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> -                       sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
>                 usleep_range(10000, 11000);
>
> -       renesas_sdhi_clk_start(host);
> +       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> +               sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +out:
> +       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> +       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> +               usleep_range(10000, 11000);
>  }
>
>  static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
> --
> 2.7.4
>
