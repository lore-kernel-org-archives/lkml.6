Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042858-2-1804985955810183967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042858; b=Xoo81fWTjh0EnQYmQGciSSx+vnKHBrkaeb0Z7uC6exxdspw
    LR9pPIU86Nrzt7ZTIczt0nfVZpw0xU5ys+yDhRKlBLdJFILhIZkPSO5qZGNJp/iv
    VsJ515vy3c8lveqcWl8tQTiNYBEDMjbtih4QxpjF7D/u4Ees4wja5Cf8Eg8XTj0L
    Vn8VGIVP5duz47x1SR50x2X1UcW/kRPZaxzLs5CQ9BxD/tciDYxBvpMn5//jZGde
    J+lMx/3aqOK8hNVUesKaqmziWI83Z148y4I9Lid/V3tK/x8cFHD2B8dqPpmvvlyM
    drA22aObGuyZZ6kMRvnwOkgJKv9EGUEhcUQv3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042858;
    bh=QzfzBZ85olcxr/OPQ6jIgL8nDh29FT0zYelJdM1iUWE=; b=OvRTPCurjKxO
    dGUz8tzw2GZygjGF3zoZWO7c4uFKRcj6AT2GZ26L5miYvXCYi2rqqv+QgOQdrfd6
    t3V+FRAlVUVEJW9jYaOubPqKPt0O1KByE+5ZL+afgstRVrLNICK74cDcL/+BaN0C
    rbdtNoRhOQfVJZLXLPd1Pz6J4yuQsqMFY6UYaKkAIGH2lwXgUFeAobh9PysdD9EU
    IUKQC+p5bdT9YjJBu5LfKLfLAJPo70rAV3udfkEvq4pV3SpsuHC1oVD7SOamPlrC
    fxntagGKuWtoUGgIMwJLR6DgqoJM06aTCWnX/0W6vEry9vBeHXUz3gbhgQawYEuT
    pxREHGcsJA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1751971AbeCNPyD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:54:03 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeCNPyC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 11:54:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 43/47] serial: remove tile uart driver
Date: Wed, 14 Mar 2018 16:35:56 +0100
Message-Id: <20180314153603.3127932-44-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:4UQtoTwUxnYN8ZPKJhFlLyv82IVUDFsaI4bNiIFhbYkG/Ksa4NN
 nyd9S1JvjxCcghIhQ6h8PBsTdGH5j/rwVfuCRmZ7qXfbInpvW34UIPdaw/6JtUDRSehnc9L
 hHoHsdo0aC3jxRU5bVp66AckrfycD4J3gsdJDQyqS8IEoR/eGhadaLzAvDkMM9cV4+mlazh
 3XxV6hQgjoRY6aeIduiJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cMw1tN3toWE=:SK6e08b7CWWkSSrpBR61B6
 MpzQYFQxrVGmRqyxA3XiUgi5i083/d749diB431cwdH+ggNdWlopIWV+5D0XF7M4ILchSOb8w
 hkqFll+5tSY7wlFCUFKAZHreZM2y2aiJtypq4/uofA8ZIPNO3IqV5Sv/L3AIk4UbZWJsx/XCb
 g8ICU0bTj8lPtkAJC9Jy2GU8noi7arpGYoyicAufH0JC2Atb1+itLqSpO2HZSkeMJlPrmvCwH
 dGvmYLpx282steN5RmsKpeb7dzh9z3QQGeTcu1rmnn8LHzdffz29CnN7G3zov9rACtrfROudb
 dyP8+rbkvduwaG+xAydqDFGBartzgP3EeKJ8kGC6YLOuZGKUTO1MoN1E7E1iUvcBY9KccJFYG
 8tNo5UKX5TKvGXJXMZxPmFr089b4ioRQUb7Nvjj3/NeHjm/ohQffyaTbDvO5hKohiRSY+c/0r
 jTGcq07X2aT3UGGm4ZGM0vLVaIlywugxsBhxLdmSZBdY/btk/bBA8HPiKdpaYhmhzwXQk/X8U
 HOVNlMJZB+Fx5fCl3NOHaJIttnoZRWW+DQJPUgUHOOuhiNDyrmSoTicEe6lCXlcD0RF3xTDl3
 my+yXIqpNHmkVIc4K0T18zYrjfc2tT8vnhvvZ5TGVugZ4PCbagNuBHs8wrb2kU66Jjy7vwUIp
 6e62sPdCa509GkyKHbarfo5B15wEVSjwOnleaZKvpsc9BednEPSxxLdEtMGl7FmBmtTPHRDAe
 ErpLYMx7mVIxAgrtRZ1fCljIv0BEoeQ+JRKPlg==
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tile architecture is getting removed, and this driver is
useless without it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig  |   9 -
 drivers/tty/serial/Makefile |   1 -
 drivers/tty/serial/tilegx.c | 689 --------------------------------------------
 3 files changed, 699 deletions(-)
 delete mode 100644 drivers/tty/serial/tilegx.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1a48ae6abb2c..736720a8d84f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1330,15 +1330,6 @@ config SERIAL_EFM32_UART_CONSOLE
 	depends on SERIAL_EFM32_UART=y
 	select SERIAL_CORE_CONSOLE
 
-config SERIAL_TILEGX
-	tristate "TILE-Gx on-chip serial port support"
-	depends on TILEGX
-	select TILE_GXIO_UART
-	select SERIAL_CORE
-	---help---
-	  This device provides access to the on-chip UARTs on the TILE-Gx
-	  processor.
-
 config SERIAL_ARC
 	tristate "ARC UART driver support"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 606e746b61f1..b30ee2e5d518 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
 obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_ST_ASC) += st-asc.o
-obj-$(CONFIG_SERIAL_TILEGX) += tilegx.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
diff --git a/drivers/tty/serial/tilegx.c b/drivers/tty/serial/tilegx.c
deleted file mode 100644
index f0a3ae57f881..000000000000
-- 
2.9.0

