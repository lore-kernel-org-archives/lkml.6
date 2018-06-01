Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3531692-1527869782-2-5198226018346857681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527869782; b=IK55YEDKF53ncbTrRy0Tn7bWVhD7xW9h/wA5Xv1BkVzd8iKkmj
    jgK30KvURzprgZvY2dOVdxaYeeJvjhyLKkbkZwPiaLpGxdUsx6jzEwUZy4hHz2vw
    DxiLNcnj++JvsxRj2P5llNujQlWceaWGPWJ89S6IUN80mffakbKgVZiyaQXrZILW
    9QKLH4mUGjuMeL034Sxn3DocFsTn0ItNNAuqUuCVy/Phc+rgj4yLFedBkBz26jFh
    E/VzWa/3Uj/qergMAalCG9U2N4KZ+5s3xazKzV6DuhJzvdzCRm/XqI53wAHfoXy0
    ZXr1bNFubHqiaLo/uD0U/aF6dvP+iQEmWVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527869782;
    bh=3WEjHsC7DCagftY+ei3eI3teT+pQU0XdoGM9JPcUUAE=; b=F41SYRIMrEJB
    l94zUOt1Cl1v/sT9iKdKPf3dHDhp/gX9fWmGGWqV6nM20QBJa6DMmWJF0NUOWoCf
    GJVkJBK33l7qFuAZQnCf6bq3rS+f9dXr9LkjxiDNC+y+Skff5ztP21TkRG06dh6D
    p2iuoqXfqKeJb2vD2JqODltsdensR49jste5dhlKHabhwDCWzUXb8iZVnOhrdWWn
    D+ZIjyo9k2eb2HI1s7NfvcGfbBg9mPNuDVNFxdZKRiYJxvcbOcaESuqQta5D3bQu
    DbctbBquk1T90TDxgF9PiB2HS/hHw3hg6hNJs1qaUojGKrJgkln2Qmjr7DzJD53x
    rijmXkx39w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RsKh3dUl header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RsKh3dUl header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOEUn0rg3FnDgzFIcWkkrWiCbZ27U5VvxheNugDntsMbYaSXaBX/fHP5SqOXk/Km+z5cCBgYuGGbeOds+icl5SuHHcXECwSbW5iIVuKA7qOgtYGSFniD
    VuDLvI5xyvi6KVm/iad5UMIkDBca0VFTa4hX2MlKu9goZqt5mfvu5WLvlhorJrd701dzez85YNYK2r5xFVNe1XXS/NLeBZpfoFBPbG7a0NUZA7Jv/l2euycs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=c88sP_5omUNfAwEvHTAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFAQQR (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbeFAQQP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:16:15 -0400
Message-ID: <ab5ddb8176c76f48dd2fb05d40bf77d413d8137a.camel@kernel.org>
Subject: Re: [PATCH v2 0/5] vfs: allow syncfs to return an error when inode
 writeback fails
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: willy@infradead.org, andres@anarazel.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cmaiolino@redhat.com, David Howells <dhowells@redhat.com>
Date: Fri, 01 Jun 2018 12:16:13 -0400
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-31 at 07:29 -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> v2: don't modify sync_fs op prototype, handle errors at vfs layer
> 
> The syncfs system call returns an int error code, but in general it does
> not return errors when an inode fails writeback. It will return an error
> if __sync_blockdev fails, but that's not useful on non-block based
> filesystems and is generally not useful on more modern filesystems that
> don't rely on that call.
> 
> This patchset aims to remedy that by adding some infrastructure to allow
> syncfs to return an error when an inode fails writeback. The basic idea
> is to add a new errseq_t to the super_block to record writeback errors.
> 
> Because we don't want to grow struct file for this purpose, this new
> behavior is only activated when the fd passed to syncfs is opened with
> O_PATH.
> 
> One of the items on the wishlist from the PostgreSQL developers at this
> year's LSF/MM was a way to tell whether there has been any writeback
> failure on a filesystem without forcing everything to be synced out.
> 
> The final patch in this series adds a new generic vfs ioctl that
> presents the new sb->s_wb_err field to userland applications that wish
> to see it.
> 
> Comments and suggestions welcome.
> 
> Jeff Layton (5):
>   vfs: push __sync_blockdev calls down into sync_fs routines
>   vfs: add an errseq_t pointer arg to sync_filesystem and
>     __sync_filesystem
>   vfs: track per-sb writeback errors and report them to syncfs
>   buffer: record blockdev write errors in super_block that backs them
>   vfs: add a new ioctl for fetching the superblock's errseq_t
> 
>  drivers/staging/ncpfs/inode.c |  2 +-
>  fs/adfs/super.c               |  2 +-
>  fs/affs/super.c               |  4 +--
>  fs/befs/linuxvfs.c            |  2 +-
>  fs/block_dev.c                |  3 ++-
>  fs/btrfs/super.c              |  4 +--
>  fs/buffer.c                   |  2 ++
>  fs/cachefiles/interface.c     |  2 +-
>  fs/cifs/cifsfs.c              |  2 +-
>  fs/coda/inode.c               |  2 +-
>  fs/cramfs/inode.c             |  2 +-
>  fs/debugfs/inode.c            |  2 +-
>  fs/efs/super.c                |  2 +-
>  fs/ext2/super.c               |  4 +--
>  fs/ext4/super.c               | 13 +++++-----
>  fs/f2fs/super.c               | 15 ++++++-----
>  fs/fat/inode.c                |  2 +-
>  fs/freevxfs/vxfs_super.c      |  2 +-
>  fs/fuse/inode.c               |  2 +-
>  fs/gfs2/super.c               |  6 +++--
>  fs/hfs/super.c                |  4 +--
>  fs/hfsplus/super.c            |  2 +-
>  fs/hpfs/super.c               |  2 +-
>  fs/internal.h                 |  7 ------
>  fs/ioctl.c                    |  3 +++
>  fs/isofs/inode.c              |  2 +-
>  fs/jffs2/super.c              |  2 +-
>  fs/jfs/super.c                |  5 ++--
>  fs/minix/inode.c              |  2 +-
>  fs/nfs/super.c                |  2 +-
>  fs/nilfs2/super.c             |  7 +++---
>  fs/ntfs/super.c               |  2 +-
>  fs/ocfs2/super.c              |  4 +--
>  fs/open.c                     |  6 ++---
>  fs/openpromfs/inode.c         |  2 +-
>  fs/overlayfs/super.c          |  2 +-
>  fs/proc/root.c                |  2 +-
>  fs/pstore/inode.c             |  2 +-
>  fs/qnx4/inode.c               |  2 +-
>  fs/qnx6/inode.c               |  2 +-
>  fs/quota/dquot.c              | 11 +++-----
>  fs/reiserfs/super.c           |  4 +--
>  fs/romfs/super.c              |  2 +-
>  fs/squashfs/super.c           |  2 +-
>  fs/super.c                    |  4 +--
>  fs/sync.c                     | 47 +++++++++++++++++++++++++++--------
>  fs/sysv/inode.c               |  5 ++--
>  fs/tracefs/inode.c            |  2 +-
>  fs/ubifs/super.c              |  2 +-
>  fs/udf/super.c                |  2 +-
>  fs/ufs/super.c                |  2 +-
>  fs/xfs/xfs_super.c            |  2 +-
>  include/linux/errseq.h        |  1 +
>  include/linux/fs.h            | 13 +++++++++-
>  include/linux/pagemap.h       |  5 +++-
>  include/uapi/linux/fs.h       |  1 +
>  lib/errseq.c                  | 33 ++++++++++++++++++++++--
>  57 files changed, 173 insertions(+), 102 deletions(-)
> 

After chatting with David Howells about this, I think I'm going to
withdraw this set and do one that only exposes s_wb_err via the new
fsinfo syscall that's going in soon. We can always add the other
interfaces later if it's 

Let's just disregard this set for now and I'll look at respinning it
around that as an interface.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>
