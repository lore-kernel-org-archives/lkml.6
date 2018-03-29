Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49KrPO6q/6SsfIz/qG+skThT7ozVRbihtkRnpMoyckF5BGrMBihft/C2E9rvV+I8Z2PRWQn
ARC-Seal: i=1; a=rsa-sha256; t=1522297751; cv=none;
        d=google.com; s=arc-20160816;
        b=esU09kQZpwPURS5zHoJcosEZA1Rcgm/SSRBUfGt1+YDtBWTikNChcWehEjb9qhfZ1P
         TIkeKOrtDtTzg+C8ExmsnLSr39CsZegqU78pgjwsZwmHHepQhSi4PN4NHWDoMm5Wnmgk
         DUjZMDMjxTKUcHvvp9KnSwYyvEO0xXPB1pdiiceXzVZjofFZaVgAHcH16jVQcGGeyx8s
         JTbm8b/Ryo2Jk34xM/PpN5J/QkBqapPOzO9gTv4r84I4vhg0iGA9pm4wSOSmqORg3oBx
         RcX646ge07SRNXabGnFFtM0ZnQXMItcmenh/jresPyJ769M5hC3ln3uJ1n2KoMDAC6Ju
         JGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=a5fRLWdZFacPtUcuqI4gC+ocNxqIYZrM28njP5+kaRs=;
        b=tshMvvTaz+ne6+rv2E/sxguKLyfUp5L7B6lu2XjULsnJxwO451Y3HQ6I0TgFpukPsL
         MqoNt4IpiF4zuHIDtJ0HsxMYaYyuonqHGjUbmUygWHSWPA9rNxPIfCwU8yt9BqiroHGm
         HtRDX2nMn/z5X7PQSHx1txIe1rflXZ9Gwsf3fHzv6qog84gXFmT1GXHZ48TMJnk6sU2k
         RBTeWrjbfDmy2QAfj/zu/zz+NC+xKin9kLwg3MTB3jIExc0YE/liMPZa8oy8hDlNAr9q
         AJlPd/we80AVhv7774o8qMryKvbGkpE+4vFtawiXjrgS4r0GGsBsiru7GoNKe65df4SL
         N/cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 17/17] staging: lustre: remove cruft from
 libcfs/linux/libcfs.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760887.27689.4035189219478811109.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244887656932993?=
X-GMAIL-MSGID: =?utf-8?q?1596244887656932993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These defines are unused or nearly unused, and do not
help at all.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/include/linux/libcfs/curproc.h  |    2 --
 .../lustre/include/linux/libcfs/linux/libcfs.h     |   17 -----------------
 drivers/staging/lustre/lnet/libcfs/tracefile.c     |    2 +-
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/curproc.h b/drivers/staging/lustre/include/linux/libcfs/curproc.h
index 4702956805a6..d6e4f47b5daf 100644
--- a/drivers/staging/lustre/include/linux/libcfs/curproc.h
+++ b/drivers/staging/lustre/include/linux/libcfs/curproc.h
@@ -43,8 +43,6 @@
 /*
  * Plus, platform-specific constant
  *
- * CFS_CURPROC_COMM_MAX,
- *
  * and opaque scalar type
  *
  * kernel_cap_t
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
index c39c34d74382..0dbd01617865 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
@@ -81,8 +81,6 @@
 #include <stdarg.h>
 #include "linux-cpu.h"
 
-#define LUSTRE_TRACE_SIZE (THREAD_SIZE >> 5)
-
 #if !defined(__x86_64__)
 # ifdef __ia64__
 #  define CDEBUG_STACK() (THREAD_SIZE -				 \
@@ -114,19 +112,4 @@ do {								    \
 #define CDEBUG_STACK() (0L)
 #endif /* __x86_64__ */
 
-#define __current_nesting_level() (0)
-
-/**
- * Platform specific declarations for cfs_curproc API (libcfs/curproc.h)
- *
- * Implementation is in linux-curproc.c
- */
-#define CFS_CURPROC_COMM_MAX (sizeof((struct task_struct *)0)->comm)
-
-#include <linux/capability.h>
-
-#ifndef WITH_WATCHDOG
-#define WITH_WATCHDOG
-#endif
-
 #endif /* _LINUX_LIBCFS_H */
diff --git a/drivers/staging/lustre/lnet/libcfs/tracefile.c b/drivers/staging/lustre/lnet/libcfs/tracefile.c
index 129430e74d00..514e1845740e 100644
--- a/drivers/staging/lustre/lnet/libcfs/tracefile.c
+++ b/drivers/staging/lustre/lnet/libcfs/tracefile.c
@@ -328,7 +328,7 @@ int libcfs_debug_vmsg2(struct libcfs_debug_msg_data *msgdata,
 		goto console;
 	}
 
-	depth = __current_nesting_level();
+	depth = 0;
 	known_size = strlen(file) + 1 + depth;
 	if (msgdata->msg_fn)
 		known_size += strlen(msgdata->msg_fn) + 1;
