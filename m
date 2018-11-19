Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE3BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5954C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkDkVOg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5954C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeKSXm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:42:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53765 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeKSXm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:42:57 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so6542506ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=68ZfZgBYmAca76CNawEEjYFB6qR2nah942zM4pDvw1g=;
        b=TkDkVOg3BhJ9FXTLJ8WAM/wtGuMuB/YjftgN+hHYHO3FlKPW8OEbSTfPEoSDJ7WLZ4
         XecKsIGsViQUEnnWa8H1QGhwMac50IyOZZPfat8yq2A3HAfv0yAdzV/pMPVgz57V0ieY
         0ayxcaFQWElLxQucu1zvatnt/Np3qGaMN38Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=68ZfZgBYmAca76CNawEEjYFB6qR2nah942zM4pDvw1g=;
        b=gjMprAQB683ESAjrpAznolOjYU/v5LyZm/BClX1/rZLRc6fuhtMmboY6B1/PwcuKmj
         GkLGmRXFytUToFVLE4HQIp6FnU66LMncy43/myKc12hG894loNOiNF020DS0A5lNl6bf
         a1Lz85iXtbfDMa1WgUcNklNtyqlKO9Zs6XWKZaxXROlAmCyA9ZA4M9vVXrcf2uM/uOKL
         7/9vcVJnonitoDjUWnXAyCjJjaI7PvhEvAaXuPOtxKA80PpXXnpKlMDTMjhneDGUYRut
         7z3OF9NwjGU9uY3sitgeRqU94jJyS2SYnqDhWSbl+DZxuKqJ30zcSizTK/l0iZH7NCq1
         uacw==
X-Gm-Message-State: AGRZ1gLXiP02VFleacOm9IoaQWWxK24phU/3t6lpAL+8jmpyM5uiSTe2
        AFJgMbS3EO8GwqFhuU/JN6Q/cprJnegP8ODEdoUVEQ==
X-Google-Smtp-Source: AJdET5eHRSOdgZ7LZbGjs4lFpCaQBFQjJZ+TY0BfIyIZfOr1XqVQvwORgKvwVkjKiVMAM1qA+aAYeR8nDAQt9j72RuE=
X-Received: by 2002:a02:a681:: with SMTP id j1mr18492346jam.43.1542633560228;
 Mon, 19 Nov 2018 05:19:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 05:18:39
 -0800 (PST)
In-Reply-To: <20181119111618.2745-2-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com> <20181119111618.2745-2-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Nov 2018 14:18:39 +0100
Message-ID: <CAPDyKFo==Up-pTGZcjMvKWY70-m7i44A5Yr_qJjtpBFjWK8J5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during tuning
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
> disabled DCRC interrupts during tuning. This write to the interrupt
> enable register gets overwritten in sdhci_prepare_data() and the
> interrupt is not in fact disabled. Fix this by disabling the interrupt
> in the host->ier variable.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Should we have fixes/stable tag?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-omap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 88347ce78f23..87138067e334 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         u32 start_window = 0, max_window = 0;
>         u8 cur_match, prev_match = 0;
>         u32 length = 0, max_len = 0;
> -       u32 ier = host->ier;
>         u32 phase_delay = 0;
>         int ret = 0;
>         u32 reg;
> @@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * during the tuning procedure. So disable it during the
>          * tuning procedure.
>          */
> -       ier &= ~SDHCI_INT_DATA_CRC;
> -       sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> -       sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +       host->ier &= ~SDHCI_INT_DATA_CRC;
>
>         while (phase_delay <= MAX_PHASE_DELAY) {
>                 sdhci_omap_set_dll(omap_host, phase_delay);
> @@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>  ret:
>         sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +       /* Reenable forbidden interrupt */
> +       host->ier |= SDHCI_INT_DATA_CRC;
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>         return ret;
> --
> 2.19.1
>
