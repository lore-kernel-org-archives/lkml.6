Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E16C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E86B20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E86B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeILUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:20:18 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:20:18 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mzz6s-1ffyyT0KV4-00x52G; Wed, 12 Sep 2018 17:14:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        gigaset307x-common@lists.sourceforge.net
Subject: [PATCH v2 11/17] compat_ioctl: remove isdn ioctl translation
Date:   Wed, 12 Sep 2018 17:13:03 +0200
Message-Id: <20180912151422.571531-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:sVY/sja0LHvqNLTgv5hsJPWtmXt9NlBmoBucSJdKP223QjucLmZ
 4TenJF1iUocwvkGiOwoKKoST/C9UhEIRxk9Dj8dY95TzM7JKADPn6/x/mfrvd12dC75LslJ
 Ksxl92emuBImzB+DS1H4dKHFUv/I02Q6h/FYx56/1w/HpImf+Lmos2VhGJeEirRg2OsVN5O
 uoW7C5ZwYBpyWluA6GOSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:efvwKRq9x8A=:bJKsz1lvaS2Uj5pj8nFmEm
 mrvuY08Ka7t622A5rXyC72QXogGbPfKdiZash5ktepftmdWmgG2yt9B5gOjx2K0WL1r2YF5Dv
 pAlmFMVFgMGbmDEVxcJHgp27S0unRuzc7z+AMC64vXtp7Vq2rGYDdUeLwJaL+r7wk5TqVEBA/
 r8196fIzhFxN4awHbhlSVKiWYEZ2+iUTUPvSOx5x3JlKj3RsxP4SyS/Q42/j+A7thmDZMKtza
 zKooNZ56IB3ZBOXzjph1Ce8EOqf3pE6aVxzGCfiBSq9fopladCH/xYtRvE/iFho9yavToEL1F
 Q+CyWm+YIRTAHUVvtkprcXgVQVPjkmfLwKnqcno8qDJ2Zi/MQVK++AomlR4EpeTRNdJq4LtvJ
 jfrjpP0wfb5spt5O5xCXoMydI6jg0G/bDeyr5Hq6CRjIwgTjrpUaoZyYOFkvhka4tDxxmyH+L
 UeM78+PdB88O7ng4qtXRZIna847YT/+HIzaNIzm7CbktT/vdr7BlUEs7DjmWvP+OFrhEZZHB2
 J169thEKbY6aiMXNFSERPmwz16ZGvLue0ps2IgV5ghj8xv9o3KhUbjHCsnNDyhprk6JgmTD9+
 CpEOTWfMlwzxRCaBXStecdAJcSmy06dqsjvNRRVHYyMV33AgXzVUu+F7sBfMMOyBvvfurmbuu
 mUExP8tHJno7AL/AAh47MUkVyUiiper6htX9LQsa0biWBGKYTMKhs85hDviwXdYWA2K8=
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
 drivers/isdn/gigaset/interface.c | 11 +++++++++++
 fs/compat_ioctl.c                | 22 ----------------------
 3 files changed, 42 insertions(+), 22 deletions(-)

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
index 600c79b030cd..e346756b0b45 100644
--- a/drivers/isdn/gigaset/interface.c
+++ b/drivers/isdn/gigaset/interface.c
@@ -233,6 +233,14 @@ static int if_ioctl(struct tty_struct *tty,
 	return retval;
 }
 
+#ifdef CONFIG_COMPAT
+static long if_compat_ioctl(struct tty_struct *tty,
+		     unsigned int cmd, unsigned long arg)
+{
+	return if_ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int if_tiocmget(struct tty_struct *tty)
 {
 	struct cardstate *cs = tty->driver_data;
@@ -472,6 +480,9 @@ static const struct tty_operations if_ops = {
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
index c28fd9f6b1e8..379e04647f83 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -60,9 +60,6 @@
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/rfcomm.h>
 
-#include <linux/capi.h>
-#include <linux/gigaset_dev.h>
-
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
 #include <linux/fd.h>
@@ -840,25 +837,6 @@ COMPATIBLE_IOCTL(HIDPCONNADD)
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

