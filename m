Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F079C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520CB206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJwq4Wvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520CB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIGNbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:31:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33679 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIGNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:31:22 -0400
Received: by mail-io1-f66.google.com with SMTP id r196-v6so969794iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4pIKyMPKKSnb7/xtYPH+wKT3CsWlu6Aj86WRcZ9z3F0=;
        b=WJwq4Wvf42/1h/3oADQzdUZq4mrCY45zQUizaauAvdngAJHGjIzY4J9Q3c2sUYFJWA
         UJKD8k7hiZlMW6vZDOk8vSHL6G/LBp4/5phV/5GeUod2uI9MUcB/EyEgqLkEaQZORW99
         p4CG9NgfM4U+2i/ddYyVde6Y7Olsodu85ISaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4pIKyMPKKSnb7/xtYPH+wKT3CsWlu6Aj86WRcZ9z3F0=;
        b=Cov1ACMvO9ueWwJlZ+IdXRGwiPM5PeupIu4/tMwX4ggKjNDa+VfI8M5BvGjoAe7knQ
         IrWsOw62j7LP9BIwkQ86JpyBKL0u9yW3aBWhjKaNEhYSzmYYxXAvXz9ZNYElCF4DZl27
         0nsHBDPhWN+mG70Cln8KTG3Wehz633UNozJ5lhWEtd2QjcWiUXtrZ/kCzararlHGnXS4
         3Tl/b7eNaYUYhKtECGJhLA3wGDwEJdJyY7mPp3ZHCnRnWJbe6ZLvbJ4MXycVk/l66BxL
         X0K2T3HgZZegJCS1cQzU7088HMoWrWUrFIKisNV7WlcZNP7re3bKJzs1LuWD508XwRzw
         Zzyw==
X-Gm-Message-State: APzg51C3aFannpDs2AYAKjsDluhXr2r5dsCE0A2KAdlrJ1vWLcxYQT8i
        IiZ80IINFB4t47+7GRFbL0LlgN/0atjd/I/A25zAaQ==
X-Google-Smtp-Source: ANB0VdbNXU2nNmIBPoIrgveEuvIPo15boVt42iG2rXo/YvO74ktKkmsUBYLeVyRBPgYNOXzqUyErXJtyuAVb8rGuyIA=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr5439279iof.266.1536310285577;
 Fri, 07 Sep 2018 01:51:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4f9a:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 01:51:25 -0700 (PDT)
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Sep 2018 10:51:25 +0200
Message-ID: <CAPDyKFq4x74p807d9n3kmn9JpT8RRmABvSrsb6JujxGbANDLcA@mail.gmail.com>
Subject: Re: [PATCH V8 0/9] mmc: add support for sdhci 4.0
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 10:21, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> From the SD host controller version 4.0 on, SDHCI implementation either
> is version 3 compatible or version 4 mode. This patch-set covers those
> changes which are common for SDHCI 4.0 version, regardless of whether
> they are used with SD or eMMC storage devices.
>
> This patchset also added a new sdhci driver for Spreadtrum's controller
> which supports v4.0 mode.
>
> This patchset has been tested on Spreadtrum's mobile phone, emmc can be
> initialized, mounted, read and written, with these changes for common
> sdhci framework and sdhci-sprd driver.
>
> Changes from V7:
> - Added Adrian's acked-by on patch 1-6;
> - Addressed comments.
>
> Previous patch series:
> v7: https://lkml.org/lkml/2018/8/29/130
> v6: http://lkml.org/lkml/2018/8/24/205
> v5: https://lkml.org/lkml/2018/8/16/122
> v4: https://lkml.org/lkml/2018/7/23/269
> v3: https://lkml.org/lkml/2018/7/8/239
> v2: https://lkml.org/lkml/2018/6/14/936
> v1: https://lkml.org/lkml/2018/6/8/108
>
> Chunyan Zhang (9):
>   mmc: sdhci: Add version V4 definition
>   mmc: sdhci: Add sd host v4 mode
>   mmc: sdhci: Change SDMA address register for v4 mode
>   mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
>   mmc: sdhci: Add 32-bit block count support for v4 mode
>   mmc: sdhci: Add Auto CMD Auto Select support
>   mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
>   mmc: sdhci-sprd: Add Spreadtrum's initial host controller
>   dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
>
>  .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
>  drivers/mmc/host/Kconfig                           |  13 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-sprd.c                      | 498 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c                           | 223 +++++++--
>  drivers/mmc/host/sdhci.h                           |  28 +-
>  6 files changed, 754 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
>  create mode 100644 drivers/mmc/host/sdhci-sprd.c
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
