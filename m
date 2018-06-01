Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeFASqa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeFASqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 1/5] staging: ncpfs: delete it
Date: Fri,  1 Jun 2018 20:45:43 +0200
Message-Id: <20180601184547.20213-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601184547.20213-1-gregkh@linuxfoundation.org>
References: <20180601184547.20213-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ncpfs code moved into the staging tree back in November 2017 and no
one has complained or even noticed it was gone.  Because of that, let's
just delete it.

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/Kconfig                |    2 -
 drivers/staging/Makefile               |    1 -
 drivers/staging/ncpfs/Kconfig          |  108 --
 drivers/staging/ncpfs/Makefile         |   17 -
 drivers/staging/ncpfs/TODO             |    4 -
 drivers/staging/ncpfs/dir.c            | 1232 ----------------------
 drivers/staging/ncpfs/file.c           |  263 -----
 drivers/staging/ncpfs/getopt.c         |   76 --
 drivers/staging/ncpfs/getopt.h         |   17 -
 drivers/staging/ncpfs/inode.c          | 1067 -------------------
 drivers/staging/ncpfs/ioctl.c          |  923 -----------------
 drivers/staging/ncpfs/mmap.c           |  125 ---
 drivers/staging/ncpfs/ncp_fs.h         |  101 --
 drivers/staging/ncpfs/ncp_fs_i.h       |   31 -
 drivers/staging/ncpfs/ncp_fs_sb.h      |  174 ----
 drivers/staging/ncpfs/ncplib_kernel.c  | 1326 ------------------------
 drivers/staging/ncpfs/ncplib_kernel.h  |  215 ----
 drivers/staging/ncpfs/ncpsign_kernel.c |  128 ---
 drivers/staging/ncpfs/ncpsign_kernel.h |   27 -
 drivers/staging/ncpfs/sock.c           |  855 ---------------
 drivers/staging/ncpfs/symlink.c        |  182 ----
 21 files changed, 6874 deletions(-)
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

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5926f0d3f6c..b695560cab2f 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -26,8 +26,6 @@ if STAGING
 
 source "drivers/staging/ipx/Kconfig"
 
-source "drivers/staging/ncpfs/Kconfig"
-
 source "drivers/staging/wlan-ng/Kconfig"
 
 source "drivers/staging/comedi/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 919753c3d3f6..d6d0e9266cb5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -4,7 +4,6 @@
 obj-y				+= media/
 obj-y				+= typec/
 obj-$(CONFIG_IPX)		+= ipx/
-obj-$(CONFIG_NCP_FS)		+= ncpfs/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
diff --git a/drivers/staging/ncpfs/Kconfig b/drivers/staging/ncpfs/Kconfig
deleted file mode 100644
index c931cf22a1f6..000000000000
diff --git a/drivers/staging/ncpfs/Makefile b/drivers/staging/ncpfs/Makefile
deleted file mode 100644
index 66fe5f878817..000000000000
diff --git a/drivers/staging/ncpfs/TODO b/drivers/staging/ncpfs/TODO
deleted file mode 100644
index 9b6d38b7e248..000000000000
diff --git a/drivers/staging/ncpfs/dir.c b/drivers/staging/ncpfs/dir.c
deleted file mode 100644
index 0c57c5c5d40a..000000000000
diff --git a/drivers/staging/ncpfs/file.c b/drivers/staging/ncpfs/file.c
deleted file mode 100644
index 8f8cc0334ddd..000000000000
diff --git a/drivers/staging/ncpfs/getopt.c b/drivers/staging/ncpfs/getopt.c
deleted file mode 100644
index 5c941bef14c4..000000000000
diff --git a/drivers/staging/ncpfs/getopt.h b/drivers/staging/ncpfs/getopt.h
deleted file mode 100644
index 30f0da317670..000000000000
diff --git a/drivers/staging/ncpfs/inode.c b/drivers/staging/ncpfs/inode.c
deleted file mode 100644
index bb411610a071..000000000000
diff --git a/drivers/staging/ncpfs/ioctl.c b/drivers/staging/ncpfs/ioctl.c
deleted file mode 100644
index d378b98cd7b6..000000000000
diff --git a/drivers/staging/ncpfs/mmap.c b/drivers/staging/ncpfs/mmap.c
deleted file mode 100644
index a5c5cf2ff007..000000000000
diff --git a/drivers/staging/ncpfs/ncp_fs.h b/drivers/staging/ncpfs/ncp_fs.h
deleted file mode 100644
index bdd262b6c198..000000000000
diff --git a/drivers/staging/ncpfs/ncp_fs_i.h b/drivers/staging/ncpfs/ncp_fs_i.h
deleted file mode 100644
index 3432bafb53a5..000000000000
diff --git a/drivers/staging/ncpfs/ncp_fs_sb.h b/drivers/staging/ncpfs/ncp_fs_sb.h
deleted file mode 100644
index f06cde4adf71..000000000000
diff --git a/drivers/staging/ncpfs/ncplib_kernel.c b/drivers/staging/ncpfs/ncplib_kernel.c
deleted file mode 100644
index 3e047eb4cc7c..000000000000
diff --git a/drivers/staging/ncpfs/ncplib_kernel.h b/drivers/staging/ncpfs/ncplib_kernel.h
deleted file mode 100644
index aaae8aa9bf7d..000000000000
diff --git a/drivers/staging/ncpfs/ncpsign_kernel.c b/drivers/staging/ncpfs/ncpsign_kernel.c
deleted file mode 100644
index 8085b1a3ba47..000000000000
diff --git a/drivers/staging/ncpfs/ncpsign_kernel.h b/drivers/staging/ncpfs/ncpsign_kernel.h
deleted file mode 100644
index 57ff0a0650b8..000000000000
diff --git a/drivers/staging/ncpfs/sock.c b/drivers/staging/ncpfs/sock.c
deleted file mode 100644
index 4c13174d85b7..000000000000
diff --git a/drivers/staging/ncpfs/symlink.c b/drivers/staging/ncpfs/symlink.c
deleted file mode 100644
index b6e16da4837a..000000000000
-- 
2.17.1
