Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeE1BrT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:47:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35227 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbeE1BrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:47:09 -0400
X-ME-Proxy: <xmx:nV8LW0zEiruuw6k5wNZacddSKLE2j7_Oqv-ECIjqyO0wJgO2-FsdTA>
X-ME-Proxy: <xmx:nV8LWxHr3LSJzlzy453ki1ULQsMDw-3gdqaoGO3GpnGabTl945HCSg>
X-ME-Proxy: <xmx:nV8LW85JFH8ItmOD1ds9sIvQDDGbAnknvzDhV6s0jLilna3IKaGcEA>
X-ME-Proxy: <xmx:nV8LW_4V3vNXaz5ywv7SoUkEC_ElzRh3ftfHYDlem9xaLIN2hBi48A>
X-ME-Proxy: <xmx:nV8LW_t73ImHyhcvSeFaXe2Axxm--F5HSLBwqO3P8_7jOGbQB7-j3A>
X-ME-Proxy: <xmx:nV8LW06McLZh84jhwFlV_d3sryBrR5QkbUasXEhmV_F74bTYKSjPzg>
X-ME-Sender: <xms:nV8LW2QCb-VJY-Hhio383El1V_g37G3UzfeDTu3KgBTUtDRoo5QRMw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] random: Fix whitespace pre random-bytes work
Date: Mon, 28 May 2018 11:46:39 +1000
Message-Id: <1527472002-11571-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
