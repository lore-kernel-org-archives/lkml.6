Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525275939; cv=none;
        d=google.com; s=arc-20160816;
        b=JisxPJuDP0sUfPmGGH0tH+3cY04S0P9PrkZNhzjizfiQXEoDOz9W4AVim6pQ0VwGiL
         JFasz+lHnbmrgd4W2YFcXpHbqOszf2sfaZe6GK9aEIDSRzqFHE1PnaX+IAx6cpF4+2IP
         ff15N4lxMK5EUKkGRgo+hzIED0ytuOP8gYxHB+oimrengVvdnUjVyms8KI7rZLzxK6QT
         AmESdzBSY9NdC12TXo1PfObMUFPIaXROs7l1tjszZTf+KKSiut3+BX2AufdthbDLYOmz
         RMaD6/yT2Kp3A4Gyom/rIjKLsLvGRACymWo/RThGbxCM1N1MRONZobnuqbb2sfk8n1uK
         atCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Dj+2Cxg/uq1k/vjjQWLe2eEAN5uLxlTlaKS/jcLhPKY=;
        b=m50qgpzer2x/5/kAK0lzN9rzcOLK23RPlBgYHC24pfKUr3LLPikEVJI4ILKAHWKLLa
         znLJMOkQRSyApmuP2JE6JYfoVq6Z9a2psH0VC1FSEow+PWKxUgaOlGHGtABu7P5biOwN
         4CaszjtmUffmLs3qFM51WmO6VS3dB2gC/j4z2cNWT3L+5g89DGibyU8WcsLVTrDghxd1
         IWK90QwZI9ppFS27qXnkzPxhBi/lNHQV10IBW11gG3edclW5NJs2s5S6F1d9v7duORGC
         q/nh+BinuxzBTq7Ws2YcSYfyepW3fL6trbCjun5HLAUHnBdHvUf3rXP6nmJs0Fia5gNb
         gPbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZralKz7gbhHJaD0HlZx0koEt9z6ov3pm0v9uZlbK3Gzs9whTLK8i8NhaE2pFo6jqIKm261RHQ==
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
Subject: [PATCH 3/6 resend] statfs: add ST_UNBINDABLE
Date: Wed,  2 May 2018 17:42:36 +0200
Message-Id: <20180502154239.14013-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367743470515267?=
X-GMAIL-MSGID: =?utf-8?q?1599367743470515267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/statfs.c            | 2 ++
 include/linux/statfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..61b3063d3921 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -29,6 +29,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_NODIRATIME;
 	if (mnt_flags & MNT_RELATIME)
 		flags |= ST_RELATIME;
+	if (mnt_flags & MNT_UNBINDABLE)
+		flags |= ST_UNBINDABLE;
 	return flags;
 }
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index b336c04e793c..e1b84d0388c1 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -40,5 +40,6 @@ struct kstatfs {
 #define ST_NOATIME	(1<<10) /* do not update access times */
 #define ST_NODIRATIME	(1<<11) /* do not update directory access times */
 #define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
+#define ST_UNBINDABLE	(1<<17)	/* change to unbindable */
 
 #endif
-- 
2.17.0
