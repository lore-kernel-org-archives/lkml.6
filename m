Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F380214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmRF1fIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F380214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJJSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:05:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36423 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:05:26 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so3501769iom.3;
        Wed, 10 Oct 2018 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfC4EWDvMvVG20MYWuy/ExxD/ybhTLTB6orOZndwgaI=;
        b=PmRF1fIyGnJN80QnxsnoNZYYunP22i0sQkD9RvE0tWn054gSY9VW2xM/Xea6d0LOFs
         Vckf1WfO3BQ4+0QwmtyWcVYAAnfv+QKAXUDlkiLMFruATs4EDmX6Mgfmb5Eh4Is80Vgq
         17D8zx9Isf/uS6x1de220m24LgypDWSIVK74lVrG0sGOuan+rJ/BNccKmwMooaO3t9kn
         T+zxOXqpPlRtMFrVxCg4fMApZrP7LiFA1HP9Mw044xyqAfuU7oICA/gN5YWehO2X5sJ0
         wq0a/6BMGltMX3lucqX2BNl7W/o/6vRsEbu4E6yLmMVpNj9KTQHOZqO9UDgQ1zEM/CR5
         bWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfC4EWDvMvVG20MYWuy/ExxD/ybhTLTB6orOZndwgaI=;
        b=jS7o4EaL6Xxd1s60P5F07JkJLDt8mVyb97NX/ZLiqZRv1u9P6HDeE/bv+nxfOw674E
         Px9eAuwBS+VDduZ659SdvwnyKJ2ktx4Mcs6xPtSahahKy1A9H4wtmnKTSGvaFN+YLkLc
         CbgUxvUu1Mgz/BE+GkhE/453NhbaNIB6GIjUyveZ3B/8Qc31aKKNzxaLQ+IGX4yxzMgv
         9CVF8pwUbWmQraGxXB4MxIwtkUFCJPurP+s5+9nDjBv8wsUEp0yptq/ktfC7l2cbl92c
         hXuw4XQSTwPPsfgq/SIt25u4p7YErTdXPVKsZPhTDQJSjvQuYYdncZlN4ZJyjHOGOrIm
         renw==
X-Gm-Message-State: ABuFfoisqrEchpm/F3XRyMCyPdhcTbRHuiW5x3VFLTqQU35UyHrOs8FB
        Lh7MDoVwZKRP54fpe7KS4JRJmMyayWpSF5QtqVo=
X-Google-Smtp-Source: ACcGV63MN2Q/xFBtXlxKDLkHy4WMfzhpW7sjXYONx/AXnp550khQUgSEakpQPUvsMyVOJM2kMLdMLERDxMV//Hu8bfU=
X-Received: by 2002:a6b:7906:: with SMTP id i6-v6mr22815842iop.241.1539168232051;
 Wed, 10 Oct 2018 03:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181009175428.18543-1-lhenriques@suse.com> <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
In-Reply-To: <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 10 Oct 2018 12:43:40 +0200
Message-ID: <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 6:21 AM Yan, Zheng <ukernel@gmail.com> wrote:
>
> On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:
> >
> > Current implementation of cephfs fallocate isn't correct as it doesn't
> > really reserve the space in the cluster, which means that a subsequent
> > call to a write may actually fail due to lack of space.  In fact, it is
> > currently possible to fallocate an amount space that is larger than the
> > free space in the cluster.
> >
> > Since there's no easy solution to fix this at the moment, this patch
> > simply removes support for all fallocate operations but
> > FALLOC_FL_PUNCH_HOLE (which implies FALLOC_FL_KEEP_SIZE).
> >
> > Link: https://tracker.ceph.com/issues/36317
> > Cc: stable@vger.kernel.org
> > Fixes: ad7a60de882a ("ceph: punch hole support")
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> >  fs/ceph/file.c | 45 +++++++++------------------------------------
> >  1 file changed, 9 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 92ab20433682..91a7ad259bcf 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1735,7 +1735,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >         struct ceph_file_info *fi = file->private_data;
> >         struct inode *inode = file_inode(file);
> >         struct ceph_inode_info *ci = ceph_inode(inode);
> > -       struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> >         struct ceph_cap_flush *prealloc_cf;
> >         int want, got = 0;
> >         int dirty;
> > @@ -1743,10 +1742,7 @@ static long ceph_fallocate(struct file *file, int mode,
> >         loff_t endoff = 0;
> >         loff_t size;
> >
> > -       if ((offset + length) > max(i_size_read(inode), fsc->max_file_size))
> > -               return -EFBIG;
> > -
> > -       if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> > +       if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> >                 return -EOPNOTSUPP;
> >
> >         if (!S_ISREG(inode->i_mode))
> > @@ -1763,18 +1759,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >                 goto unlock;
> >         }
> >
> > -       if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
> > -           ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
> > -               ret = -EDQUOT;
> > -               goto unlock;
> > -       }
> > -
> > -       if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) &&
> > -           !(mode & FALLOC_FL_PUNCH_HOLE)) {
> > -               ret = -ENOSPC;
> > -               goto unlock;
> > -       }
> > -
> >         if (ci->i_inline_version != CEPH_INLINE_NONE) {
> >                 ret = ceph_uninline_data(file, NULL);
> >                 if (ret < 0)
> > @@ -1782,12 +1766,12 @@ static long ceph_fallocate(struct file *file, int mode,
> >         }
> >
> >         size = i_size_read(inode);
> > -       if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> > -               endoff = offset + length;
> > -               ret = inode_newsize_ok(inode, endoff);
> > -               if (ret)
> > -                       goto unlock;
> > -       }
> > +
> > +       /* Are we punching a hole beyond EOF? */
> > +       if (offset >= size)
> > +               goto unlock;
> > +       if ((offset + length) > size)
> > +               length = size - offset;
> >
> >         if (fi->fmode & CEPH_FILE_MODE_LAZY)
> >                 want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> > @@ -1798,16 +1782,8 @@ static long ceph_fallocate(struct file *file, int mode,
> >         if (ret < 0)
> >                 goto unlock;
> >
> > -       if (mode & FALLOC_FL_PUNCH_HOLE) {
> > -               if (offset < size)
> > -                       ceph_zero_pagecache_range(inode, offset, length);
> > -               ret = ceph_zero_objects(inode, offset, length);
> > -       } else if (endoff > size) {
> > -               truncate_pagecache_range(inode, size, -1);
> > -               if (ceph_inode_set_size(inode, endoff))
> > -                       ceph_check_caps(ceph_inode(inode),
> > -                               CHECK_CAPS_AUTHONLY, NULL);
> > -       }
> > +       ceph_zero_pagecache_range(inode, offset, length);
> > +       ret = ceph_zero_objects(inode, offset, length);
> >
> >         if (!ret) {
> >                 spin_lock(&ci->i_ceph_lock);
> > @@ -1817,9 +1793,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >                 spin_unlock(&ci->i_ceph_lock);
> >                 if (dirty)
> >                         __mark_inode_dirty(inode, dirty);
> > -               if ((endoff > size) &&
> > -                   ceph_quota_is_max_bytes_approaching(inode, endoff))
> > -                       ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
> >         }
> >
> >         ceph_put_cap_refs(ci, got);
>
> Applied, thanks

I don't think it should go to stable kernels.  Strictly speaking it's
a behaviour change -- it's been this way for many years and, unless you
are close to ENOSPC, it's sort of appears to work.  I'll take off the
stable tag unless I hear objections.

Thanks,

                Ilya
