Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275940; cv=none;
        d=google.com; s=arc-20160816;
        b=ms5zkb/XqQzfmrTARerqTZgrjYJ+AnjQzqRl7MwHAqT69H0JndfMh12hI+XKI2OM84
         cj+mpmubEfH9X9K7zQ1ElZuxie/EU2yGYp/2jNtn64t/4ielyVAYquiEpaW/m23IbAsu
         UBvo4/f+odBYWgMpU0y3ETSfBAK5ehFUKTgalaj/fef/bHZ+nx7QBuPWYmv7cXf0NHmv
         QVc2I9+YVJ61p+mMpMe2PDLx7cF6v+xKomS07hIQCi5nBpdwMM2IjscborfQBnc1N/ap
         r4rynbnYv/YmajGoqAfFKGAs8Hl01ptQYSq+ArJQHhPdvj28drztoTv2MJNzyJLBBLGJ
         dhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=IMf2Pr1TxcF66z3wx6sc/5l5PJQpw/ZqZjzXFeue0Jk=;
        b=B+naAWyqfBHBzDqw8Cp97QPNRGap4mUPTevkQTPZh/jzjohkO0NN+9bKa9Bmzuooel
         Vv5ONiDuvcix9zIxGQonW5ycGlzA3ffIyimRQ4cudcJ90/jtUmkqQsvorCod9NAX0Rtg
         j9z8a0enfAdbGZ1xKMT0Sbp0rvJpBuQHwLlZDDKWAZxzdN6klzRgAt1Z5qqvFQ5xjhoR
         EY0WRWC+FjQ4JnxZiuAsweZJPERpxww8PquOCVtDprhqz2smcjAx15X6pgieUbbt1m+Q
         QAfY+cE1qFobIT08Sbh09Ija8UOgZo9Jdllk8DHEtbj9QmoUCrYN8x4jhLeGGE2DY5eJ
         yGmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZoP9E4vvYQK/br3IYe/wRDuq11XiU4366qekTpaDzGVe0X3QW0JiOxnvXN3H8ta7DLwh57bTA==
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
Subject: [PATCH 4/6 resend] statfs: add ST_SHARED
Date: Wed,  2 May 2018 17:42:37 +0200
Message-Id: <20180502154239.14013-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367744442373961?=
X-GMAIL-MSGID: =?utf-8?q?1599367744442373961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 61b3063d3921..2fc6f9c3793c 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -31,6 +31,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_RELATIME;
 	if (mnt_flags & MNT_UNBINDABLE)
 		flags |= ST_UNBINDABLE;
+	if (mnt_flags & MNT_SHARED)
+		flags |= ST_SHARED;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index e1b84d0388c1..5416b2936dd9 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -41,5 +41,6 @@ struct kstatfs {
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
 #define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define ST_SHARED	(1<<20)	/* change to shared */
 
 #endif
-- 
2.17.0
