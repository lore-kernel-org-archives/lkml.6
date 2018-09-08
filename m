Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E281C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312412086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312412086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIHTQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:16:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:16:32 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFsER-1g5WvQ3FwF-00HMTN; Sat, 08 Sep 2018 16:30:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, Karsten Keil <isdn@linux-pingi.de>,
        Paul Bolle <pebolle@tiscali.nl>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        gigaset307x-common@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] compat_ioctl: remove isdn ioctl translation
Date:   Sat,  8 Sep 2018 16:28:10 +0200
Message-Id: <20180908142837.2819693-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:WgQp1kucjzT9wpU82gmyNa2NWeV+CUQUCZhKJKPf+jQrikhscCh
 oZ29mZnpA1q27MxKVC+RNzANQPqkL8aaFxXruUYtKZZIOK4WYLCJfpb9nwCLOrgrmyELvzQ
 pNw5Xncgxtu9+xUX2radRs5iruAzaP/9LjiFGHaV95QpvFsD9OLmU0L+s7QCat7aj+plFNj
 jSEeOB9uYBxMcrcqiRUig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v6ytYpd0Njg=:PCa9TBvgLaTRpp//15zQuX
 ZDmAtx/uUtW7TaGRasUMQwQd37lmsWVzBf2lhZOQsWBh2aQeUeTnZCWHRzBKYZlnGTjD522BN
 5MUGKDPsSI/uw2qJwm2UiswVZeViNXOTv/xVpCNPwm7tQmIcqRXmbl35ET7oBUHYQNUEWNLOf
 HCx2gaZsFrKnToX/rkpNJ2IyprghqiIWTmG+v65JrCK0ELzwDx2X2MaZJG/l/kyA6R96N+b6K
 hGjGY0CAt2QbCY87skNcgA752wQFVgtntsktgc9gP6rWkmLNTePzu4uJjeJ4crkP/7lh5u6bc
 Atj4arnpsx6VvT1lFqOcILC5p9hK4ejKmL01FgPgbYa2Ap7xTe2ZGHccVb9GKv8Tk1I0FHcsw
 9qNvH8OJoMVnMkuCy0J23Ks7pGXgVtDG1Z/+z1/J2ZpE/gvJPml3n2ydb5g2hGu8d3aj0NiIR
 WX0zbg733ACCA/JnWN2qVBiI14KeZQ/xy1UDKzf8fE5/81fIokVdrq49yDVIObY6K+a+dUKos
 4m+9xEGxtkA6oCD0N2pVBvNkjW/4JPq8QaQAhaJ/PXqN6xkbFBp404PoPTwtuG0YkTmOz1fo2
 EAoz0zUSK4iYN78V/c1ambpeAc5wQJKOQ6Z0wOeeISEH8GtQy1NR5fJ4TiSL4Nu/86oUrjaYm
 Eg6eMZLDjiWxVgfHq/pTswVQ4PpMgegoviJNbTl1c3C0GEZT6PKir9hYWSWeTpaH2Fb4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the old isdn4linux interface nor the newer mISDN stack
ever had working 32-bit compat mode as far as I can tell.

However, the CAPI stack and the Gigaset ISDN driver (implemented
on top of either CAPI or i4l) have some ioctl commands that are
correctly listed in fs/compat_ioctl.c.

We can trivially move all of those into the two corresponding
files that implement the native handlers by adding a compat_ioctl
redirect to that.

I did notice that treating CAPI_MANUFACTURER_CMD() as compatible
is broken, so I'm also adding a handler for that, realizing that
in all likelyhood, nobody is ever going to call it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/isdn/capi/capi.c         | 31 +++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/interface.c | 10 ++++++++++
 fs/compat_ioctl.c                | 22 ----------------------
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b848ab..4851dc3941eb 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -942,6 +942,34 @@ capi_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+static long
+capi_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	if (cmd == CAPI_MANUFACTURER_CMD) {
+		struct {
+			unsigned long cmd;
+			compat_uptr_t data;
+		} mcmd32;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (copy_from_user(&mcmd32, compat_ptr(arg), sizeof(mcmd32)))
+			return -EFAULT;
+
+		mutex_lock(&capi_mutex);
+		ret = capi20_manufacturer(mcmd32.cmd, compat_ptr(mcmd32.data));
+		mutex_unlock(&capi_mutex);
+
+		return ret;
+	}
+
+	return capi_unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int capi_open(struct inode *inode, struct file *file)
 {
 	struct capidev *cdev;
@@ -988,6 +1016,9 @@ static const struct file_operations capi_fops =
 	.write		= capi_write,
 	.poll		= capi_poll,
 	.unlocked_ioctl	= capi_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= capi_compat_ioctl,
+#endif
 	.open		= capi_open,
 	.release	= capi_release,
 };
diff --git a/drivers/isdn/gigaset/interface.c b/drivers/isdn/gigaset/interface.c
index 600c79b030cd..faae8ae54802 100644
--- a/drivers/isdn/gigaset/interface.c
+++ b/drivers/isdn/gigaset/interface.c
@@ -233,6 +233,13 @@ static int if_ioctl(struct tty_struct *tty,
 	return retval;
 }
 
+#ifdef CONFIG_COMPAT
+static long if_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
+{
+	return if_ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int if_tiocmget(struct tty_struct *tty)
 {
 	struct cardstate *cs = tty->driver_data;
@@ -472,6 +479,9 @@ static const struct tty_operations if_ops = {
 	.open =			if_open,
 	.close =		if_close,
 	.ioctl =		if_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =		if_compat_ioctl,
+#endif
 	.write =		if_write,
 	.write_room =		if_write_room,
 	.chars_in_buffer =	if_chars_in_buffer,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 875516658c39..7d8c5722fd0a 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -61,9 +61,6 @@
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/rfcomm.h>
 
-#include <linux/capi.h>
-#include <linux/gigaset_dev.h>
-
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
 #include <linux/fd.h>
@@ -670,25 +667,6 @@ COMPATIBLE_IOCTL(HIDPCONNADD)
 COMPATIBLE_IOCTL(HIDPCONNDEL)
 COMPATIBLE_IOCTL(HIDPGETCONNLIST)
 COMPATIBLE_IOCTL(HIDPGETCONNINFO)
-/* CAPI */
-COMPATIBLE_IOCTL(CAPI_REGISTER)
-COMPATIBLE_IOCTL(CAPI_GET_MANUFACTURER)
-COMPATIBLE_IOCTL(CAPI_GET_VERSION)
-COMPATIBLE_IOCTL(CAPI_GET_SERIAL)
-COMPATIBLE_IOCTL(CAPI_GET_PROFILE)
-COMPATIBLE_IOCTL(CAPI_MANUFACTURER_CMD)
-COMPATIBLE_IOCTL(CAPI_GET_ERRCODE)
-COMPATIBLE_IOCTL(CAPI_INSTALLED)
-COMPATIBLE_IOCTL(CAPI_GET_FLAGS)
-COMPATIBLE_IOCTL(CAPI_SET_FLAGS)
-COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
-COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
-COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
-/* Siemens Gigaset */
-COMPATIBLE_IOCTL(GIGASET_REDIR)
-COMPATIBLE_IOCTL(GIGASET_CONFIG)
-COMPATIBLE_IOCTL(GIGASET_BRKCHARS)
-COMPATIBLE_IOCTL(GIGASET_VERSION)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
-- 
2.18.0

