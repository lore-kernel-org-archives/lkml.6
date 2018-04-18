Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043652; cv=none;
        d=google.com; s=arc-20160816;
        b=XjwBApbctww1QerhRHJW880VeWY6aP3Xfzm6/moMFb9XZG+pCPhjv/mZ+BATyAia7J
         4oYfZkKRGWHVg1MIA4HV5kwo2//lsE4HKl9fwlvBKDldjL4uwr4s7RVvmziBzmiqPR41
         c5/h6Nc/E7WhfpSsOIawGDW6QQRKwYKZf745pIl9bTnMjF+5txLhlgJlGY51xZaKt96H
         1p8dc3hXj5C7vDEJtiFe7LxO2Gubw+N8klHYX3V44YaPfQ6p8y6MPNV0lvcQsWyS/ycS
         G/bPmJ0Www9O1H+VoLco3gvAwIKPsfxE9frT4vEbJ86CXOYk02zK3RWubZh5EXd5Fboz
         zOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=B3GoGn87dc0IcAvXmnmtQNYTZyenaafcf7e2xF5ClAw=;
        b=f7as/hS7SQj4devi8b6+m/ebjOBG4gPNKFy/Jd7EA0MabFy3lE4/OrsFtNjSTt1fir
         XjA1tEtugOK9eZcg08RCoeKTNXk+TKKmz11wCDer+3B+CuL8IpHxSSJkLbGXGn0Jt1G3
         vEvzJxh6ZPCwmcB0L3jgqN/RY2RMrmaxIJpDpULsMFxP9NMpIILf+Rzkn67T8EHASOT8
         m3rEqSeCpXFUrF2xMnKuIxCtFMUF6Hkx/n8FrE+Fblwwk3vcLMdMskfWK+RD6IBrTrdZ
         9uEcsrOJb6Jj/9tBZ1PLN5cm7NRNcQiRd3F8BSEaeLqhEMP8ofXNbvY0Cpa97kG1Ybrl
         2HHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4/n5fHa7pPl5pxV7xJMYhrIIELK7RLrR/u7cNU3GH1lVKYrwZ57RnreLxNChS7rrhIIaPz+gg==
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
Subject: [PATCH 2/6 RESEND] statfs: use << to align with fs header
Date: Wed, 18 Apr 2018 11:27:18 +0200
Message-Id: <20180418092722.20136-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075596435924970?=
X-GMAIL-MSGID: =?utf-8?q?1598075596435924970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Consistenly use << to define ST_* constants. This also aligns them with
their MS_* counterparts in fs.h

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
