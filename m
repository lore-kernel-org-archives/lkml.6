Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1038C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DF12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFkJCq3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DF12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLKXkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:40:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40680 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:40:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so7654781plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VjH+rI5/R187+iqNGcuaXCuvoVFV97Sx2vAw7HIEn4=;
        b=EFkJCq3AUcJbdKF3L2kyDYz0jOQBo2Lb1TRcuxXqP+nuHCl36bExK2kNeBXj4Enwxw
         LPIWd6gsqOi0PWsYu6ycI24Og2Lij9e/S3K8VfQiP7wJuzOmYQE+BnK8RYekVdkuQATC
         lLioTZxS+ckRemHStJgDTq+pZqQnuVN+1uEbPmVKBoAGpfOTtz6QN28ZZW9hg3ZeWzrD
         B/S5xZbKU2O8Er0FGg8t2cyutRzGJmDH2dNreQ+oI09Xc0h19a6WfcHP9r2F7XpmFS3T
         igtQb8tZ7Uk9LO6Ae5qrAN+cEi3aoQ5oFsYdwPNSFS43jD1B+YHeosRWqlz760EfLD8t
         oWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VjH+rI5/R187+iqNGcuaXCuvoVFV97Sx2vAw7HIEn4=;
        b=Kkf8N+dQ0fXF7GcfFf0POy1GkFm8/L80rB4cWGEYZK0ACqF3isrCwsM2BtaA0BaHio
         tRql6FuK+rGqUjUxUXdR1lfz0ueh7VP4X5C37DJ5cVZnAXP42jfGqAFxA2BMIm/dTlNQ
         8jr7snnrABImLiEMCJhh9o/O36V2Hu5HHErXAbrYybh5CnbZQC61eOdu9oRsACrDPfiT
         RgafKzjFo1STTw9ouzrMOR8lvDsH+iG7ys9Cb5A7MaPHehSApwYZbBA2L6TSaXkM4nru
         JYM8FJPgUOWQPy2bp51ZYoBJK6MA5ei7/fBRaSk8nGwePoGvHr5KHd8pDjMaegukKkDQ
         V3MA==
X-Gm-Message-State: AA+aEWY/gtvwISjdEEpqNgr5yssrNr3y7T5YzajnXg1J3B2ZOqNVOLi4
        oc9qSYx/BdZq+jWAh4y8Pd+eOz65ZcHhS5Ljy0RHCQ==
X-Google-Smtp-Source: AFSGD/WsyKVvcCTxWpYY2NcXDvj/1CsgRv/lcwAgvRv0tnulhEEkYD+NAs9wIfUNhpFKdr8AJKdMYjC33gJOd3PaGhk=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr17721740pll.320.1544571616230;
 Tue, 11 Dec 2018 15:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20181210234929.5729-1-natechancellor@gmail.com>
In-Reply-To: <20181210234929.5729-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 15:40:04 -0800
Message-ID: <CAKwvOdkB0BViLgVyWBQZw4jZgFjp-3m2ndjiJmutsbevYjy7nA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ux500 - Use proper enum in cryp_set_dma_transfer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:49 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/crypto/ux500/cryp/cryp_core.c:559:5: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                                 direction, DMA_CTRL_ACK);
>                                 ^~~~~~~~~
> drivers/crypto/ux500/cryp/cryp_core.c:583:5: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                                 direction,
>                                 ^~~~~~~~~
> 2 warnings generated.
>
> dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
> Because we know the value of the dma_data_direction enum from the
> switch statement, we can just use the proper value from
> dma_transfer_direction so there is no more conversion.
>
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Deja vu!
These particular enums get mixed up ALL THE TIME. Thanks for fixing
probably every instance of this bug (via patches before this one).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
> index d2663a4e1f5e..a92a66b1ff46 100644
> --- a/drivers/crypto/ux500/cryp/cryp_core.c
> +++ b/drivers/crypto/ux500/cryp/cryp_core.c
> @@ -556,7 +556,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
>                 desc = dmaengine_prep_slave_sg(channel,
>                                 ctx->device->dma.sg_src,
>                                 ctx->device->dma.sg_src_len,
> -                               direction, DMA_CTRL_ACK);
> +                               DMA_MEM_TO_DEV, DMA_CTRL_ACK);
>                 break;
>
>         case DMA_FROM_DEVICE:
> @@ -580,7 +580,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
>                 desc = dmaengine_prep_slave_sg(channel,
>                                 ctx->device->dma.sg_dst,
>                                 ctx->device->dma.sg_dst_len,
> -                               direction,
> +                               DMA_DEV_TO_MEM,
>                                 DMA_CTRL_ACK |
>                                 DMA_PREP_INTERRUPT);
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
