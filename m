Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16ACC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F0320842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhVI161C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F0320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeJOVBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:01:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37764 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJOVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:01:29 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so27568672ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+hsOkPP5K8ZZOX5P6tdiQOlyqOgEp37k4qqBjqR+OQs=;
        b=EhVI161CKBJ9fwwV/eT0U+FkPP3MWQb881bIXaw8UXXX80JdmM9InNbdaIKeJ4rNVO
         ma2aDq+2G+3eAmWWEGHP8F/RwAtqXaCLtFtp4QrXI17Mx3YRaC2k+n6fZOs42qrE9JPW
         FWQoJE4FChRvvRyzDRR6OTRWwm2N4bi/Izqzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+hsOkPP5K8ZZOX5P6tdiQOlyqOgEp37k4qqBjqR+OQs=;
        b=l/eHfB5N7NXGpG2RNUPpuIupl8CpSkUoDyyDIReKd+w7evhxmWq8SXeFyLYqICXo5p
         qN/Rwcz+Xgjnz/5PDRRjfi0briV8oE325M8l2xTaQ3rWhcUCGZongRTtsiKIMPnook6d
         LSFEUkkGG72kgaf5V3VYXk4KP8PIpZ1gCgjvqSSGOH9U4lcs1Upwp6eEQYyf/4PkEK/r
         uwriWxjKIO0zBjmVfTIdXY5Zzlq9WlJg58wSh76L4u86yPyX/+mNkQAU+Z/LQCQe0TAO
         Pi9d220259JwhSRNifjJHSmIC5u+W/tcFCvgMxFyW98FNLbwExGXP8Ni6I9WS6cQBFuL
         T/QQ==
X-Gm-Message-State: ABuFfogVVZgvTMoHbSFbZXtiUaUxhuK+N5hyKJC8AMZk+HLN2ffOUbMA
        qDdoip5pWLnqH11Pwj6WhunjHrI28GLzoHgNI2H94A==
X-Google-Smtp-Source: ACcGV62a62tFbvv0h2EByS0HIuqQhyTCl/rVDd3sWqTSl9iGIY6eLsZVz9+NQ0ZAbqppODwJJ5MC8NUQK9s+Qj+tIgY=
X-Received: by 2002:a02:c881:: with SMTP id m1-v6mr13615376jao.43.1539609373683;
 Mon, 15 Oct 2018 06:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:15:33
 -0700 (PDT)
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 15:15:33 +0200
Message-ID: <CAPDyKFqaWF889x5MxbE7Q_mBS4GxBR=kV0GViRDw3pwB5=tyJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 October 2018 at 05:51, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> CTL_SDIO_REGS is a register specific to tmio_mmc.c
>
> Currently, we handle it in tmio_mmc_core.c, hence need
> TMIO_MMC_HAVE_HIGH_REG flag to prevent the other platforms
> from accessing to it.
>
> We can just move CTL_SDIO_REGS to tmio_mmc.c
> and delete the confusing TMIO_MMC_HAVE_HIGH_REG flag.
>
>
> Masahiro Yamada (2):
>   mmc: tmio: move MFD variant reset to a platform hook
>   mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
>
>  drivers/mmc/host/tmio_mmc.c      | 24 ++++++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc.h      |  4 +---
>  drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
>  include/linux/mfd/tmio.h         |  7 -------
>  4 files changed, 29 insertions(+), 20 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
