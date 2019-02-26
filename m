Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B18217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYPHGh5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBZISo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:18:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36702 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfBZISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:18:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id e15so9889349uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8KdkHDpk1QFWE0uev1+fXSqk27OFrjXeyo1VHkMZSo=;
        b=UYPHGh5f395QN2qqF2ENzBq/xaeokitmR3TMzat3m2hX63XN5jZhpB9JkRyde33Lb4
         2siNquY+QNDKcYTfBQ7PXYlWwmTJ5zW3SY6irOrWaAQIrWKv7oUyl+lRNUfa/BivQo/g
         4LnTamH8KmI3FnInFfUcdiu550CN7noUW+DtjINW6xQd8qeKBJOHbVeB1tBJILSL5DZu
         1WsOzvDnfut9jKX2CyAkNj1jek3qqVyzw8CobXIJCEFu2EHM53iUnMn2TsQjjV1MqAHS
         YlaibZsNIGvxzsK3vSNHaK9BbCBOMSaTQPlWml/Kw0GfmxCrI+2SuFqN1+/v4zPMWLWT
         DhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8KdkHDpk1QFWE0uev1+fXSqk27OFrjXeyo1VHkMZSo=;
        b=mrnwMPiu/lSrCW7r3FaFwPt3/GPALU+NtpGWhKN4l+lf3SIG6IceYDwWgct/wUODSm
         dT5VHxBXdl9e+ecM+QWAOB7JJTSDNlu1onIZ5cLPaJGMSLyNNnYMHxRZC+caY4+Z2Z5B
         9Bnd1yEIlzScv5T2Y/Pd21gG139TaCilkpvJsGg1+5kHWqsJy55cjJ8fGh/RsSRHOTRd
         ExtDqLusVCqGYcTvDQz2BFLknerc68GNAteteDPK4TF/31Cu7aT+YSjuD5i4Dtjo6AKL
         Ji4NyOHUSO7LXRNxQt4GWvpTasa83LBTFLlGsJp7oGuRPE7SeV9q9C1LpvtStlAb7G57
         rb2w==
X-Gm-Message-State: AHQUAuao50f0UKMSomQDc0oza4eaZv94MrBkAFuxkdUSp6F6bfbqCVQm
        kS6uMKR3mksuPAtCA0XQsLX2vHCBPv+7jR25CTmiEg==
X-Google-Smtp-Source: AHgI3IZ0t3nWWMKfU8sCKTTvdpSscxpmk39hjlPJc/chwLiNCKNoVIKuhrX3WLWKVPZWZyYO9BXFZHGEyshn2s7P4GM=
X-Received: by 2002:a67:7685:: with SMTP id r127mr11415652vsc.35.1551169122768;
 Tue, 26 Feb 2019 00:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190210173109.12602-1-j.neuschaefer@gmx.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Feb 2019 09:18:06 +0100
Message-ID: <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 at 18:31, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> When using the mmc_spi driver with a card-detect pin, I noticed that the
> card was not detected immediately after probe, but only after it was
> unplugged and plugged back in (and the CD IRQ fired).
>
> The call tree looks something like this:
>
> mmc_spi_probe
>   mmc_add_host
>     mmc_start_host
>       _mmc_detect_change
>         mmc_schedule_delayed_work(&host->detect, 0)
>           mmc_rescan
>             host->bus_ops->detect(host)
>               mmc_detect
>                 _mmc_detect_card_removed
>                   host->ops->get_cd(host)
>                     mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
>   mmc_gpiod_request_cd
>     ctx->cd_gpio =3D desc
>
> To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
> is registered.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

This works well as fix and for stable! However, we should probably
clean up the code in ->probe() to avoid this thing altogether. Anyway,
I send a patch for that - on top.

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 10ba46b728e8..8ade14fb2148 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1450,6 +1450,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>                 mmc->caps &=3D ~MMC_CAP_NEEDS_POLL;
>                 mmc_gpiod_request_cd_irq(mmc);
>         }
> +       mmc_detect_change(mmc, 0);
>
>         /* Index 1 is write protect/read only */
>         status =3D mmc_gpiod_request_ro(mmc, NULL, 1, false, 0, NULL);
> --
> 2.20.1
>
