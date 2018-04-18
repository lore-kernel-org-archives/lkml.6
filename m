Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524043654; cv=none;
        d=google.com; s=arc-20160816;
        b=sVDuQzJLrbixZaQ/hCX1LyEo6x4VAdmVm6+PGvOjtsdtQA3zhWKyerOc0oGDOQwnTC
         xFyVrhMsN4OFBn6AeGU565KfvGnpxZjzemWCM6OzPufnXVqFDLln/OHaAtzzlBYCXm+B
         5Xr82n6aXjbcsmEwGyRgPIW5zdp4IXHTAAVSoncSDKipYOECjlrffXGOJKO7QEPhWt2P
         ZbWbZ/GkLx9sdWoxIvj8mxVURGiN3Imk/F4VzW+yAor/6u6XpyWNn18ZGeoqudWioHqT
         oYkvOg05rus3nWq9RDV9Bhks138EQMjUWr85kPcXaCSkSdZtjVwwxc5afto598F5Ll25
         ZuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Y9ImTX5Z7ixP7InZU8GHw6ppf1T3NOu1OskDToCK7KQ=;
        b=Qkg4YCT0jD9TPjPT7B0V57aQNciyPr1Sem2kWk91t1NMNs1NaUDX9FBBaUPZhEv5k/
         wsphUC4R3HF1pDWEj/QCTHdkHM5mdIPMndWo+a5AhuZKfITu3Avm0SK6/YX/M1Dg4WlJ
         NPCluFn2HviXHWyMmlfPmtOxSdIj2gyr5Zj5fqmWUJI4zZuEklLLTTteunaKd8Gln419
         mi1I3L6pzI8tSMi0xmJmJu+VlWwkFrootHq37e20Bw3Gzxwf872pAYQJfvNtd/wDyRC6
         fY2/cseOz2bTs8P2Ict+9HkyQUo0VOfOyyQUf/IrwYV3GPcVvJljXX6CffUicSGsdTLz
         XpOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx4/w616KzIjsjGvTfVu5ODzaiTbBwDxVN+WzLNRr7FrA/4DJo2D46pKFdOO0r9UPcqUT6wieEw==
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
Subject: [PATCH 5/6 RESEND] statfs: add ST_PRIVATE
Date: Wed, 18 Apr 2018 11:27:21 +0200
Message-Id: <20180418092722.20136-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418092722.20136-1-christian.brauner@ubuntu.com>
References: <20180418092722.20136-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075598879968593?=
X-GMAIL-MSGID: =?utf-8?q?1598075598879968593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_PRIVATE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 2fc6f9c3793c..26cda2586d7e 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -33,6 +33,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_UNBINDABLE;
 	if (mnt_flags & MNT_SHARED)
 		flags |= ST_SHARED;
+	else
+		flags |= ST_PRIVATE;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 5416b2936dd9..1ea4a45aa6c3 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,6 +41,7 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_PRIVATE	(1<<18)	/* change to private */
 #define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0
