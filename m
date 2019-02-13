Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52918C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC65222AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/+MFZFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbfBMMJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:09:21 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34542 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbfBMMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:09:21 -0500
Received: by mail-ua1-f68.google.com with SMTP id a42so211926uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tomadc5NLuTEZWSBt9A/Z/OxsLDygmn8C6sD5u1RnAk=;
        b=s/+MFZFQdJ5wc+fCrcDEdY98PFQKR/CkdOol5xVzknngHj2Mf6EjCRTZYeMbClJyXJ
         Vt1zdHaQp/xFOIFVa/MV3L5vdiG0+9av6+IYIy8Dgm7NEoBag56GjgFoGq8Vhz0k3lMV
         F9fShJEFK1IFPGdiXCL8bz0JvsMJqDbig1PH31wnLCSs61EY7WEOi3JST6O6obqQWC4s
         jApFMc5UjrgfNgTLUr0kFKH29B6thd5h0CLSvIwFGEL2xY0Ik9VFUbOv4nKg5clbUOhn
         vujiF7hqOujrN3GA+B/IqO0klktNmmlJj4SEV8Zq/xGHFF+ItvbDFeNUXPRkrfEx54aL
         1P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tomadc5NLuTEZWSBt9A/Z/OxsLDygmn8C6sD5u1RnAk=;
        b=H4aGRxamFwehHAZ7cUNPZjE+oFefB9SOItAjhWZqOpcOH6KRYQF1TVQVpNdRFx5C2M
         R50lCIiBn4xQbY96N0t5Y7xjzg+bvnh9W1BWxzItfrni/ffYel9GyiCR0jaAa1d05iJB
         gybpnfpo0AI9YgKOe7otfoT2cpGZChPfcV45bWcmnWj82Igrv6iSCVNxKLyOqwUHkXBo
         bW4nr7dIdWLRibwz2ljKO1mT3wZoBfGHFNXrHy1NACZN5osiIAyTD4ByoSTSlO0I80r/
         zFh5b/npqrvRfC7hAJjorLyMmNIESNeIuONXKXYjYAEHMN2MfmCNEjMC3QQmbRnESB56
         dAvQ==
X-Gm-Message-State: AHQUAubLjA9b4x4fsmvxd99o/4Rbx6KiFdQB8vaR4gEkbxCbNYK/LLHS
        mNIRELnhtY310wIm7h2IwI+Q9Fc8AO3SkGQ5yVEOFw==
X-Google-Smtp-Source: AHgI3IYKJI/LELk31xcRwzxAgH9EsF+YE5I4BAcQjqNLWWzOUqdfVYoErIEDJkKVxxDYnIhK0mxyOLo6njWBHweJTaw=
X-Received: by 2002:ab0:238e:: with SMTP id b14mr48222uan.119.1550059759809;
 Wed, 13 Feb 2019 04:09:19 -0800 (PST)
MIME-Version: 1.0
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Feb 2019 13:08:43 +0100
Message-ID: <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> Therefore, any commands sent to the card should use HS400 timing.
> reduce clock frequency to 50Mhz but without host timming change
> may cause CMD6 response CRC error. because host still running at
> hs400 mode, and it's hard to find a suitable setting for all eMMC
> cards when clock frequency reduced to 50Mhz but card & host still
> in hs400 mode.
> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> after card timing change.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> ---
>  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 09c688f..00adc2d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -
>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, 0,
>                            true, false, true);
> -       if (err)
> -               goto out_err;
> +       /*
> +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> +        * error, do not treat it as error.
> +        */
> +       if (err) {
> +               if (err == -EILSEQ) {
> +                       /*
> +                        * card will busy after sending out response and host
> +                        * driver may not wait busy de-assert when get
> +                        * response CRC error. so just wait enough time to
> +                        * ensure card leave busy state.
> +                        */
> +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> +                       pr_debug("%s: %s switch to HS got CRC error\n",
> +                                mmc_hostname(host), __func__);
> +               } else {
> +                       goto out_err;
> +               }
> +       }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +

What Adrian suggested was to not to move this part, but instead, only
allow CRC errors from the CMD6 as above.

I guess it didn't work for you?

>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe
