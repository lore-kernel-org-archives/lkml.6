Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1867C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1B2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="On5bmQR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfBKNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:42:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52271 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfBKNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:42:08 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so20932724itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giqaHiBsND/qI83EsAI6AXBrNN9Hhmins57o8Oh9M0s=;
        b=On5bmQR81k3CMpCY2wBV+GXkQ+HCSXPn8d+JJJDIrqylCzE0J6ucmHhww5bdvfWW5B
         hUu4DXQwPZisISu0yDZWdq+nsxNvTHaPXgXN4qSzkPC1qmNWx9NrUeXNJVGcbWdxG4kw
         8/g51qJk7VyDQKbXFiNavUSJSAch0x3CNhG+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giqaHiBsND/qI83EsAI6AXBrNN9Hhmins57o8Oh9M0s=;
        b=fc+UR8wtoLsEEaRauxPjLXuNXXyi2kJP22G+Zo6oa2m7mBzD8BMMimL8qd2VwE8mMN
         bxZPkZpVYz5wxCpa1DKvkotYIKUae0q1I64luHF+H57kNUEhWtNFR2UV2u8rpG95e9gl
         VrsiJjrJhRrqJIxD5WOAA0aDf4OfLEWcptLvXnI2JbxwagTOVBvF/OO/NrvtothYnkyC
         y9OqYmzAafGLFdLfYLPhQmuENluZ4xe/vxebOnS82OQaCWViiqLEpYkYtU/9VackREsr
         0h6EGAPlLhYD7bcVxwlOwwWfqI8oqb95vOtnT4o/kPz/9K1yRVW7bfit4sPPPLL9cC/w
         clBg==
X-Gm-Message-State: AHQUAuaTpYbLL54Y2DR+gu9w730+CrNoH/HqjLoEqDnZZsne2I6ZPfhX
        SO7JdDK16Od19+663IUP734zOwYJboKeBEo8rQUV9g==
X-Google-Smtp-Source: AHgI3IZ0NSyuEqjibOHC2dMJ0hCCGPwIqvxgBHBCAWDVSEKJdtJd8a1E6OU2Z6LOAFZgn6fQoo398vjcg5whZD34lZA=
X-Received: by 2002:a24:26c4:: with SMTP id v187mr6427552itv.54.1549892527862;
 Mon, 11 Feb 2019 05:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211133415.9020-1-colin.king@canonical.com>
In-Reply-To: <20190211133415.9020-1-colin.king@canonical.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 11 Feb 2019 19:11:31 +0530
Message-ID: <CANjDDBj=kzvaWZfwe6rrJki9crfCGxUaBi2Pc+Cb3+MSWYtAVA@mail.gmail.com>
Subject: Re: [PATCH][next] RDMA/bnxt_re: fix or'ing of data into an
 uninitialized struct member
To:     Colin King <colin.king@canonical.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:04 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The struct member comp_mask has not been initialized however a bit
> pattern is being bitwise or'd into the member and hence other bit
> fields in comp_mask may contain any garbage from the stack. Fix this
> by making the bitwise or into an assignment.
>
> Fixes: 95b86d1c91ad ("RDMA/bnxt_re: Update kernel user abi to pass chip context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 1d7469e23cde..de5cb9a61a78 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3720,7 +3720,7 @@ struct ib_ucontext *bnxt_re_alloc_ucontext(struct ib_device *ibdev,
>         }
>         spin_lock_init(&uctx->sh_lock);
>
> -       resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
> +       resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
>         chip_met_rev_num = rdev->chip_ctx.chip_num;
>         chip_met_rev_num |= ((u32)rdev->chip_ctx.chip_rev & 0xFF) <<
>                              BNXT_RE_CHIP_ID0_CHIP_REV_SFT;
> --
> 2.20.1
>
Thanks  that was missed!

Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>
