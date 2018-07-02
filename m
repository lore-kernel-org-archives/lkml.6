Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE324DAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzQ0M44I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CE324DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeGBOgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:36:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40092 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:36:39 -0400
Received: by mail-io0-f194.google.com with SMTP id t135-v6so14938658iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8KpzpYfw/art0ozFUYjjmrRJ84wgJAh0xaB7Z+74AUU=;
        b=QzQ0M44IGZijX162Ag1iOgbwOOYeEJ5bd2+Z+/xIOfZgdlZewMD99PNbVpqBYN+cIL
         8Kx2Y9E7jjfj+CetN6NEroXP1Cgfs6IUERqf3XnPwULfxWP1QuNT0Uyon6a0uGYvkCDf
         Ss82ITiHny3z1Y4QJOB2bwouu8BJBn3Zih4+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8KpzpYfw/art0ozFUYjjmrRJ84wgJAh0xaB7Z+74AUU=;
        b=QIWKy7TmWM4RU6JZIyfpECXVJLmI8MAVXaV2/auFhGeCr1xR+YvTPx/50Q1hpYM48K
         qDXk7XJIub1Em+FRxs43u7exPJf+xWtrS1PvBLF8Z0rT69wYDYXgt/k1EPwMLupAVYbV
         7cD5sMXBPvEIAEs6ADoMSgZPrQ+JudSAg5QhPTO+IvdHtaHsseu1PhL1y7KQvMfQjV0q
         D8iBfZu3UxMsWe6YiwSi2Hr6Mu+7wG+9rOHLd3Wg9dyetvOeEBZ/sIW4GlW6vsoONHWe
         5hfKweep9HUTdIDyDqUfI7ORiSJX1KN4wmx/79Jdyr96ZIKR12h/MGOFJ5Xrk/LfGeAL
         miQw==
X-Gm-Message-State: APt69E13XML45CA7TRQt4unev2ck8DPahTXKV0JieB5ebrl4GC0Qd7+B
        m8z2Pu+K70Cb599G/0TcUfjI6miDpR9EGcV8yi3VPQ==
X-Google-Smtp-Source: AAOMgpcXF6+vkg4ntNl8r8ZOtb+y5DnLOnaDypw7LWk0YvN4yrHzwIvfxvi3LxTKmdt5VtQ6b9LlWa1z2pjfY+rtBqs=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr15009008iof.266.1530542198761;
 Mon, 02 Jul 2018 07:36:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:36:38 -0700 (PDT)
In-Reply-To: <20180628081331.13051-2-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch> <20180628081331.13051-2-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:36:38 +0200
Message-ID: <CAPDyKFqazWbHfn=poZcbDXddsUVk3=Mz5m6-K-6wC7FD6O1jLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
> The field support_vsel is currently only used in the device tree
> case. Get rid of it. No change in behavior.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6f444731754d..20a420b765b3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>                              &boarddata->tuning_start_tap);
>
>         if (of_find_property(np, "no-1-8-v", NULL))
> -               boarddata->support_vsel = false;
> -       else
> -               boarddata->support_vsel = true;
> +               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>                 boarddata->delay_line = 0;
>
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> -       /* sdr50 and sdr104 need work on 1.8v signal voltage */
> -       if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> -           !IS_ERR(imx_data->pins_default)) {
> +       if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 7daa78a2f342..640dec8b5b0c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -34,7 +34,6 @@ enum cd_types {
>   * @cd_gpio:   gpio for card_detect interrupt
>   * @wp_type:   type of write_protect method (see wp_types enum above)
>   * @cd_type:   type of card_detect method (see cd_types enum above)
> - * @support_vsel:  indicate it supports 1.8v switching
>   */
>
>  struct esdhc_platform_data {
> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>         enum wp_types wp_type;
>         enum cd_types cd_type;
>         int max_bus_width;
> -       bool support_vsel;
>         unsigned int delay_line;
>         unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>         unsigned int tuning_start_tap;  /* The start delay cell point in tuning procedure */
> --
> 2.18.0
>
