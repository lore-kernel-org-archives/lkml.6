Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mjl4FNlvGlsvFAAAmS7hNA
	; Fri, 08 Jun 2018 12:13:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80962607E4; Fri,  8 Jun 2018 12:13:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fIdZleev"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB896607A4;
	Fri,  8 Jun 2018 12:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB896607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeFHMNi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:13:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34118 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:13:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so13180334wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DsekjAEjvjzQkOeaC8Xmlnuw1FTH3zSnOs85VVuHX+0=;
        b=fIdZleevnunbOKcITwHwTOcfijoth+AnaJBWiWAg37NwmUfcvWJbPbOe2vxx2YQ9ll
         +rOkIMN9Tm1wvbMQc6XS9RC36GsXyTewBFrWMCIkDPC3VOCfQuikLa+S10OIkQAehPWB
         DdOxbRGmqSf4qkmqmVjFF2ZNkMsYdKnfpL+a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DsekjAEjvjzQkOeaC8Xmlnuw1FTH3zSnOs85VVuHX+0=;
        b=h7VIr/OHkkerTWPvhmfLKrbsUab7wK8gssvT2YT6bbMyHJo7TrDi5Q7e2fIwMtKF6y
         2zucdEKakkduNrV6d8DmWQ/DGtNv4cyLt0hu6Tju7Ji7sfIgPkbEWg1AQ9NPmacQn3Nm
         IugE2S6WrLLDBEEZTOWYYF35oJsGxJWTKgW5/xTRht8hl5PbgGUmQBs85jxMJgcpvt6s
         mKz61XhjR8bwr0kC6gbqZIbaGfOUJI9dhOhHfUkeViVZnYrPb0GpyDeSmncKyZ6zeGFq
         +OZz8UY9ZRAHvYJhwBlUv36yrUdgJFKiSbURTafh4vfmZ77cBR43jtd/2BDVnimSBKc6
         qbFQ==
X-Gm-Message-State: APt69E3linRXZmgEHJVswzgz8fkWeixx30Mm7PnVsccTd7CbOdkOFKDG
        oSW+O0h/aXAw5sdTFK2Idffrxl6A
X-Google-Smtp-Source: ADUXVKJhU9hRFeMNa3cbFbwbEs0aq2Sr4kyVoLRDfhMqqxjHbUO7siEJRbgWddyTq4f1JgL5szJE/A==
X-Received: by 2002:a5d:4307:: with SMTP id h7-v6mr5057470wrq.58.1528460013994;
        Fri, 08 Jun 2018 05:13:33 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-176-63-54-97.catv.broadband.hu. [176.63.54.97])
        by smtp.gmail.com with ESMTPSA id o12-v6sm88624050wrf.30.2018.06.08.05.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 05:13:32 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:13:30 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@infradead.org
Subject: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.18

This contains two new features:

 1) Stack file operations: this allows removal of several hacks from the
    VFS, proper interaction of read-only open files with copy-up,
    possibility to implement fs modifying ioctls properly, and others.

 2) Metadata only copy-up: when file is on lower layer and only metadata is
    modified (except size) then only copy up the metadata and continue to
    use the data from the lower file.

The series starts with a cleanup of the internal dedupe API.  There's some
late discussion on details (should vfs limit the size of a dedepe request,
and if yes, how much).  I've ignored it for this pull request, it can
easily be fixed later.

Other pain point: overlay doesn't want to double account open files (due to
stacking) for fear of breaking existing setups.  So added infrastruture
that allows to skip accounting an open file in nr_files.  I don't much like
this, but can't see any other way of keeping backward compatibility.

There are two conflicts when merging, attaching my resolution.

Thanks,
Miklos

---
Miklos Szeredi (37):
      vfs: dedupe: return loff_t
      vfs: dedupe: rationalize args
      vfs: dedupe: extract helper for a single dedup
      vfs: add path_open()
      vfs: optionally don't account file in nr_files
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

Vivek Goyal (28):
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
      ovl: add helper to force data copy-up
      ovl: Do not do metadata only copy-up for truncate operation
      ovl: Do not do metacopy only for ioctl modifying file attr
      ovl: Enable metadata only feature

---
 Documentation/filesystems/Locking       |   3 +-
 Documentation/filesystems/overlayfs.txt |  90 ++++--
 Documentation/filesystems/vfs.txt       |  16 +-
 fs/btrfs/ctree.h                        |   5 +-
 fs/btrfs/ioctl.c                        |   7 +-
 fs/file_table.c                         |  13 +-
 fs/inode.c                              |  46 +--
 fs/internal.h                           |  17 +-
 fs/ioctl.c                              |   1 +
 fs/locks.c                              |  20 +-
 fs/namei.c                              |   2 +-
 fs/namespace.c                          |  69 +----
 fs/ocfs2/file.c                         |  10 +-
 fs/open.c                               |  87 +++---
 fs/overlayfs/Kconfig                    |  19 ++
 fs/overlayfs/Makefile                   |   4 +-
 fs/overlayfs/copy_up.c                  | 190 ++++++++----
 fs/overlayfs/dir.c                      | 105 +++++--
 fs/overlayfs/export.c                   |   3 +
 fs/overlayfs/file.c                     | 508 ++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c                    | 175 +++++++----
 fs/overlayfs/namei.c                    | 195 +++++++-----
 fs/overlayfs/overlayfs.h                |  47 ++-
 fs/overlayfs/ovl_entry.h                |   6 +-
 fs/overlayfs/super.c                    | 103 ++++---
 fs/overlayfs/util.c                     | 252 +++++++++++++++-
 fs/read_write.c                         |  91 +++---
 fs/xattr.c                              |   9 +-
 fs/xfs/xfs_file.c                       |   8 +-
 include/linux/dcache.h                  |  15 +-
 include/linux/fs.h                      |  31 +-
 include/linux/fsnotify.h                |  14 +-
 include/uapi/linux/fs.h                 |   1 -
 33 files changed, 1590 insertions(+), 572 deletions(-)
 create mode 100644 fs/overlayfs/file.c

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ov-merge

diff --cc fs/btrfs/ioctl.c
index d29992f7dc63,70eac76804df..000000000000
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@@ -3596,14 -3192,20 +3596,15 @@@ out_free
  	return ret;
  }
  
- ssize_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 olen,
- 				struct file *dst_file, u64 dst_loff)
 -#define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 -
+ loff_t btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
+ 			       struct file *dst_file, loff_t dst_loff,
+ 			       loff_t olen)
  {
  	struct inode *src = file_inode(src_file);
  	struct inode *dst = file_inode(dst_file);
  	u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
- 	ssize_t res;
+ 	int res;
  
 -	if (olen > BTRFS_MAX_DEDUPE_LEN)
 -		olen = BTRFS_MAX_DEDUPE_LEN;
 -
  	if (WARN_ON_ONCE(bs < PAGE_SIZE)) {
  		/*
  		 * Btrfs does not support blocksize < page_size. As a
diff --cc fs/read_write.c
index e83bd9744b5d,1ff18ea56584..000000000000
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@@ -2021,46 -2055,21 +2055,21 @@@ int vfs_dedupe_file_range(struct file *
  
  		if (info->reserved) {
  			info->status = -EINVAL;
- 		} else if (!(is_admin || (dst_file->f_mode & FMODE_WRITE))) {
- 			info->status = -EINVAL;
- 		} else if (file->f_path.mnt != dst_file->f_path.mnt) {
- 			info->status = -EXDEV;
- 		} else if (S_ISDIR(dst->i_mode)) {
- 			info->status = -EISDIR;
- 		} else if (dst_file->f_op->dedupe_file_range == NULL) {
- 			info->status = -EINVAL;
- 		} else {
- 			deduped = dst_file->f_op->dedupe_file_range(file, off,
- 							len, dst_file,
- 							info->dest_offset);
- 			if (deduped == -EBADE)
- 				info->status = FILE_DEDUPE_RANGE_DIFFERS;
- 			else if (deduped < 0)
- 				info->status = deduped;
- 			else
- 				info->bytes_deduped += deduped;
 -			goto next_loop;
++			goto next_fdput;
  		}
  
- next_file:
- 		mnt_drop_write_file(dst_file);
+ 		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+ 						    info->dest_offset, len);
+ 		if (deduped == -EBADE)
+ 			info->status = FILE_DEDUPE_RANGE_DIFFERS;
+ 		else if (deduped < 0)
+ 			info->status = deduped;
+ 		else
+ 			info->bytes_deduped += deduped;
+ 
 -next_loop:
 +next_fdput:
  		fdput(dst_fd);
 -
 +next_loop:
  		if (fatal_signal_pending(current))
  			goto out;
  	}

--sm4nu43k4a2Rpi4c--
