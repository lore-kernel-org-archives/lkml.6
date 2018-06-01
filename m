Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeFASqX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeFASqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/5] staging: remove ncpfs and ipx code
Date: Fri,  1 Jun 2018 20:45:42 +0200
Message-Id: <20180601184547.20213-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ncpfs filesystem and ipx networking code moved into the
drivers/staging/ tree back in November of last year.  Since then, no one
has steped up to take over maintance of this code.  Given that it has
been more than 6 months, it is time to delete it.

Note, there is more work to be done to remove the ipx header files
completly, as it is burried deep into the networking stack in places.  I
will work on a patch series to complete that later, after this is
merged, in order to clean up the last remaining bits properly.

Unless there are any objections, I'll take this through my staging tree.

Greg Kroah-Hartman (5):
  staging: ncpfs: delete it
  ncpfs: remove compat functionality
  ncpfs: remove Documentation
  ncpfs: remove uapi .h files
  staging: ipx: delete it from the tree

 Documentation/filesystems/00-INDEX     |    2 -
 Documentation/filesystems/ncpfs.txt    |   12 -
 drivers/staging/Kconfig                |    4 -
 drivers/staging/Makefile               |    2 -
 drivers/staging/ipx/Kconfig            |   61 -
 drivers/staging/ipx/Makefile           |    8 -
 drivers/staging/ipx/TODO               |    4 -
 drivers/staging/ipx/af_ipx.c           | 2082 ------------------------
 drivers/staging/ipx/ipx_proc.c         |  338 ----
 drivers/staging/ipx/ipx_route.c        |  293 ----
 drivers/staging/ipx/pe2.c              |   36 -
 drivers/staging/ipx/sysctl_net_ipx.c   |   40 -
 drivers/staging/ncpfs/Kconfig          |  108 --
 drivers/staging/ncpfs/Makefile         |   17 -
 drivers/staging/ncpfs/TODO             |    4 -
 drivers/staging/ncpfs/dir.c            | 1232 --------------
 drivers/staging/ncpfs/file.c           |  263 ---
 drivers/staging/ncpfs/getopt.c         |   76 -
 drivers/staging/ncpfs/getopt.h         |   17 -
 drivers/staging/ncpfs/inode.c          | 1067 ------------
 drivers/staging/ncpfs/ioctl.c          |  923 -----------
 drivers/staging/ncpfs/mmap.c           |  125 --
 drivers/staging/ncpfs/ncp_fs.h         |  101 --
 drivers/staging/ncpfs/ncp_fs_i.h       |   31 -
 drivers/staging/ncpfs/ncp_fs_sb.h      |  174 --
 drivers/staging/ncpfs/ncplib_kernel.c  | 1326 ---------------
 drivers/staging/ncpfs/ncplib_kernel.h  |  215 ---
 drivers/staging/ncpfs/ncpsign_kernel.c |  128 --
 drivers/staging/ncpfs/ncpsign_kernel.h |   27 -
 drivers/staging/ncpfs/sock.c           |  855 ----------
 drivers/staging/ncpfs/symlink.c        |  182 ---
 fs/compat.c                            |   72 +-
 include/uapi/linux/ncp.h               |  202 ---
 include/uapi/linux/ncp_fs.h            |  147 --
 include/uapi/linux/ncp_mount.h         |   72 -
 include/uapi/linux/ncp_no.h            |   20 -
 36 files changed, 1 insertion(+), 10265 deletions(-)
 delete mode 100644 Documentation/filesystems/ncpfs.txt
 delete mode 100644 drivers/staging/ipx/Kconfig
 delete mode 100644 drivers/staging/ipx/Makefile
 delete mode 100644 drivers/staging/ipx/TODO
 delete mode 100644 drivers/staging/ipx/af_ipx.c
 delete mode 100644 drivers/staging/ipx/ipx_proc.c
 delete mode 100644 drivers/staging/ipx/ipx_route.c
 delete mode 100644 drivers/staging/ipx/pe2.c
 delete mode 100644 drivers/staging/ipx/sysctl_net_ipx.c
 delete mode 100644 drivers/staging/ncpfs/Kconfig
 delete mode 100644 drivers/staging/ncpfs/Makefile
 delete mode 100644 drivers/staging/ncpfs/TODO
 delete mode 100644 drivers/staging/ncpfs/dir.c
 delete mode 100644 drivers/staging/ncpfs/file.c
 delete mode 100644 drivers/staging/ncpfs/getopt.c
 delete mode 100644 drivers/staging/ncpfs/getopt.h
 delete mode 100644 drivers/staging/ncpfs/inode.c
 delete mode 100644 drivers/staging/ncpfs/ioctl.c
 delete mode 100644 drivers/staging/ncpfs/mmap.c
 delete mode 100644 drivers/staging/ncpfs/ncp_fs.h
 delete mode 100644 drivers/staging/ncpfs/ncp_fs_i.h
 delete mode 100644 drivers/staging/ncpfs/ncp_fs_sb.h
 delete mode 100644 drivers/staging/ncpfs/ncplib_kernel.c
 delete mode 100644 drivers/staging/ncpfs/ncplib_kernel.h
 delete mode 100644 drivers/staging/ncpfs/ncpsign_kernel.c
 delete mode 100644 drivers/staging/ncpfs/ncpsign_kernel.h
 delete mode 100644 drivers/staging/ncpfs/sock.c
 delete mode 100644 drivers/staging/ncpfs/symlink.c
 delete mode 100644 include/uapi/linux/ncp.h
 delete mode 100644 include/uapi/linux/ncp_fs.h
 delete mode 100644 include/uapi/linux/ncp_mount.h
 delete mode 100644 include/uapi/linux/ncp_no.h

-- 
2.17.1
