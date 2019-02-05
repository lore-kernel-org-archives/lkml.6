Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFB520844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G44lrqCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfBEMtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:49:01 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33183 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:49:00 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so1075081uap.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 04:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZN1UpMBMmOw83+EwInVm2MuWNGrwZoLHs62Yuiv5fg=;
        b=G44lrqCvrBWiPQbtHulkqkth48zLb9tCqst5gfNwqJAn3/uTsYDCcd5hZsZSfk1h9c
         2/g6xYtAin+TycnAYwPQQZ3Me83RJVUoEF4kA0G59KX+Dc8tLt8zcjEltcPLVJcuhliM
         Y/tZrpzMW+5xlfMqIRzoDcOHTVWRjx7io/BrOLB0NoAwakpq7inNsLqmvHi1ouhHKW97
         m8V9H79/yC6BvwCyvuLPKXsZA8mjUvmmDWy2O3Tj5vq9FaF971nrMs2kUEgC4YRM3/bv
         +GPuUP/ntD7bglmjUMEV2Xff9dXf0rjKel/g0LMzrSNwiDEGDZro9YsRwcd4So9PBmsz
         61oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZN1UpMBMmOw83+EwInVm2MuWNGrwZoLHs62Yuiv5fg=;
        b=uEhpKEO4A5rXghjnw436wFvDj4l9aUCUxLAjha0gtGBIN0GjKvA0kWuCqcDLMqCE1N
         MmkomElL1wjUlBWl5fVR8BCNd1YwmjPMk8NSuvCFKmdcuUM+NH5y4fK5f+DKXEaNSMwc
         AuxUb5n2+ULPcXoDJ0qYiYvjLoTUXseluguJMqM7vov1Ehu4ciHS+4X6mxaUOKqckEx0
         FCJhJsf+1LK6ZB3OymLoPWCTqYNi2+XZAkr+n3y6Qi58TRgLCsaSmjIwKOr4uqqy+ulw
         4EuxVi1VVAasjb6NthxNqkHQjy0g79zMeAwYJ4uCY9qmW3o5S7f5N2r80NrneNdE3k94
         1y5A==
X-Gm-Message-State: AHQUAuaB/qedJ+FvuxddR/0F8d3rRVaa9VhVrYUELQ+VYu+yK7k+k1Pg
        uWV9JJw+gXIb623bQHHgUQ8jHqtkNy4HKkeQZdl1OA==
X-Google-Smtp-Source: AHgI3Ib4YSBrbFxrYzN1Iq8lb+yb04c+DmfY+sP7A0hwqQZrJyhNvvjq9VILhxc52LLrA6Od9e9E2KvejD9V7fiBpZY=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr1779780uar.39.1549370939516;
 Tue, 05 Feb 2019 04:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20190202221433.24717-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190202221433.24717-1-aaro.koskinen@iki.fi>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 13:48:23 +0100
Message-ID: <CAPDyKFqKkT9sfpzCsGiuXu6+6tWFmJUOQkoVv6dW+TZx+qgYoA@mail.gmail.com>
Subject: Re: [PATCH] MMC: OMAP: fix the maximum timeout setting
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 at 23:15, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> When running OMAP1 kernel on QEMU, MMC access is annoyingly noisy:
>
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         [ad inf.]
>
> Emulator warnings appear to be valid. The TI document SPRU680 [1]
> ("OMAP5910 Dual-Core Processor MultiMedia Card/Secure Data Memory Card
> (MMC/SD) Reference Guide") page 36 states that the maximum timeout
> is 253 cycles and "0xff and 0xfe cannot be used".
>
> Fix by using 0xfd as the maximum timeout.
>
> Tested using QEMU 2.5 (Siemens SX1 machine, OMAP310), and also checked
> on real hardware using Palm TE (OMAP310), Nokia 770 (OMAP1710)
> and Nokia N810 (OMAP2420) that MMC works as before.
>
> [1] http://www.ti.com/lit/ug/spru680/spru680.pdf
>
> Fixes: 730c9b7e6630f ("[MMC] Add OMAP MMC host driver")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index c60a7625b1fa..b2873a2432b6 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -920,7 +920,7 @@ static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_reques
>         reg &= ~(1 << 5);
>         OMAP_MMC_WRITE(host, SDIO, reg);
>         /* Set maximum timeout */
> -       OMAP_MMC_WRITE(host, CTO, 0xff);
> +       OMAP_MMC_WRITE(host, CTO, 0xfd);
>  }
>
>  static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
> --
> 2.17.0
>
