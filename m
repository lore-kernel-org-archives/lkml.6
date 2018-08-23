Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F5AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D59320C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXuiClte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D59320C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeHWOMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:12:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40395 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbeHWOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:12:39 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so6940280ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ReE1zRBX9lJQoh1dcoEwTvD7SMWq7KfniaRoSBaiOP4=;
        b=NXuiClteD+xrP61+LN3EiikKhQdjHwgdiU1GDS9XT2g26WMVxuCiIjmt0PDm0j/iuL
         R7USeZqlUtNEb7QbkpB5eyJ6iUEwxtEk+zjiUTYAxP/4I2WtM7zSMOYlRmiSjK2SaRXM
         tOb7jF7p1M6/bYLAlJTir48xDPF7IkOq4jrsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ReE1zRBX9lJQoh1dcoEwTvD7SMWq7KfniaRoSBaiOP4=;
        b=Uy9Yfu4GpMGgymL43mcvmtSVZoLAxUinminjtaVGYYiJ7K1WQePtzsXRVAFvhum85m
         IdfJCnRGvbzvqAH9XUfG643jAbLtMmHWfoPT/QJ4zj54xeT5866Tjzvj1g+zcnGYmuNI
         69/TBsWQBt8iZuLSEifSsAemS8sWT22d1ZKJyrJ4kkM27HJ+i8k0NT1TEqF2psmEK67m
         jRjywAg0LJTYrUcWFJi00nWkI0SwvtyKCA5hbuPccwbWdHbNyba57C8E7qFro9IbpcP/
         gU6BEVu+2SzHsFUK1rTaPoUB4VDOfrva8OixJrX5oII5/xSuStHL2arFCzmSkOHrZphO
         au9w==
X-Gm-Message-State: APzg51CzSp3YdhWPg7taRY/rS/PngezlyK4fF9NRU5toKKdK5mhJorom
        NQUjmHXfgYqGXirRsUyMvYGm0sy8CK6T7h7aB9dZnQ==
X-Google-Smtp-Source: ANB0VdYNpZeThq/bfj473w4BXBJDvVjpdm3gMCO4rHjjBWzirny6eoch7De33H0nRZi7IdjdcwuUvV3A2SQik4heYJ4=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr6478500itb.45.1535021012311;
 Thu, 23 Aug 2018 03:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 03:43:31
 -0700 (PDT)
In-Reply-To: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Aug 2018 12:43:31 +0200
Message-ID: <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 06:44, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add UniPhier SD/eMMC controller support.
>
> As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> The clock rate setting is platform-specific, and UniPhier variants
> will add another way.  I thought it would be better to split this
> to a hook to avoid a mess.
>
> V3 is rebase on top of Linus' tree.

I have queued patch 1 -> 4, waiting for further reviews for patch 5 and 6.

One minor comment of patch 4, see separate email.

Kind regards
Uffe

>
> I dropped 6/7 because Renesas added more quirks
> in the current MW.
>
>
> Masahiro Yamada (6):
>   mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
>   mmc: tmio: move tmio_mmc_set_clock() to platform hook
>   dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
>   mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
>   mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
>   mmc: tmio: refactor CLK_CTL bit calculation
>
>  .../devicetree/bindings/mmc/uniphier-sd.txt        |  55 ++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  10 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c               |  48 +-
>  drivers/mmc/host/tmio_mmc.c                        |  56 ++
>  drivers/mmc/host/tmio_mmc.h                        |   4 +-
>  drivers/mmc/host/tmio_mmc_core.c                   |  92 +--
>  drivers/mmc/host/uniphier-sd.c                     | 693 +++++++++++++++++++++
>  9 files changed, 871 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
>  create mode 100644 drivers/mmc/host/uniphier-sd.c
>
> --
> 2.7.4
>
