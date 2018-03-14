Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042790-2-16684426338862718908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042789; b=aBlQlPX/L15wvoTmw0vLDqt/CQuYNFJf9leGmuSU31Fve56
    jxFrarCn2NlbMvp+bLIIsopf41ML8ksIoec0quZuBVrMQelNPPDFV51WnvwXH44v
    Ipy4Hio3FuL2JHVA0QKwISEGpl/gXIyM66AFIR3SJR1YmA4I2hgmfMQTf7fVw+Lx
    GBV+5MNuqRG2bfOSGsLCOqmDuRdPBJlh89xgrat1xU+CIKJwMfIqakRKIj7tTzVa
    ZioI5CKaqVZI5219Db6P9eQniZYa1O4R6OtCe0No0R54TZjzWqcZNzZLuZwlhL5M
    E4wLFzEuEPDSk++GxF2rTBimt6DoznBSQqisKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042789;
    bh=tHj/iGjH2q8oQK2gmwNabVdJvb4ehPU5N32YzQ0rEck=; b=aaG05hg84doT
    OCjo4UTczuxDdacuPtwaKQW/Gtf9HExYiyEFSiqdPLOH/7+WKu+pcKABf9RDnbgb
    6uz/oF0B+z9usWRlJ5wgFjE3hca/pEQPRTRerh/Xn4AcI31l4swmbKvd0CmluwJ8
    O7LtYfrCWKeyiVkI4LiGltPFZX2SthcHk30+9fPzsRYLb3t/pRsbldXa7GbrZOdi
    zL/mRU/QyXBoA3DP3y1jogK8OniFDezLTBtKxY/4hhb3RhySMGuMXjr2N4kavjAV
    ro87JswXjjvOTzS2PDhc+2RVEbD7hvlOBkuedL1eOJX8FqC6keX9D+bSwnh1c+wh
    r0B6qdUG8A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S1751452AbeCNPxH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:53:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCNPxG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 11:53:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 40/47] serial: remove cris/etrax uart drivers
Date: Wed, 14 Mar 2018 16:35:53 +0100
Message-Id: <20180314153603.3127932-41-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:MCxtjxUy6K4Rh40lotAlQJmTcSo3daAGbmtIpauuRS2NUpYKVuz
 DVJII7Y7lbCk7YXIC0ajMF5QAidHqxjJoTMo4qu6q3mjRnQVJjANXHfkHhhhLYJF7n4smLe
 fdMii0PYxw9Bk7ECqMUnAzrt3e3sEQXroCfTi+NjFqqVvZnVV1osxmvTcsuSmILwyOZ9vmf
 CedWebBrlDMFNxul8jDlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7GLGl51BLAs=:BTbXas5VFuP8kkRK56jWPM
 HOk/K0N3qIBhZMwgYzp1xN4a3ImFB9UVR4UozbdKJ6rsCs56WCJnuOxRaoO324es48F8l4Cn+
 jhPiKQ/h7dCpwCgvwizh2bju9IAFdsp/GgSxUR+4c46zCB7hO/bP4bu+P7BBkPSPOyRnD3mNx
 FLFIgOb6H5mrAmEhiRnI9QXF7mCZ5IbAh2/O3U7KMZHzuT3GnUINDz1In3DndrQKHIWM00HiZ
 iFdKxjAu3VZKTjZvs+VmHEgrRpqK8IHFyYX3wFm37OIhgdzpcaPtCMtfy0aoPxO6lPGFpVeMd
 MidhDJpbFTUs3W/AgikLbOK0EA31GdBZYhSnJz6sa0/bnnDaTodVgBbIGSRS/yRw0IbRy2Aga
 5HFnNohkft8tWNuyUSzPymdqcLHP7iCLAJEiyrcjopHTzMIPFX3OIbsy6Inv9gsio/BCYWn3o
 hwLhLaYJ/PdsMP1xFznzfIwSDm5Anp5uGFwO345kzJT9MAcscVv+UL6q6zDSFqs5S5Iox7aGT
 9n5aQw0r8NQNkUGqIItH8UuRAeL4ZzG8Ei07I9ZFm7Ko0/hosmFzNBAgoOSfK5qUww53JKReY
 FIEnntI4EgOXEVocYBoGFhqHtRxI/eZq/hF3rGUj/mgFgdK0YviTri/hrHtRGn+0sZt2JSE3j
 b6JjjtWyRiwd3PE1v84Z8BAMCxCfoR+pBdeOmI7rAshHkzUWi42HJttnboLQwsHtRB9htqKVt
 NCtNwfSq9LPwmK+3kdRhLN9vwiM/2lbOH9ji1g==
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cris architecture is getting removed, so we don't need the
uart driver any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../bindings/serial/axis,etraxfs-uart.txt          |   22 -
 drivers/tty/serial/Kconfig                         |   11 -
 drivers/tty/serial/Makefile                        |    2 -
 drivers/tty/serial/crisv10.c                       | 4248 --------------------
 drivers/tty/serial/crisv10.h                       |  133 -
 drivers/tty/serial/etraxfs-uart.c                  |  960 -----
 6 files changed, 5376 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
 delete mode 100644 drivers/tty/serial/crisv10.c
 delete mode 100644 drivers/tty/serial/crisv10.h
 delete mode 100644 drivers/tty/serial/etraxfs-uart.c

diff --git a/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt b/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
deleted file mode 100644
index 048c3818c826..000000000000
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3682fd3e960c..f6e09326042d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1114,17 +1114,6 @@ config SERIAL_VT8500_CONSOLE
 	depends on SERIAL_VT8500=y
 	select SERIAL_CORE_CONSOLE
 
-config SERIAL_ETRAXFS
-	bool "ETRAX FS serial port support"
-	depends on ETRAX_ARCH_V32 && OF
-	select SERIAL_CORE
-	select SERIAL_MCTRL_GPIO if GPIOLIB
-
-config SERIAL_ETRAXFS_CONSOLE
-	bool "ETRAX FS serial console support"
-	depends on SERIAL_ETRAXFS
-	select SERIAL_CORE_CONSOLE
-
 config SERIAL_NETX
 	tristate "NetX serial port support"
 	depends on ARCH_NETX
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 842d185d697e..c21835dc16b2 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -51,8 +51,6 @@ obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
-obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
-obj-$(CONFIG_SERIAL_ETRAXFS) += etraxfs-uart.o
 obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_CORE) += sc16is7xx.o
 obj-$(CONFIG_SERIAL_JSM) += jsm/
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
deleted file mode 100644
index c9458a033e3c..000000000000
diff --git a/drivers/tty/serial/crisv10.h b/drivers/tty/serial/crisv10.h
deleted file mode 100644
index 79ba2bc95d3d..000000000000
diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
deleted file mode 100644
index 24bf6bfb29b4..000000000000
-- 
2.9.0

