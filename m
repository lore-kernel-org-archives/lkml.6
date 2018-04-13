Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635908; cv=none;
        d=google.com; s=arc-20160816;
        b=aHmm3B08W6WgiOODuzhwWn8fS88zTJ2yuz23ySYQv7W8tBOA0WcK/DqPHGZdEvD3Li
         /jcG6suLwG5zpVqsjRhE/FI8bDC/86OcQyJgJ9JsZbsdZz+ETZFXFUJiJ9CVEd27gzoX
         uOoFAi6MOzYLhPG/RXQ7MB0GYUlUsfrpl+GPYvPPZTwni/hNqKFpF0/qVYNcbASf5nqz
         xQZZfqWtFBVAl96QXSYibG4H1mgJubTVxzE3MYK/ytQjN+gJ7lBGN2vvPQXJoYFhsPqt
         ztCQVrvkGYT8PGzCI891wWHaTlajSl2xvDPXWnO1N35fO1lOwM2nqECYuV63ZOyTnD/m
         miNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gUFd8NdHfoK6QD2SIr8dl1d2y2i504U6BtEy1flMYRM=;
        b=ye8rdw6tUPocoUfD3sJwXtAJoEjETiez3H1viK9Lnr+hqKZtVy41o1k2ZIlRxq9b/Y
         anuAlw37tfx6H+NbtW6NhUCeLWDTkJQKa63WCuohT2gXJjFZkGgjVJ70YNxKRNl0OxsR
         C9ZvQVYPTsqcPoZASHna9TZZGhuRzc0BFsvrA0SjcQ6GVCac++NTjq+kYWi7vZ7mp4LV
         aUoM8KbCyqf600sQpH06wtyurG47xcW7OUv0qiODbI1bvtehgDPIJPvoeh7ToOm3IOzX
         +0Bqh/HHzgfCkSsiwwlTyslftLsUeE8owqvsVFzRD/MW40hlhh4DLbN9jxb1cntAtUUg
         3ngQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49lWkEdQgYDlU21g9MVeynxZSdoGIkk9EcVVvCq/SBpNflB/9JzPGDYyLheDSswmDhriCNpFQ==
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
Subject: [PATCH 2/6] statfs: use << to align with fs header
Date: Fri, 13 Apr 2018 18:11:22 +0200
Message-Id: <20180413161126.31313-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648046265390168?=
X-GMAIL-MSGID: =?utf-8?q?1597648046265390168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Consistenly use << to define ST_* constants. This also aligns them with
their MS_* counterparts in fs.h

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/statfs.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 3142e98546ac..b336c04e793c 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -27,18 +27,18 @@ struct kstatfs {
  * ABI.  The exception is ST_VALID which has the same value as MS_REMOUNT
  * which doesn't make any sense for statfs.
  */
-#define ST_RDONLY	0x0001	/* mount read-only */
-#define ST_NOSUID	0x0002	/* ignore suid and sgid bits */
-#define ST_NODEV	0x0004	/* disallow access to device special files */
-#define ST_NOEXEC	0x0008	/* disallow program execution */
-#define ST_SYNCHRONOUS	0x0010	/* writes are synced at once */
-#define ST_VALID	0x0020	/* f_flags support is implemented */
-#define ST_MANDLOCK	0x0040	/* allow mandatory locks on an FS */
-/* 0x0080 used for ST_WRITE in glibc */
-/* 0x0100 used for ST_APPEND in glibc */
-/* 0x0200 used for ST_IMMUTABLE in glibc */
-#define ST_NOATIME	0x0400	/* do not update access times */
-#define ST_NODIRATIME	0x0800	/* do not update directory access times */
-#define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
+#define ST_RDONLY	(1<<0) /* mount read-only */
+#define ST_NOSUID	(1<<1) /* ignore suid and sgid bits */
+#define ST_NODEV	(1<<2) /* disallow access to device special files */
+#define ST_NOEXEC	(1<<3) /* disallow program execution */
+#define ST_SYNCHRONOUS	(1<<4) /* writes are synced at once */
+#define ST_VALID	(1<<5) /* f_flags support is implemented */
+#define ST_MANDLOCK	(1<<6) /* allow mandatory locks on an FS */
+/* (1<<7) used for ST_WRITE in glibc */
+/* (1<<8) used for ST_APPEND in glibc */
+/* (1<<9) used for ST_IMMUTABLE in glibc */
+#define ST_NOATIME	(1<<10) /* do not update access times */
+#define ST_NODIRATIME	(1<<11) /* do not update directory access times */
+#define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 
 #endif
-- 
2.17.0
