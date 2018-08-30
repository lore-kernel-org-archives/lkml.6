Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35411C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF13620834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JR2ZnL+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF13620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeH3Qc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:32:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40278 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeH3QcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:32:25 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so2413547ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SHqnC8flpw6Cp68GX/cMG2kHJgDCCdVNvD3yOJ2WdSo=;
        b=JR2ZnL+jSTud9ZmTqqOqnOVsNzD1moU+3V7AzH6FClvwUlDRJSsEjgWYCaVbX36NCQ
         hbH/0ecNy8N3A4up6YRxO8GtVhsE0yAimB5OjHvedSmhKSgR3jSYzyjAFpya20qPJ29f
         Zg0xj9ByFCuUMSl0fTjank2843dgkMLt1fpjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SHqnC8flpw6Cp68GX/cMG2kHJgDCCdVNvD3yOJ2WdSo=;
        b=fcpPWyX5G+J2jB7+4LKwMVRq583J1GcdkASRZ/9Y7QITW99sr1dYxXwNvYWUdAaLm7
         UCqWx9CIbfrx8MUspoZSwh6iSwzj1xFCrIdvo70T0+jYn3EpCogYSKIM261HJ1AYYu5u
         ZmlnbjTXXrCLPZJXNDmZgCCzcIx031GeZtTMFGca7jgOhlo9DBTDNWxUFwFibRuaFdvN
         LiWUxjVLshMjLavh759SKAORAmkFQ+br6LXG3bT7w4m7vYc9q6/1CegCSJBVSsfQ0b+M
         zU1106Hlohf04xbvnsyvh2yG4KCinVAqa8HxMAasG7fJC+ttZui/7sgZkcPuzXnLnfae
         5BOg==
X-Gm-Message-State: APzg51C/eE8ztqVraaeb6HroBYZgHjkEgaTNVT4LGBX8mLGoDOb4aEmo
        aX51LsyA/f+Ut1RDcfyEO1x91278ndCO72BoOkOUVA==
X-Google-Smtp-Source: ANB0Vdb2XlpHWfZ4w0G1sxIlaA06R9nHXK5XOX6FOM/xGpmAkCBRzZAUVvqcMAwjXM6BeP+HYbpH/PyphCCeEBH05vI=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr1809253ita.64.1535632229959;
 Thu, 30 Aug 2018 05:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 05:30:29
 -0700 (PDT)
In-Reply-To: <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com> <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 14:30:29 +0200
Message-ID: <CAPDyKFpHHviQevw_rH3LzT7jMeLuYOyhmGD6+TwDx4AmfsDeuw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
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
>   for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
>           clock <<= 1;
>
> ... is too tricky, hence I replaced with
>
>   roundup_pow_of_two(divisor) >> 2
>
> '(clk >> 22) & 0x1' is the bit test for the 1/1 divisor, but
> it is not clear.  'divisor <= 1' is easier to understand.
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
>  drivers/mmc/host/tmio_mmc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index b031a77..e04c322 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -48,19 +48,27 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
>  static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
>                                unsigned int new_clock)
>  {
> -       u32 clk = 0, clock;
> +       unsigned int clock, divisor;
> +       u32 clk = 0;
> +       int clk_sel;
>
>         if (new_clock == 0) {
>                 tmio_mmc_clk_stop(host);
>                 return;
>         }
>
> -       clock = host->mmc->f_min;
> +       divisor = host->pdata->hclk / new_clock;
>
> -       for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
> -               clock <<= 1;
> +       if (divisor <= 1) {
> +               clk_sel = 1;
> +               clk = 0;
> +       } else {
> +               clk_sel = 0;
> +               /* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
> +               clk = roundup_pow_of_two(divisor) >> 2;
> +       }
>
> -       host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
> +       host->pdata->set_clk_div(host->pdev, clk_sel);
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                         sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> --
> 2.7.4
>
