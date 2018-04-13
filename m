Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635907; cv=none;
        d=google.com; s=arc-20160816;
        b=xm1kV92pah9Gp/f+4QgWY3/jPCAq4VznZ1Mxtbfme2CExLtbnaJ7jMUF4KOzT+B5Ph
         CkDLP8qE1efJMdkesczLeGiJcZZWSGRBHs6/mJkNLBNFxcWP6Hdjqzl5aB7OxbmHgmxK
         ZyjN92oKhbT1GAcX4RsiJqUvhK1SOf0zjIxxi6AlOOxXuP6ftyFC1imEJzexrxKfITC0
         DttflVKBq+5yw7uSgDi956+EF7qSY3Pyna+jzlRMNG9etuQSuYNldkmB8+FGdH8u2VCN
         WekdsyzbgUXmtLyMsbVhwbx0G63T1XoV0sRRnUxUltO6/6JXOYQNcmrFRfrlEUa1kym+
         PTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PPPDt86F5yUuXmHDv6AGlyjxtJfn1rWBCcfwatk8iN0=;
        b=bOPamjSJXOkxLnwfVPx7fAJ8gdm2ucKakzlruYX+gityxFB3m4K2KFQ2nZThvft0OC
         2A7tT/5/k9hHSHsUA92ePRGdQu/sPFZj1XCJIZZovnBwSusL0QFbS8lHOMU0EaAcQCI5
         sYon2FaDQIEHJibOAJToGSaI5ryUwRvT4L/VVRKypO90Z213ipvbUGcnSxXCg8VkxFT3
         1rHxMmHMW7n4c0DlvpkQ87SNF+D0S7Vj01vwkMCyCMvXB7ZGAlXUv79meiLJ+TnkaTAy
         b9qX9zH1yV/Gqr4rVuyNFZUQX6yEMBg562dlgUJz1Zav80ACaC66j53NssaS2DCzsRjc
         v5eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49bN8s1l/NMroIjsEZEhQXRpyTDe5NsMJwX8/dW5sl6RsjdF0Ejg6FAULGJWLKLg9pmpUGhYg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	serge@hallyn.com
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/6] fs: use << for MS_* flags
Date: Fri, 13 Apr 2018 18:11:21 +0200
Message-Id: <20180413161126.31313-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648045071126947?=
X-GMAIL-MSGID: =?utf-8?q?1597648045071126947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Consistenly use << to define MS_* constants.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d2a8313fabd7..9662790a657c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -105,22 +105,23 @@ struct inodes_stat_t {
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
-				   MS_VERBOSE is deprecated. */
-#define MS_SILENT	32768
+#define MS_RDONLY	(1<<0)	/* Mount read-only */
+#define MS_NOSUID	(1<<1)	/* Ignore suid and sgid bits */
+#define MS_NODEV	(1<<2)	/* Disallow access to device special files */
+#define MS_NOEXEC	(1<<3)	/* Disallow program execution */
+#define MS_SYNCHRONOUS	(1<<4)	/* Writes are synced at once */
+#define MS_REMOUNT	(1<<5)	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	(1<<6)	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	(1<<7)	/* Directory modifications are synchronous */
+#define MS_NOATIME	(1<<10)	/* Do not update access times. */
+#define MS_NODIRATIME	(1<<11)	/* Do not update directory access times */
+#define MS_BIND		(1<<12)
+#define MS_MOVE		(1<<13)
+#define MS_REC		(1<<14)
+#define MS_VERBOSE	(1<<15)	/* War is peace. Verbosity is silence.
+				 * MS_VERBOSE is deprecated.
+				 */
+#define MS_SILENT	(1<<15)
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
-- 
2.17.0
