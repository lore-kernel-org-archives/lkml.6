Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E07C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81E2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mR82q3S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C81E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeJPC3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:29:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40311 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:29:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so22544506wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzzDb02wcMiUpjOGmy+dVj43H0l+RcMs0T3YRHxEV2w=;
        b=mR82q3S+9tPdHDEiUKqg0DLGKvo1LBTDWym/CPoBs5Un6hz3xN38vtljGn2JNmjAIc
         xwvnfdpxAZlAP1w2Gsck1kY6Az8b4zO/ErazdqWYJt8WyKtg4tSOo/JSmyA4fX1qXDeW
         iFbE4YPg7QzVht1JLpB7/thGGl3Ua89QLQjoiOyuRe4lbwDXCjN8Mml4jF2NKfkmAgV8
         HCSWk6tQ7D6KftkoKI/C2nfAhqSrRRHZp8WcKSQVWvQvLg3ec6TCFghjwe/9y1YjbJc8
         cY4HWJQR6A0jTRygzuxg59eE4P1+GgD0KKcNwLsTeFB0lW7jPEbgt6k+dO89AwIoP1xa
         fUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzzDb02wcMiUpjOGmy+dVj43H0l+RcMs0T3YRHxEV2w=;
        b=CuOJRoA/kImZXczPxp70cgNvz+KY6ayUzEFbDee5cN/ieJRvXkSEP2QgQHYZsxd+mM
         1IM9m+xjKJw9wcYpm2kk3WsHa+XBpUGFgvzeo6vkGL3FQCxVQSALOKFJbHJHDNu+LF0m
         +dP5C/fykhUGuyO+7hdZUGaDZikN455jZadJw8yhCQ/AK+FV1qOGtTJORfw7+KHUAmms
         KqRxTJfw6O9ggAshWfPuaBXyoSE/mJpzqhVdXMTHQh1CxrheLaWa1CRTvyrLEVn3cmhA
         gmgu3UQ94e1GBfOEqkgDkvUAUQvLubzO50hmmFChSpMTqZaRX1HzvmkXZQUrFlaeq7wp
         mgOg==
X-Gm-Message-State: ABuFfojloe78W9+8K4MCNRRB4KHAttao7p0JhrSZ0Rv9Rfnaz8wiB5eX
        6ROXC+ML5/FeZLoCLhNCnHLPEP+jO2O3FS8GL8kG8g==
X-Google-Smtp-Source: ACcGV62hZNpzZZUS1jTUnKWbl6z483zYZdyL2IGPqtpRIVS5C5YZtiNuDy49g4sAzgSLKgKcG0LWy81+xOVfvz4ub3E=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr14878835wrc.131.1539628954043;
 Mon, 15 Oct 2018 11:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181010142548.GB4071@kroah.com> <20181010212426.3167-1-laurence.rochfort@gmail.com>
In-Reply-To: <20181010212426.3167-1-laurence.rochfort@gmail.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Mon, 15 Oct 2018 11:42:21 -0700
Message-ID: <CAAW3YpbLUSicJS788rMTnBJTiKHJy_hW-EOS7s05+V-09zTbrQ@mail.gmail.com>
Subject: Re: [PATCH v3] staging: gasket: Fix sparse "incorrect type in
 assignment" warnings.
To:     laurence.rochfort@gmail.com
Cc:     Rob Springer <rspringer@google.com>, benchan@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 2:14 PM Laurence Rochfort
<laurence.rochfort@gmail.com> wrote:
>
> Remove the coherent buffer __iomem cookie because the buffer is
> allocated from dma_alloc_coherent().
>
> warning: incorrect type in assignment (different address spaces)
>    expected unsigned char [noderef] [usertype] <asn:2>*virt_base
>    got void *[assigned] mem
> warning: incorrect type in argument 3 (different address spaces)
>    expected void *cpu_addr
>    got unsigned char [noderef] [usertype] <asn:2>*virt_base
>
> Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
> ---
> Changes in v3:
>  - Just remove the __iommem cookie, don't alter type.
>
>  drivers/staging/gasket/gasket_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
> index 275fd0b..e62adcd 100644
> --- a/drivers/staging/gasket/gasket_core.h
> +++ b/drivers/staging/gasket/gasket_core.h
> @@ -231,7 +231,7 @@ struct gasket_coherent_buffer_desc {
>  /* Coherent buffer structure. */
>  struct gasket_coherent_buffer {
>         /* Virtual base address. */
> -       u8 __iomem *virt_base;
> +       u8 *virt_base;
>
>         /* Physical base address. */
>         ulong phys_base;
> --
> 2.9.5

Reviewed-by: Todd Poynor <toddpoynor@google.com>

Thanks!
