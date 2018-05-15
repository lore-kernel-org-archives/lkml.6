Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZrkoBdD4SfcSU4DnMsTY/9VVHMAWYb21h9GE5KV7IMvVFVq8FvGtDK1go0RHkELfMOB+PSZ
ARC-Seal: i=1; a=rsa-sha256; t=1526426286; cv=none;
        d=google.com; s=arc-20160816;
        b=klkmu87eYENGcngjtwjnLGZP+wpvFZr+Q91ruXRaWlHj8vs9QJppb6U4fpJTtNGPjT
         09rMe/WaTRfgW8TnJCExqs9soWYjcQCJqsZUIJSQ1WrlHM+FWo64y7FvxTWJXwLwFiBh
         S4EW8GxIKT/rqMSrV5Oz4fhiLKvQlTOLsGE2Brgh+r0eV2LERqr/MkKYvj9G/lgEJOMO
         r4nRuDfU0ChQ/2MxscFvYPEvZB+9nWn0z889y+xngSofT218/XCCN9JiWxNjWSrTYfNz
         cG0o+7ZMPY++hz/zChFXw/SQyP7GQzIvHMs/6QggacTkc6k1Fzw5+w0czDsbrF5R4/X4
         RpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=ggDfkzu+suD8nCQpszt/+6rXoR/bTJTIfstsJWVoaQo=;
        b=xto7cxadUBamRihCzTJvUQxLonF4EGNTjWUrFEivqzLDvOk3QNpwjUDTt281icDBpy
         Ub0rn2CHQJIr+uQlS1O7O+tjw8xFiuZ6XbgxtkL7RJtL491aIfXo+4gdxE/HHNtexvgv
         XdOzyNJ/RRIIED8FsHJFGTkoKz6NpO+CTo05aRbaM0QajXbTherVPMryTi7e2H6Onki4
         ZQdHjDDH93i+XNoUOkarmzH9r5M1jbPd9XhcXFKn7+H9eh3cPI5dE3tTVKTFsgLGrTEW
         PXBR4sks9CqU1CcYVydQuoamXdCeA9YiAwP5cA0WVKYN7XPzpXqGzb8xRTbJeECCPPai
         sUzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=Pvh+p3g3;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=RbOEgnOH;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=Pvh+p3g3;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=RbOEgnOH;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:rWr7Wrq08up5N_IMHIy-8vwcAgBsNppIuWqoWxW27pogE-Hx3lk5RQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] random: Fix whitespace pre random-bytes work
Date: Wed, 16 May 2018 09:17:37 +1000
Message-Id: <1526426259-23012-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526426259-23012-1-git-send-email-me@tobin.cc>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600573969366176066?=
X-GMAIL-MSGID: =?utf-8?q?1600573969366176066?=
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
