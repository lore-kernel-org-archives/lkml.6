Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD59020823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgHvoB/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD59020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeKSWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:32:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35515 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeKSWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:32:03 -0500
Received: by mail-io1-f65.google.com with SMTP id u19so17809003ioc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=meFYdoJO7yODUDtGHZGHsRtP8LnQz6/aEAsVLpIsjX4=;
        b=QgHvoB/f1XnMuVQS4LAJFii/nXxcPVvGsMFxbHVDwXO8TpW8MDxElYSEQrKWciN+rg
         86iFkc5ZowV8AWjdre+LH5cT/OmwTD9kLcXaImgY/h8H+SIGTB2g8rLBwdNKvrKI1Wes
         KODnT59x9KmoTLt4GNbT7jlhjMwlySWChaL8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=meFYdoJO7yODUDtGHZGHsRtP8LnQz6/aEAsVLpIsjX4=;
        b=Ts/CrmMsceDD2/bMoNeWfDBrRn2YL44liuLRjQGj9vrphVE8VhsOdfqtH2uGk3eM08
         osdQuS9LVi+Y+IaJLrENV86fuAiQnS75GoikZrXBv4PEnKJ83x1UDlEfkZfKyIKEfRNZ
         yFQyde1IU7PkKW0byCKQG/FaOQeYuE8360+itGLr5PjNkkxJl9FxTu9zbjpnNPEtkNLf
         VJL89yOKwomKF5hRQBOTJuD1j0fojBywBBfYMFSUcoTECi1Swn9n7fDKv6FOuBnFZORi
         lGT7dAS5VbMVvbZEDtCSm7SWt7l32I89FZnzU2rEh0r6v8VOIUVoCeJQN00cVrOK3fZ6
         teHQ==
X-Gm-Message-State: AA+aEWaY90iCRg/6FKkhmPogl+RwWCbew8iIFG/loCVwNsiGoh36OVZc
        mhJF+Igsfmw+PCfYiFc6b2H0rhmi+lSzfG5F7rBC/Q==
X-Google-Smtp-Source: AFSGD/XGYzDysp7tejPg0HjzGVt2roWlUhsYlbtc/vr6Ts+GJKY7lq8TWOh3f5OLHBGyZg4QeLfILfHiMSfvNYnHysE=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr18015250ioa.266.1542629317088;
 Mon, 19 Nov 2018 04:08:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 04:07:56
 -0800 (PST)
In-Reply-To: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Nov 2018 13:07:56 +0100
Message-ID: <CAPDyKFo_RckxWhp3+_NX5Mwd=VgWdszmj=7Di+VzTkvuwu0kFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: include <linux/bits.h> instead of <linux/bitops.h>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 October 2018 at 12:05, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The reason of including <linux/bitops.h> here is just for BIT() and
> GENMASK() macros.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 7a343b8..e241287 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -14,7 +14,7 @@
>   */
>
>  #include <linux/bitfield.h>
> -#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> --
> 2.7.4
>
