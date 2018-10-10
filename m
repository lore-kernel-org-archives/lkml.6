Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9BFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43D02087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9Csy1yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43D02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJJLlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:41:24 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40928 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:41:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id z130-v6so3761371vsc.7;
        Tue, 09 Oct 2018 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djoF6aDj3uGLbVmgSOoUxjqySXrK8yC+0Xs5Sv1AT60=;
        b=G9Csy1yYOCD94QXSKTe/YPKg+14lQIzZyloROtdU7uL6olyCS/AcrzwDgzpqRKTeVO
         xoR7FXoTFfxfuU6PntggnKJZT2pftMuEwioriYRNJhQzFD1pLi5ZSSLMMRZiZfBgp0gx
         XyHHpHJrsDMjc7OozUF0ZpW3ZrKP/dm26fd14072HIR0aio12n/IVOzUD//XvOfmMUCi
         I+XD65hZEILuVNQDXq1U+AT765OgTKfVNGAHVulJiNgVpiD0IJL0I1ziG0t45+Y8XeyM
         Ywci7Hv2o9xwJFc0nr8NJjw3YuhLwgOIW1hOkr/M8ofu3OUkrUcc1gOcYdsqFwYUOAUB
         SytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djoF6aDj3uGLbVmgSOoUxjqySXrK8yC+0Xs5Sv1AT60=;
        b=ETyY8EU81Jfa8eWNYnA1ROwECNKz1Lt+8KwL3rLdpnBmZc86v8FghsLBADJloofQfQ
         rfYKbvcKSmxcWvnGhEr2WjAvEW2f64JuUrIMHeWKFHMj7/DnZNkFuQUW7ntFN5nx6CQG
         Oi2SU8UHyE6iUshae5A6p34tvfCyRL8lYVOS8T7pq3j3Z2JproUs8OYlsOEwqtHAIiin
         ifLYC/m220b7II7lzAYMmJVFTyRaymFiMFYIxSndGfnp083ITuGBeNr14YcvOHb/mnOI
         cbET+JfwW1dVaCp5EhAoRVgrHFC2ZyELs7ejXa+5V21+KWd7P3E6PFqfg+xunFRdUPdj
         OlEQ==
X-Gm-Message-State: ABuFfohZj+tK6Wu6k74BW4A1xtFNHZfd54TPAKLvqIsvaIEhs3iViM+/
        LEIi0c5LBXxmaDv8B3eqvfyVwgyetEZ3mP9jXno=
X-Google-Smtp-Source: ACcGV61oxax6Y9tJQLlqlPQf9IWjWU3dh6tknLP69lckRPqZrmwWfksTnWgFAzGN/kI590S+UhvLj11gHd67yQF83c8=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr7788926vso.13.1539145269239;
 Tue, 09 Oct 2018 21:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181009175428.18543-1-lhenriques@suse.com>
In-Reply-To: <20181009175428.18543-1-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Wed, 10 Oct 2018 12:20:57 +0800
Message-ID: <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> Current implementation of cephfs fallocate isn't correct as it doesn't
> really reserve the space in the cluster, which means that a subsequent
> call to a write may actually fail due to lack of space.  In fact, it is
> currently possible to fallocate an amount space that is larger than the
> free space in the cluster.
>
> Since there's no easy solution to fix this at the moment, this patch
> simply removes support for all fallocate operations but
> FALLOC_FL_PUNCH_HOLE (which implies FALLOC_FL_KEEP_SIZE).
>
> Link: https://tracker.ceph.com/issues/36317
> Cc: stable@vger.kernel.org
> Fixes: ad7a60de882a ("ceph: punch hole support")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 45 +++++++++------------------------------------
>  1 file changed, 9 insertions(+), 36 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 92ab20433682..91a7ad259bcf 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1735,7 +1735,6 @@ static long ceph_fallocate(struct file *file, int mode,
>         struct ceph_file_info *fi = file->private_data;
>         struct inode *inode = file_inode(file);
>         struct ceph_inode_info *ci = ceph_inode(inode);
> -       struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
>         struct ceph_cap_flush *prealloc_cf;
>         int want, got = 0;
>         int dirty;
> @@ -1743,10 +1742,7 @@ static long ceph_fallocate(struct file *file, int mode,
>         loff_t endoff = 0;
>         loff_t size;
>
> -       if ((offset + length) > max(i_size_read(inode), fsc->max_file_size))
> -               return -EFBIG;
> -
> -       if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> +       if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>                 return -EOPNOTSUPP;
>
>         if (!S_ISREG(inode->i_mode))
> @@ -1763,18 +1759,6 @@ static long ceph_fallocate(struct file *file, int mode,
>                 goto unlock;
>         }
>
> -       if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
> -           ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
> -               ret = -EDQUOT;
> -               goto unlock;
> -       }
> -
> -       if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) &&
> -           !(mode & FALLOC_FL_PUNCH_HOLE)) {
> -               ret = -ENOSPC;
> -               goto unlock;
> -       }
> -
>         if (ci->i_inline_version != CEPH_INLINE_NONE) {
>                 ret = ceph_uninline_data(file, NULL);
>                 if (ret < 0)
> @@ -1782,12 +1766,12 @@ static long ceph_fallocate(struct file *file, int mode,
>         }
>
>         size = i_size_read(inode);
> -       if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> -               endoff = offset + length;
> -               ret = inode_newsize_ok(inode, endoff);
> -               if (ret)
> -                       goto unlock;
> -       }
> +
> +       /* Are we punching a hole beyond EOF? */
> +       if (offset >= size)
> +               goto unlock;
> +       if ((offset + length) > size)
> +               length = size - offset;
>
>         if (fi->fmode & CEPH_FILE_MODE_LAZY)
>                 want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> @@ -1798,16 +1782,8 @@ static long ceph_fallocate(struct file *file, int mode,
>         if (ret < 0)
>                 goto unlock;
>
> -       if (mode & FALLOC_FL_PUNCH_HOLE) {
> -               if (offset < size)
> -                       ceph_zero_pagecache_range(inode, offset, length);
> -               ret = ceph_zero_objects(inode, offset, length);
> -       } else if (endoff > size) {
> -               truncate_pagecache_range(inode, size, -1);
> -               if (ceph_inode_set_size(inode, endoff))
> -                       ceph_check_caps(ceph_inode(inode),
> -                               CHECK_CAPS_AUTHONLY, NULL);
> -       }
> +       ceph_zero_pagecache_range(inode, offset, length);
> +       ret = ceph_zero_objects(inode, offset, length);
>
>         if (!ret) {
>                 spin_lock(&ci->i_ceph_lock);
> @@ -1817,9 +1793,6 @@ static long ceph_fallocate(struct file *file, int mode,
>                 spin_unlock(&ci->i_ceph_lock);
>                 if (dirty)
>                         __mark_inode_dirty(inode, dirty);
> -               if ((endoff > size) &&
> -                   ceph_quota_is_max_bytes_approaching(inode, endoff))
> -                       ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
>         }
>
>         ceph_put_cap_refs(ci, got);

Applied, thanks

Yan, Zheng
