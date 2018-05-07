Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682298-2-5739311599928978331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682298; b=Q1bZrIL/ZOffVAQnyAH9s9GXiDlAXZloRlQNa4W4Jo2yYUC4p8
    h+AJtBq3JSLXbJrVdkcgCbbuaVJIIOadt16nRRwS4TVY6WIggcdQ/BMcjQXbyUIi
    uYhco0/PVzw6QDslBzR5Ks9BH0BxXkpPAkznD2NM0szNilj/rJlZQUzL7ysLHu4l
    /QOQwFNEtCos17KcONQBarbow/3FgfIjLuv9CAjVWvTEh1A6gSSqOP2EpnqZSdRP
    wD9MkKtZtfN8tWX4IDEQFm0Pb7R9dtQew/KnD+R3ElPl9f2R7CBYwc5WKGandWrN
    oy5dyZdtEOKL8zGt9dnuBXkteVcP0tGuQ16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525682298; bh=SxyZrACj+hd8TV1c8TxSAfuenu9KOm
    9wmUI0QczyAao=; b=V3rGNhChDnNIQVV2FPxU3MzP0WxMZofVlzGKk+uC4I/Jz0
    OrogSfIW9K0+ANiIb+12nxSh58cMadnQd4rLisuUrv0G0FTrSb6yHNlbdM+wamDi
    0CH8fOSZJ8YA9fTZbOgXRCS0iI/l0TaR/EKDupFmDBFgXT0V2jPG2uVRWONbT6a0
    sKB4UrVhCed/sjrbd8/jypucvKVaNtJjh0pXDs5AkxY8dVwy13WY2s6JD0m7WDD+
    YsIuQ3bGpNOB7HQQj/teIKd+mHalJrmcRmVsqnM6+SGpnpVG+BIG6dqDFprN3ulC
    u5ryIaTRjDw036XezV8CzkpgqFDNYlajhDEvL1GA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fNrWE/2/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fNrWE/2/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ8fxlGxA+iTKOJBjETuiLjTjoKVzo6raTx3XLyXsIzHXyPc3evnXU4qCy66OIYqYLmw+YHtVOqMZKD1KCv89pU9Ks3IplpSKDIukUUEGXcQgytD7G+Y
    +PqjvhppIf8xN24tldnrA7cHtz2TlBTGEzpH7F9x0qERvrvsN5yUFSm9RhfZxMr7+DNfjAmJAlswIvIbdIPsATrEM8jSc4AcZYsKF3jN6TxBwGyQ8gR1ehmm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=cD0sha9eELB2ZReeA2UA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeEGIiP (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:38:15 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:39334 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeEGIiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:13 -0400
X-Google-Smtp-Source: AB8JxZrskdRwSkKWpw25I5+b0xf6DuOtiVPTRWQ4HAH45qIDA65NVBX2RNUHKCMvbZM954RW4KJqaA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 00/35] overlayfs: stack file operations
Date: Mon,  7 May 2018 10:37:32 +0200
Message-Id: <20180507083807.28792-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[Al, can you please review the vfs affecting patches? ]

Up till now overlayfs didn't stack regular file operations.  Instead, when
a file was opened on an overlay, the file from one of the underlying layers
would be opened and any file operations performed would directly go to the
underlying file on a real filesystem.

This works well mostly, but various hacks were added to the VFS to work
around issues with this:

 - d_path() and friends
 - relatime handling
 - file locking
 - fsnotify
 - writecount handling

There are also issues that are unresolved before this patchset:

 - ioctl's that need write access but can be performed on a O_RDONLY fd
 - ro/rw inconsistency: file on lower layer opened for read-only will
   return stale data on read after copy-up and modification
 - ro/rw inconsistency for mmap: file on lower layer mapped shared will
   contain stale data after copy-up and modification

This patch series reverts the VFS hacks (with the exception of d_path) and
fixes the unresoved issues.  We need to keep d_path related hacks, because
memory maps are still not stacked, yet d_path() should keep working on
vma->vm_file->f_path.

No regressions were observed after running various test suites (xfstests,
ltp, unionmount-testsuite, pjd-fstest).

Performance impact of stacking was found to be minimal.  Memory use for
open overlay files increases by about 256bytes or 12% of total (files +
pinned dentries + pinned inodes).

Git tree is here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-rorw

Thanks,
Miklos

Changes from v1:

 - split out dedupe API cleanup
 - update documentation and comments
 - clean up directory modification helpers inside overlayfs
 - make functions static
 - added compat ioctl
 - check for upper files in dedupe
 - bring back d_real_inode() as a new user just cropped up in 4.17

---
Miklos Szeredi (35):
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
  ovl: fix documentation of non-standard behavior

 Documentation/filesystems/Locking       |   4 +-
 Documentation/filesystems/overlayfs.txt |  60 ++--
 Documentation/filesystems/vfs.txt       |  19 +-
 fs/file_table.c                         |  13 +-
 fs/inode.c                              |  46 +--
 fs/internal.h                           |  17 +-
 fs/ioctl.c                              |   1 +
 fs/locks.c                              |  20 +-
 fs/namei.c                              |   2 +-
 fs/namespace.c                          |  69 +----
 fs/open.c                               |  74 ++---
 fs/overlayfs/Kconfig                    |  21 ++
 fs/overlayfs/Makefile                   |   4 +-
 fs/overlayfs/dir.c                      |  33 ++-
 fs/overlayfs/file.c                     | 506 ++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c                    |  63 +++-
 fs/overlayfs/overlayfs.h                |  21 +-
 fs/overlayfs/ovl_entry.h                |   1 +
 fs/overlayfs/super.c                    |  65 ++--
 fs/overlayfs/util.c                     |  11 +-
 fs/read_write.c                         |   6 +-
 fs/xattr.c                              |   9 +-
 include/linux/dcache.h                  |  15 +-
 include/linux/fs.h                      |  28 +-
 include/linux/fsnotify.h                |  14 +-
 include/uapi/linux/fs.h                 |   1 -
 mm/util.c                               |   5 +
 27 files changed, 824 insertions(+), 304 deletions(-)
 create mode 100644 fs/overlayfs/file.c

-- 
2.14.3
