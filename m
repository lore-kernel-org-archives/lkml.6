Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C81DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60A421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFgquYke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60A421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbeIUXS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:18:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39762 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:18:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so6272870pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwoCqG+pAO6Bw/styrscnZ1G56Ao1kSQrIgQWWfxQtI=;
        b=qFgquYkeV9FLwZMEoAvjakSSZj9e5xIgf/LjsJegCrHlNde2Q1nj41ikuswOi3Z6i/
         alxM0cAW6oZvVwxoP80XB3j38JjiKxjnJ9j4aTsttSAN3PO65LJTSwpQgzQfcweeHDnI
         NS6z1AxjssUh/iBnpCvwGaKJNzwRPyOENv7k7SmOWfpXIJ4QnlT5s7klgYJyvR7C3iDL
         4MdgbLGrAcz3XbO327BeVMoXlpNCMbG2XhJZQysH/DuHMGivATec2xwXQNBVAhUJ4WE6
         l1V5xbpDzn0CKHUHTgwQR+CiE4vT94QsYQN7Mht2JzMlmE8j2WyoYOeBfqV5OjTOk5hv
         1Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwoCqG+pAO6Bw/styrscnZ1G56Ao1kSQrIgQWWfxQtI=;
        b=gB4nJI+ofocIZjlreVDlTB6HFhCm8qsHsuh81FUBL0dBGQGA3msor/qP29Bhkpkz9O
         v6ynjXdBtm1GhcoO3L7OM6Bx9v9GX6n88dHWsicK9Dp6Uzgh4NA8ixE4ii2VkdrKn3lI
         Gkvd0QEZkZ584ExpnpLr//JWuru3mCSt9Rq3PgAWV+yztwHyKBP5K4MgN4DZjppGIg8t
         YH5xgA1nB9FUPDZbYDTrTEGwkbah/czwNBBG3KHH0EZbUZ653x4c97mpsY9dyeLq6cV8
         POBIgS0gxrTjUniDZkGBGk9HMcKRSiqLX6Ot//+vPGUVzQ3x+vI69/CtrXlggcufhJz3
         7q+g==
X-Gm-Message-State: APzg51AJjqZQwhFsAhSOv/R1OZUwcYFu2jimr9btFz9YZgZdlGnaA4R+
        k4ald06JlkUu35ke+08Tr0d5fJKsjrH77I9LMbb0cg==
X-Google-Smtp-Source: ANB0VdbaZUcHrcc5UiQDA7ktuEDeENfJc65FH/fYTgs1X6dz4GKXco4mejf/QdUF4T0CcmV/Ww7UW1bstWrv33+vvgI=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr42397130pgt.202.1537550914122;
 Fri, 21 Sep 2018 10:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180920233024.28534-1-natechancellor@gmail.com>
In-Reply-To: <20180920233024.28534-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 10:28:22 -0700
Message-ID: <CAKwvOd=V4n9MXDn3+gX7iQtoCBNEcn3CSueg++QvOMMzD4VDDg@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: Use proper enum for flctl_dma_fifo0_transfer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, David Woodhouse <dwmw2@infradead.org>,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 4:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is converted implicitly to another:
>
> drivers/mtd/nand/raw/sh_flctl.c:483:46: warning: implicit conversion
> from enumeration type 'enum dma_transfer_direction' to different
> enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>                 flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
>                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> drivers/mtd/nand/raw/sh_flctl.c:542:46: warning: implicit conversion
> from enumeration type 'enum dma_transfer_direction' to different
> enumeration type 'enum dma_data_direction' [-Wenum-conversion]
>                 flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
>                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> 2 warnings generated.
>
> Use the proper enums from dma_data_direction to satisfy Clang.
>
> DMA_MEM_TO_DEV = DMA_TO_DEVICE = 1
> DMA_DEV_TO_MEM = DMA_FROM_DEVICE = 2
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mtd/nand/raw/sh_flctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
> index c0c0798f268f..4d20d033de7b 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -480,7 +480,7 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
>
>         /* initiate DMA transfer */
>         if (flctl->chan_fifo0_rx && rlen >= 32 &&
> -               flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM) > 0)
> +               flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)

Looks like flctl_dma_fifo0_transfer() expects an `enum
dma_data_direction dir`, not an `enum dma_transfer_direction` as noted
by the warning, and luckily the values specified happened to have the
same value today as you noted.  So this change is no functional
change, but will prevent changes to either enum from potentially
breaking this code.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                         goto convert;   /* DMA success */
>
>         /* do polling transfer */
> @@ -539,7 +539,7 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
>
>         /* initiate DMA transfer */
>         if (flctl->chan_fifo0_tx && rlen >= 32 &&
> -               flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV) > 0)
> +               flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
>                         return; /* DMA success */
>
>         /* do polling transfer */
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
