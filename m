Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275937; cv=none;
        d=google.com; s=arc-20160816;
        b=Zhlhnq3QsXU74OsviViXwWgN9UYXbzZ2mL4OnZu/MJTAavVh1Kt4x08KE9O3BRygAl
         U+X4/Xxmq+FIUZ2OIBN8KeQKYwYZQW3Y3AvIjSJctqzaiO/496zauP7K2sZ1MaXXZetO
         HDfTFRGbKXodujkYpXVGz7IudiHcyzDyX6fOjGoR5RjdL/i9IcUKGA7JvN+L2/lcAfI1
         aU4nadYfmMtMAagUlF9VmodPOITPsnjTJrV+CHQmh5hHcGQh2lreObNZsh2jGmuK6RJO
         k3LybBfRAwJI/e3v6Kpgt/mUPhwzeQFIowsbQCXreTuxWdTGBoGS2EyzTELhWmDLKgxX
         jdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vq1U9GjqlLaE1luvm+2+lTRtK8LC5SefbckzjbDafrI=;
        b=BmKu0hg7CY99lK4X6TqTu8Ei28mkMFxMwbGJV7ZMHGaYfIyuHlEWawNe0+3UehrGni
         pYdnj/DuXem60zTRNsbW4MUklXWmt7aHRW2lhMGXl/tZgqJy2hGDbQHlLgSUypec8InN
         lBEJHWotYmXxYmSXxnF8xAjgX7vqrp3XxuHjRfqWtwJSpMujPVRaq5UcdorQiU13Mq1U
         QdPuZjHWATYFrXzGM0Bc5y9qflh0SWqsrU3/fNbPqEAr6VpJIQOtSZZUdSqBorvBhSoN
         PCdk6tvVCoh7RmVVJf6FUlUaqxAXz3KlX5DdAQ+hO9j59S/xpyf5hLNMwIyakU0zOGia
         cBHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpMn6/39I+xBwbpONwPU8LXjuCCtpE4tmOfv4s3E0frd5gPxyFJfCwaB4qTq+SdjjFPI1W+7A==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Cc: tglx@linutronix.de,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/6 resend] fs: use << for MS_* flags
Date: Wed,  2 May 2018 17:42:34 +0200
Message-Id: <20180502154239.14013-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367741623278537?=
X-GMAIL-MSGID: =?utf-8?q?1599367741623278537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
