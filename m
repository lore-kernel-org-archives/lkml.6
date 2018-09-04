Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AA920843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVA03VPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AA920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIDHIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42665 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so879287pgp.9;
        Mon, 03 Sep 2018 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GxHfpXfEOk9XYTLZ+H5qwUF7ZNphH1CAsEDqllzqo4=;
        b=tVA03VPo7j3sVSscYTpVEeHmPevVxEsFXiCSw5Mnv0/iyykkV0CYzP7CjEdED8YAUT
         tvz132dLLZLXDkGnaZUOrXER24+hL6KKk6wiwu9DmPcaYeWbdN79jerVRpqXuSwY+e7z
         t01Xd4KhXs7tun7SiSM+IbULs8ypyeo+7JOEjSFjbMz0XSoewATUmJvY4GgnilINu2Zn
         4GxLs8xfJ+Vau5f7kn8MKBV8dDXFihoGNe8/fA6DcfP+ZYKzs4k9njJ1QgAl0yRoyJUX
         wEV43MsOSsyaOqCabINkG7mX2la1PWjPxWFoZG7pNhOO+O9dncJxgFNQcWPPP3juSRAj
         iAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GxHfpXfEOk9XYTLZ+H5qwUF7ZNphH1CAsEDqllzqo4=;
        b=C6tn/U/4cCeQgVgqFQKrOOz8w3qjU8PSBmFqxTTsM7okF+Da2zESv0arfgN3KsnMcf
         NkfRFpK3On4A3wa3X7MfecOZECnpH52ivnGjvg+4OEwST2fL0L0dFlZmwWx1dXVY9flA
         f5JiyGAQj8LDZaq6xGMwJ2hjhuiIurq/fvAtZKj9l+1jZ1ssmUQIrjJqRMXXRvg8r5u8
         G3VCmGd8U1xxzECnZjlU01OSzRiGsyLk1msihmmODgmHy3T2TAueSPTp3nkKk6Jx6Usx
         Q/Vb0oENkQxc4meH1wmNjV0fLMpwDc9mSbVLMCuLYlNXXLaR+ZT4WTiEDtooUJ7UpXVo
         QvuQ==
X-Gm-Message-State: APzg51BxjW4cfyFmk5dqNQkAG3SDtP1selJRkDjYzYr/0KgEGNiKN7yd
        tcYs2c0+DA8z0k+e0nxGMm8=
X-Google-Smtp-Source: ANB0VdYMoqLb/evAfeLiGb4LA0wUP6Kr4PZ9D+BeNrRRhwerJ+ChrZIwKifFRbtqIy9QW3nBIxcTQg==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr28828698pgd.372.1536029105898;
        Mon, 03 Sep 2018 19:45:05 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:05 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 01/25] tty: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:27 +0900
Message-Id: <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers with tty use the tty_stand_install(). But, there is no
need to handle the error, since it always returns 0. So, change the
return type of tty_standard_install() and tty_port_install() to void
type and remove unnecessary exception handling where we use these
functions.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/tty_io.c   | 10 ++++++----
 drivers/tty/tty_port.c |  4 ++--
 include/linux/tty.h    |  4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3..b01cec8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1196,13 +1196,12 @@ void tty_init_termios(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(tty_init_termios);
 
-int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
+void tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	tty_init_termios(tty);
 	tty_driver_kref_get(driver);
 	tty->count++;
 	driver->ttys[tty->index] = tty;
-	return 0;
 }
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
@@ -1221,8 +1220,11 @@ EXPORT_SYMBOL_GPL(tty_standard_install);
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
 {
-	return driver->ops->install ? driver->ops->install(driver, tty) :
-		tty_standard_install(driver, tty);
+	if (driver->ops->install)
+		return driver->ops->install(driver, tty);
+
+	tty_standard_install(driver, tty);
+	return 0;
 }
 
 /**
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d7368..fd8d40d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -656,11 +656,11 @@ EXPORT_SYMBOL(tty_port_close);
  * to a concrete tty specified by @tty. Use this or tty_port_register_device
  * (or both). Call tty_port_link_device as a last resort.
  */
-int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 		struct tty_struct *tty)
 {
 	tty->port = port;
-	return tty_standard_install(driver, tty);
+	tty_standard_install(driver, tty);
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e397..63cdac1 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
-extern int tty_standard_install(struct tty_driver *driver,
+extern void tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 
 extern struct mutex tty_mutex;
@@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
 extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
 extern void tty_port_close(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
-extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+extern void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 				struct tty_struct *tty);
 extern int tty_port_open(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
-- 
2.7.4

