Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqhJGOsdhsPgfixkPzAebKUvrYuyPOpFZvLfdtMtmLgF1+Lc9BjolJMAwqrtlnpWyBkctPu
ARC-Seal: i=1; a=rsa-sha256; t=1525217664; cv=none;
        d=google.com; s=arc-20160816;
        b=KAsQ9NM3ZjLDqy/IEejipqStnV18w0oIdbaV0O3Kr5i8brtnDAFKW2oy6Uj3UXsJQc
         ljENP2auWOUzw0kywuOdmwJnSaec9flNRE/lEgn5fEzHEEDeG4RtNqAb/5nNnKlIQjAT
         S0ErNYjnXG7PbuEkbeg08IU14cHWgbxsl67wdsSctFw1d/dr4axuAihOO07shz2o8JEm
         oBnkUeDMW+l2/0xx8KBYGLLaCyGkyhis0yiJou+9h8NVyTDzae1OkwyugCsTppG4VZjI
         OU4lujC0pAg+tGsn310ZBUai40+9DD8h8Q5iPRcKMXgzN5ajzVKjleZ610MELuqXbHLg
         FhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=Z+v6M3+dZPTXHIBCGBi4C5qs9f6cKe6rr2zHzqfqu/Q=;
        b=fc7AsWzDLZdoNTH4ODiaTfdn+KNR0F43wY/Luqc07633/cteo4m0OXL4f2S8mIJO8K
         eEJAWGcYqAvNLBWxY0FQyrtpdESXiQhqWHOipeJZnZtUcDhhz8+VFVRdgVoaWAuyJrC3
         QydkT1GD0z3NIgWJK72Ag0611SnReBh7B3pTvzoghRe3HTmMA3WH+1oUbwaFfw00vkzY
         prvrVybgzy3+YTcCeDF56x0D5oU/LlGNr1wK0pLfJRSMHXSzQxZF8wRwARloqGgrtVPD
         faJJoyj0X2zsOYG2sjtJ63pymIr4Zg4wD4SbMSzC6iUGdrElMQezK05QETz8HyUb3E2f
         xNjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=qgV+TQ7S;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Xg4JmYIf;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=qgV+TQ7S;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Xg4JmYIf;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:gPnoWugCoBzP5q9KG-Ca_uHxBzSxvTMlRuzS0_M6nAy_wr3qNLkUhA>
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
Subject: [PATCH 1/3] random: Fix whitespace pre random-bytes work
Date: Wed,  2 May 2018 09:33:38 +1000
Message-Id: <1525217620-4107-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525217620-4107-1-git-send-email-me@tobin.cc>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306638182795864?=
X-GMAIL-MSGID: =?utf-8?q?1599306638182795864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are a couple of whitespace issues around the function
get_random_bytes_arch().  In preparation for patching this function
let's clean them up.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
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
