Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F3C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E74206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="pe199ICu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E74206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeIFMZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:25:48 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38958 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:25:47 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so7999021uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Slo4tfo2wtx/SydMkopT1pC0pBzmeD37AMX3zMM6ZQ=;
        b=pe199ICu0beE1L6Kr6aA6v8WeHd8m9kopmSqATJ4cKUdSzN+XHpW0nED/FNTo/Hb1q
         GlWgDRzSVetyxNBLJs4PEQ4DYdzBzqhfzUw3fVycP8SnUGvVcB5R7D0QPr7s1dbwYHYj
         W9cS3v6Ffde7LPyJUwV07StylaoJ6HHOnWRVHT5T6nOVYnzZxlTQUhyb67AUK8W2BfUR
         G8+9Ch0g73sJTvBt3Mxk5o1HPNqmSbBOiZl/eHhpwCey3LU8A9HYL76PRh8uUrO6YeYB
         daC44PJpilAEevGr8fbzt36GEVC1zkzt4WVQaurk9Y60JOFtVLPrxFr6iZPPEFiP3GU9
         yx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Slo4tfo2wtx/SydMkopT1pC0pBzmeD37AMX3zMM6ZQ=;
        b=sPoEtTs8RUygIMZOPjhS/hSFXmkSZYopZ/u60dqP0Dcgg3nlyYP1kw8/hZJHHEnJYW
         8TpfCzVg1IsZTyTWBOhp4G2Vc4+wug/MLm+vOEGjDoAIajG7YKTtihCCR8lE+im27wLu
         JX4YY7yG3JjG5zD6f6agnCnuWDggMydEtwpyaCJodDfZBvhdakEz+gSKusKmFMIVdfuK
         p8reXNUaxb+OuyO6lodxdCO02kYCB5mMdyogQiZ4xgXy7q9sAnW/oO3nGqwmVrNvJQOu
         OL1ZobAt6KzUdBcD5dc3wEHwUD+gv1fODq3DwmOKYd+xfQpXKaLhGp5qMuF28y/BV8e0
         I+vw==
X-Gm-Message-State: APzg51CqYCJ1ZSmcVt8IBRNdkUAT3J6kV1fGPLrtHkJmrbqHHbf1mXFt
        J7G6z5gSCext8nm6S4xD57STHTxpVAxJ+VJucVsySV1xcf8=
X-Google-Smtp-Source: ANB0VdYLRaiKqIdHkSqRIqU3rRShksb+miYH8Ckn/eTYXUHuqBAk8RV6qps908ATGS0/cml+KFhcim5/dg5R+Q5gOu4=
X-Received: by 2002:ab0:7110:: with SMTP id x16-v6mr497106uan.194.1536220296986;
 Thu, 06 Sep 2018 00:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
In-Reply-To: <20180905084017.27593-1-baijiaju1990@gmail.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Thu, 6 Sep 2018 09:51:25 +0200
Message-ID: <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
To:     baijiaju1990@gmail.com
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 10:40 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> The driver may sleep with holding a spinlock.
>
> The function call paths (from bottom to top) in Linux-4.16 are:
>
> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 754:
>         nvm_dev_dma_alloc in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
>         pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
>         pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
>         pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
>         spin_lock in pblk_recov_l2p
>
> [FUNC] bio_map_kern(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 762:
>         bio_map_kern in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
>         pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
>         pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
>         pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
>         spin_lock in pblk_recov_l2p
>
> To fix these bugs, the call to pblk_line_replace_data()
> is moved out of the spinlock protection.
>
> These bugs are found by my static analysis tool DSAC.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Move the call to pblk_line_replace_data() out of the spinlock
>   protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>   the calls to bio_map_kern() and nvm_dev_dma_alloc().
>   Thanks Javier for good advice.
> ---
>  drivers/lightnvm/pblk-recovery.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 3a5069183859..5fde414d78bb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>                 }
>         }
>
> -       spin_lock(&l_mg->free_lock);
>         if (!open_lines) {
> +               spin_lock(&l_mg->free_lock);
>                 WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>                                                         &l_mg->meta_bitmap));
> +               spin_unlock(&l_mg->free_lock);
>                 pblk_line_replace_data(pblk);
>         } else {
> +               spin_lock(&l_mg->free_lock);
>                 /* Allocate next line for preparation */
>                 l_mg->data_next = pblk_line_get(pblk);
>                 if (l_mg->data_next) {
> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>                         l_mg->data_next->type = PBLK_LINETYPE_DATA;
>                         is_next = 1;
>                 }
> +               spin_unlock(&l_mg->free_lock);
>         }
> -       spin_unlock(&l_mg->free_lock);

Wouldn't the most straight forward solution here to not take the lock?

As pblk is doing all the recovery sequentially during initialization,
I don't see the
reason for grabbing the lock.

>
>         if (is_next)
>                 pblk_line_erase(pblk, l_mg->data_next);
> --
> 2.17.0
>
