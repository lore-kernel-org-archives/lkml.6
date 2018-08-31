Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021CBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCC120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO/HFXWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHaRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:23:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42662 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeHaRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:23:22 -0400
Received: by mail-io0-f196.google.com with SMTP id n18-v6so10355528ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AnsPt+z33r1AA6UV2GGSIxQ5ykR+2qc6HRwgbnaHHzo=;
        b=PO/HFXWFxsn/WNAvfq98VV7nGFki+T2a0jHOg4GxhC2nfHp9DxAbpZ70I9TFS4kZ2C
         Um+YNXSxVWEmgm5kPG3pSdbXBUYWHCuUnzsBXNmT4/h9s3ljw7MRC65H8TYtiTOyXIdC
         3n3W5bG3tVLuy3n8ZX/vz26kv2fInP68pdQAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AnsPt+z33r1AA6UV2GGSIxQ5ykR+2qc6HRwgbnaHHzo=;
        b=XEcIfGWiSBw/KlHqpc5GRYZBvXw7m9kndiuAZtHVsZbvT+YuBQfpi/xwFsZFV8av3C
         xZaOny0TYwzRX4tSb2Cmp1ruSlOd1oCn7fHsgaLl8PxkoQ/d2hJo0ctytiAFoYmxo69c
         6vOsGPgaZlkyzd3TKMVDtZciVco39Rf0DlHn9nq72CRZLEkUb1604IubIFC56xOqX/ca
         N8Hyi5PCmxoe1O49XrxvDyVJzY9dI+pYUGPjVSzWZwI26PxXIQMuruBzbgrVLu5JRigw
         l6gw9UGtlfgh5mEy89MZ5sZOGnuPbZLPrAyt5RFzmUUXTJeAKmYeCuB+S/NvtvPNFcsm
         UerA==
X-Gm-Message-State: APzg51BBGizYfJ5mY8jCEPn9EpWacULL4krDhJYMKYJGMzYDYV+vMY4W
        h+UfIVNqCvmjTVgOaSeu1EsJMWM9BTapz5Qb1/sXmw==
X-Google-Smtp-Source: ANB0VdZH9Hmp+TJy8+hxbEtPAIR/Hc/V0ZDJgUd607IVNcqAjr/+gOfT8uk+CD5c1yKEU+JqoqzqM++K0rMyyEhqANQ=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr12443188iof.266.1535721355931;
 Fri, 31 Aug 2018 06:15:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5805:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 06:15:55
 -0700 (PDT)
In-Reply-To: <20180830150639.21048-5-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com> <20180830150639.21048-5-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Aug 2018 15:15:55 +0200
Message-ID: <CAPDyKFqrqNLH_bTsckL5WfM5G6xnhgd9BFQSjEzm2b+mRVJRsQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/38] dt-bindings: mmc: Add Tegra SDHCI sampling
 trimmer values
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Document the Tegra SDHCI inbound and outbound sampling trimmer values.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

I noted that Rob added his tag for the earlier version, so I am
re-adding when applying.

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9713e052f736..edecf97231b9 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -67,6 +67,10 @@ Optional properties for Tegra210 and Tegra186:
>  - nvidia,pad-autocal-pull-up-offset-hs400,
>    nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
>    calibration offsets for HS400 mode.
> +- nvidia,default-tap : Specify the default inbound sampling clock
> +  trimmer value for non-tunable modes.
> +- nvidia,default-trim : Specify the default outbound clock trimmer
> +  value.
>
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> @@ -77,6 +81,13 @@ Optional properties for Tegra210 and Tegra186:
>      - The SDR104 and HS400 timing specific values are used in
>        corresponding modes if specified.
>
> +  Notes on tap and trim values:
> +    - The values are used for compensating trace length differences
> +      by adjusting the sampling point.
> +    - The values are programmed to the Vendor Clock Control Register.
> +      Please refer to the reference manual of the SoC for correct
> +      values.
> +
>  Example:
>  sdhci@700b0000 {
>         compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> --
> 2.18.0
>
