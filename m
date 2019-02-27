Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B553C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B962083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8zwfi2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfB0OLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:11:42 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34448 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfB0OLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:11:42 -0500
Received: by mail-ua1-f65.google.com with SMTP id a42so15444322uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkgTrzMlTHQSev3W5v3UtV0kyHYOc4PrzpCvhNX0dFc=;
        b=p8zwfi2H00EosyxqM2DxLKiFMIU6k7Xa4/fsb1l0CTMiMq4g2LD5eYn0CzApkveLI+
         4nN40Ngr64aXdJSfk2QzgpojqfMGttPK+T/7Jjjo5ebp13soPqTB9VNFyIg0v7M6RaoT
         QWCarx1d7/38QjBzNid+GDl1Or6KxJJoUO3OBFXzH5ocRbfe+/QtabM0qrT+8wmvrWqP
         o4mwWlS1emxrddrGuPRZrwVEUhrPVdfkD6saYwxkrPYEtHkEBG7eR3/PJZgpdAEQGXqS
         mL44cQFNyvf3RmFHd1leHSx/jhcaAqCuOtgzaHMiqz5X6EF4tWzgTJzIcQhmWOW4iYiG
         8+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkgTrzMlTHQSev3W5v3UtV0kyHYOc4PrzpCvhNX0dFc=;
        b=GxIuduGwRdkMENF2Efi42sGzJ+t8QyBaPk9TnaPncMBw3rDDwQRbnCIfE68YquEbY+
         Y+rbny2h/cD7ueCKlaM6n0VVybb9lR88oszrku1C571IFjpHuxCdRIK+lGQDdPht7QfG
         0qZygLv2DHSqPSLT7M3Nvr/ela0OgN9wgj8NgjhDOyxLq3Hw8o6sDsqbmF5n4VKcrfZd
         h271C0GxhOmEAZpkOM2iQLp8vBhMnyChqMnmclnQmbChMM4Bpa/qaMxNGSP2DMUc0XyW
         6gthCL5XVugeJaUgj8amMZ31GLCZBkRRuNe6OSu77rNgwMwsxD70/ZIApQDljlO6IY79
         bLSQ==
X-Gm-Message-State: AHQUAubvDRKkIP5wG3CQFvrP5lBxbauZSycMggTtGmm/dX7D24H/xp5c
        9lzHJyZq+I9ZmpCjlHYmLT4gh7lKnBHK4Aklnzcu3A==
X-Google-Smtp-Source: AHgI3IaDRifNe7rtdDyKMdYb0CK/rlBGYLKBBjUlBd8693ZJxxQRmV6fgWH4AKTt8AUeEUJgmiOnsXLrEdWxYi4Vrmo=
X-Received: by 2002:a67:8055:: with SMTP id b82mr1827696vsd.200.1551276700557;
 Wed, 27 Feb 2019 06:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20190225192214.3881-1-alamy.liu@gmail.com>
In-Reply-To: <20190225192214.3881-1-alamy.liu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 15:11:04 +0100
Message-ID: <CAPDyKFo05Nh0O42oRgW5qN6U2eWFX4-kVZUmUdTcbPmcxRNeUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: fix space allocated for transfer descriptor
To:     Alamy Liu <alamy.liu@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 at 20:22, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> There is not enough space being allocated when DCMD is disabled.
>
> CQE_DCMD is not necessary to be enabled when CQE is enabled.
> (Software could halt CQE to send command)
>
> In the case that CQE_DCMD is not enabled, it still needs to allocate
> space for data transfer. For instance:
>   CQE_DCMD is enabled:  31 slots space (one slot used by DCMD)
>   CQE_DCMD is disabled: 32 slots space
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 4cc7863c13..974997b6cb 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>         cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>
>         cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -               (cq_host->num_slots - 1);
> +               cq_host->mmc->cqe_qdepth;
>
>         pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> --
> 2.17.1
>
