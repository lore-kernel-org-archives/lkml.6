Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZq8shrzl0UlduASySwEMnTZp7fOw37cwKinKexeMf3fdXewSQUEpxlwZj3bwepaABDkb2Z4
ARC-Seal: i=1; a=rsa-sha256; t=1525301453; cv=none;
        d=google.com; s=arc-20160816;
        b=l4LVqSvOw3tiAcLWZ6/WS5qq8FDzaXfXvgwc5keZIGCzMPZsMKa+q4kshSz2CfvLHh
         yPsV9xs85oLYWnDbCz4uNK/se3t/rSbYLqLBJSOTVhtuNP/TV+d6Ol5y/6WCP+dshAnP
         23s1OVFYyjj8fc236pikF2Cy94w8QtfIDdDVjcZ70sGPlmyV6bEWZNvwlK9tKyjPkqfh
         +loNdTAlDFxTLM6C9PE++Pg0v+h/LL7SjpTBAHO3kRGxiPl4mnvQ50lOMf6HGc9rP1Y6
         guhAKT9He54YH6fOg3B481LpnqMr6zdPtkAnW2EViAQOEeafsMumYPbB9EokWWvvYZpi
         IAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=ggDfkzu+suD8nCQpszt/+6rXoR/bTJTIfstsJWVoaQo=;
        b=qubZa+vO2e5VV0CjXrVtDwVA0LQs8P9/E2e2J3xUP8bkqKNIATTkT7103OpjUDHZC8
         ysolzYvKi7pTRiKy52al3+ywEdPRxQ+TcLvCNBMARfdzdeNESTxWfuj/NBgYsOEcWutr
         56Oqio5nUGi2FNfWqwTIaLLbn/Aaaq6FY7oNRy8FoZGJFrgvnvHKBcP+K2n+3UEUKr+b
         Ux6iHAKv3zoZsKcFckhJyHWppeqXmj+RkEUQksvBtaYs+XLW88Q1KahLqLuWdQ6P3uMQ
         1DuVjtnntNSeQyKfda9qs4clMKxrTPqeNt05puJ/Ly9+6xfk30W/EYEDCe+d8M/vvYPJ
         CLEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=looGG4bu;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=bCsjyJ6l;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=looGG4bu;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=bCsjyJ6l;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:zEDqWoxBVxoWsA2wPT7vMakm8wDReR7J0xfLUHP3d1NwzUiXmtEUJw>
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
Subject: [PATCH v2 1/4] random: Fix whitespace pre random-bytes work
Date: Thu,  3 May 2018 08:50:23 +1000
Message-Id: <1525301426-23543-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525301426-23543-1-git-send-email-me@tobin.cc>
References: <1525301426-23543-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394497127048669?=
X-GMAIL-MSGID: =?utf-8?q?1599394497127048669?=
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
