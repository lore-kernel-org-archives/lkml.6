Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF1CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D259420652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt6L/1og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D259420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeICKc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:32:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39118 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeICKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:32:57 -0400
Received: by mail-it0-f67.google.com with SMTP id h1-v6so14123835itj.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nEMcIRfW8iPwL8DGCAlr4/RAlyGTXuiiMzrCdhWXKSs=;
        b=Gt6L/1ogKp7JaQTmxaZDY+ikPNy4izpjgYZEMmJdefnWK0PImtN8VGYa6v0543pM9/
         EUrBWdhIPleGy4d1vTUqzw0NhNZbpqeUAB5IBSRWLzL8SiqZUsPN0qRM/iZ81SZnRTbs
         Iob5AbgR7ObgV7DtS6sCGVEeawQdnDnk/YSXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nEMcIRfW8iPwL8DGCAlr4/RAlyGTXuiiMzrCdhWXKSs=;
        b=M8BhoP2diW39+olfjfM7e7hTGszcA5yDLk/t/SDxnX9RUUUtLcnC8ZcFKdsbOVQ6E1
         nqMVpM58y4g7qcCncaYx5y8YGqVyYkVTWja5lJaBmyZZ+jqPTFoSzcpemW6/9Fc3bSew
         TOhE2IOFWdQsIkyb6OHFGeHJBRMbAjgCsCAYqGi614Ci+cc8XaC/nhCp+6AIBFshKYZG
         3kiSSFyRJOm1+fsuTUGDuREpXL7X1jm7uvKU0gDBTdWZd0iQ+8qQ803k4ytARIj/9csG
         aLmQkAlM+rdCP8xhGSLNzA9TvfHy3rDPNUxzt8m76Uk12Pz4thLjcj1drvRL/Cb6v6EW
         v72w==
X-Gm-Message-State: APzg51DCQTeV3cmqnX522JhGBBmXMCkM8xZG801vwNrtQI3pP2NCD1Ob
        8ZUyu/YXIKWQAcsNWlN0eMSJ0tt+Cm4jUxiCaTE7Vw==
X-Google-Smtp-Source: ANB0VdZ0pILSwCbdp6C2VL+ToLay+mUkfwGNKdI8/iEIoA9ciIBiXd8Air9p3A94reUfiEYliK6EAIwRzpHZm3jfgMk=
X-Received: by 2002:a24:a388:: with SMTP id p130-v6mr3952506ite.146.1535955257609;
 Sun, 02 Sep 2018 23:14:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 23:14:16 -0700 (PDT)
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 08:14:16 +0200
Message-ID: <CAPDyKFqBin991q5P2k3jEjz6PxSYEQW9HwMzuC0nYz9u2yT9FQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 August 2018 at 20:13, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Hi all,
> This series implements support for HS400 signaling on Tegra210 and
> Tegra186. This includes programming the DQS trimmer values, implementing
> enhanced strobe and HS400 delay line calibration.
>
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>
> Changelog:
> v2:
>         - Document in dt-bindings which controllers support HS400
>         - Use val instead of reg in tegra_sdhci_set_dqs_trim()
>         - Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
>           value" commit message
>         - Add spaces around << in tegra_sdhci_set_dqs_trim()
>         - Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
>           message more detailed
>         - Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
>         - Add blank lines around if-else-block in
>           tegra_sdhci_hs400_enhanced_strobe()
>         - Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
>         - Make commit message of "mmc: tegra: Implement HS400 delay line
>           calibration" more detailed
>
> Aapo Vienamo (8):
>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>   mmc: tegra: Parse and program DQS trim value
>   mmc: tegra: Implement HS400 enhanced strobe
>   mmc: tegra: Implement HS400 delay line calibration
>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>   arm64: dts: tegra186: Enable HS400
>   arm64: dts: tegra210: Enable HS400
>
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>  drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Applied patch 1->4 for next, thanks!

Kind regards
Uffe
