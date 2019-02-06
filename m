Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEA32080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwfY5YYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfBFPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43266 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBFPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:17 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so4567649vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz955wv4fnOkkLQqaldBnTCxXxBxagJ06nKx09S/P7k=;
        b=AwfY5YYjbEvUiLYGt8lvT+AiM175+aPha69gsnXSwdCKlGov5GG7kde5UFPt4ebiBY
         nyblwdkNOjBl1hxlPzPaeCjI457mqFoFgJ1gkC4EQttn0lV6gqhZjOugv2RxJaeh5XUv
         GBiRJpv11W/LxVopYnWU9g00WlGXMhS0mhTQMgHcTtawxCTmV9SOUdDracPeHJpxFm30
         mKk/kf+8DDJrdXbcdCtAG8biVWYveR/misZfVeYxlGPMDFaOiqmC7QhCLPjep6uslIF6
         kT9AECavtcVhPio0AxmOCbqOlaMLyJ+V6IyJ9JHYfU83voam3bLB4pAWRLvKtIfNZNlS
         lJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz955wv4fnOkkLQqaldBnTCxXxBxagJ06nKx09S/P7k=;
        b=W77ZpGeKAfE5umD6Dv6T6dLr3EB5frbtCBHqEIAcPxu1V7yljj2llfzRFDPjACl51x
         4/6zXowwSUR2DcoE8MJPF0Ayoq1gFboxY4V0a0tX5LihIiMj9/X/TL4t13EN/V0ullCr
         yQHyBhuuBv9Gt0c1+v2G1cc2JdzFLRXwAFozS8ONK5VOhbfMhe4cu+zlQ4rbOuio3o81
         G5arFKn2DaDJ7S/tTJAe3z66Zl31GLTsv8eiOXcXG4/FGjwhau+QAh/4vJL05bw96HuH
         7z9X5b0If8q5HoEgmuVr1WTQY8CvNpDIWpdqhIttGLDQyYlk4RYd7ccVgi1aNAh3g+RI
         inpA==
X-Gm-Message-State: AHQUAuapNu58ggL1BHPbmfyLUtGdToYyO2GPhkO5Dwi5FRzGWgmepR5x
        JJNmg58dz+FWlR3cYBrhwbptst8TZjoPNnASYW+96Q==
X-Google-Smtp-Source: AHgI3IZKvz78TBeqCIaZLQuqntJrLneavol1tsfl6uNUBvlgmd+ye82uCbSbXvMiENOYemeFS0zoLGi8iPSTZxPrpU4=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr4711960vsc.34.1549466116099;
 Wed, 06 Feb 2019 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com> <1549452487-17193-3-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1549452487-17193-3-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 16:14:39 +0100
Message-ID: <CAPDyKFpUMNOZSMt1J+3x4PRxyurBQET+QWp9QtzbF+G7McYrpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: core: Indicate SD specs higher than 4.0
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

On Wed, 6 Feb 2019 at 12:29, Avri Altman <avri.altman@wdc.com> wrote:
>
> SD specs version 4.x and 5.x have a dedicated slices in the SCR register.
> Higher versions will rely on a combination of the existing fields.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c    | 5 +++++
>  include/linux/mmc/card.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index bd48b28..c2db94d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -209,6 +209,11 @@ static int mmc_decode_scr(struct mmc_card *card)
>                 /* Check if Physical Layer Spec v3.0 is supported */
>                 scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
>
> +       if (scr->sda_spec3) {
> +               scr->sda_spec4 = UNSTUFF_BITS(resp, 42, 1);
> +               scr->sda_specx = UNSTUFF_BITS(resp, 38, 4);
> +       }
> +
>         if (UNSTUFF_BITS(resp, 55, 1))
>                 card->erased_byte = 0xFF;
>         else
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8f429b6..d791813f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -133,6 +133,8 @@ struct mmc_ext_csd {
>  struct sd_scr {
>         unsigned char           sda_vsn;
>         unsigned char           sda_spec3;
> +       unsigned char           sda_spec4;
> +       unsigned char           sda_specx;
>         unsigned char           bus_widths;
>  #define SD_SCR_BUS_WIDTH_1     (1<<0)
>  #define SD_SCR_BUS_WIDTH_4     (1<<2)
> --
> 1.9.1
>
