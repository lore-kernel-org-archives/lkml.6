Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqa4GHfKZmeSGXf9GY9K9nmkNz+Uzji3bVUg7LEY6upMDkOPh0UJXMznSnTJL0/YGE1QilF
ARC-Seal: i=1; a=rsa-sha256; t=1526353610; cv=none;
        d=google.com; s=arc-20160816;
        b=r/qBicgihWkl8uoISAa6269XzwEY3Bh04GOFExVA2a7SdwHs2owJbMekC3uFEKiGY9
         PKFYCgKEbNsmOV7Z7rOChR1i3d9G2Zqrl9P7UAHvVuQkSrzx12k8vov34vyZPL6RTBYi
         TvaDTKv7pxIufSPf4cfyfDkaCRIrTzY4UAvPv8lSKrz6MIYIcBRHlYbLFcgkNGmY4due
         FtpQ76j0Dc9h/PsZxcl51W+ppmqkCr/Skn+TK/cxzor9Ugf+mKuLiyjSMHyW1NZqg6/h
         siBg0B8NOuQO3a3cgqk9NCRIIy9wBwcAxROFChxg4wut8q0VmPwlvBp6q9Oh0jyGMLpY
         4zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=ggDfkzu+suD8nCQpszt/+6rXoR/bTJTIfstsJWVoaQo=;
        b=GHkPzMcj9ID11jVn2Cn2rh1KQ6STOuNTFjTwb4Paw1iT8OwOHLahqvVkzrlMjVFVJi
         7+0geteMbGdeSq4i07zJAm4swYTtyXybqTE+VCAQQ/kI0k5vfLrK6YKhHaYBepWI/I3N
         4/VMSJndGL3WL5DOfDVI+pohRHDZPmEcCloJK8/+zDGy2CLSW94kMLfErMOEbeV3PBuT
         zRw7a/MweYhh8Af10Rww2O5Z+GoMRCX3YS1eB9OAqHVEh82HiSWJqmyZSLcj/UYJ6yIs
         wksXxwTti4f9ZSSf7IaubcYiJH5j5nQWRiqg/+CZr6nCCDvZAev6kp2nQkLPVIcT+ppZ
         brsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=Xaar7x2d;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=IIWyIRjy;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=Xaar7x2d;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=IIWyIRjy;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:yU76WlATNg4hRj7DrT77bVw7oecWXf43t6maX11faWRuE3KOSsar_w>
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
Subject: [PATCH v4 1/3] random: Fix whitespace pre random-bytes work
Date: Tue, 15 May 2018 13:06:24 +1000
Message-Id: <1526353586-30092-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526353586-30092-1-git-send-email-me@tobin.cc>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497763395618360?=
X-GMAIL-MSGID: =?utf-8?q?1600497763395618360?=
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
