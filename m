Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpZpYpitvGswMkv5jSXEETNTQcuG0WF8f4ewiUJ8ExixbnHYQ2jQWZgbBDzMhBkQKob9g50
ARC-Seal: i=1; a=rsa-sha256; t=1525388897; cv=none;
        d=google.com; s=arc-20160816;
        b=GLDYSXFqfUr/u1ke3rvuTLDX5jHp34oldmca8yHL7z5D/bbOmAMIYCuO+DtRfEb2JY
         LwLuKcl74LiNyBN66bC97EfjgV/tuYGBrRiST18dSkWJVvUT/96HiWs54RsAmzaufhMm
         3gtAgilCNtRqZuSJeDq3TC9Bjz6JkWXAc7aCN+qKwA0qx/SoPqqBzpPnzS+J77rRl3x1
         xj0GuB6maQKop6KFqoEBNKZ0P6U+NTi8bre7JNT/ItwPH/wUqA0mI4C//a2px+26fh6O
         rm2BmWnYmNx1QZXbX7H3RhS/TgJVtYPBuhe5ZYQfC8LiPOfqX6DXpWquiv/12CaqvsOo
         5HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=ggDfkzu+suD8nCQpszt/+6rXoR/bTJTIfstsJWVoaQo=;
        b=WIx+TETCoI/RrtBkH/V++BeMk/QflyztAVqeceRlo1MaYaylSdlpiXW9VBLirqwcpv
         VWIRMLIMdM4DGsL9l/KfI0hhXGSrJ3nUKa00bU5Sne9uC6bq7dYhRE1PRday2svSU5+I
         Pl6c+IrMdTfBibmzUb7q6D++zLGXDvasfGnx2uIXQTfqS5JxTTfwDEy7S90bd04xzu5S
         AEJrwMPfPNhOdE2e459j+m8SeUxhHN3zmZUu8q/5/CLnV5I0f0BT+PffKoeig/HbI5gN
         zvVA+XMGR4+w44xVNWs18FXkMIxIlvarE8c0SUb9HJFNEy4T1Htl7nC0X+m2MLeuhdAf
         scZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=p4QiHD5k;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ko5Pz0Bi;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=p4QiHD5k;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ko5Pz0Bi;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:YJbrWrlgiutaVOHjk16XtQWwkuO74b6QBxn6mo5pseNsUdJ9HxSmPQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: linux-kernel@vger.kernel.org
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/4] random: Fix whitespace pre random-bytes work
Date: Fri,  4 May 2018 09:07:38 +1000
Message-Id: <1525388861-27018-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525388861-27018-1-git-send-email-me@tobin.cc>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486188377948666?=
X-GMAIL-MSGID: =?utf-8?q?1599486188377948666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are a couple of whitespace issues around the function
get_random_bytes_arch().  In preparation for patching this function
let's clean them up.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..031d18b31e0f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1737,7 +1737,7 @@ void get_random_bytes_arch(void *buf, int nbytes)
 
 		if (!arch_get_random_long(&v))
 			break;
-		
+
 		memcpy(p, &v, chunk);
 		p += chunk;
 		nbytes -= chunk;
@@ -1748,7 +1748,6 @@ void get_random_bytes_arch(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
-
 /*
  * init_std_data - initialize pool with system data
  *
-- 
2.7.4
