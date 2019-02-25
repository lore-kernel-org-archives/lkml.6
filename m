Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00714C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F7B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCuDZc1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfBYQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:08:52 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35738 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfBYQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:08:52 -0500
Received: by mail-ua1-f66.google.com with SMTP id f88so8866158uaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XU/r/zwkjtr/RRn8IMe8IxcCB42wnio9h2da5cXx2F0=;
        b=BCuDZc1I8jlLwdob6hihdZ9/mzNbiHx6tE9ePO/YQhcdKZBMptqMnFfuQHIdTBA/dK
         Sz5RAkKQ6JVttL5jKs2sXpsC46t14X/s5OritYw2w5zrizWaFvzAxMIDSzO2idbqeCBk
         Tz8eKbhzvi0OvalPBIJT+Z75yOzaZADf4tg6L9pvvSWSvginy8uHjvDy1EHIPjeNLKy7
         YT0du3Xfi+T3K0sFvgYSd81xQB1UdqaulxOFWRn84exap5EJjrhXUJjn5n8R4ZkFSRY+
         Rd1x6rw5zxAGw9EzKWnSLH5VgJhkqGGzodOVq/PWr1ZH008Y67/8oz7cTeeScEobkxJn
         QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XU/r/zwkjtr/RRn8IMe8IxcCB42wnio9h2da5cXx2F0=;
        b=LTQAUG96ZbAMdM30sr8IwBvIlX3w9MahDibmGumkI2lIB2bcIdGhUp7iIiajTG08f7
         LPv6h32boh/UFHpo6cyzd3V/P+yV47TDa6c+MJ1kM2dexjOKcRCXKhRZLmiqloccJoI1
         AdT3OQ7Lyucz3XW9sRXCpZ/qK6MYAeOr189s8DfYBqsEWZi8DGELZGs7lhsPkmpDdf71
         HXWoM6xzEd9daHfi5ZX4lECxszzKVcKyeciieQoPSenIAmGjJ9dPSK+55jYCWk2iL8d0
         2EzOAFKZkrcpRViaSVqewNAR2L/SpGoeMH+gsF/NVT5ml4DOitFO0q81ApQLSuNj337D
         rl2A==
X-Gm-Message-State: AHQUAubSwr2IATG4fIa+A4AUhsvRSt4XRwnVgAzDM0iayoMQLyWaVh1i
        /eNBCkCdQykvis52M9Ekkb7KnI1lceb3tEiAjCm8kg==
X-Google-Smtp-Source: AHgI3IZxinq8v01ArpVsWD6oL5Yo/p4NZDXG9ouiGftD1xFUdDWGdXCLun9xQRAS56RvrMLwILQ0x38WMIpiP/+WvD8=
X-Received: by 2002:a67:8055:: with SMTP id b82mr7902148vsd.200.1551110930624;
 Mon, 25 Feb 2019 08:08:50 -0800 (PST)
MIME-Version: 1.0
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com> <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Feb 2019 17:08:14 +0100
Message-ID: <CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Avri Altman <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 06:59, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> before send CMD6 to switch card's timing to HS mode, it reduce clock
> frequency to 50Mhz firstly, the original intention of reduce clock
> is to make "more stable" when doing HS switch. however,reduce clock
> frequency to 50Mhz but without host timming change may cause CMD6
> response CRC error. because host is still running at hs400 mode,
> and it's hard to find a suitable setting for all eMMC cards when
> clock frequency reduced to 50Mhz but card & host still in hs400 mode.
>
> so that We consider that CMD6 response CRC error is not a fatal error,
> if host gets CMD6 response CRC error, it means that card has already
> received this command.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> ---
>  drivers/mmc/core/mmc.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 09c688f..03d1c17 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1248,8 +1248,25 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
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

Well, I am having seconds thoughts about this. Sorry.

There are different scenarios of why we end up doing a re-tune and
thus call mmc_hs400_to_hs200(). These are:

1) Because of a periodic re-tuning - to avoid CRC errors in the future.
2) Because the host controller needs to do a re-tune when it gets
runtime resumed, due to that it lost its tuning data (and is unable to
restore it).
3) Because we encountered a CRC (-EILSEQ) error for a block I/O
request and want to try re-cover.

I assume you are looking at case 3), because mtk-sd don't use periodic
re-tuning and nor does it need re-tune at runtime resume, right?

So, when thinking a bit about these cases, more closely, I think we
need to admit that these are actually quite fundamentally different
cases. Therefore, we should probably start treat them like that as
well.

For 1), There are no reason to decrease the clock rate before invoking
__mmc_switch(), but rather we should decrease it afterwards instead.
For 2), The clock rate must to be decreased to HS speed (50 MHz),
before invoking __mmc_switch(), as there are really no tuning
parameters available at all to use for the controller.
For 3). Similar to 1) and for the reasons you also have brought up
earlier, the clock rate should remain at HS400 speed before invoking
__mmc_switch(). This is because the controller are still using the
tuned data for the HS400 clock rate. So, even if the conditions
started to become fragile, I think it's better to try with the HS400
MHz than on any other rate.

Moreover, as I stated in an earlier reply, if the call to
__mmc_switch() ends up with a CRC error, how can we ever be sure that
the command was accepted by the card? We can't, hence that solution
will probably never fly.

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
> --
> 1.8.1.1.dirty
>

If you take into account my comments above, it seems like we need to
add a new tuning flag somewhere, to tell the reason for why the tuning
is needed. Then we can let mmc_hs400_to_hs200() act on that flag, and
depending on its value it can either change the clock rate before or
after the call to __mmc_switch(). If we can make this work, that would
be the best solution, I think.

The fallback method, is to add a specific host cap bit, that instructs
the mmc core to adjust clock rate before/after the switch, but I would
rather avoid this solution, but perhaps there is no other way. Let's
see.

Kind regards
Uffe
