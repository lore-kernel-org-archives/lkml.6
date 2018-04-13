Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523635911; cv=none;
        d=google.com; s=arc-20160816;
        b=MwlaYzDzD+ExAScbmuBqmOd5u5BsZltCV6Qu05uCom/7/OJWfrxIvif72WZqw6mg0Z
         LfoZsm1suFq5hdZTOncAl2QwZBXxl3dMDDqYoldhhrkfOip42YR7xpHqQneNalgdT6TN
         rjSpAOYWiDm5Eil5RJD0beRIbgqwgFKSwT4E3qb9s164x3GNBghZetPMdNl79U89Iv/W
         S5KKdqESoF6DwCl9MHZUtZZLRvL/u4YDqB25/v5DeWpTUc3L3LEdJD7i5FUh37nR2cNS
         K9S9d8SPJDgT+0jZmFg14lSYBCXxpQFb2Rb/v3wq+rCCodkzYseU8aJN2TUtvTuJaHUf
         cu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8KDADTlBg4Z43JfcjkH5Utnvi/TojVBV+acRcHCU3wA=;
        b=OTnJgXi916dRFUsiOJPd71uu52GCgGTyIwCXfOct53pMCsRU+2OFV3O3/kvrZa8teq
         BgFa7wivOwfuWrUUsawPGbpXPA3JovIVGWFXq/NjRvUuflk8zhnv5vSDUAPwKgVyTXPP
         0lUzM9UDCiWuYgMw3MbOKC2voYy7abLHKPBm5vpWAdZn48Y7i9oOsvKpQwfS+y0Ee4nj
         JJOi0+eo3A289zm8gQNm4N4TVzDjGRfZ8/jh8pCv8r2IEn0Fb20yoDfr28TkqpPSbCo3
         ecOvBTY/dLRnSdHKGcCcmSAdFmYBNFiLoel2LLXiZxGsTucfY8Ruuv89K5MdhSDFKR3k
         1kDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AIpwx49WZm/M4rcy+IjaKSv26yksZZVCS0jUE5QtZYL3stqNpIrMmOcuDvNelM6psylo/3B1vv8oQw==
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
Subject: [PATCH 5/6] statfs: add ST_PRIVATE
Date: Fri, 13 Apr 2018 18:11:25 +0200
Message-Id: <20180413161126.31313-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161126.31313-1-christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648049708525580?=
X-GMAIL-MSGID: =?utf-8?q?1597648049708525580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lets userspace query whether a mountpoint was made MS_PRIVATE.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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
