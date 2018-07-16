Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6983DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D427208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQYEz+Eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D427208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeGPKig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41474 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeGPKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:36 -0400
Received: by mail-io0-f194.google.com with SMTP id q9-v6so37265179ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+dB75c+rBlHnDZ366EGwI/jMlxjFJoiCFgAmpttcxcg=;
        b=TQYEz+EqqDhfnPbDabesnIqpIOI4vybBU1X/XsonlvREg0eMYC1jbSA3DYzVvdsxLm
         i0bd1RozmlyFxrOPZKrZXZ1pMju48nCZ5RLanRtn52uREtUaX0Zvu/zZD/mJlDG9+nrv
         ns4lDVenuTiHD2wCkvJy/DFMgQDOwCApVa6hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+dB75c+rBlHnDZ366EGwI/jMlxjFJoiCFgAmpttcxcg=;
        b=sLsXs7qUWuEerB5Ez7a4hgGZjWaHLLItVgIG2SOCt481QCg1BNBeQeu8U6zgECUgGX
         86H1vLBud72iGIT1Hnvy9fp6qCFAy+e9HEuqfRT5Wpd7yA1Du1ZsZmAR+rxPGnfhPQBU
         zOUZyZu+Hrb/7tnC2yStAbflHNfwjvV0V6NfSnNbyBxrckY7MC/DYeuuKM7YIkDckpBR
         WqMCQoWOhwdvx2TaqJ6utERIaCdlzBzWlUAcW5yz779HOwhY0t1PbCNxfPqhsQ6Qi70J
         oHXsFyIbMsHMZ16XRqB5JS5+Kz49iaOv6Nj3965gXOX6zaILQQMxOWatVOZwVFlnaaun
         XV1w==
X-Gm-Message-State: AOUpUlHHhgisZ+ft0kcvBjHUxizRKFpSuQLa8hYRevEY5p8Lr0zzsH1I
        gbMdzvyjiWu8h0UBFj/e06L2uZ9ydm4KkePO61njOg==
X-Google-Smtp-Source: AAOMgpcWuPOZYF0fBdfWoZl/sI9oE9JfjNmMecsTNuceT9G4NfUKh1FtyRYIIQDgf/hKoYDTYimkHrmrEiY7Vd2ek3I=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr40393870iof.266.1531735914811;
 Mon, 16 Jul 2018 03:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:54
 -0700 (PDT)
In-Reply-To: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
References: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:54 +0200
Message-ID: <CAPDyKFpv_zedwgDRmHTUadaDYb-xBQLFRV0sAk116YbjOhY+GA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: improve reasonableness of bus width setting
 for HS400es
To:     Hongjie Fang <hongjiefang@asrmicro.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bastian Stender <bst@pengutronix.de>,
        Jin Qian <jinqian@google.com>, Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 05:00, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..4bd6c09 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1021,8 +1021,11 @@ static int mmc_select_bus_width(struct mmc_card *card)
>                                  EXT_CSD_BUS_WIDTH,
>                                  ext_csd_bits[idx],
>                                  card->ext_csd.generic_cmd6_time);
> -               if (err)
> +               if (err) {
> +                       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
> +                               return err;
>                         continue;
> +               }

I would rather let mmc_select_hs400es() check the return code from
mmc_select_bus_width().

So, if the return code isn't MMC_BUS_WIDTH_8, mmc_select_hs400es()
should bail out.

[...]

Kind regards
Uffe
