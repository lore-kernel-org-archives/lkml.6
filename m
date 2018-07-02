Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE78DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72970259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFPGhTnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72970259E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeGBNRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:17:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35140 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeGBNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:54 -0400
Received: by mail-it0-f66.google.com with SMTP id l16-v6so11958245ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i9zvTE/M67n0LKq3HRoArel2yfH6MG4OrLu8ZPNqwy8=;
        b=KFPGhTntFWIP4Zf6BqmCidMMR9Jyz1Dm1/jbszsgOCq5c9844Mpk0i6RxP+PXKff96
         DW8T2xzaEbDwuExyDa0XZjCROPVt4g8vrjdS+9OlbARgTZ/3OUhn7AqIbgCUoYDpi7XR
         Ztn4qlpQsTpxcgOoJSh+3t/D3gdxQM7RLjSwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i9zvTE/M67n0LKq3HRoArel2yfH6MG4OrLu8ZPNqwy8=;
        b=Gu48L3P7dgN+rry9SBEBYWkPIVoMWR/pcYcrNhddp+bILKQ6yhSjFSOOhsPDqlNMtf
         lWLYpU02z6EyIuLJ9Ryo0NeoSJlhIRfeOtnYH3cD7LaE6ALftdgx8jiZmk/cXEfvLWYl
         rGcl3ME0NAQiyAZKNvhNBGQNFgAaR2DWuJfbhvOYudDHuYBsY2hRmjgMJx5Xc8uEvcOr
         yHWGk/ddnNLQO+8N7Afw0jp0uvJ3Mj8MINOjtspk9tnIFymm5sLsyyHM4oXrZUFTWr8Q
         M5XIa2UHVfvfdN1o0BLF6KLpimNtUJWANmnJkbULrUrnp+Zq29l8vkFWmcrCL8UkTxhj
         9kRg==
X-Gm-Message-State: APt69E2YNKi+Q7EQvpP7jAHxJOFS46uberSl+5mz855gV1eggWQ5k9Pm
        zv73ZHslNORkT9aaKzR0hTwS2l/WuOTEHzuu1dbr3g==
X-Google-Smtp-Source: AAOMgpcAd7Nu2+wglND2hADgthtVYSJK/e8hsHINp9f6lpKOmBfBuhNmhXs4WX8eLm1MPXiMCJjtrJ7Wavl+RAudMjU=
X-Received: by 2002:a24:d00b:: with SMTP id m11-v6mr6095818itg.97.1530537413609;
 Mon, 02 Jul 2018 06:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:16:52 -0700 (PDT)
In-Reply-To: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 15:16:52 +0200
Message-ID: <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 17:35, Aapo Vienamo <avienamo@nvidia.com> wrote:
> The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
> and tegra_sdhci_get_max_clock is removed. It appears that the
> shdci-tegra specific callback was originally introduced due to the
> requirement that the host clock has to be twice the bus clock on DDR50
> mode. As far as I can tell the only effect the removal has on DDR50 mode
> is in cases where the parent clock is unable to supply the requested
> clock rate, causing the DDR50 mode to run at a lower frequency.
> Currently the DDR50 mode isn't enabled on any of the SoCs and would also
> require configuring the SDHCI clock divider register to function
> properly.
>
> The problem with tegra_sdhci_get_max_clock is that it divides the clock
> rate by two and thus artificially limits the maximum frequency of faster
> signaling modes which don't have the host-bus frequency ratio requirement
> of DDR50 such as SDR104 and HS200. Furthermore, the call to
> clk_round_rate() may return an error which isn't handled by
> tegra_sdhci_get_max_clock.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 970d38f6..c8745b5 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_set_uhs_signaling(host, timing);
>  }
>
> -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -       /*
> -        * DDR modes require the host to run at double the card frequency, so
> -        * the maximum rate we can support is half of the module input clock.
> -        */
> -       return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> -}
> -
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
>  {
>         u32 reg;
> @@ -309,7 +298,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = tegra_sdhci_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> @@ -357,7 +346,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = tegra_sdhci_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> --
> 2.7.4
>
