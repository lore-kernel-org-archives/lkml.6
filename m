Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE0C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF55320881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAO0WWFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfAaH2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:28:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36075 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfAaH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:28:36 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so1405133vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4E2z4O0xcEXrOmkDYZ4PM2OXuuZsOm6EfZsp6/NjsYI=;
        b=YAO0WWFTjXfSbFuS2jaHIn0Xl/oQvYJ+jGBKgcv4+dZtrcOJUpQiFk2JQ27OsqBUZi
         nt6U95KAnrGh+XKuwDKMPr/yeHjg8RwTnALljf8xNVCg9E0N/APH8ZiN/6j4xqpRiWzS
         dFG/xvSx4UTRB6Xkgy9J93Xz0w1hqthaypqmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4E2z4O0xcEXrOmkDYZ4PM2OXuuZsOm6EfZsp6/NjsYI=;
        b=amC9jh1S8q8B7ZlYUTbtqcVpaiQdMD82soqwwCh6bf/lxhFpYBOKkKof2UUT9EQgB/
         9efGy5vBc2H62e+Mei6LeisiulGa/DiKFYnf2MMX4crxtMGDqZSGw0sv08jt6Tm/8zLt
         OLhX74mzE8AyRt4zH5J1vqvnplMC6i5EDwhDtcHTtYxLLoZaGtV5Ptjwu9Y3fe654Rq5
         dRyr/iGoPgSvxMgXEkZroY2mGIKaYY45qO5tn/Eopf4XcrDeEWdVKFCURsh+b9L9NbFd
         +k/saBkHBBjYj450lbFANGqhIlYrzPZ/O5IfzuRAkM6EEpw6VbKQLrIpXJJ+wGWVur1r
         C3bQ==
X-Gm-Message-State: AJcUukcc90aAcaXGz9L6R2HlH8MNSCdMUF+woZNMvk86adxFr7UT7zzn
        XK90ZnwImzVp/sgnIloPVUmtpHNWHAkxAZ62W6RoVQ==
X-Google-Smtp-Source: ALg8bN5v8EmRiuiaJ+mCXlQlPShGAE4wyC2YkWZuoX/BOnbP8aU2XBwAMFjJLNPJcSzDCX8YZx7GqafSWfqf4XgtQhQ=
X-Received: by 2002:a67:b245:: with SMTP id s5mr13944165vsh.200.1548919715357;
 Wed, 30 Jan 2019 23:28:35 -0800 (PST)
MIME-Version: 1.0
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com> <1548271854-1765-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1548271854-1765-2-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 08:27:59 +0100
Message-ID: <CAPDyKFqth+VYZgx3iHGWaUFe=RyiOwoQwy2jEEtLnGXqvsPn-w@mail.gmail.com>
Subject: Re: [PATCH V11 2/4] arm64: dts: tegra: Add CQE Support for SDMMC4
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 20:30, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add CQE Support for Tegra186 and Tegra194 SDMMC4 controller
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

To be clear, I am not picking this one as this should go via arm-soc.

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 22815db4a3ed..3dfdc4701934 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -319,6 +319,7 @@
>                 nvidia,default-trim = <0x9>;
>                 nvidia,dqs-trim = <63>;
>                 mmc-hs400-1_8v;
> +               supports-cqe;
>                 status = "disabled";
>         };
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6dfa1ca0b851..9ce1c91d4596 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -325,6 +325,7 @@
>                         clock-names = "sdhci";
>                         resets = <&bpmp TEGRA194_RESET_SDMMC4>;
>                         reset-names = "sdhci";
> +                       supports-cqe;
>                         status = "disabled";
>                 };
>
> --
> 2.7.4
>
