Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A149C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D61620838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UB3Pt/TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfBUXF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:05:29 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50613 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBUXF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:05:29 -0500
Received: by mail-it1-f193.google.com with SMTP id m137so507347ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M18y1j6N0BCPC6Qvm+oCd9cTgbTHzAhsGLH6qTZCOZg=;
        b=UB3Pt/TAhv5IjOxRvaiLS/aDHOu0BHqJAaVmztbR3nDBwQMq68zY37bNnLJk5cpjAB
         iu8TAGjqmYJIfj38mb/ku00WfoC93c+VgT8uJQj/x00JD7K0ssTVyNK5UuR0CHPIk+0H
         kezIq4fbNbZgHihpQAvGp5Q0s3N7D5gskOGd8xCaqoI/byLj11Zt7v+dlCHPr5szjucw
         MA0hqIUv+SEGGAop89a+I9fQMRbx4WSL0d+AgoeABwVuu92wu6NxTqswkAFcHvV21zXf
         2H3I6QmWyznNZx5eJuWCSKJAqBev3Auc0bRFN5Nld84Vsg+CkrftiMbGKsI5J5B3YU+B
         PqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M18y1j6N0BCPC6Qvm+oCd9cTgbTHzAhsGLH6qTZCOZg=;
        b=KjdNIxACYsKrbDWput6g2T//5Z2AO7Zv72jvVCWOhLxf2jKqszdLy/wpwUEEFLQFPl
         HRHVCgFvU0GeJ2OU/erwrjuDdPtUeh1BAPdCO28xYByBq7zLI7WBUuhxY+vEaOY8ocmd
         gLt5SU659Us8ptVWOs7/ReszOQ1Xi+j/DrgcDB7Ec1fk5JOUATPoGxHUIb5VvvpurnlE
         J+41IJMazF6u0KneT7y5OZlNFXGorMi81HWbgNGqvM/3Bq0EqcrADB+c4VWoHB8TzxAq
         wtqOihAG5JrvsUmAlgm+pWi8r0uuNn4XgMzJLAWZVS+GmagDpDRbP5+XSmG9X7O/2ebP
         worg==
X-Gm-Message-State: AHQUAuaSyX5B0gzdPGryaKulZqnnqne+oTYEtCnrGbduvXTYDkTE11/A
        qd2r5nK5YYEUHrnl59r1/XG1xdJ+J984Rf7CAqG5rw==
X-Google-Smtp-Source: AHgI3IbosYKaCWed927UbZANAkfOS+LE0FELNMJEJrToVmfVRIFOE2T7F4QzFVFavvoelT2LUgzH5iMTCu9TzmoXe+E=
X-Received: by 2002:a24:2ec2:: with SMTP id i185mr637247ita.62.1550790327967;
 Thu, 21 Feb 2019 15:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20190221222123.GC6474@magnolia>
In-Reply-To: <20190221222123.GC6474@magnolia>
From:   Hugh Dickins <hughd@google.com>
Date:   Thu, 21 Feb 2019 15:05:01 -0800
Message-ID: <CANsGZ6Zb0hLWZH3Tnx83hrgnSchsr06HNT9ZE4F0Z=kt3PRS3Q@mail.gmail.com>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:21 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> When we made the shmem_reserve_inode call in shmem_link conditional, we
> forgot to update the declaration for ret so that it always has a known
> value.  Dan Carpenter pointed out this deficiency in the original patch.
>
> Fixes: "tmpfs: fix link accounting when a tmpfile is linked in"
> Reported-by: dan.carpenter@oracle.com
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Gosh, yes indeed: thanks Dan and Darrick, I'm very sorry for not noticing that.
Acked-by: Hugh Dickins <hughd@google.com>
(and sorry if this mail is garbled: it's from gmail, I cannot use
alpine at the moment).

> ---
>  mm/shmem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0905215fb016..2c012eee133d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2848,7 +2848,7 @@ static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
>  {
>         struct inode *inode = d_inode(old_dentry);
> -       int ret;
> +       int ret = 0;
>
>         /*
>          * No ordinary (disk based) filesystem counts links as inodes;
