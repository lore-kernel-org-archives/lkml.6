Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7220863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKBPUV0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfBKI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:28:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40045 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:28:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id t14so7028898lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d4OW+zzPyadCP4+f8UwijYToclAZ3Hu2NV1LWQcdDiQ=;
        b=mKBPUV0QuGOpOTho3v9LYI9r/SXZ0JfHdDznAiusfl8Z2fFz9LP8pLGUHLhqPVzsng
         hH23mJS/Z+RUCScJMxr4gIJI9bD9GFFxHiqPJtDXuf8gSYYbtpZ8kSS5DD5QmlnTU2yE
         VZb0qyWeWAgDYX1iRni749cCwqg8U9z4kJQR4LTRdUUFb9JII0VJvh1M9PqDb55OLQt7
         8uv1E9K4SwTNXzKPpKzn0tkiDDM5WPvzv1ojr92oqv5Jk3EnusK5bAgF7OSbWONKC9YQ
         ZSiaEbHVB2FadDqROgSnylpbR4bDN9hKZ9jyj61sXCmHddJbbUp/EhdXgEpMHXWhlH8O
         UNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d4OW+zzPyadCP4+f8UwijYToclAZ3Hu2NV1LWQcdDiQ=;
        b=Ixj1B2omgvfoxTh/DwIJw8L4yGHraauoiMEvTB4kmwkjkpB9BMpEJFRlbFI2VtSLGn
         sEiauU0ldEB6fgYR9K9Zm6lf3nQy7ejgmr1fPbA7vOfYQ8HZsnHfR71g75NBizwg2Ani
         i8HQ4JtCnaIw0YhwEw4Z/DFsYE9B3h2YmpmZSzFNkV+8np62QXT2y1bFGDzHtC9YyyAa
         zJXzQg8qHuwuOgeTAyaQaPA2wB0d4n5hesOwAVhm1PmNcuA1oYv4+SyIzRBmxi9v4Nw4
         UrW6wEvLFB56b5jF/j9fK70aIQxa2rl9F2uEUKEhm2NejGDnZpiENNzwAlhluDh/kfkH
         JUWA==
X-Gm-Message-State: AHQUAuaH6eeVXsG7D1MsR19zuy357yAwbssrmmip5B7wC1mhTR6a8rcM
        fmfukX18VM9AbNkeMFQHe/TcvEM77l3U1ayAjefY9g==
X-Google-Smtp-Source: AHgI3IaBK92sdBl5F7VPoURPbFtqOj/aJXdebcSod84TcuQBzc9m0ANts1Da7U2yxSvfQqDONJlpLxYq82K2+SCDVvo=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr20880922lfh.130.1549873678834;
 Mon, 11 Feb 2019 00:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190210173109.12602-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 09:27:47 +0100
Message-ID: <CACRpkdZZvvd+yTuvfrBuCzXj==Eni4oiC0zj2LP1Mh4wUgdn5Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 6:31 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

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

Seems correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
