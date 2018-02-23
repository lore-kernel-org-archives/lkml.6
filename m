Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs3ptKt1Dg1x0gjMC8lT6z3lB9snb89UuXLAP/K0CMMV6rQtwt7IvQMDm0EvTwMZppG24ee
ARC-Seal: i=1; a=rsa-sha256; t=1519411745; cv=none;
        d=google.com; s=arc-20160816;
        b=Wyn9xbfvgn8k2wHi2vWT2XIB6mvYMV7oox2b0vZ/lvG+YFgoaeBEWBb3DYQ/nPoz1n
         T7VPZgX3XWxpikhAATAb1gusJNiMj7+f9bs7zb7CDAaw2pMKNpUv4/HgkrT7DQ1kTgqo
         a7PreFHfs4wmIfFDDY5HSTFxedji5M8zzOdiIzLGgiNz1WRFxn9hHwQAz0MMVpE/09sw
         lMtHWRIt0BhtKovrCGF6c0qhRI/mEXq5Z861RFBXx28V3DkhdhluPw2v9rFw7sjLmFJa
         yaEe4sdhFKe4xis7sGz4cg2lVh3h3i5ELyMxF/HSyD1FXw2aTO2y3qdN5ks+hzmHr2ay
         9Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=59Sdscd+OePbmQsuCO84mUj0y2gKVI3/DPAgnua/sfM=;
        b=LKygP/ORu4IMYu5a/64k4rFYKzkAAivKmWAsuOrYXMOQlUT+iwtsJ+Lkf8pYe6HCSH
         3vOUErhtK/eNoAtfKVFjsre+5su54IIxR5dyAwlMk0wIUXWIbImggWkWVnzKyvlTwSpo
         uRPlnJGv+4WsqrhyuK1hhgIkP+QvepVbGzFntrpslhwCH2vqTjgreKCkHIqW81B9UEAG
         qVklwzVIrr8kaZBJPWIIWtCyg0KEtHgIIn1ZNPDoyjtGXQdkfsC02KVvsr8eZW/0MFQ8
         QaGdxUzzx2y7749WugUULw8jVkmZ+kdRcSix2rU4JhYNI5NJK3DlDq91lYp7uhDirubx
         euIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 126/145] shmem: fix compilation warnings on unused functions
Date: Fri, 23 Feb 2018 19:27:12 +0100
Message-Id: <20180223170741.140492106@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218690445037907?=
X-GMAIL-MSGID: =?utf-8?q?1593218690445037907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>

commit f1f5929cd9715c1cdfe07a890f12ac7d2c5304ec upstream.

Compiling shmem.c with SHMEM and TRANSAPRENT_HUGE_PAGECACHE enabled
raises warnings on two unused functions when CONFIG_TMPFS and
CONFIG_SYSFS are both disabled:

  mm/shmem.c:390:20: warning: `shmem_format_huge' defined but not used [-Wunused-function]
   static const char *shmem_format_huge(int huge)
                      ^~~~~~~~~~~~~~~~~
  mm/shmem.c:373:12: warning: `shmem_parse_huge' defined but not used [-Wunused-function]
   static int shmem_parse_huge(const char *str)
               ^~~~~~~~~~~~~~~~

A conditional compilation on tmpfs or sysfs removes the warnings.

Link: http://lkml.kernel.org/r/20161118055749.11313-1-jeremy.lefaure@lse.epita.fr
Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -370,6 +370,7 @@ static bool shmem_confirm_swap(struct ad
 
 int shmem_huge __read_mostly;
 
+#if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
 static int shmem_parse_huge(const char *str)
 {
 	if (!strcmp(str, "never"))
@@ -407,6 +408,7 @@ static const char *shmem_format_huge(int
 		return "bad_val";
 	}
 }
+#endif
 
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_split)
