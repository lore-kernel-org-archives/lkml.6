Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464249-2-15044436642929100837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464248; b=aIid2cL3IZ+ZMS4ALEn2w8VwIzZP0XYrn+eq9iQFc60VSKKdJs
    GNFbeEnf8/J0Zwu/h2ZdyN1XlbXTVBOA/frUnO8qLLTEkVeaiFpIDyTd/4ITMREA
    nBh+vYA8EF88D26bjre5JZzfEDyeEcuWnatbXA6c2JEHpUhbG5lPh0R6nxPrDBJ0
    k0RUEYvqld06xbY4iw6XFHjcE+MkzF20DY8dQG1NCud8g6UgtolDHx4fjb0Q/qdn
    5r9I9yO6UdJ9mvG5F21Lv1lxKxtN1ipkWLBmMcD3zqqBMktRdJDzLpggt2nMXjHG
    h5uh2mUEyk3cvacLcX6W2qqy+9uOXNcTC6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464248;
    bh=tqzkTQaZtrHrEljDGQZXskVy7oxzKQHlEf2KS4VkjXk=; b=lAIuBZ/3QPkX
    6nNsFyNvRdI8f0aC5HJqzAG2Jmof1wBnDuIwy/aKYQ33ONh89pnG1s6NIywWwLir
    BXbU1ENvGOJGqd/v1x6TAVBbp4nYXBPSj6s1gfBsJGLEsoL0cO2YezgY9qPHrj4W
    g/jNl/tpJd/ljJb2c+0LYIh6+X0xzgyzixswVVL0oBbgK6J1un5t6lYTN23+yfgS
    DKTVWLgqxLCZ0KWA6ugQUmU9IIA+Uy8XpP91zJVHvlT/BITTuL5L10YCXw5ZG7ae
    DHCrdsclHNqKKsxZ8u/sA5EEjNRJVq2AVB0wpY8I9pBYWEuFtqBjFmQie0W0Ipz/
    ct7/GOq9ew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFam6ar6OAMCfejyHZ/pgbc8DSOUQSAprLxd8tuSMFnWHAeycliJElq60R2fcYmq6LVH5aRxa1RicIQZP2KI4g5gd4LyQK8g8UOQrAYiMrKT45ljFT2l
    dr/DSDv0cqr7TFZIrvRCeB0eiM5Bno5H34TxLVDbdxowVKnF5bkFNJnftLd+bUI1BVvM92LvwIaxP2sy171/qaorookv1xPWm8NkUf1jKEy6LpeI2Get8vwd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=svUXFjUAJE5RGX_gYZoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeDKQY5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:24:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753755AbeDKQYz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:24:55 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/24] Add a SysRq option to lift kernel lockdown
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:24:52 +0100
Message-ID: <152346389240.4030.11187964053014260180.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kyle McMartin <kyle@redhat.com>

Make an option to provide a sysrq key that will lift the kernel lockdown,
thereby allowing the running kernel image to be accessed and modified.

On x86 this is triggered with SysRq+x, but this key may not be available on
all arches, so it is set by setting LOCKDOWN_LIFT_KEY in asm/setup.h.
Since this macro must be defined in an arch to be able to use this facility
for that arch, the Kconfig option is restricted to arches that support it.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: x86@kernel.org
---

 arch/x86/include/asm/setup.h |    2 ++
 drivers/input/misc/uinput.c  |    1 +
 drivers/tty/sysrq.c          |   19 ++++++++++++-----
 include/linux/input.h        |    5 ++++
 include/linux/sysrq.h        |    8 ++++++-
 kernel/debug/kdb/kdb_main.c  |    2 +-
 security/Kconfig             |   11 ++++++++++
 security/lock_down.c         |   47 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..3108e297d87d 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -9,6 +9,8 @@
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 
+#define LOCKDOWN_LIFT_KEY 'x'
+
 #ifdef __i386__
 
 #include <linux/pfn.h>
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 96a887f33698..027c730631cc 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -365,6 +365,7 @@ static int uinput_create_device(struct uinput_device *udev)
 		dev->flush = uinput_dev_flush;
 	}
 
+	dev->flags |= INPUTDEV_FLAGS_SYNTHETIC;
 	dev->event = uinput_dev_event;
 
 	input_set_drvdata(udev->dev, udev);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6364890575ec..ffeb3aa86cd1 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -487,6 +487,7 @@ static struct sysrq_key_op *sysrq_key_table[36] = {
 	/* x: May be registered on mips for TLB dump */
 	/* x: May be registered on ppc/powerpc for xmon */
 	/* x: May be registered on sparc64 for global PMU dump */
+	/* x: May be registered on x86_64 for disabling secure boot */
 	NULL,				/* x */
 	/* y: May be registered on sparc64 for global register dump */
 	NULL,				/* y */
@@ -530,7 +531,7 @@ static void __sysrq_put_key_op(int key, struct sysrq_key_op *op_p)
                 sysrq_key_table[i] = op_p;
 }
 
-void __handle_sysrq(int key, bool check_mask)
+void __handle_sysrq(int key, unsigned int from)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
@@ -550,11 +551,15 @@ void __handle_sysrq(int key, bool check_mask)
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
+		/* Ban synthetic events from some sysrq functionality */
+		if ((from == SYSRQ_FROM_PROC || from == SYSRQ_FROM_SYNTHETIC) &&
+		    op_p->enable_mask & SYSRQ_DISABLE_USERSPACE)
+			printk("This sysrq operation is disabled from userspace.\n");
 		/*
 		 * Should we check for enabled operations (/proc/sysrq-trigger
 		 * should not) and is the invoked operation enabled?
 		 */
-		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
+		if (from == SYSRQ_FROM_KERNEL || sysrq_on_mask(op_p->enable_mask)) {
 			pr_cont("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
@@ -586,7 +591,7 @@ void __handle_sysrq(int key, bool check_mask)
 void handle_sysrq(int key)
 {
 	if (sysrq_on())
-		__handle_sysrq(key, true);
+		__handle_sysrq(key, SYSRQ_FROM_KERNEL);
 }
 EXPORT_SYMBOL(handle_sysrq);
 
@@ -667,7 +672,7 @@ static void sysrq_do_reset(struct timer_list *t)
 static void sysrq_handle_reset_request(struct sysrq_state *state)
 {
 	if (state->reset_requested)
-		__handle_sysrq(sysrq_xlate[KEY_B], false);
+		__handle_sysrq(sysrq_xlate[KEY_B], SYSRQ_FROM_KERNEL);
 
 	if (sysrq_reset_downtime_ms)
 		mod_timer(&state->keyreset_timer,
@@ -818,8 +823,10 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 
 	default:
 		if (sysrq->active && value && value != 2) {
+			int from = sysrq->handle.dev->flags & INPUTDEV_FLAGS_SYNTHETIC ?
+					SYSRQ_FROM_SYNTHETIC : 0;
 			sysrq->need_reinject = false;
-			__handle_sysrq(sysrq_xlate[code], true);
+			__handle_sysrq(sysrq_xlate[code], from);
 		}
 		break;
 	}
@@ -1102,7 +1109,7 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 
 		if (get_user(c, buf))
 			return -EFAULT;
-		__handle_sysrq(c, false);
+		__handle_sysrq(c, SYSRQ_FROM_PROC);
 	}
 
 	return count;
diff --git a/include/linux/input.h b/include/linux/input.h
index 7c7516eb7d76..38cd0ea72c37 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -42,6 +42,7 @@ struct input_value {
  * @phys: physical path to the device in the system hierarchy
  * @uniq: unique identification code for the device (if device has it)
  * @id: id of the device (struct input_id)
+ * @flags: input device flags (SYNTHETIC, etc.)
  * @propbit: bitmap of device properties and quirks
  * @evbit: bitmap of types of events supported by the device (EV_KEY,
  *	EV_REL, etc.)
@@ -124,6 +125,8 @@ struct input_dev {
 	const char *uniq;
 	struct input_id id;
 
+	unsigned int flags;
+
 	unsigned long propbit[BITS_TO_LONGS(INPUT_PROP_CNT)];
 
 	unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
@@ -190,6 +193,8 @@ struct input_dev {
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
+#define	INPUTDEV_FLAGS_SYNTHETIC	0x000000001
+
 /*
  * Verify that we are in sync with input_device_id mod_devicetable.h #defines
  */
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..7de1f08b60a9 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -29,6 +29,8 @@
 #define SYSRQ_ENABLE_BOOT	0x0080
 #define SYSRQ_ENABLE_RTNICE	0x0100
 
+#define SYSRQ_DISABLE_USERSPACE	0x00010000
+
 struct sysrq_key_op {
 	void (*handler)(int);
 	char *help_msg;
@@ -43,8 +45,12 @@ struct sysrq_key_op {
  * are available -- else NULL's).
  */
 
+#define SYSRQ_FROM_KERNEL	0x0001
+#define SYSRQ_FROM_PROC		0x0002
+#define SYSRQ_FROM_SYNTHETIC	0x0004
+
 void handle_sysrq(int key);
-void __handle_sysrq(int key, bool check_mask);
+void __handle_sysrq(int key, unsigned int from);
 int register_sysrq_key(int key, struct sysrq_key_op *op);
 int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index dbb0781a0533..aae9a0f44058 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1970,7 +1970,7 @@ static int kdb_sr(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	kdb_trap_printk++;
-	__handle_sysrq(*argv[1], check_mask);
+	__handle_sysrq(*argv[1], check_mask ? SYSRQ_FROM_KERNEL : 0);
 	kdb_trap_printk--;
 
 	return 0;
diff --git a/security/Kconfig b/security/Kconfig
index a68e5bdebad5..46967ee77dfd 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -253,6 +253,17 @@ config LOCK_DOWN_MANDATORY
 	  Makes the lockdown non-negotiable.  It is always on and cannot be
 	  disabled.
 
+config ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+	bool "Allow the kernel lockdown to be lifted by SysRq"
+	depends on LOCK_DOWN_KERNEL
+	depends on !LOCK_DOWN_MANDATORY
+	depends on MAGIC_SYSRQ
+	depends on X86
+	help
+	  Allow the lockdown on a kernel to be lifted, by pressing a SysRq key
+	  combination on a wired keyboard.  On x86, this is SysRq+x.
+
+
 source security/selinux/Kconfig
 source security/smack/Kconfig
 source security/tomoyo/Kconfig
diff --git a/security/lock_down.c b/security/lock_down.c
index f35ffdd096ad..2615669dbf03 100644
--- a/security/lock_down.c
+++ b/security/lock_down.c
@@ -11,9 +11,15 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/sysrq.h>
+#include <asm/setup.h>
 
 #ifndef CONFIG_LOCK_DOWN_MANDATORY
+#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+static __read_mostly bool kernel_locked_down;
+#else
 static __ro_after_init bool kernel_locked_down;
+#endif
 #else
 #define kernel_locked_down true
 #endif
@@ -63,3 +69,44 @@ bool __kernel_is_locked_down(const char *what, bool first)
 	return kernel_locked_down;
 }
 EXPORT_SYMBOL(__kernel_is_locked_down);
+
+#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+
+/*
+ * Take the kernel out of lockdown mode.
+ */
+static void lift_kernel_lockdown(void)
+{
+	pr_notice("Lifting lockdown\n");
+	kernel_locked_down = false;
+}
+
+/*
+ * Allow lockdown to be lifted by pressing something like SysRq+x (and not by
+ * echoing the appropriate letter into the sysrq-trigger file).
+ */
+static void sysrq_handle_lockdown_lift(int key)
+{
+	if (kernel_locked_down)
+		lift_kernel_lockdown();
+}
+
+static struct sysrq_key_op lockdown_lift_sysrq_op = {
+	.handler	= sysrq_handle_lockdown_lift,
+	.help_msg	= "unSB(x)",
+	.action_msg	= "Disabling Secure Boot restrictions",
+	.enable_mask	= SYSRQ_DISABLE_USERSPACE,
+};
+
+static int __init lockdown_lift_sysrq(void)
+{
+	if (kernel_locked_down) {
+		lockdown_lift_sysrq_op.help_msg[5] = LOCKDOWN_LIFT_KEY;
+		register_sysrq_key(LOCKDOWN_LIFT_KEY, &lockdown_lift_sysrq_op);
+	}
+	return 0;
+}
+
+late_initcall(lockdown_lift_sysrq);
+
+#endif /* CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ */

