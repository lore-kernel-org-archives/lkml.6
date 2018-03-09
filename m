Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbeCILdz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:33:55 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40390 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCILdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:33:53 -0500
X-Google-Smtp-Source: AG47ELsZ81XHL4SNgkk8eFOwWJMu7n2OAICbScoXtD6a46xR+GkUBAm8VHcNEjMGGzi5lpj8wKtwiw==
Date: Fri, 9 Mar 2018 12:33:48 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 4.16-rc5
Message-ID: <20180309113348.GC19579@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-linus

This fixes a corner case for NFS exporting (introduced in this cycle) as well as
fixing miscellaneous bugs.

Thanks,
Miklos

---
Amir Goldstein (3):
      ovl: hash non-dir by lower inode for fsnotify
      ovl: check lower ancestry on encode of lower dir file handle
      ovl: check ERR_PTR() return value from ovl_lookup_real()

Fengguang Wu (1):
      ovl: fix ptr_ret.cocci warnings

Miklos Szeredi (1):
      ovl: update Kconfig texts

Vivek Goyal (1):
      ovl: redirect_dir=nofollow should not follow redirect for opaque lower

---
 fs/overlayfs/Kconfig     |  14 +++
 fs/overlayfs/export.c    | 216 ++++++++++++++++++++++++++++++++++++-----------
 fs/overlayfs/inode.c     |  58 +++++++++----
 fs/overlayfs/namei.c     |   6 +-
 fs/overlayfs/overlayfs.h |   1 +
 fs/overlayfs/super.c     |   1 +
 6 files changed, 228 insertions(+), 68 deletions(-)
