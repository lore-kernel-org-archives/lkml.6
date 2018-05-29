Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2122766-1527600138-2-5500277437390103577
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527600138; b=OtXRGxWka7q5kVoXHeZU5NJeF32fzbz7shE/3zi+k/yn9lwLo/
    57EFHYyD/ToDDNStpa0O6Hz42lUmXC99C2TE5a1gKz0onJJUBQm7dwWOwKaTdUEF
    lMENLq0k0IyGQ+IAbOrJs/6SkDDwsF8PX+/Pyg6OSnWDdgC5ThgMSGx7ELYGwHAr
    Q6+SCKaYn9sjLYdP/HVWtMQO0kUIkjGmBnTKAaHKsHJURaRP3rO2VAeQLASbqNKc
    Wzymf872+G2VkAm9v8yNZkUmq2Z3PBTjv7kia8x41xPmHSjoOma4HdYom4JvIRLA
    D3S2QBP1AwHSQNJ67bCOdInWQcrN1cISOcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527600138;
    bh=6Jqf+My1HRMHxKHidckshlozTi3lS1F53cCvwgkne00=; b=S1oiTyNrgDpw
    sC+Q6oqTpSk2SD/Ttiij6t5c7E9wSEOp3bWaxS9+9U8szahyYSivXGPYecvIf5IE
    19Y4Qp9zz9q3kcFuvkx+GLNSZ69b7dXDXbiJdVJtqnWG39dqvnMWMeGJlkq9UIcI
    pQ9E1Uuqh5Uj6IJL8RrKkT+WiItWLfXMlAH4oZflDZQBGTjCaF+2Yl2cpmmJI88M
    6hCQQ6GPAWFNYuD8gRP6Yp1vAqAIKnshjY5Jrve2BL9uOtIQcu31ov77W7GvtaZn
    YKCt3Tc2cBrnhzl6Hb3/vMWs6K/9AYmouAAAq/wrLiqw3PGjpJqrfH3p3YYG+1Yj
    +PEmt/0fhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=JVPtUA+x
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=e/irRD8L;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=JVPtUA+x
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=e/irRD8L;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD0a7VZHxTW+sX4xNgyAYNPDYCvI+1eKaqCTIX8YvFfXF2NKakK9qoS2Xip1j25VB4R2XVTBjrBgbxqlOz2H2efqAdu6d0CSqSAX4k6IF7qNOhKG6o3L
    NMGWSTbG3OWrYHEsOBL1cMi4USLR2Rgrx6nVmXmNed3vA2Y16qEN+s8ni3RsYyfVY+dYJ9+vRoik7iAQqfBo1hSvneELOF5mTetiNadrSLd034/4GP/ue9sO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ThVFv52XctbayZBtqoMA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934185AbeE2NVy (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 09:21:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36504 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934174AbeE2NVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 09:21:53 -0400
X-Google-Smtp-Source: ADUXVKKvMytO3L1Vjv/Gxs4qwW6ycGzpbCtUs3Bn4v+/laFiB12bfzBuDKNwulLM9OLCi4dVrsWQ6g==
Date: Tue, 29 May 2018 15:21:48 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Al,

I'm sending this pull request to you instead of Linus, because a bigger than
usual chunk involves the VFS.

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro

This update contains the following:

 - Deal with vfs_mkdir() not instantiating dentry.

 - Stack file operations.  This solves the ro/rw file descriptor inconsistency,
   weirdness with ioctl, as well as removing a bunch of overlay specific hacks
   from the VFS.

 - Allow metadata-only copy-up when data is unchanged.

 - Various cleanups in VFS and overlayfs.

Thanks,
Miklos

---
Amir Goldstein (8):
      ovl: update documentation for unionmount-testsuite
      ovl: remove WARN_ON() real inode attributes mismatch
      ovl: strip debug argument from ovl_do_ helpers
      ovl: struct cattr cleanups
      ovl: return dentry from ovl_create_real()
      ovl: create helper ovl_create_temp()
      ovl: make ovl_create_real() cope with vfs_mkdir() safely
      ovl: use inode_insert5() to hash a newly created inode

Miklos Szeredi (41):
      ovl: clean up copy-up error paths
      vfs: factor out inode_insert5()
      vfs: dedpue: return loff_t
      vfs: dedupe: rationalize args
      vfs: dedupe: extract helper for a single dedup
      vfs: add path_open()
      vfs: optionally don't account file in nr_files
      vfs: add f_op->pre_mmap()
      vfs: export vfs_ioctl() to modules
      vfs: export vfs_dedupe_file_range_one() to modules
      ovl: copy up times
      ovl: copy up inode flags
      Revert "Revert "ovl: get_write_access() in truncate""
      ovl: copy up file size as well
      ovl: deal with overlay files in ovl_d_real()
      ovl: stack file ops
      ovl: add helper to return real file
      ovl: add ovl_read_iter()
      ovl: add ovl_write_iter()
      ovl: add ovl_fsync()
      ovl: add ovl_mmap()
      ovl: add ovl_fallocate()
      ovl: add lsattr/chattr support
      ovl: add ovl_fiemap()
      ovl: add O_DIRECT support
      ovl: add reflink/copyfile/dedup support
      vfs: don't open real
      ovl: copy-up on MAP_SHARED
      ovl: obsolete "check_copy_up" module option
      ovl: fix documentation of non-standard behavior
      vfs: simplify dentry_open()
      Revert "ovl: fix may_write_real() for overlayfs directories"
      Revert "ovl: don't allow writing ioctl on lower layer"
      vfs: fix freeze protection in mnt_want_write_file() for overlayfs
      Revert "ovl: fix relatime for directories"
      Revert "vfs: update ovl inode before relatime check"
      Revert "vfs: add flags to d_real()"
      Revert "vfs: do get_write_access() on upper layer of overlayfs"
      Partially revert "locks: fix file locking on overlayfs"
      Revert "fsnotify: support overlayfs"
      vfs: remove open_flags from d_real()

Vivek Goyal (29):
      ovl: Pass argument to ovl_get_inode() in a structure
      ovl: Initialize ovl_inode->redirect in ovl_get_inode()
      ovl: Move the copy up helpers to copy_up.c
      ovl: Provide a mount option metacopy=on/off for metadata copyup
      ovl: During copy up, first copy up metadata and then data
      ovl: Copy up only metadata during copy up where it makes sense
      ovl: Add helper ovl_already_copied_up()
      ovl: A new xattr OVL_XATTR_METACOPY for file on upper
      ovl: Use out_err instead of out_nomem
      ovl: Modify ovl_lookup() and friends to lookup metacopy dentry
      ovl: Copy up meta inode data from lowest data inode
      ovl: Add helper ovl_dentry_lowerdata() to get lower data dentry
      ovl: Fix ovl_getattr() to get number of blocks from lower
      ovl: Store lower data inode in ovl_inode
      ovl: Add helper ovl_inode_realdata()
      ovl: Open file with data except for the case of fsync
      ovl: Do not expose metacopy only dentry from d_real()
      ovl: Move some dir related ovl_lookup_single() code in else block
      ovl: Check redirects for metacopy files
      ovl: Treat metacopy dentries as type OVL_PATH_MERGE
      ovl: Add an inode flag OVL_CONST_INO
      ovl: Do not set dentry type ORIGIN for broken hardlinks
      ovl: Set redirect on metacopy files upon rename
      ovl: Set redirect on upper inode when it is linked
      ovl: Check redirect on index as well
      ovl: Disbale metacopy for MAP_SHARED mmap()
      ovl: Do not do metadata only copy-up for truncate operation
      ovl: Do not do metacopy only for ioctl modifying file attr
      ovl: Enable metadata only feature

---
 Documentation/filesystems/Locking       |   4 +-
 Documentation/filesystems/overlayfs.txt |  97 ++++--
 Documentation/filesystems/vfs.txt       |  19 +-
 fs/btrfs/ctree.h                        |   5 +-
 fs/btrfs/ioctl.c                        |   7 +-
 fs/file_table.c                         |  13 +-
 fs/inode.c                              | 210 +++++--------
 fs/internal.h                           |  17 +-
 fs/ioctl.c                              |   1 +
 fs/locks.c                              |  20 +-
 fs/namei.c                              |   2 +-
 fs/namespace.c                          |  69 +----
 fs/ocfs2/file.c                         |  10 +-
 fs/open.c                               |  74 ++---
 fs/overlayfs/Kconfig                    |  40 +++
 fs/overlayfs/Makefile                   |   4 +-
 fs/overlayfs/copy_up.c                  | 273 +++++++++-------
 fs/overlayfs/dir.c                      | 312 +++++++++++++------
 fs/overlayfs/export.c                   |  11 +-
 fs/overlayfs/file.c                     | 530 ++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c                    | 203 ++++++++----
 fs/overlayfs/namei.c                    | 205 +++++++-----
 fs/overlayfs/overlayfs.h                | 119 ++++---
 fs/overlayfs/ovl_entry.h                |   7 +-
 fs/overlayfs/super.c                    | 134 +++++---
 fs/overlayfs/util.c                     | 252 ++++++++++++++-
 fs/read_write.c                         |  91 +++---
 fs/xattr.c                              |   9 +-
 fs/xfs/xfs_file.c                       |   8 +-
 include/linux/dcache.h                  |  15 +-
 include/linux/fs.h                      |  36 ++-
 include/linux/fsnotify.h                |  14 +-
 include/uapi/linux/fs.h                 |   1 -
 mm/util.c                               |   5 +
 34 files changed, 1981 insertions(+), 836 deletions(-)
 create mode 100644 fs/overlayfs/file.c
