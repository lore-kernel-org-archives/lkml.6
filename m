Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525116986-2-18277043783970766913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116985; b=a0uaCj3AC5PZxXe9gUcHw6H7vetnMoeZJY3/CGw4ILF+WkRxsn
    AK7S3/ZdwBzONZFpp0wJFFpLco6362wlYLgdK/l4IY2hZ+LUo1NPO7NULSt6YBQ5
    hAzx8TMvCDnqabxmSN9B1YG+D18msiGZ/jZwCKveZ6+cSYzqqPrPG2Xkja7A6jJm
    9tXGWj/N06+y/ppTBr2hVoGhanDKutUrc2meaCrNYGnflTqT0QP++O9j6ogtAr74
    x1WJcm7Y9ipVg2lyJfhwcbZiqzlWLFMA254EB0upRCA8cNumjvHTQ3iA9Exo/7Qu
    EAW65WnjBU4BbinFV/BRIz+zFbwZDQaTdfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116985; bh=RJVLkqMkLMzlq2+BK2asg/cxSI+ZSV
    CCmVCXb1Z+wfg=; b=k8At68oMNU7ByJfunjj5AcHYN7lvGYCs+WuvmgCLQz+xm2
    Y7ul2C3P3yc4+flirN0AseCHL0xPTGY1+mO8dV9o9GxOfTO+rKXie0z1EIEemAb4
    ilmwKGTtjIumks7yL40P9CCbqTfPuUDLI2gcdbx477B+UmPRoSL1/QN0C4zNyNxV
    AXvxZP4ieVMr45KJPOAU94LqXAaQCLMdWRrW5cS6Z/X8X0QFZ+pjnManVIatkxC/
    5jS4THUrLhHIqvLBq3vY3XvX8l4SIqTIgQDyxU757t/0kuRA2X4wItxh41FlQPcC
    tD//JalKfDO3m5upfBoOCczqh68FsddsYERsCtoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNpKKa9uCkYqf78/wTFrQg0jjSYjAW9bu/lBJgA7z3OHPv/voM/FbyKbzX7wodu71a843bLgZelmbnrDSCnXXqBT9ftnGR0vq1nCyUEkgNPcKm6uFguQ
    6vpTr6HvLdjYK6BXCCohS5EIUwHX+//Jz3MZKm3wyEBiibnlHk0GmHSxu24R1Dr/d879qvYO/h37rOkXAMaGTna8NzrnJaR55bcszT3LbqOU24GN0jI6ytna
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=3P7Wojad0bB6e94CpZgA:9
    a=xs7EWp7mlxHWYPQ1:21 a=mXqxSbPysldKSwQ6:21 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756429AbeD3Tfx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756383AbeD3T2r (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AA122DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 4.16 095/113] earlycon: Use a pointer table to fix __earlycon_table stride
Date: Mon, 30 Apr 2018 12:25:06 -0700
Message-Id: <20180430184019.214952093@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Kurtz <djkurtz@chromium.org>

commit dd709e72cb934eefd44de8d9969097173fbf45dc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/fdt.c                  |    7 +++++--
 drivers/tty/serial/earlycon.c     |    6 ++++--
 include/asm-generic/vmlinux.lds.h |    2 +-
 include/linux/serial_core.h       |   21 ++++++++++++++-------
 4 files changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -942,7 +942,7 @@ int __init early_init_dt_scan_chosen_std
 	int offset;
 	const char *p, *q, *options = NULL;
 	int l;
-	const struct earlycon_id *match;
+	const struct earlycon_id **p_match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -969,7 +969,10 @@ int __init early_init_dt_scan_chosen_std
 		return 0;
 	}
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
+	     p_match++) {
+		const struct earlycon_id *match = *p_match;
+
 		if (!match->compatible[0])
 			continue;
 
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -169,7 +169,7 @@ static int __init register_earlycon(char
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
@@ -362,12 +362,19 @@ extern const struct earlycon_id __earlyc
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
 
