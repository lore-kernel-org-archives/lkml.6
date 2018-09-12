Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C23C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B913020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWdb97Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B913020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeILWGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:06:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeILWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:06:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so1301855pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXvGnZs/IiKs2GckirEX6nN/Oz8y9hZIMqi+cEKmwk0=;
        b=fWdb97LzhqC0KEXwTtadYPN4+UNioT+fIevo0g2XX46mj5c6zX0u3LtX2fsNWDxGGL
         x1DKEFWMOJxIlxQu7gyaHLOSEWKM8QeieO8admRPpd0bV0DrWrjR4nQcIaY55g2faGMR
         UC3Dw0g0tMeLufwh9fw6sWXwVy18lQk8g1wL6LHKs5x9rPX+DLHpjqOO9ZMlcEx97AZ2
         aQru8dwmuoqeIUpGRHAn7kYVpD4FfUpN6TuTBL0nDRN9AaC3fokx/kH4Qqb7B4wIEw0q
         SQrqCJTSPnoEh9U3rKtZUz5I7hXBOonGxVo7yWX0UKduxH0MI4QyYI0yaYNPiWXHAVhv
         9j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXvGnZs/IiKs2GckirEX6nN/Oz8y9hZIMqi+cEKmwk0=;
        b=qAmmo0nrstlI04cTmiOb4MjHpDCoI9goZInef1zS7IrmIyHn8REDuDqGXsX6AmaLDF
         9O/20uDlAwf7NQjQoq3d2sE0ouGu5NpyLPZlOGW2z7OSYaMQKD82xgLB/b9vZZySXPwz
         w0gmxh23BvgRV730/3+iclc0jc9Aez1S9dlnCRCjYPC67U+jtapFUPVNJldiZbcBb/Y+
         uW1uAPwnaZ0akgfMDTmtJG/wCrwbeC+cdqMcAA7iwjvISPforAXa/H7JYPd1gtp3EFOD
         OolUMilywyTzt+qH6jkPbw4yD7fNAs139kXL9rjRcNJ5vCBiSUC2L7iaVM/Eq24+lbdv
         TQ1g==
X-Gm-Message-State: APzg51Aaafyx2fUm3lGlmnimzitoCztABnsKeBwgkCinD5IWHT6QG6VK
        Hr6F9vCOnj6kSLw6gbU00olXm4gxIAo3U3iFlQp5Xw==
X-Google-Smtp-Source: ANB0VdZIaC8EVEOSn9E2yRN9SqXV1wo0MT1UKBwPmkZd/lo4oRHx/bdOALDhdz+USnVPPuD0i34EDB0PeSZXIosbZOk=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr3395756pgb.145.1536771669203;
 Wed, 12 Sep 2018 10:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180911234020.9064-1-natechancellor@gmail.com>
In-Reply-To: <20180911234020.9064-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Sep 2018 10:00:57 -0700
Message-ID: <CAKwvOdmJ1NGmFi8Vcv5oPr7828X3tbOZeUainPhtC4HnTK_xjw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ep93xx: Return proper enum in ep93xx_dma_chan_direction
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:40 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when implicitly converting from one enumerated type to
> another. Avoid this by using the equivalent value from the expected
> type.
>
> In file included from drivers/dma/ep93xx_dma.c:30:
> ./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                 return DMA_NONE;
>                 ~~~~~~ ^~~~~~~~
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/linux/platform_data/dma-ep93xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
> index f8f1f6b952a6..eb9805bb3fe8 100644
> --- a/include/linux/platform_data/dma-ep93xx.h
> +++ b/include/linux/platform_data/dma-ep93xx.h
> @@ -85,7 +85,7 @@ static inline enum dma_transfer_direction
>  ep93xx_dma_chan_direction(struct dma_chan *chan)
>  {
>         if (!ep93xx_dma_chan_is_m2p(chan))
> -               return DMA_NONE;
> +               return DMA_TRANS_NONE;

Looks like this changes the value of the returned enum from:
DMA_NONE: 3
DMA_TRANS_NONE: 4

Hopefully the DMA maintainer can review if this was ever correct?
Looks like the callers of ep93xx_dma_chan_direction were comparing
this return type, so those comparisons would likely always be failing
if `!ep93xx_dma_chan_is_m2p(chan)`.

Normally this warning (-Wenum-conversion) is kind of noisey, but it's
concerning when the enumerated values evaluate to different integers.
I think it's found an actual bug here.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>         /* even channels are for TX, odd for RX */
>         return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
