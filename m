Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526495232; cv=none;
        d=google.com; s=arc-20160816;
        b=ua6PGnjNyZZuKLv1umCV/oC3rEO/T55yv8rjnbMnbLHpfi90ob3x0aZtonuizG8wxb
         EpsKYTEXa3iusB4MAZH/TRWsZLLHEdtlJvTASFGH4XQhC9KPULmN0CwFW8tgXUUHNAgi
         0uHcxffyJJ+a+ocsL+CcOpQOI3jk4PB8I1hryjJT5DOh+fcILR5ODWMlbFqfwoORVy7y
         DJX30E0CW5+vYSSWGITAgJmW8BFADPLyJrr5wHL4bCo+vamlUKbv0q6Blfl7NmDfx7u0
         ofplGFvfO2IetRH2sIppn98lJV07UUaZcIufcaJ3//gQcA5j3BREj/jA9+sKWQpZcidX
         lQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xrTwjUyAmplOAL0dzw4hOLwGips7DT/OzdbNL1k7Fe0=;
        b=P9eAL+3T9JEusJvohG9apEG2IgSoMyvefkz+R2X0xRgH8mSssrom3qxltjab0z/iev
         uOg+ILMxn5x93uQ5acaDZPkUlCLDfY0AG4otav3erI99YQ4+GlmvvSuXHBQQrNuAPNdk
         jtWQr8A1wnwb0SUASyumOHkVzs4iG9TRKfNXjCElxFzaVzaiQ/axG0GVwiZy2V1c6vMO
         0QVALYzzMe9jywBe4PVZUu82hMAwj2ddIIhWY4aBRBfLDqfTRjeLgd5IGHnjho39dAy6
         +P1V+dg87R7aaktaYuBt+hIRemQCjFN41DKrT5cwC+E61HIcZ3g01Lb+GyTyCqSGmZdb
         x9dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BzQcCswC;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BzQcCswC;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpGAuHKWMG8rKf9Q9O4DGovKVTOKetOKoyVertmV6NCANgsKf2uTV++io+bswaf8ERNDlvt4A==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	oleg.drokin@intel.com,
	lustre-devel@lists.lustre.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 2/5] staging: lustre: Fix block comments style
Date: Wed, 16 May 2018 20:27:07 +0200
Message-Id: <20180516182707.5191-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600646264659471540?=
X-GMAIL-MSGID: =?utf-8?q?1600646264659471540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes the checkpatch.pl warning:

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 .../staging/lustre/include/uapi/linux/lustre/lustre_idl.h   | 6 ++++--
 .../staging/lustre/include/uapi/linux/lustre/lustre_user.h  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
index e6016a71ad23..f13138972be2 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
@@ -1526,9 +1526,11 @@ struct mdt_rec_setattr {
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
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
index 2fcfe2b2d365..f0fbe3318db6 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
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
