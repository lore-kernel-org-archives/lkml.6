Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E639AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B3B2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNxiyXye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B3B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeGILbR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:31:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36413 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGILbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:31:15 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so25609264ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZdrvwUnFG6nTq0Ss1g3TC1KlslQXs1qEY5Kg6CNd7QQ=;
        b=QNxiyXyeRQ629gKmMlqyYlLiSST0zz9G/3r1iEtVv8KeA4/6b1OwuBiqgIkXPGZ5e1
         jYTWckfeycuutIOpKWKDy+oe19moI1YRxRUe3npjMQ0c5D6f2c5Et4PpKlgtDagcMTik
         +AVUZbT1mG3UPU/0QkhqgSLxQxI1y4M6qKMgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZdrvwUnFG6nTq0Ss1g3TC1KlslQXs1qEY5Kg6CNd7QQ=;
        b=bCu+uWd9TsIC0kqgkaS6MVMx13+21jDYWCPBblmLH1mEORNqtsefP0vfDPsc2/TdkK
         9218G2l06rIVOR2ew/Yqo/fnuxf5nvBjCiVTcINnoySIkFIwlE4Uxxv2UTHhDV9PJoUc
         VTNYMQQgvGpcBnh7T+nrZLF19soTCbpNeUJnnTbPFkcGELKVhQr2KkBiUHsA4yfCbtaq
         FJyqcJ7u0uZJ+hkqmYcrUQ0a9bOaimum7TxiZQIIfFVzju8TofG4GYLRzZ0vRdjBLD8F
         IZwrEmagC7YoMcdZrKANA+m/lPIdqSN+jvt4lhQuYZQiE4dbftwT0SB2fPT6pQqG1gch
         KKpw==
X-Gm-Message-State: APt69E1R4sYFvQOxYIQv6+TU3X9vUPjfQLqSBs+2l+tWvzONia2CB1e2
        j0nTBYjhP+GFQ2HbQxSKuWmo3PT9VNqADYL3o5JsbA==
X-Google-Smtp-Source: AAOMgpeYQbZLow4/sBFBS/Rto31PXg6utGGUgce9oSAaEi+6/YX1r4k3My/sHDsBvn1Y8HuRdfm1rGh8mzwZ3+MTGuw=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr16616015jaa.142.1531135874947;
 Mon, 09 Jul 2018 04:31:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:31:14 -0700 (PDT)
In-Reply-To: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
References: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Jul 2018 13:31:14 +0200
Message-ID: <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
To:     Hongjie Fang <hongjiefang@asrmicro.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastian Stender <bst@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 08:47, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will try to
> set 4bit transfer mode if fail to set 8bit mode. The problem is that
> the bus width should not be set to 4bit in HS400es mode.

I guess it fails because there is something wrong. Can you please
elaborate under what circumstance the problem occurs?

>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..94c3cc5 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *card)
>         if (err)
>                 goto out_err;
>
> -       err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       /* Switch card to 8 bit mode */
> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                        EXT_CSD_BUS_WIDTH,
> +                        EXT_CSD_BUS_WIDTH_8,
> +                        card->ext_csd.generic_cmd6_time);
> +       if (err) {
> +               pr_err("%s: switch to 8 bit mode for hs400es failed, err:%d\n",
> +                       mmc_hostname(host), err);
> +               goto out_err;
> +       }
> +
> +       mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
> +
> +       if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> +               err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
> +       else
> +               err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
> +       if (err) {
> +               pr_err("%s: test 8 bit mode for hs400es failed, err:%d\n",
> +                       mmc_hostname(host), err);
>                 goto out_err;

Lot's open coding, no I don't like it.

Wouldn't it instead be possible to check the return value from
mmc_select_bus_width(), as it should tell what width it manage to
select. Then if it isn't 8-bit, then we should bail out. Does that
work?

> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>

Kind regards
Uffe
