Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukVYi0qHW7yG0m2aBOoyKmBnyqiSEr0+kXNv/srNSUXd9fu+wSay0shBtmtHYK3a3iuBNH
ARC-Seal: i=1; a=rsa-sha256; t=1521483306; cv=none;
        d=google.com; s=arc-20160816;
        b=JvXU4Vx/P9VF4AVh143fHQGeQh6uCaWFzWSBaZTUItrARwxUtM7t7Q1xMH1RVFDtP0
         +lt4C5KjSl15qWLubVLDeeIU+agTGhI1Z5wnLp7g9mM/CE5Aqs48WteiDkQ+ExmXxxKL
         iSQsBQL2xfgOsAn5bKmjlC1sFTtqSjaOgQCxkLH8UUPZFkHeSQLJvdBrWcg/tOYumnjA
         or5YgimNGrzFtaXXahNMu2bA6Z8S7Ggyxm8kKGcOKtOtcsEhF5Z4K/XQhFIgNH8jAlZ9
         8xiQAc5EDCRNxzhgvstKM3NbHC0NSLXO1EeBLzqG7hFcd3z+mrBNBuMSqb1uj34D6S9P
         gvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TOeV8o4CuQ9wwLCRRoo1ryUuhX2Qvmse8XrEb2UAMe8=;
        b=qRDfSjExUbmeSSxAB0zcTOPSFh7qBPMvGBoElqg/cXqmYs4b6GmLec22YPqvlvddpt
         0rIRRu5LhLBei8kMq10R7YDdGysz4s5hFokINzNjJGnIJgo0hUU0uIlVEfHvQ2y9MXE6
         uDvtORQ53egYrcqui4LncV/x5zSGzHANyABZ1M05roAtQetAjPNB4M5AX0oHz/3Mcf1X
         dh1SX4S2UaI4P9xYKHd5Q2KsoTzdJzkkdMQLNgqSmdCqehI2zcu0MMBoQPh24eT4FzZv
         O6CUO1QxyBDRXnVOGwBpOrkGQDHBqTSEnmw4lQ3/9EhfgTMiXNnlD+Gt+kFl+uPoTiib
         TSxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Aleksey Makarov <aleksey.makarov@linaro.org>,
	Joe Perches <joe@perches.com>,
	Ming Lei <ming.lei@canonical.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 042/134] braille-console: Fix value returned by _braille_console_setup
Date: Mon, 19 Mar 2018 19:05:25 +0100
Message-Id: <20180319171855.461834353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390537392999945?=
X-GMAIL-MSGID: =?utf-8?q?1595390879675536962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Thibault <samuel.thibault@ens-lyon.org>


[ Upstream commit 2ed2b8621be2708c0f6d61fe9841e9ad8b9753f0 ]

commit bbeddf52adc1 ("printk: move braille console support into
separate braille.[ch] files") introduced _braille_console_setup()
to outline the braille initialization code.  There was however some
confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
("printk: Fix return of braille_register_console()") tried to fix it
but failed to.

This fixes and documents the returned value according to the use
in printk.c: non-zero return means a parsing error, and thus this
console configuration should be ignored.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Joe Perches <joe@perches.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/braille.c |   15 ++++++++-------
 kernel/printk/braille.h |   13 ++++++++++---
 2 files changed, 18 insertions(+), 10 deletions(-)

--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -2,12 +2,13 @@
 
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 #include "console_cmdline.h"
 #include "braille.h"
 
-char *_braille_console_setup(char **str, char **brl_options)
+int _braille_console_setup(char **str, char **brl_options)
 {
 	if (!strncmp(*str, "brl,", 4)) {
 		*brl_options = "";
@@ -15,14 +16,14 @@ char *_braille_console_setup(char **str,
 	} else if (!strncmp(*str, "brl=", 4)) {
 		*brl_options = *str + 4;
 		*str = strchr(*brl_options, ',');
-		if (!*str)
+		if (!*str) {
 			pr_err("need port name after brl=\n");
-		else
-			*((*str)++) = 0;
-	} else
-		return NULL;
+			return -EINVAL;
+		}
+		*((*str)++) = 0;
+	}
 
-	return *str;
+	return 0;
 }
 
 int
--- a/kernel/printk/braille.h
+++ b/kernel/printk/braille.h
@@ -9,7 +9,14 @@ braille_set_options(struct console_cmdli
 	c->brl_options = brl_options;
 }
 
-char *
+/*
+ * Setup console according to braille options.
+ * Return -EINVAL on syntax error, 0 on success (or no braille option was
+ * actually given).
+ * Modifies str to point to the serial options
+ * Sets brl_options to the parsed braille options.
+ */
+int
 _braille_console_setup(char **str, char **brl_options);
 
 int
@@ -25,10 +32,10 @@ braille_set_options(struct console_cmdli
 {
 }
 
-static inline char *
+static inline int
 _braille_console_setup(char **str, char **brl_options)
 {
-	return NULL;
+	return 0;
 }
 
 static inline int
