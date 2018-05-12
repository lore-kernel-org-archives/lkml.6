Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526122946; cv=none;
        d=google.com; s=arc-20160816;
        b=oIllOmk1LMfiJe8cS6Ff9svhwKItBkyyujdJKnnMJ8vcTpqDXSetRY1V89s2TE6k+2
         Sl3yX/2ZefNYakDUJXCOcjXc/91J46H/+yU28JYn7PjCUgcBLtD0ZTWPr6oDL5MyEMrr
         NjCewDIsU7jm4QxNM2ugTwlq7lEukJTiMe6kvWj8VZRdgqQmh+Wgshg4EjBjFUFjXoP2
         MYlzCOlf/kdfCZJ1S2hdpTZ/8CPgzYCbQoMMyt3eilXPITMIHwaTP7BJdie9aEtkwSxf
         LTzQzAdKam7t6YTZZ9kVhEx4OdZgFQuLY2jaVbCUg3JwRG0sGkoesFSRetxOTXYvZrC/
         aZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mByfn1ZjmL6dsE4dF9jYdfwIQ/u52J6mr6jNp8gPm+0=;
        b=KjvYBQSQt3GEcxB6ZJbsnCz4mQQrz+DsgwQLSQczA9EY0tqEGBWuxEnORV1z+aD4Yh
         lOt640I4Fs29fCtR7fIBSKTbTnOP4/dCuym1BDSRD6btkbHlowhqOhNYPQj8WSYc5M0e
         VO5kQGqVJ6RNx/eGhmFSZIvUbN0KszfdIDNG2NRu4gq3NvNiRkKCbg6rqBs6UR16EHq7
         4Yk+FCSMBevu+xfS+AuirDtRxDYzU7gWJwPYY3WzvnvBgpPamKCSthLPOF8MsEgLckN0
         lFTmQgcju+7jp+YREKkXu9WGK140w4KNSznXnJBep9qpwxHMnkxJN8Yr15EsqrTqKalw
         ObEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b6Jr4OF8;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b6Jr4OF8;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZriw0Ym7OnGQ/BsLovSC7IgJAg/W4cMrxwRNLIw/0F+Xv2y0r5ENmO4D7KrHOGuKJfCRjjsfg==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	leg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 2/2] staging: lustre: Fix trivial checkpatch warnings
Date: Sat, 12 May 2018 13:02:16 +0200
Message-Id: <20180512110216.6851-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600255894345488447?=
X-GMAIL-MSGID: =?utf-8?q?1600255894345488447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Trivial fix to multiple errors and warnings in the lustre headers.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 .../lustre/include/linux/libcfs/libcfs_cpu.h  |  2 +-
 .../lustre/include/uapi/linux/lnet/lnet-dlc.h |  4 +-
 .../include/uapi/linux/lnet/lnet-types.h      |  4 +-
 .../lustre/include/uapi/linux/lnet/lnetctl.h  |  2 +-
 .../lustre/include/uapi/linux/lnet/nidstr.h   |  2 +-
 .../include/uapi/linux/lustre/lustre_cfg.h    |  2 +-
 .../include/uapi/linux/lustre/lustre_fiemap.h |  2 +-
 .../include/uapi/linux/lustre/lustre_idl.h    | 45 +++++++++++--------
 .../include/uapi/linux/lustre/lustre_ioctl.h  |  2 +-
 .../include/uapi/linux/lustre/lustre_ostid.h  |  2 +-
 .../include/uapi/linux/lustre/lustre_user.h   |  8 ++--
 11 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 813ba4564bb9..45aa6ae8380d 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -90,7 +90,6 @@ struct cfs_cpu_partition {
 	unsigned int			cpt_spread_rotor;
 };
 
-
 /** descriptor for CPU partitions */
 struct cfs_cpt_table {
 	/* version, reserved for hotplug */
@@ -225,6 +224,7 @@ cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
 	return 0;
 }
+
 static inline int
 cfs_cpt_number(struct cfs_cpt_table *cptab)
 {
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
diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-types.h b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-types.h
index 1be9b7aa7326..401a08920195 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/lnet-types.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnet-types.h
@@ -298,7 +298,7 @@ static inline void LNetInvalidateEQHandle(struct lnet_handle_eq *h)
  */
 static inline int LNetEQHandleIsInvalid(struct lnet_handle_eq h)
 {
-	return (LNET_WIRE_HANDLE_COOKIE_NONE == h.cookie);
+	return (h.cookie == LNET_WIRE_HANDLE_COOKIE_NONE);
 }
 
 struct lnet_handle_md {
@@ -320,7 +320,7 @@ static inline void LNetInvalidateMDHandle(struct lnet_handle_md *h)
  */
 static inline int LNetMDHandleIsInvalid(struct lnet_handle_md h)
 {
-	return (LNET_WIRE_HANDLE_COOKIE_NONE == h.cookie);
+	return (h.cookie == LNET_WIRE_HANDLE_COOKIE_NONE);
 }
 
 struct lnet_handle_me {
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
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
index f5214dc33c60..d375a476f5ea 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
@@ -51,7 +51,7 @@ static inline size_t fiemap_count_to_size(size_t extent_count)
 				       sizeof(struct fiemap_extent);
 }
 
-static inline unsigned fiemap_size_to_count(size_t array_size)
+static inline unsigned int fiemap_size_to_count(size_t array_size)
 {
 	return (array_size - sizeof(struct fiemap)) /
 		sizeof(struct fiemap_extent);
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
index aac98dbcf6e3..31bf06c6d46f 100644
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
@@ -335,8 +335,8 @@ struct lu_dirent {
  *
  * Individual attributes do not have their length encoded in a generic way. It
  * is assumed that consumer of an attribute knows its format. This means that
- * it is impossible to skip over an unknown attribute, except by skipping over all
- * remaining attributes (by using ->lde_reclen), which is not too
+ * it is impossible to skip over an unknown attribute, except by skipping over
+ * all remaining attributes (by using ->lde_reclen), which is not too
  * constraining, because new server versions will append new attributes at
  * the end of an entry.
  */
@@ -680,9 +680,9 @@ struct ptlrpc_body_v2 {
 #define OBD_CONNECT_PINGLESS	0x4000000000000ULL/* pings not required */
 #define OBD_CONNECT_FLOCK_DEAD	0x8000000000000ULL/* flock deadlock detection */
 #define OBD_CONNECT_DISP_STRIPE 0x10000000000000ULL/*create stripe disposition*/
-#define OBD_CONNECT_OPEN_BY_FID	0x20000000000000ULL	/* open by fid won't pack
-							 * name in request
-							 */
+#define OBD_CONNECT_OPEN_BY_FID	0x20000000000000ULL /* open by fid won't pack
+						     * name in request
+						     */
 #define OBD_CONNECT_LFSCK	0x40000000000000ULL/* support online LFSCK */
 #define OBD_CONNECT_UNLINK_CLOSE 0x100000000000000ULL/* close file in unlink */
 #define OBD_CONNECT_MULTIMODRPCS 0x200000000000000ULL /* support multiple modify
@@ -814,6 +814,7 @@ enum ost_cmd {
 	OST_QUOTA_ADJUST_QUNIT = 20, /* not used since 2.4 */
 	OST_LAST_OPC
 };
+
 #define OST_FIRST_OPC  OST_REPLY
 
 enum obdo_flags {
@@ -1185,7 +1186,7 @@ struct obd_quotactl {
 	struct obd_dqblk	qc_dqblk;
 };
 
-#define Q_COPY(out, in, member) (out)->member = (in)->member
+#define Q_COPY(out, in, member) ((out)->member = (in)->member)
 
 #define QCTL_COPY(out, in)		\
 do {					\
@@ -1228,6 +1229,7 @@ enum quota_cmd {
 	QUOTA_DQREL	= 602,
 	QUOTA_LAST_OPC
 };
+
 #define QUOTA_FIRST_OPC	QUOTA_DQACQ
 
 /*
@@ -1526,9 +1528,11 @@ struct mdt_rec_setattr {
 #define MDS_OPEN_HAS_OBJS    020000000000 /* Just set the EA the obj exist */
 #define MDS_OPEN_NORESTORE  0100000000000ULL /* Do not restore file at open */
 #define MDS_OPEN_NEWSTRIPE  0200000000000ULL /* New stripe needed (restripe or
-					      * hsm restore) */
+					      * hsm restore)
+					      */
 #define MDS_OPEN_VOLATILE   0400000000000ULL /* File is volatile = created
-						unlinked */
+					      * unlinked
+					      */
 #define MDS_OPEN_LEASE	   01000000000000ULL /* Open the file and grant lease
 					      * delegation, succeed if it's not
 					      * being opened with conflict mode.
@@ -1920,6 +1924,7 @@ enum ldlm_cmd {
 	LDLM_SET_INFO    = 107,
 	LDLM_LAST_OPC
 };
+
 #define LDLM_FIRST_OPC LDLM_ENQUEUE
 
 #define RES_NAME_SIZE 4
@@ -2062,6 +2067,7 @@ enum mgs_cmd {
 	MGS_CONFIG_READ,
 	MGS_LAST_OPC
 };
+
 #define MGS_FIRST_OPC MGS_CONNECT
 
 #define MGS_PARAM_MAXLEN 1024
@@ -2147,6 +2153,7 @@ enum obd_cmd {
 	OBD_IDX_READ,
 	OBD_LAST_OPC
 };
+
 #define OBD_FIRST_OPC OBD_PING
 
 /**
@@ -2389,11 +2396,11 @@ enum llog_flag {
 
 /* On-disk header structure of each log object, stored in little endian order */
 #define LLOG_MIN_CHUNK_SIZE	8192
-#define LLOG_HEADER_SIZE	(96)	/* sizeof (llog_log_hdr) +
-					 * sizeof(llh_tail) - sizeof(llh_bitmap)
-					 */
+#define LLOG_HEADER_SIZE	(96) /* sizeof (llog_log_hdr) +
+				      * sizeof(llh_tail) - sizeof(llh_bitmap)
+				      */
 #define LLOG_BITMAP_BYTES	(LLOG_MIN_CHUNK_SIZE - LLOG_HEADER_SIZE)
-#define LLOG_MIN_REC_SIZE	(24)	/* round(llog_rec_hdr + llog_rec_tail) */
+#define LLOG_MIN_REC_SIZE	(24) /* round(llog_rec_hdr + llog_rec_tail) */
 
 /* flags for the logs */
 struct llog_log_hdr {
@@ -2426,11 +2433,11 @@ struct llog_log_hdr {
 #define LLOG_HDR_BITMAP_SIZE(llh) (__u32)((llh->llh_hdr.lrh_len -	\
 					   llh->llh_bitmap_offset -	\
 					   sizeof(llh->llh_tail)) * 8)
-#define LLOG_HDR_BITMAP(llh)	(__u32 *)((char *)(llh) +		\
-					  (llh)->llh_bitmap_offset)
-#define LLOG_HDR_TAIL(llh)	((struct llog_rec_tail *)((char *)llh + \
-							 llh->llh_hdr.lrh_len - \
-							 sizeof(llh->llh_tail)))
+#define LLOG_HDR_BITMAP(llh) (__u32 *)((char *)(llh) +	\
+				       (llh)->llh_bitmap_offset)
+#define LLOG_HDR_TAIL(llh) ((struct llog_rec_tail *)((char *)llh + \
+						     llh->llh_hdr.lrh_len - \
+						     sizeof(llh->llh_tail)))
 
 /** log cookies are used to reference a specific log file and a record
  * therein
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
index 5e332e3af68a..f0fbe3318db6 100644
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
@@ -405,7 +405,8 @@ static inline __u32 lov_user_md_size(__u16 stripes, __u32 lmm_magic)
 
 /* Compile with -D_LARGEFILE64_SOURCE or -D_GNU_SOURCE (or #define) to
  * use this.  It is unsafe to #define those values in this header as it
- * is possible the application has already #included <sys/stat.h>. */
+ * is possible the application has already #included <sys/stat.h>.
+ */
 #ifdef HAVE_LOV_USER_MDS_DATA
 #define lov_user_mds_data lov_user_mds_data_v1
 struct lov_user_mds_data_v1 {
@@ -468,7 +469,8 @@ struct ll_fid {
 	__u64 id;	 /* holds object id */
 	__u32 generation; /* holds object generation */
 	__u32 f_type;     /* holds object type or stripe idx when passing it to
-			   * OST for saving into EA. */
+			   * OST for saving into EA.
+			   */
 };
 
 #define UUID_MAX	40
-- 
2.17.0
