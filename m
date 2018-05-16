Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526495218; cv=none;
        d=google.com; s=arc-20160816;
        b=Lx9+Ndpd3t0GZ8z4FrVImcrNS+rhL1m77PIB2FkTu2epbDmY19vfrMnqcMwPLxHg51
         XY+J5FIKmhFylChbowE2tcxWfY6udWhO5a+QHxdT427l/gAQyG0H1j6Mq76B9/0AO5VV
         2uGccQdVarCysYIdb6aTBbqRlLbMsNiAngsc5BFYaJHvuqtMfDWjnWZQI92/Axd7bPkM
         jdAUMW7vrhyVip1GKk8HNhpYA50EhfiI32AJvVAUDi5GWuCjEPm3zgGqXHEXUyRnlm7a
         JYZB80Wm3U+PfR6Pwc/GS7JR9uGgbnimNimLu9nQCDDzvFP90sVL3N/JJi3QDgbc0pGQ
         6XKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=G6NFgbRh57kQNkO9oF4HGYTIIvEVHsF+fwzdQQTIWoM=;
        b=ed6pWlQoUCNNTsD6aXHNXz8YSP0SNAuxoVOqfbuuxtXYsS0bvqsA4/zS9bMoZqg+SX
         Clt+UrYQTumLYc70ABPvaHlybvqHZVlV4uwV5Z0+NLtqDOWQH8W6BPlGOskxqax0ti27
         k1QsCyC65R+JtZUywtlrzPnJ2DJZgSAuUkoGpC+gFMKlA7R+f/N5/eudU+0bDtebNvdQ
         p6MWl8qV6hovbov9lCyRUDx0jG4d0weKh0s0jCZHaTCF3yNt0R1GB9VIwr8/GmIZUQZ6
         ItzidV6hzpdQlAxZid32M3RrHH38/NtIc6+kyaZ8RCXm/Tm4qmAm1QyoMv81QPJlTwhA
         RUXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QbCf8pM9;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QbCf8pM9;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoM99+gthJulNSmcsb92BpwgR9n1lee6AiOpF2f/NLtNGkGDkotkwe4RC8WwFBz4UzZg9jf4w==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	oleg.drokin@intel.com,
	lustre-devel@lists.lustre.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 1/5] staging: lustre: Fix inclusion of local headers
Date: Wed, 16 May 2018 20:26:36 +0200
Message-Id: <20180516182636.5137-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600646249682035019?=
X-GMAIL-MSGID: =?utf-8?q?1600646249682035019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes the checkpatch.pl error:

ERROR:UAPI_INCLUDE: No #include in ...include/uapi/... should use a uapi/ path
prefix

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h     | 4 ++--
 drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h      | 2 +-
 drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h       | 2 +-
 drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h | 2 +-
 drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h | 2 +-
 drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h | 4 ++--
 .../staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h   | 2 +-
 .../staging/lustre/include/uapi/linux/lustre/lustre_ostid.h   | 2 +-
 .../staging/lustre/include/uapi/linux/lustre/lustre_user.h    | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
index c1619f411d81..1530ac26b449 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-dlc.h
@@ -29,8 +29,8 @@
 #ifndef LNET_DLC_H
 #define LNET_DLC_H
 
-#include <uapi/linux/lnet/libcfs_ioctl.h>
-#include <uapi/linux/lnet/lnet-types.h>
+#include "libcfs_ioctl.h"
+#include "lnet-types.h"
 
 #define MAX_NUM_SHOW_ENTRIES	32
 #define LNET_MAX_STR_LEN	128
diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h b/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
index cccb32dd28f2..c7be86610cc0 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
@@ -15,7 +15,7 @@
 #ifndef _LNETCTL_H_
 #define _LNETCTL_H_
 
-#include <uapi/linux/lnet/lnet-types.h>
+#include "lnet-types.h"
 
 /** \addtogroup lnet_fault_simulation
  * @{
diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h b/drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h
index 882074ed6021..d153c97ea64d 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/nidstr.h
@@ -28,7 +28,7 @@
 #ifndef _LNET_NIDSTRINGS_H
 #define _LNET_NIDSTRINGS_H
 
-#include <uapi/linux/lnet/lnet-types.h>
+#include "lnet-types.h"
 
 /**
  *  Lustre Network Driver types.
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h
index 11b51d93f64c..a1dc912af960 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_cfg.h
@@ -35,7 +35,7 @@
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <uapi/linux/lustre/lustre_user.h>
+#include "lustre_user.h"
 
 /** \defgroup cfg cfg
  *
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h
index 2e7a8d103777..1e347a86427c 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fid.h
@@ -37,7 +37,7 @@
 #ifndef _UAPI_LUSTRE_FID_H_
 #define _UAPI_LUSTRE_FID_H_
 
-#include <uapi/linux/lustre/lustre_idl.h>
+#include "lustre_idl.h"
 
 /** returns fid object sequence */
 static inline __u64 fid_seq(const struct lu_fid *fid)
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
index aac98dbcf6e3..e6016a71ad23 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
@@ -72,8 +72,8 @@
 
 #include <uapi/linux/lnet/lnet-types.h>
 /* Defn's shared with user-space. */
-#include <uapi/linux/lustre/lustre_user.h>
-#include <uapi/linux/lustre/lustre_ver.h>
+#include "lustre_user.h"
+#include "lustre_ver.h"
 
 /*
  *  GENERAL STUFF
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
index 6e4e109fb874..54e8fbbe98c4 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
@@ -31,7 +31,7 @@
 #include <linux/ioctl.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <uapi/linux/lustre/lustre_idl.h>
+#include "lustre_idl.h"
 
 #if !defined(__KERNEL__) && !defined(LUSTRE_UTILS)
 # error This file is for Lustre internal use only.
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ostid.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ostid.h
index 3343b602219b..9110229b0886 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ostid.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ostid.h
@@ -35,7 +35,7 @@
 #define _UAPI_LUSTRE_OSTID_H_
 
 #include <linux/errno.h>
-#include <uapi/linux/lustre/lustre_fid.h>
+#include "lustre_fid.h"
 
 static inline __u64 lmm_oi_id(const struct ost_id *oi)
 {
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
index 5e332e3af68a..2fcfe2b2d365 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
@@ -55,7 +55,7 @@
 # include <sys/quota.h>
 # include <sys/stat.h>
 #endif /* __KERNEL__ */
-#include <uapi/linux/lustre/lustre_fiemap.h>
+#include "lustre_fiemap.h"
 
 /*
  * We need to always use 64bit version because the structure
-- 
2.17.0
