Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6322C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D4F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="sLgVWhTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D4F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeJ3Dra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:47:30 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:37760 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ3Dra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:47:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id E97FF75E;
        Mon, 29 Oct 2018 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540839451; x=1542653852; bh=S194dGt1nr
        tTrOMnUcpfB3rdAqbSpgnf+IwHD1/78bE=; b=sLgVWhTUCkLKgW7Vc0Z4PBVXKn
        aBX63wR8reB5EpMeRA0+m2bSl+swb9gTciumAU9wwSJ3xhnX6IsNksg8kV9yNhS+
        I3qyQJjsvYBVO/1cb+7V5oICP0vikTTWfwzis7q/P6BFRBjhpv/rBqWbZjP5mTlS
        YRLetUVTOp5Orn1d3rNf2NGX5CY2jpFkEaASwyyGZz7tAe+lYvBlpYYm3WMTXuNb
        vpnPt0Iqx1e8DlhGTI7HmsmS4mo2GY+0zSX6SyT9HErGXXIzwIcDl6UI+hlADeeY
        OK94ah3v5hipbPYic+vMrLRiB6w7+W7z6oDYm5eBLu/RfH7hqsBMW4iR5DoQ==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Q8Ad75TNB3h; Mon, 29 Oct 2018 13:57:31 -0500 (CDT)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com [209.85.166.178])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id C708A75C;
        Mon, 29 Oct 2018 13:57:31 -0500 (CDT)
Received: by mail-it1-f178.google.com with SMTP id m15so10759756itl.4;
        Mon, 29 Oct 2018 11:57:31 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLEOb3/iJA8r2wO9vzVmvzIfKpEWkFfUEWBTejLQrhFZFOpZZM6
        a9VrwoRiyZXaWjJ+4HVodHJPfiO0M37uMzMDqlo=
X-Google-Smtp-Source: AJdET5caYmDK+Dc0yzyzrWKSWvveRStmMdpNrlfImVAR3S7eRZRrzgWoQ5zBcwFjaBD4VXAeqqWL7VaEsSCnlxlLnmI=
X-Received: by 2002:a02:5409:: with SMTP id t9-v6mr11207783jaa.100.1540839451535;
 Mon, 29 Oct 2018 11:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 13:56:54 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com>
Message-ID: <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/vfio: Fix a redundant copy bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, alex.williamson@redhat.com,
        kvm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could you please apply this patch? Thanks!

Wenwen

On Wed, Oct 17, 2018 at 2:18 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> the user-space buffer 'arg' is copied to the kernel object 'op' and the
> 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> error code EINVAL is returned. Otherwise, 'op.op' is further checked
> through a switch statement to invoke related handlers. If 'op.op' is
> VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> to 'op' to obtain the err information. However, in the following execution
> of this case, the fields of 'op', except the field 'err', are actually not
> used. That is, the second copy has a redundant part. Therefore, for
> performance consideration, the redundant part of the second copy should be
> removed.
>
> This patch removes such a part in the second copy. It only copies from
> 'err.type' to 'err.mask', which is exactly required by the
> VFIO_EEH_PE_INJECT_ERR op.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> index 38edeb4..66634c6 100644
> --- a/drivers/vfio/vfio_spapr_eeh.c
> +++ b/drivers/vfio/vfio_spapr_eeh.c
> @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>         struct eeh_pe *pe;
>         struct vfio_eeh_pe_op op;
>         unsigned long minsz;
> +       unsigned long start, end;
>         long ret = -EINVAL;
>
>         switch (cmd) {
> @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>                         ret = eeh_pe_configure(pe);
>                         break;
>                 case VFIO_EEH_PE_INJECT_ERR:
> -                       minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> -                       if (op.argsz < minsz)
> +                       start = offsetof(struct vfio_eeh_pe_op, err.type);
> +                       end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> +                       if (op.argsz < end)
>                                 return -EINVAL;
> -                       if (copy_from_user(&op, (void __user *)arg, minsz))
> +                       if (copy_from_user(&op.err, (char __user *)arg +
> +                                               start, end - start))
>                                 return -EFAULT;
>
>                         ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> --
> 2.7.4
>
