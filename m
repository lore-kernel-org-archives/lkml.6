Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B053C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4980D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2Co8wGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfAVHsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:30 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33259 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAVHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:28 -0500
Received: by mail-ua1-f67.google.com with SMTP id t8so7775018uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0ADUYQ/JbodKc0VnKOxqZ7sbZiQN1ji/+G/neIGxBM=;
        b=A2Co8wGI0hSgcoSrtO+TtKH5YLWKk+fXTXkk+y7Y830u1z8M5OqagjvxOqFZlLqJtw
         A/0aT5JEK75QMHc1rB/smASxTraBg/7JozHXGUV6pqCihl4i+tihFj8xi+O+8SOOJ5TP
         IVmP8s2aTN6F0qJBXkKcRaXPXKm8yP/o385zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0ADUYQ/JbodKc0VnKOxqZ7sbZiQN1ji/+G/neIGxBM=;
        b=qD1GyZfPq6PHL3A7vohNlRQ4yDpU4V5e5+CRSDhWu8VNEboBP62OfJ4TTYxE7AIzSK
         Y+WuT8CRb8aLGCy4kX74/W154TjPtezmM5avfD157t/eM7zkhve8DYvI5I/+a4XGr+gR
         EWcKf3f1nK9g5r8gSCyCuhw7Dc7MRJZDWvEoKqdSQWUlrsKvzUt7iAUVnX8S6ywDfiFo
         o5x+0mRe9HW7yJam5D9aRUtjKSlPCYEw+yAnfNILYWV61hcjKYwEBVC4pLl/hFkV7xZz
         FS1sBHCBeb9ZCjSFQt3JRVc3Q08rKYVO9TOmM4OjPROgALwKAQeVmyrSy7IZbEOKURna
         d3sw==
X-Gm-Message-State: AJcUukftDB9sz5KiEpgzBR+EtnYiyLKdxlPpUpdCCwmGEFmwsXTrHjoy
        htoNmHc/0wNJ2OwLmTF60StDG7FZq/JQBo748+HCi/8S
X-Google-Smtp-Source: ALg8bN4Y/8aGqux7e48IRJrFE0EYOe7BLfoXaWIOLJkbi6kdBUEdK9D9KMd5g+ngu3ray9MZv0hVWSVL8gp2+dwsKLY=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr13316972uan.107.1548143306973;
 Mon, 21 Jan 2019 23:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20190114204211.21386-1-malat@debian.org>
In-Reply-To: <20190114204211.21386-1-malat@debian.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:47:51 +0100
Message-ID: <CAPDyKFqT3dk1X_-kNSiE6SM5jLGEpLd5bdaeTQPoDMSLaMVpJQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 at 21:42, Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> In this particular case rewrote the comment to start with the string "fall
> through", so as to match the regular expression expected by GCC. Truncate
> the comment slightly to fit the max line length of 80 characters.
>
> This commit remove the following warning:
>
>   drivers/mmc/core/host.c:196:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f57f5de54206..0052d6fed7c8 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -194,7 +194,7 @@ int mmc_of_parse(struct mmc_host *host)
>         switch (bus_width) {
>         case 8:
>                 host->caps |= MMC_CAP_8_BIT_DATA;
> -               /* Hosts capable of 8-bit transfers can also do 4 bits */
> +               /* fall through - Hosts capable of 8-bit can also do 4 bits */
>         case 4:
>                 host->caps |= MMC_CAP_4_BIT_DATA;
>                 break;
> --
> 2.19.2
>
