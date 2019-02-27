Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvtRgHYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfB0Jka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:40:30 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37485 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0Jka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:40:30 -0500
Received: by mail-ua1-f68.google.com with SMTP id v26so14735101uap.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nt1fsem2OAistWQMNYOqX4SZ/P39kvVGl+EUEs6GRas=;
        b=gvtRgHYbHar2fKCRXc+2ZTaZ4nDOTSd5QdyKfoh02cPHuocYLL2p3JvLGNuK0VYjQR
         br2bJhXiM7tJlt0jnA295/VZ6n98JRaVbFY/AePnCrqR37hjaYFyoM4a82fR3GEUWE2R
         vLlJS9t2+ZVvmHfYixYukkAWElFrydbdTY37n9nObTn0vtR1KtD4is7jxC6paf1LNd55
         0PzQxlA0anx1wQFJWscVfhH/di9QwbWJ/O0CyzN/OdCDd/hIX49AsN9sLkr9Ey76CJ4v
         cqi9xo8W/7WTu5WuMOs/Uxn3okOZr0Gu73mX8mWzd9mO5TGyl1SYSDzAKtmT76oLKcOZ
         wveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nt1fsem2OAistWQMNYOqX4SZ/P39kvVGl+EUEs6GRas=;
        b=fPG0E5Pv2ySpCtdbHclQJs4qCUSMz0ylzXooJUIYzVmVqsYVqmEUto8CSyOEY1eQfa
         s4vcbilAt+IpdQsubt721pSzbke21ye45j1nJ2QV4w3sxRADg8mxQ1wMJuArFooOwna1
         4iKzAkOTjqEVybQ2Apwjb3JtoymhyHTsBRid8pvo0r9FWpCyFqZtk5kqeMcAPE8ryucQ
         /DDiSLWshA58FG03BDx7DIxefYPfUKEnfY9TpYn3vRslQ1qeNBILetQHpo8fWOVpZHck
         Djadd9SdrKOemKOw8NVX0YbbwMnP8USnhMrxq2qsCzOFsBMumWSd6FeaE+4TUBuK42KY
         riAQ==
X-Gm-Message-State: AHQUAubilOvFE0TGtGQtd3x43/9VyEHYkw79g8jz8+v2v0JpiUjFDvoe
        oD5KrF1KOLOLER5TCuaa6FrH/hFq5SJtO3wlHpVaLw==
X-Google-Smtp-Source: AHgI3IbAbpi+3R/XllDHwNWfmZzUncegq2Y5gVE5pV5NqgF4PqzoN/2zYpNOYyjvNI0J2toa0LWOW4n1KbrMJpGRItQ=
X-Received: by 2002:a67:c902:: with SMTP id w2mr1243615vsk.191.1551260428723;
 Wed, 27 Feb 2019 01:40:28 -0800 (PST)
MIME-Version: 1.0
References: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 10:39:53 +0100
Message-ID: <CAPDyKFqKPQWUSLTCndEiCztp0jSpLDrxbrK1quisVzcG8qeg8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: core: Add SD Discard support
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 16:10, Avri Altman <avri.altman@wdc.com> wrote:
>
> SD spec v5.1 adds discard support. The flows and commands matches those
> in eMMC, Which leaves to set the appropriate discard arg in CMD38 if
> DISCARD_SUPPORT (b313) is set in the SD_STATUS register.
>
> We set this arg on card init: not in mmc_init_erase as one might expect
> but arbitrarily once the card indicated its discard support.  This is
> because unlike erase, it doesn't really involve any logic, and we want
> to avoid the unnecessary complication.
>
> V2->v3:
> The first 2 patches in the series got accepted.
> Elaborate the changelog of some of the differences between discard and
> erase. Clean some inconsistency in arg checking in mmc_erase().
> Add a patch to set the timeout for sd discard.
>
> V1->v2:
> In the first patch, assign the discard arg for SD cards as well to keep
> the code consistent. Rename "discard_arg" to "erase_arg", and elaborate
> the change log.
>
>
> Avri Altman (2):
>   mmc: core: Add discard support to sd
>   mmc: core: Add sd discard timeout
>
>  drivers/mmc/core/core.c | 15 +++++++++++----
>  drivers/mmc/core/sd.c   | 10 +++++++++-
>  include/linux/mmc/sd.h  |  1 +
>  3 files changed, 21 insertions(+), 5 deletions(-)
>
> --
> 1.9.1
>

Looks good, applied for next, thanks!

Kind regards
Uffe
