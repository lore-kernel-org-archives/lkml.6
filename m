Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA9C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AECB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiNC0jg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AECB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeILEjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:39:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40394 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeILEjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:39:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so27831pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdighdpCK8l3g23G1LnqfpjUHeJsbRGl3KVCVAsOO1s=;
        b=qiNC0jg6QL6IaB5DyGB434k0Eaa6vKbTuMslWV8nnnsbXtu2DrbnXwIwUCtOxSyKke
         kEKNvsCbJBWNhsVzeV4qHPlTWWVL9cpwCDcONjLYNjZrG+mR5Yhji3paGLmg+nLzPaBV
         sHjQsXddN5q+yOt6F8RDgoVdGiiIK2xpBJnSHEEyadROlpnx0BoDCNOl5p8HkZPZzhbg
         NFy1Q6QdTgPz3XnT1DCipnOuy/6JqXCRlB8ktfSylN06aPoKxjTGqGYHqSF7cbRHMFHr
         lJxk6hi3AR947Dt/+04H9IkrJfD5z7B5O6DVldwS6W5hhn2GnwgozxsyPwrqUx01fSDu
         p/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdighdpCK8l3g23G1LnqfpjUHeJsbRGl3KVCVAsOO1s=;
        b=C9NvH6X7IJRmfkmWJpUz3mTq5qRDucFP7k2bFUEBHZcpNQXe9kOr9x/15v7JDsntj9
         kfv3+HVdz91W84CfhtCyu3CqJ1JwUyu8WHraLnJcewaTzgQj5VbWa6Cc81VS44OZuC/+
         pM8rmfxFdDy0iW+lqudamKimPkUCdNm882NIWHgqIfX9c/EsHU/REr/mHArUxTA8Jvgv
         1gB7CPVsTYBCV9ORlRcdCsnNfbglqg3IGqUx0314xcPhvNd8uAJNiQsj+caqRU/k7qQq
         DphPZK5gjStI+LTzDcxhq9Z4A+8afcA90y6+jutWoDvYkC2lCApGiJ+d4PBQE05EmQJg
         pTjg==
X-Gm-Message-State: APzg51BHmoBDeVkjYYqGmfP309XLrRXvHkF+omsVKePcGo757x9QZnpv
        owVwUk9GjlbiwR4eS/9zQ0V2ke//DmmUeOOtN5+0LQ==
X-Google-Smtp-Source: ANB0VdaWrUyy6IUGHywR6mIu3glomjFrPcf930wxVFbC2+1V7OKElfuiu+bPgwdSWO8w+4VT6cKNG4TxBUR5yUY9V7I=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr32086995pfi.174.1536709079791;
 Tue, 11 Sep 2018 16:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180911230533.31873-1-natechancellor@gmail.com>
In-Reply-To: <20180911230533.31873-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Sep 2018 16:37:48 -0700
Message-ID: <CAKwvOd=KaX4+3J4WGOcWBAfhHEyytXKKCLHFdCuDAr5McQ-g=g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix __aligned attribute on zynqmp_dma_desc_ll
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> ignored, place it after "struct" to apply attribute to type declaration
> [-Wignored-attributes]
> }; __aligned(64)
>    ^
> ./include/linux/compiler_types.h:200:38: note: expanded from macro
> '__aligned'
> #define __aligned(x)            __attribute__((aligned(x)))
>                                                ^
> 1 warning generated.
>
> Place __aligned before the semicolon.
>
> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index c74a88b65039..dc19d67cb8c1 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
>         u32 ctrl;
>         u64 nxtdscraddr;
>         u64 rsvd;
> -}; __aligned(64)
> +} __aligned(64);

Thanks for this patch Nathan.  Thinking more about this...the integer
passed to __attribute__((aligned(x))) should be in terms of bytes.  64
bytes seems kind of high.  Maybe they meant 64 *bits* thus 8 *bytes*
which already the default alignment of the struct:
https://godbolt.org/z/7vW6E3

In which case, the correct fix is to remove the `__aligned(64);`
outright.  Since that doesn't change anything (thanks to clang's
helpful -Wignored-attributes), such a patch would be "No Functional
Change" (does not change the status quo).  Still, it might be good for
the maintainer to remark if 64 *byte* alignment was intentional (I
would think not, but I don't have the datasheet for this piece of
hardware in front of me; never say never) before sending such a patch.

If the 64 *byte* (512 bit) alignment was intentional (again, which I
doubt), then this patch is good to go, but that would then be a
functional change and should be tested by someone with hardware.


>
>  /**
>   * struct zynqmp_dma_desc_sw - Per Transaction structure
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
