Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0EF2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5M2vHv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0EF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLKXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:46:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLKXqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:46:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so7912901pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP2JXB83ehSuUUhv1rq1xYihPYM+7i/n+umUAu4qGKI=;
        b=U5M2vHv1x8YzyzQvGztuJl8ETWMjMWhtp5ezX9d5JWoxElx18DXW3xzhaFUxhlPyo+
         AdceRz38pBu9o4M7PdqzNQEJXxUONYE+01v/5W9i0ed0vMaUXxAOFUCLMW1bUq0ai9Ci
         xNONWGdkAih4Y5FN5bbgyWokZ67We2kQid3vLYGwcSZBkWw6ra1gZrjtMkD/zKq2NZda
         opwIEvgPh0rO1/W7+ODXx1WflOtpwGPLboZpJ8Eg9elSshb9bZBbOVUMznOI0gAzIn+q
         gFnusNRJJIVnyZ57GFwS0rXjiIM5GPEmz4qVOFCL+LIkwMg3RLYE2iExgJvTbrTTzlxt
         4R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP2JXB83ehSuUUhv1rq1xYihPYM+7i/n+umUAu4qGKI=;
        b=nZ6JAloEBMSvS16VoOw+YACI3s9dznrzmbVuryt0rpcNbymeAdLtIipo2D/m3G1Tt+
         0DXHvtjnfkVFP5JI8e//U7eNkgkOf5neOdl7PqAYedD/Que0fkVWR5drJxQeu0s3E2yN
         HAnXXneaUTzOkk8AqyGziTQlGF64TTNGTeMrpVENMpFf4aHmIjZppMHfeYxNsVZUF8mK
         F77bN1KxI0DZQSOLBZKIAjOPhTdrrGYGJEcGD3YjaLt1c+SuOuFDVIq4/g7S+8CW4377
         wtuMFJsOJEY/l5AutbGhw1paFIk4vJId4wIIJYus7WSNoHNq3q6y521v59ff6XqoyTFp
         Yg1Q==
X-Gm-Message-State: AA+aEWbwwINjEawGPLCf+9GckphtBEchsDshWPKQ0eaKvGvHkg9IRJLh
        WM7BEG8E2BYLCF3uIP0w6QsBxeJnDsDb0o/AHdxlxm3G
X-Google-Smtp-Source: AFSGD/U+Sj1xCGLGxl7sI6XzxDGxtnraWmjCBkeNp51xMqsupHyJJX1ZpkKo5znECV4j3epYVEWsL+TCRcKFdk5VI7w=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr16780608pgf.302.1544571967752;
 Tue, 11 Dec 2018 15:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20181210234954.5862-1-natechancellor@gmail.com>
In-Reply-To: <20181210234954.5862-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 15:45:56 -0800
Message-ID: <CAKwvOd=2ORedFQbBFE+pyhEb-XTu0BVLGWRxYN3dLi7gaSdz+w@mail.gmail.com>
Subject: Re: [PATCH] crypto: ux500 - Use proper enum in hash_set_dma_transfer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:50 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/crypto/ux500/hash/hash_core.c:169:4: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                         direction, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
>                         ^~~~~~~~~
> 1 warning generated.
>
> dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
> We know that the only direction supported by this function is
> DMA_TO_DEVICE because of the check at the top of this function so we can
> just use the equivalent value from dma_transfer_direction.

That's correct. Thanks for fixing up yet another one of these enum
confusions. (I'm beginning to think we should change the values of the
enum members so that things break when aliased as such. Unfortunately,
that would result in runtime bugs rather than strong type system based
compile time checks; but this warning from Clang helps).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/crypto/ux500/hash/hash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
> index 633321a8dd03..a0bb8a6eec3f 100644
> --- a/drivers/crypto/ux500/hash/hash_core.c
> +++ b/drivers/crypto/ux500/hash/hash_core.c
> @@ -166,7 +166,7 @@ static int hash_set_dma_transfer(struct hash_ctx *ctx, struct scatterlist *sg,
>                 __func__);
>         desc = dmaengine_prep_slave_sg(channel,
>                         ctx->device->dma.sg, ctx->device->dma.sg_len,
> -                       direction, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +                       DMA_MEM_TO_DEV, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
>         if (!desc) {
>                 dev_err(ctx->device->dev,
>                         "%s: dmaengine_prep_slave_sg() failed!\n", __func__);
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
