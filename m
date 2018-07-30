Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA7160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1434A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpLMKoRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1434A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeG3Qlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:41:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36640 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeG3Qlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:35 -0400
Received: by mail-io0-f195.google.com with SMTP id r15-v6so10106633ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z5elBxaR48P7LrlQC4E21L9/Uym2sImNbpdY41NgVVU=;
        b=DpLMKoRfyrmo1Ksu/Q3JO5Ul9tEfQScYHeg/FtjiPOOJTrpU5VXPotHfsp8yScnM0n
         lpVzmCUCPUq3XxQpEpT88uES/wV76tQAPNN9XNW53jazUNd2plkn4p3voSCQDHfOCZqF
         C4t6mzkLwvcplgAeioTv8YkP6iW8YbVi4wowU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z5elBxaR48P7LrlQC4E21L9/Uym2sImNbpdY41NgVVU=;
        b=L+y7Gn5Gh3yb7cbsA+LBEm6kQlm2hzcgnmJdXNo0QAcVpOE/+Yq5Ee8+WQvf5C8cdx
         Bz2XuGUU7f4xNx8a/F/a7yY5Y2BbtjWcGPcgJPQpadAhmRTVqpgytFIrpWm2ACtUPkz5
         dEHs9Wx3hpKpsfIdvwWr/JR2oFW+Yfsq2lFRMj7sK0qMXWZpkkZs7PZlPUViRn2So6Qn
         mh6Dt/Sz3xw1CDjv2izEEGk9WIzHkrgX+Z3fKur5FOAifkIWNqWNY1sSDO6s9I31KfJ2
         iaYv76wR4ScDFFaVWWGNEgiuZHnekWj/G5OaybRU8Mh3oGlJRmNC7Hcr1HB6mjos2aJu
         4Lbw==
X-Gm-Message-State: AOUpUlEd8OTJexK2e2AFGfy/xQNZvuaooECV8rAsgMNi0iRueyI4v3Xz
        05vvW2kkSNFaufdvAxw52neYZL8WlAETHMa6rLzCGQ==
X-Google-Smtp-Source: AAOMgpeEWam4Ob8ICB7CDVJsbseDcOfxdq436F/Dzr5UWna3wI1RiWDFF03JGLSIPnJpNnB7HuL0F3nrRpOVEb7IGzw=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr13621285iou.218.1532963171223;
 Mon, 30 Jul 2018 08:06:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:06:10
 -0700 (PDT)
In-Reply-To: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
References: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:06:10 +0200
Message-ID: <CAPDyKFoEsRz8eQmZ+qXOSZ=cF2pjsR5UYJHp9UgJ4-3b6ofcww@mail.gmail.com>
Subject: Re: [PATCH V4] mmc: core: improve reasonableness of bus width setting
 for HS400es
To:     Hongjie Fang <hongjiefang@asrmicro.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bastian Stender <bst@pengutronix.de>,
        Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 11:14, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..0dbc512 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,8 +1338,12 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>
>         err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       if (err != MMC_BUS_WIDTH_8) {
> +               pr_err("%s: switch to 8bit bus width failed, err:%d\n",
> +                       mmc_hostname(host), err);
> +               err = -EIO;
>                 goto out_err;

ENOTSUPP seems more like the correct one.

Something like this:

err = err < 0 ? err : -ENOTSUPP;


> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>

Kind regards
Uffe
