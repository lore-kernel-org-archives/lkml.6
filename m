Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275938; cv=none;
        d=google.com; s=arc-20160816;
        b=DBoWp1cIYtuBbI2bc2LBrdu2heekOOeZbFkiOitCCzKdbcnWMWgx3lPlkOBIj5boBr
         hb2IH6T2NawTAw1MZvfpPo++J9RqkmiKPdabyUm5rj1rprJUNXOYVU2zNWLGUHgEq2Cv
         E598erg/GQ2pCjy0vdk57QaXtV4RjMlbWaV5Q91CYmtG0VMxMasac75LWHeSgF+dh1bN
         z5E8qhIF7YpKi+USAbJ8IY2DLIw0x4U5O/L4TP1nO4Rl+47cZJhu45edmfh2aoXxP4T2
         f4c+v4xUJMeAM8cuJjFjTNN4lbkW+LkNn7Mr8HDNc7lz3TFcC44bm770c3kbO7F2RWFj
         7OVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/IA0auHZyTc3bR5aXR5DkfwrT9FOzkYDJKkPmZWnj2w=;
        b=gdcxbrrO/SoGS3c/6Q7jaU8Ayf55sMF1AmOreAKkIGlwrdtWL7ky9W5K7Evc1495hk
         5E04yjjZ+y1Fysw4aqVcYdWAcXRSOSQYOpc7yJXjiATxA45dA+0Zj7yBfGtBkDdO0rhZ
         ndFfgIVZCU+egWp4Uo1lRv73p+cglBeDWQMFkLYYpocfJtifr2YCVqHUlMsPH3m6mwAy
         FXk7vFTwZMIyeiVO9SJdebGBw+qNh4oRAgB7e7YTsHungOYMqheUg1P67v0n8gHgKach
         qNN1jP31ElTIA/s1USVzF1sgFbyJb7jG/r7YhMGzPOFkqz+U2jh+X5wbp1GM5ZiY/MvS
         OmcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZqQ2VqqBvbLCponpvQB+kL5R5sJLiS+mo0+tglvRim72u4ee2RJiIWY0mJHa2HHvBIaruUmKg==
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
Subject: [PATCH 2/6 resend] statfs: use << to align with fs header
Date: Wed,  2 May 2018 17:42:35 +0200
Message-Id: <20180502154239.14013-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367742714366334?=
X-GMAIL-MSGID: =?utf-8?q?1599367742714366334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
