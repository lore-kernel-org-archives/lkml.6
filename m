Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440482-1523056984-2-858618892755521901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523056984; b=rKwJzrvTDal2DJYWTt/9wjyR5wM2+rHaXkbbBbUzwHJZCiUm6X
    zIc154Usj6xJ/VaZtfUKZsF2L/twOmVYQ2NxmOGE7CKl8Lp9G3fY5bQlJTovvvf/
    QZgjcqFIlcq/tR+MCmWlNYU1LHTVhiNpPDV45kLxD83oZDJYmzxxtYdoUgBIoKhL
    Jl/zTf/k5jCvmwl5zYzN/HKQ5OyJ7e0Ynv9qG+HvORXHqTR5HoMQMclf9Ms+Z6Js
    VwKFohn0ZvhLIvY/rmq98fPLJKjyWTDb3JduYaB2xIkD/ffgM91ufAmeTIs6b4K/
    6d8tmqk6jsMvlbCf+1C4iPZ2sq+GsZcWS1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id:to:sender
    :list-id; s=fm2; t=1523056984; bh=MfiGFESsqXEAJhdsS/ytwHAWbbUXjY
    g8g6t5odisySk=; b=TbvoKWTtVUnL27ZHh1Z+/4RHkY9K31Vwn+4sqwTapRD78S
    3AEF5DRU82UhlmCnsrD9D0w5IxZNFOiRzZoxNJ5Lx1VydyOkaQpF4upVTvvAcHqf
    PvUMi3O+sSnqpolmwzMPVER+Yeqx+fipgux7jNBJkXWfPUHOA51uYm1ydX5pOl0y
    Gf+X2aIOob/i3EIYa1pHn+1gY+WEIegYlICnklLBSfk9nP8Qf1u5dd9S6dfsFnyw
    Yl6QrX/l4oVkpEfUKATPXkDqXKRvxtmRaUV6q9x3aI2aX53CQ0nNY5aex4439ofP
    lHZQ6HU00sMFhETeXQTGPH4+1aEPjMDyDYcJjQMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=mKS/1Tdj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EEH0Y1eI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=mKS/1Tdj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EEH0Y1eI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD0tHefRqDajGs3q1DjDFGJbuadvCeTPiF+nqJ3sMcisLQG+nDldqD4UcJa0aeVXeYfdi/gVuUxfNMtzuw4HAs3Nh7WEDqCuLuRf9uVyU5zewyP81CrD
    cuCAsEcUWdANKFCtuxO246aummVr9FEcyUzOkCtKnIz3bxYp9N7bxnYa8WEW5ZH9WEaAIxPzVkD4baExg/A0e8QdIcBN1KYMVJYYvg2KbAUvMAE7wmVn7e6S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=9K3CYiR1sqi6B-peTUYA:9
    a=8v25mDhiXSy9xSgA:21 a=gv_WQOUwXfijEXDO:21 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeDFXW5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 19:22:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38007 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeDFXV5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:57 -0400
X-Google-Smtp-Source: AIpwx49hDg8SZzcCy/mWiunmahGcheRa1U+9VWHt1r+lSBaSym+kk+wFWRJKowqFr3w88dVebImJCg==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list),
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6] earlycon: Use a pointer table to fix __earlycon_table stride
Date: Fri,  6 Apr 2018 17:21:53 -0600
Message-Id: <20180406232154.168174-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
To: unlisted-recipients:; (no To-header on input)
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

Fixes: 99492c39f39f ("earlycon: Fix __earlycon_table stride")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Suggested-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: stable <stable@vger.kernel.org>
---
Changes since v2:
 * Use __initconst instead of __initdata to avoid h8300 and alpha kbuild errors

Changes since v3:
 * Fixed typos in commit message

Changes since v4:
 * removed Change-Id: from commit message

Changes since v5:
 * None, just re-posting per request from greg k-h

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
index 278841c75b97..af240573e482 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -188,7 +188,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
+#define EARLYCON_TABLE() . = ALIGN(8);				\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
 			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 1d356105f25a..b4c9fda9d833 100644
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
2.17.0.484.g0c8726318c-goog

