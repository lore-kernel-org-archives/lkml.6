Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02D56C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C0F20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5pJJc3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C0F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966409AbeFNOPw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:15:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37777 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965614AbeFNOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:15:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so9707481lfb.4;
        Thu, 14 Jun 2018 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=yaXCI8CBAdPhNBQmjaBEvjECz45gdJJpBje1Rhesu7k=;
        b=B5pJJc3nKa8jPn8hti0QqjNNMSCxkhk7tzUpS4sydbfUgrP3Fn1Bq/ZaFdn3lopu2l
         ntlK39cxvIVvOLb3Z//Xzl/19HWamMdT8F503bXg1XpTIjnBoJFXXziERboyjWoiSH1Y
         aTTe3j0JpafCOAoDo2LJ4zTo9hNuIZNYW8glIJb2Hzdv8dLXRaFdcdythaJQLV5lNPdG
         3rn9O+sUMBlK+FmjR/b2kaxGcsiOj9Sl7oEnVpOQOi5ACcEPqthN/e8WpXLGuERU3KgI
         raP4K8yT3zB5jnU23VmhvD5H+Jk+0CzsZdH2CWyGhcuZf0iK5wnfQ3UZ6xwqyPYqgxlc
         HSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=yaXCI8CBAdPhNBQmjaBEvjECz45gdJJpBje1Rhesu7k=;
        b=NbIYZsUlWCwRpfw4WkYC095J2OfTMWOh55D+C787zlHpWU15UbHyksDJ5pm5DKXhXz
         xBM+7sHeh26ctMMTTMyBNHcZlAMoMzRsheNAIwkyx7zC6csO5Em/oCAYZ8e2WeyQ47fh
         IHD2MRRurji7BcRKvTnMTpufS7VheatRPKuq38JdEPWi9BGYdV5P3T22ShYJo1zPleVx
         1jP+ubqOFX9rhPNIufb92v3Dft68qLDTWtz7tz6vRnQfGpSYyKsFKnCliHcR1WsESh5k
         2l4WjKXpUnTP6flbueUdjMVOtW59+WZ49v5QxsEstENz1twbf22058IgMATgceRyO+2O
         R2Cw==
X-Gm-Message-State: APt69E2ry599PWYHs6sgE2BX/Ws3O9Oh5DjshrJTCC3PVznG0UKFY7sf
        KumAbkyarz5Bu+fGn/LShIICP2Ecwxablhu/6TU=
X-Google-Smtp-Source: ADUXVKK32qdYls38tTsXY4/2qXNxdoDMtlsKTiDtB8aQYWYqkT/753jSqRhbnZQYnBwXl0OVvBW+p7bGJfghJxk83l8=
X-Received: by 2002:a19:1460:: with SMTP id k93-v6mr6486286lfi.23.1528985742032;
 Thu, 14 Jun 2018 07:15:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:15:41
 -0700 (PDT)
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 16:15:41 +0200
X-Google-Sender-Auth: 3OBu9l1UJ-NJIBsa2dxZdHyRqYY
Message-ID: <CAK8P3a0+F8QwQ8MfL=T0USpV_SL07JaK-dsr5rr5ZkhAYFayLw@mail.gmail.com>
Subject: [GIT PULL] vfs/y2038: inode timestamps conversion to timespec64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 93b7f7ad2018d2037559b1d0892417864c78b371:

  skip LAYOUTRETURN if layout is invalid (2018-06-12 08:48:04 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/vfs-timespec64

for you to fetch changes up to e264abeaf9daa3cde9aed8013a6f82b0370425e5:

  pstore: Remove bogus format string definition (2018-06-14 14:57:24 +0200)

----------------------------------------------------------------
vfs/y2038: inode timestamps conversion to timespec64

This is a late set of changes from Deepa Dinamani doing an automated
treewide conversion of the inode and iattr structures from 'timespec'
to 'timespec64', to push the conversion from the VFS layer into the
individual file systems.

There were no conflicts between this and the contents of linux-next
until just before the merge window, when we saw multiple problems:

- A minor conflict with my own y2038 fixes, which I could address
  by adding another patch on top here.
- One semantic conflict with late changes to the NFS tree. I addressed
  this by merging Deepa's original branch on top of the changes that
  now got merged into mainline and making sure the merge commit includes
  the necessary changes as produced by coccinelle.
- A trivial conflict against the removal of staging/lustre.
- Multiple conflicts against the VFS changes in the overlayfs tree.
  These are still part of linux-next, but apparently this is no longer
  intended for 4.18 [1], so I am ignoring that part.

As Deepa writes:

  The series aims to switch vfs timestamps to use struct timespec64.
  Currently vfs uses struct timespec, which is not y2038 safe.

  The series involves the following:
  1. Add vfs helper functions for supporting struct timepec64 timestamps.
  2. Cast prints of vfs timestamps to avoid warnings after the switch.
  3. Simplify code using vfs timestamps so that the actual
     replacement becomes easy.
  4. Convert vfs timestamps to use struct timespec64 using a script.
     This is a flag day patch.

  Next steps:
  1. Convert APIs that can handle timespec64, instead of converting
     timestamps at the boundaries.
  2. Update internal data structures to avoid timestamp conversions.

Thomas Gleixner adds:

  I think there is no point to drag that out for the next merge window.
  The whole thing needs to be done in one go for the core changes which
  means that you're going to play that catchup game forever. Let's get
  over with it towards the end of the merge window.

[1] https://www.spinics.net/lists/linux-fsdevel/msg128294.html

----------------------------------------------------------------

Note: since the conflicting overlayfs changes are still part of linux-next,
the linux-next build will fail after this gets merged, unless the overlayfs
tree gets dropped or updated to reflect the changes.

Arnd Bergmann (2):
      Merge branch 'vfs_timespec64' of
https://github.com/deepa-hub/vfs into vfs-timespec64
      pstore: Remove bogus format string definition

Deepa Dinamani (6):
      fs: add timespec64_truncate()
      lustre: Use long long type to print inode time
      ceph: make inode time prints to be long long
      fs: nfs: get rid of memcpys for inode times
      udf: Simplify calls to udf_disk_stamp_to_time
      vfs: change inode times to use struct timespec64

Kees Cook (1):
      pstore: Convert internal records to timespec64

 drivers/firmware/efi/efi-pstore.c               | 27 ++++----
 drivers/staging/lustre/lustre/llite/llite_lib.c | 12 ++--
 drivers/staging/lustre/lustre/llite/namei.c     |  5 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c     |  7 +-
 drivers/staging/lustre/lustre/mdc/mdc_reint.c   |  6 +-
 drivers/staging/lustre/lustre/obdclass/obdo.c   |  6 +-
 drivers/tty/tty_io.c                            | 15 ++++-
 drivers/usb/gadget/function/f_fs.c              |  2 +-
 fs/adfs/inode.c                                 |  7 +-
 fs/afs/fsclient.c                               |  2 +-
 fs/attr.c                                       | 14 ++--
 fs/bad_inode.c                                  |  2 +-
 fs/btrfs/file.c                                 |  6 +-
 fs/btrfs/inode.c                                |  8 +--
 fs/btrfs/ioctl.c                                |  4 +-
 fs/btrfs/root-tree.c                            |  4 +-
 fs/btrfs/transaction.c                          |  2 +-
 fs/ceph/addr.c                                  | 12 ++--
 fs/ceph/cache.c                                 |  4 +-
 fs/ceph/caps.c                                  |  6 +-
 fs/ceph/file.c                                  |  6 +-
 fs/ceph/inode.c                                 | 86 +++++++++++++------------
 fs/ceph/mds_client.c                            |  7 +-
 fs/ceph/snap.c                                  |  6 +-
 fs/cifs/cache.c                                 |  4 +-
 fs/cifs/fscache.c                               |  8 +--
 fs/cifs/inode.c                                 | 26 ++++----
 fs/coda/coda_linux.c                            | 12 ++--
 fs/configfs/inode.c                             | 12 ++--
 fs/cramfs/inode.c                               |  2 +-
 fs/ext4/ext4.h                                  | 34 ++++++----
 fs/ext4/ialloc.c                                |  4 +-
 fs/ext4/namei.c                                 |  2 +-
 fs/f2fs/f2fs.h                                  | 10 ++-
 fs/f2fs/file.c                                  | 12 ++--
 fs/f2fs/inode.c                                 | 12 ++--
 fs/f2fs/namei.c                                 |  4 +-
 fs/fat/inode.c                                  | 20 ++++--
 fs/fat/namei_msdos.c                            | 21 +++---
 fs/fat/namei_vfat.c                             | 22 ++++---
 fs/fuse/inode.c                                 |  2 +-
 fs/gfs2/dir.c                                   |  6 +-
 fs/gfs2/glops.c                                 |  4 +-
 fs/hfs/inode.c                                  |  4 +-
 fs/hfsplus/inode.c                              | 12 ++--
 fs/hostfs/hostfs_kern.c                         | 12 ++--
 fs/inode.c                                      | 58 ++++++++++++-----
 fs/jffs2/dir.c                                  | 18 +++---
 fs/jffs2/file.c                                 |  2 +-
 fs/jffs2/fs.c                                   | 12 ++--
 fs/kernfs/dir.c                                 |  4 +-
 fs/kernfs/inode.c                               |  8 +--
 fs/locks.c                                      |  2 +-
 fs/nfs/callback_proc.c                          |  4 +-
 fs/nfs/fscache-index.c                          |  4 +-
 fs/nfs/fscache.c                                | 12 ++--
 fs/nfs/inode.c                                  | 49 ++++++++------
 fs/nfs/nfs2xdr.c                                | 25 ++++---
 fs/nfs/nfs3xdr.c                                |  8 ++-
 fs/nfs/nfs4xdr.c                                |  7 +-
 fs/nfsd/blocklayout.c                           |  8 ++-
 fs/nfsd/nfs3xdr.c                               | 14 ++--
 fs/nfsd/nfs4xdr.c                               |  7 +-
 fs/nfsd/nfsxdr.c                                |  2 +-
 fs/ntfs/inode.c                                 | 30 ++++-----
 fs/ocfs2/dlmglue.c                              | 20 ++++--
 fs/ocfs2/file.c                                 |  6 +-
 fs/orangefs/inode.c                             |  2 +-
 fs/orangefs/orangefs-kernel.h                   |  2 +-
 fs/overlayfs/inode.c                            |  2 +-
 fs/overlayfs/overlayfs.h                        |  2 +-
 fs/proc/uptime.c                                |  2 +-
 fs/pstore/platform.c                            |  2 +-
 fs/pstore/ram.c                                 | 18 +++---
 fs/reiserfs/namei.c                             |  2 +-
 fs/reiserfs/xattr.c                             |  4 +-
 fs/ubifs/dir.c                                  |  4 +-
 fs/ubifs/file.c                                 | 23 +++----
 fs/ubifs/ubifs.h                                |  2 +-
 fs/udf/ialloc.c                                 |  4 +-
 fs/udf/inode.c                                  | 59 +++++++++--------
 fs/udf/super.c                                  | 17 +++--
 fs/udf/udfdecl.h                                |  4 +-
 fs/udf/udftime.c                                |  9 +--
 fs/xfs/xfs_inode.c                              |  2 +-
 fs/xfs/xfs_iops.c                               |  2 +-
 fs/xfs/xfs_trans_inode.c                        |  2 +-
 include/linux/fs.h                              | 24 +++----
 include/linux/pstore.h                          |  2 +-
 include/linux/stat.h                            |  8 +--
 90 files changed, 559 insertions(+), 440 deletions(-)
