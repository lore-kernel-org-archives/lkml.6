Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440680-1521583467-2-11416291761280491607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521583466; b=n1XIygxI7CymHfmznC1Uh8t373YfMQmmGYW4e5a77zS4F5y
    UvUXphzU/REo1p+nRqOWzZ2u88PBDhvfsssdBB6KczQpzBU2aj9FIjtIbJdiXAG4
    wYB78BceNIwdgbxuaErb7Msy9Z3EqxxsR+VgsYfXPayCaMeWDG+eR8ha1iV7rXr9
    QHqybvc3J6A2YcGXsfrrVa5UlMGSpScm2z6oCxkTnRNMB7ZOykv7emuVDtiORe+x
    6EUvMfWgb0Wy8X3Huwb0eX+zP+r1ncjLYJ5Qi2yq/oKqv28jl15B4Mha/kJlJsQN
    LsnyengMouqrLb06LNTcIg9QxTpfcmmFKkxddFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521583466; bh=bmSsW+21cxjPEAtqSbsQrZvJsG
    wYpoqUzz+ihvpOcMU=; b=KzpSAO+hQxsEwgDL5cIGKlCpaXKfvppOcgbdnwpEyc
    GYviobifDAqWUu5ULWYdByk2ZAGrp6SPpwF65ig1rRWbhoFKmYCnsFzuMTaH5TXt
    bD3jVvAM7c6TluhykxSEgJkBvmwmP9Sq8slCUY0Nit1Z6FwGswNVlMEWZ0LCUsl0
    QoH7IhBjyFDY72sZSo81MKh4f5kc1SOc92qTlZ4agLYD/G7x0Qk9jKA3RlG1uyVh
    JDZE/mnRjqXVS4DSf/Yrb7wyd3g4/iPGIJFn1UJJ1kTSWR62xiQtbcTSnmgOkgio
    EUkyLdGfCm6UYGadPaxHs0EEZioBiZSMsUdofRPZqwMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oZfwmw03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U7IEKHUZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oZfwmw03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U7IEKHUZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCTWEO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 18:04:14 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34880 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeCTWEN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Mar 2018 18:04:13 -0400
X-Google-Smtp-Source: AG47ELuea6QlGtOltldOnise9XlAT4BE7cf9U986ctupbYAg3wQzWNTFjY2Y2H/HTxsveS03+7IUgQ==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v4] earlycon: Use a pointer table to fix __earlycon_table stride
Date: Tue, 20 Mar 2018 16:04:09 -0600
Message-Id: <20180320220409.19740-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") tried to fix
__earlycon_table stride by forcing the earlycon_id struct alignment to 32
and asking the linker to 32-byte align the __earlycon_table symbol.  This
fix was based on commit 07fca0e57fca92 ("tracing: Properly align linker
defined symbols") which tried a similar fix for the tracing subsystem.

However, this fix doesn't quite work because there is no guarantee that
gcc will place structures packed into an array format.  In fact, gcc 4.9
chooses to 64-byte align these structs by inserting additional padding
between the entries because it has no clue that they are supposed to be in
an array.  If we are unlucky, the linker will assign symbol
"__earlycon_table" to a 32-byte aligned address which does not correspond
to the 64-byte aligned contents of section "__earlycon_table".

To address this same problem, the fix to the tracing system was
subsequently re-implemented using a more robust table of pointers approach
by commits:
 3d56e331b653 ("tracing: Replace syscall_meta_data struct array with pointer array")
 654986462939 ("tracepoints: Fix section alignment using pointer array")
 e4a9ea5ee7c8 ("tracing: Replace trace_event struct array with pointer array")

Let's use this same "array of pointers to structs" approach for
EARLYCON_TABLE.

Change-Id: Ic42c4db0c8b034fa6aa2bf02eef0fdc159478ac4
Fixes: 99492c39f39f ("earlycon: Fix __earlycon_table stride")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Suggested-by: Aaron Durbin <adurbin@chromium.org>
---
 drivers/of/fdt.c                  |  7 +++++--
 drivers/tty/serial/earlycon.c     |  6 ++++--
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/serial_core.h       | 21 ++++++++++++++-------
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 84aa9d676375..6da20b9688f7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -942,7 +942,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
 	int offset;
 	const char *p, *q, *options = NULL;
 	int l;
-	const struct earlycon_id *match;
+	const struct earlycon_id **p_match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -969,7 +969,10 @@ int __init early_init_dt_scan_chosen_stdout(void)
 		return 0;
 	}
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
+	     p_match++) {
+		const struct earlycon_id *match = *p_match;
+
 		if (!match->compatible[0])
 			continue;
 
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..22683393a0f2 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -169,7 +169,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
  */
 int __init setup_earlycon(char *buf)
 {
-	const struct earlycon_id *match;
+	const struct earlycon_id **p_match;
 
 	if (!buf || !buf[0])
 		return -EINVAL;
@@ -177,7 +177,9 @@ int __init setup_earlycon(char *buf)
 	if (early_con.flags & CON_ENABLED)
 		return -EALREADY;
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
+	     p_match++) {
+		const struct earlycon_id *match = *p_match;
 		size_t len = strlen(match->name);
 
 		if (strncmp(buf, match->name, len))
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e520d6fc..e17de55c2542 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,7 +179,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
+#define EARLYCON_TABLE() . = ALIGN(8);				\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
 			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..c4219b9cbb70 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -351,10 +351,10 @@ struct earlycon_id {
 	char	name[16];
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
-} __aligned(32);
+};
 
-extern const struct earlycon_id __earlycon_table[];
-extern const struct earlycon_id __earlycon_table_end[];
+extern const struct earlycon_id *__earlycon_table[];
+extern const struct earlycon_id *__earlycon_table_end[];
 
 #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
 #define EARLYCON_USED_OR_UNUSED	__used
@@ -362,12 +362,19 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_USED_OR_UNUSED	__maybe_unused
 #endif
 
-#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
-	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
-	     EARLYCON_USED_OR_UNUSED __section(__earlycon_table)	\
+#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)		\
+	static const struct earlycon_id unique_id			\
+	     EARLYCON_USED_OR_UNUSED __initconst			\
 		= { .name = __stringify(_name),				\
 		    .compatible = compat,				\
-		    .setup = fn  }
+		    .setup = fn  };					\
+	static const struct earlycon_id EARLYCON_USED_OR_UNUSED		\
+		__section(__earlycon_table)				\
+		* const __PASTE(__p, unique_id) = &unique_id
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	_OF_EARLYCON_DECLARE(_name, compat, fn,				\
+			     __UNIQUE_ID(__earlycon_##_name))
 
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
-- 
2.16.2.804.g6dcf76e118-goog

