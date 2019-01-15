Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D418C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16CC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHeMiLhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfAODK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:10:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33540 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfAODK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:10:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so1078225oib.0;
        Mon, 14 Jan 2019 19:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5KmkYpJA/KK91DqJdyqJiZYDbcMfiTcwYilq3TSd9A=;
        b=pHeMiLhWvVPxVFvIxjDKmnEtXAZ2SvYQa9Rn80wesevOhhf26EwVcoWBP+eyIOZkQh
         d0w+h2arFSCR1+XciE7DahUNOs+yhxIphtycqoHq6N3aRTxHIXiM2PGvdtgcCN1yX3LI
         YrCFVSF8EfRRm81mdWuEXHrmYSkYy38s7uXgIwIX3sepWaPXT/XAPfeswdGIFLQW5lgQ
         GQ7OTWOZX9FkkcheXaOtFSPmAY5sNXrnfq8SGbpq7tD5g4GQtnOxdB8ro2V75rSjamh8
         3VGkojuC1+g9K6ZcTwKwl49bEuyWOBE25CXwGxPHMt+rPM256BqX7WST6YRIF3zr4fqd
         S7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5KmkYpJA/KK91DqJdyqJiZYDbcMfiTcwYilq3TSd9A=;
        b=uJAgb+bZ4V84u63EjK/87fLU+NDV7RfyfUipnvOR4N10ellGN8jvqN4WlKqKdQsCjC
         0bm+H86r9hHGqrSbP6VvT2+dtGfpPSqFOIYuXj7BLpcpKrjMgR0qu4u6y9Pjfn1iu3O0
         mQAi1PtAB07JB1vm+Yg94EjKOarRdeoTNcv9yq1QG0ck/zPB65JO7r176XK66yhCVVc9
         jvPu7FTrkP9lbty9VsC2S+DX9OA9CrPe9NYvSIoar5W5viLoW6h2WV/z4YfJod6uiJjp
         xiocotGbcjx4ZzfkrKhy+VlAXafFvXpEXbbOIzk+DXDadorFKjF47lQ2ryXepO455ARW
         l7DQ==
X-Gm-Message-State: AJcUukcjI4SVq/zPC99biArDjW0paGGao4npKDO0Fy3uhhUyvPa83b5R
        FrXwVmvAbIToIIVaa/HUcaJAJhDOqABKdDOvsWo=
X-Google-Smtp-Source: ALg8bN40uoE9LjcbwRns63fh4ijfhlyj4G7UOaSGEjSnC5AggoXnmhxe8EfDpe16cZhvlWi3RDfffbGCzbDIUnXZDDQ=
X-Received: by 2002:aca:e495:: with SMTP id b143mr807399oih.286.1547521857478;
 Mon, 14 Jan 2019 19:10:57 -0800 (PST)
MIME-Version: 1.0
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
 <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com> <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 15 Jan 2019 11:10:46 +0800
Message-ID: <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra SDMMC
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 8:58 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> >> +static int sdhci_tegra_add_host(struct sdhci_host *host) {
> >> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +    struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> >> +    struct cqhci_host *cq_host;
> >> +    bool dma64;
> >> +    int ret;
> >> +
> >> +    if (!tegra_host->enable_hwcq)
> >> +            return sdhci_add_host(host);
> >> +
> >> +    host->v4_mode = true;
> >
> >Can you use sdhci_enable_v4_mode() here?
>
> Hi Adrian,
> sdhci_read_caps sets v4 mode thru sdhci_do_enable_v4_mode if v4_mode is true
> sdhci_setup_host calls sdhci_read_caps so I was setting v4_mode to true so v4 mode gets enabled during read caps.
>

Hi sowjanya,

I also would suggest to use sdhci_enable_v4_mode() instead of setting
host->v4_mode directly.
Enabling v4_mode in read caps was just because that I was worried
about v4 mode would be cleared after reset all on some controllers. If
that's not the case for all sd host controllers, I guess it can be
removed.

Thanks,
Chunyan
