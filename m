Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042829-2-6160783944207145214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042829; b=uRqwwqOabZXFl0x1A6sINOdRZ0iWFsiu7adPJftw0kc478B
    rFmTmsugco6CkBRsGcNRaObFIFfwvtjz0l59VlnAsDkBH1xrBTfoe2za/H/UXQtI
    QBWdWX+GDOr8jDH215y3318Tan4nKJlvUAJgZ+KcSKTioXP8ANj5Q47IserBq1PT
    i7jF8U62YcKKQeewGg6ZwPSfHHjtPXudcDY0+ENBt3JZvgHrs5DOp87uVFQLvx1n
    CdkTMRhFyWIShMx0p7auJ8plvVa7iLZfXZgaqU8BeWVEEVvnauyWoEvIls1q4iTX
    bbjg4gQh8o8EZQ4O/wnY1nazd/mAojY/Ar8TntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042829;
    bh=heaR+Y7pExR2LJEbYaKnSyZLghlPeSNwp04BTQNS0Zk=; b=huty1Gg69q2K
    y2YLy5F4QeHQqlp8bmzGtIKhZX4a2dxdVQRyqmaXVtyA+0e0BCc1rY+GcjAISokf
    g4v2Z9CebvzVSfOYrwGV9fh+z9oD2WJdi/ioyDBpdCy6ZgRqDmyw/gFeKJA+WbVh
    w6cxQmKGWss7uyOM4yoc71G7p37m2KuM/Xv+X3XIiC8RQQ0h04d/C4ycEkLU+3sb
    +7rb945Ths8FDmrekOoUJpCSQV1dV9u4O7YUYZ6TWlFt29JFk1eUVbXv1PbNZCya
    AgJFrI/GNwEcJRTCy/g5JY4SUC2zUX7sY42Y1ZSrkjdJ8QYbPX3dxh/cF+HfSiI8
    GDIOkRt8uA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNPxq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:53:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNPxp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 11:53:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 42/47] serial: remove m32r_sio driver
Date: Wed, 14 Mar 2018 16:35:55 +0100
Message-Id: <20180314153603.3127932-43-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:LS6029ebq67OfJeFLX9B1WqoCBhxs5KyIOdiDnGfZ54Do3nt27H
 mHZaFCxN1/yVQ+EVUvXLW5qxubagFq9s/xp9u8AX2zU6Pb37TpOOPK7CYv/t2WI9g1Jg70X
 QsW/Gt9V21CHgQMLN/0RSneyNkVLjJhEwsXf8nbsw+mLlq2xB6f6e7/KrAlKwPLeaHxg4Cz
 1HsPyQwWpvWogxT+ZhC9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kxsJDpZp4gg=:xTMelizG2x+6Z9QlAQ50t7
 J1oNzbNLhk6zgZMRZjsl4nmks8jzV6uo6yKC7C/4LKqy7jWNQmTrVdbqo1NMqia/uDzr6Gd2O
 qV5+npp0MUtLW0S3E/P92H0ebQ6WbKHJAIgAWzLNAJpL9h6AV7SKT1jfqrxjRvBIIZnur94me
 dkyglXDnnIAApr7eAUY+f2SWmQCjEcpmq8RKc9BPKjiMe0qtUeXFT5Q2a633BqjxEGlceibay
 yhZxJVGEa2iYHCD7u57Kac6i73tQUQOkN+nnxNTEmo0mv9zBYmj6gqw9UcuRfj2CyaOJVXahG
 KhW7gHOKq+7/kQw47zsjcOw28ERhyOCDG7O+CWM1Y+k5Vb11SxNoIqiqWPdBJE163mH17mmxK
 O1v3Pk0JUlrEpFmb/uEiYNathFzwGBY/ue0NZzQHRkkXx/UAStYXvHd4Wg1y8KAGgirx0xEjH
 Mx/7W6mTBYolnkPhObPSpKywF//kPBTaNLBM/oswTb/wgWtBRkBRvIOtdD9XMusTDVf8/SCKn
 SkBtRENcH7nLqAnL4P5bI4gfRPrs1CrCDvC398tayr/Qfo/Z0pFX5ZWVSl2/IwKtrNPKNKzR4
 1d4ZvjAIFpBrxCmmzCLrykvAHPVrMo0XcvJhURx5ReP6VwctNhggMUpD/qjsafdX1lA83/AqZ
 IVgaaVjn9B68ij9jijt/z6acdFcx/8kUezbSsy97sSidfWGX0A8LSOAmxeaISWn4eZM9ydBoI
 4sw+K186VB4xtjXkMRF/AaPtMGYP7j9y5lr8CA==
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The m32r architecture is getting removed, so we don't need this
any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig        |   29 -
 drivers/tty/serial/Makefile       |    1 -
 drivers/tty/serial/m32r_sio.c     | 1053 -------------------------------------
 drivers/tty/serial/m32r_sio_reg.h |  150 ------
 4 files changed, 1233 deletions(-)
 delete mode 100644 drivers/tty/serial/m32r_sio.c
 delete mode 100644 drivers/tty/serial/m32r_sio_reg.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 031552eb3f65..1a48ae6abb2c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -905,35 +905,6 @@ config SERIAL_ICOM
 	  This driver can also be built as a module.  If so, the module
 	  will be called icom.
 
-config SERIAL_M32R_SIO
-	bool "M32R SIO I/F"
-	depends on M32R
-	default y
-	select SERIAL_CORE
-	help
-	  Say Y here if you want to use the M32R serial controller.
-
-config SERIAL_M32R_SIO_CONSOLE
-	bool "use SIO console"
-	depends on SERIAL_M32R_SIO=y
-	select SERIAL_CORE_CONSOLE
-	help
-	  Say Y here if you want to support a serial console.
-
-	  If you use an M3T-M32700UT or an OPSPUT platform,
-	  please say also y for SERIAL_M32R_PLDSIO.
-
-config SERIAL_M32R_PLDSIO
-	bool "M32R SIO I/F on a PLD"
-	depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PLAT_USRV || PLAT_M32700UT)
-	default n
-	help
-	  Say Y here if you want to use the M32R serial controller
-	  on a PLD (Programmable Logic Device).
-
-	  If you use an M3T-M32700UT or an OPSPUT platform,
-	  please say Y.
-
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
 	depends on HAS_TXX9_SERIAL
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index a9242484e821..606e746b61f1 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_IMX) += imx.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
-obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
deleted file mode 100644
index 7b83a8aab495..000000000000
diff --git a/drivers/tty/serial/m32r_sio_reg.h b/drivers/tty/serial/m32r_sio_reg.h
deleted file mode 100644
index 6eed48828f94..000000000000
-- 
2.9.0

