Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A15FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E0208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="djQ6NSss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4E0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeG3QnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:43:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50664 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeG3QnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:43:24 -0400
Received: by mail-it0-f65.google.com with SMTP id g191-v6so6645791ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ILo4JCLTw1IKQrg+mW1sKsL/tYnm+d93robLPtzv7KM=;
        b=djQ6NSssLubG7PC1KjKzNlhgSNxenv9kG74k6y3hLyQQdcaKKZ2SXKktsTKI3Q0PFc
         LpgdClo8CZFtI5m7fEjoy78DTdjKSMkRl3r53bh7xS+Tapfx5SajLpDT7txb68xFlPva
         x/WXEKaVWgz6IJC+ZxtXwuNKAr37EdSZHFUSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ILo4JCLTw1IKQrg+mW1sKsL/tYnm+d93robLPtzv7KM=;
        b=CfGZa3zGBRw4qsYpvwk8+rESr6gNATLERbyGTKXXsjaZZrPTPK9kD8CMFiGsXyFlzn
         Z+Pac99Ax1PNQQXUka22ia79XN++QoA7BdrL4pEtnzhG8svhTobuiLqmv3RbJwDonqAt
         xw1jO0QjyEcjY3Qkiv8S0xkeq9xUlMRWMsWUKfiAdL8lrS5iifQKSMq2w8krZR5SFFUR
         K+rTmfl0G0kfONCiFUlHmwYHOkwT4h4GKBdwpn5j6WeLwghJzubJW+P19Q2fFndemWkR
         gSfBheCTHMuK4NlIzlAepTvDCCmbiJyjLUy7PP4HrNHLPmBWqKb3sZEId/djQmKabkib
         ZeGQ==
X-Gm-Message-State: AOUpUlF7KIX2j3E5CnjdpUE9Lw9Wo/Bnrry0rSE9K6aAtdyHd1yTNLIv
        Bmfw75XZSTrLLhpuMrgvRu8OHozUkRvsMfqDmzZrVg==
X-Google-Smtp-Source: AAOMgpeDLpD8v9HXFy9FGWHUy3hAYxPKlwuDHZ50gDEdUEgLelj+1jfWHkf6ibxXaDEzDx0I5ShadsjlGjQvKm5UIiw=
X-Received: by 2002:a24:4524:: with SMTP id y36-v6mr1548556ita.97.1532963279556;
 Mon, 30 Jul 2018 08:07:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:07:59
 -0700 (PDT)
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:07:59 +0200
Message-ID: <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 July 2018 at 14:26, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Hi all,
>
> Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
> procedure to match the ones specified in the TRMs of the more recent
> SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
> should not break things older generations either.
>
> This series depends on the "Tegra SDHCI enable 1.8 V signaling on
> Tegar210 and Tegra186" series posted earlier.

According to the cover letter of the above series, it states that it
depends on $subject series. A circular dependency. :-)

In fact, there should be no dependency at all or else there seems to
be a DT compatibility problem here...

Anyway, I think it actually makes sense to fold in all changes into
one series. Make sure the dt-doc changes comes first, then the driver
changes and finally arm64/dts changes. This should make it easy to
follow the review and I can pick the mmc parts and the soc maintainer
can pick the arm64/dts changes.

[...]

Kind regards
Uffe
