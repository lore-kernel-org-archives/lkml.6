Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043651; cv=none;
        d=google.com; s=arc-20160816;
        b=XOmo3HQk8eW/3JZCuZ+r2R3sL8asu9A7uZKKHzulUmnhY1adKZpJy5GYp4lbKkyhGK
         stWGQ4nf32/xr1nJMNAzk9z5z/HxqbVrE2vmsLCz2ZfSiDwIiJAZRMGCtJhvNbufLShL
         fEhfcFavFOCPtYW59ZzYTixBvvxE9I4fDzTbZfTgK1giaSTXY0aZIw+FzxpnWTaEqATy
         IoANHyx1MhmK5Io0NoHIj45dxpl/9j+mKHK2nbnpWgcuI+SVv+CWlE/KvOGnMvjZaR+S
         aAu5dZvBCNXltOdC9ldbht58zg+GpThEXZVkdjs4Tgi+qSFkJlec3sSsfnETH0rRq87N
         3iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Yyz+PDRbcGqMJPiadMkvct+GbAqYigThM1581fNVjoI=;
        b=zgh109sIQF2KAxDB1SeshRBuIgl8y+4BFowQMJ9JMvU4+88Z+P+32Yr/cK1HnB4EIa
         RDnQgUeDAwMLNQjD5QMwoKvoKP4iDSO0Of7HABMOb4e6oXrfKu+PG3maCb7anAdILPd4
         RTPwefkbUyW00N2wYVE4hgt4HtC3uIk5u14e5BXkDHTTCpr3IIdTZ03UWwEMR6LaXGX6
         mlyuiskN6K5Piy64KY5qclm0bLpIXTk6ecTl/wiHjpW/5OkE3oQ94iTx0NPkplPyReOq
         AxmFq/eSXcVPkjQjcnM78Ql5Dq8QTUk0fG+CZndAvKKmkW1mGs/xaj74wgmwZKspAQ0R
         TThQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4+fn8SfcvEOa4Ef1Uf+rLeA4XInKgUCrSkrLEgUF5T6vUAQhKFqTzBRtqobjiIc2qWPogPsMA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/6 RESEND] fs: use << for MS_* flags
Date: Wed, 18 Apr 2018 11:27:17 +0200
Message-Id: <20180418092722.20136-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075595860803389?=
X-GMAIL-MSGID: =?utf-8?q?1598075595860803389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Consistenly use << to define MS_* constants.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
