Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELt5/VJeSYbFX0DShR8Wc9c6xujRlsmB+1ai1XTObw1m429eE4FMeFCAPCaMVq5kh7x992SS
ARC-Seal: i=1; a=rsa-sha256; t=1521042873; cv=none;
        d=google.com; s=arc-20160816;
        b=AFP2J07chZPUepxGiA+2VtZ47X1pA87sINBZsIIQkJs6/x/ldjhZIGnkD2TZrZHz9H
         cSaUX0nAaRtiB1o0umgfRp1YpJg3eXfNwAHxVzYW09Mh0M6N0Cxrv83GpMDs2yM9vayH
         FXBX1U9mk4qXDncSXwDplB76lPcq0kZWZC6CwriaVzHki4vQAkBpLh0kv2/WWghTMJU6
         +J9gBNnB2Ur0/2MZFPEZ+rYx+UBo2UpzrXDBo5M3lBoDz8GppjWBeM4puLjAsNLE4VW6
         0Qv+D7J8PCEFvmzAu6XMrvQhmW+jcG39p9QhDmPB3DsUhce7ZOfp68DIIr8C15Am91UA
         xS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=H9gKAEybKL7qaMdOIndbU9Eb0IwczpIulz46Akpc9Sg=;
        b=OiF7E2aID6AvgE4KIcINTIcDnsD0kq4IJYIMsKD/65MBiFBa8BX7uAHXzch/cYC5WU
         AO/jdnZHDZ2dLo64zCnQN1nN4VBO/NpZb0N5sGuysfUhSlF5FQ91g7nIkPTsC5LscwAn
         B3zxpmnB4/mwHc0cUdjpPwpysof1tjNqAB+LHPzPDsCVg9ZsJ8ffPBx8adtrkXJx4FqK
         PA1P38YBnifNj/E7xFVf2tU62Lbw2rzllOTRtDA/sL+y6UZVgWwicLsVL9EI9Y9xyMBA
         abBt+0BE7w+0wFhvYelFDcoV9kXK5E8menBxuIjeK03hZvpu7kUzxg3C97JOvMjQh4wi
         GnGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 44/47] tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers
Date: Wed, 14 Mar 2018 16:35:57 +0100
Message-Id: <20180314153603.3127932-45-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:T3bbDlDI97J4dNyuZ7sRh4ZD4CFiNhB4WIxvqyYbsWZCjghYk9W
 uWb5iglEdKYe+xYXe9RNGQOpL3xWY3t3gh9Pd24jSdPHnodpp5znhAC/CvwKEiWzubRnrdA
 zvh1StXUFySsl65O79rBiR+sBhU1bvY1bawhfKrdgRkk6PQn9ANPw+R0k+5edYAgHdb/tT3
 ovZO2QyyLfL/bvsPyMqIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DDiJVYQvTDI=:Kzkvx0JKLp45Ac5Fzb9L4a
 dqtxQZ675idq4KFwnBYR5x+HFd/+7UqMGSIHyeijduNZA8wlzErh4vHtVhLUNg37Cb4V/FMGL
 D5jbc4phnGlWtq0RDadF/i2e2bwD/6EMi/t8T+JnalhXFK9Od6JLXEItq4hc9IEmK7ki1c8gt
 NnQbbcwAVgmSPIBIsuaxHOMHimEk+tGQdcEJptUKZqnrD3sxud5eRsuw30occl90AFW4QEgTj
 IJPlj6mKXkvLCCPdV2BT4x5A9fhaDiO0Px7EeC8eqkInN1J+TpFC7wYFUmp2e8l6odAAsm4DP
 mr3uRmBHCnrxG+tVmkBHbkDXpc+0OFZTmKliinIe/HpTX9wRYHP+P3SmhFHaDeq3GPWPlr/OS
 jHX2Lj8rkEbZ6USs090Zdz2/QHzOxKS88jMiVDdpUI9RpmdzlDw88SSyqGUGdCkRTVZnMR1nT
 DkSYERvPtkcmIuEvwWr0Dy7ZpyTmRwvh1M7XD/1+orKQ/QfxtTDm6xt1YpkbC2OfMeRAtVy5q
 KCByrTS9xZBaeK1hMq8VIOr/FYxXrvV63gblipy8FYwho67GJHwFeeAHItLPKchhNRb1LNSBG
 GVIvh1OCOfHMo8AJk5nyHXJ9r+afyji9oIDu8ACeMBxxRIPK/O7BOg04UrS4vbkZkm2QGHeeE
 3grz1wph0v1rr0lVh/qcCwAEvZgcO2I0mf1MgXgri4+Fm//Q+ga1Onnhshj42Hm6kgZ0mXWcW
 Xibi0GoC5mwUgxKokfLcY0NqyVdVhxKXuMKPYg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929052450697377?=
X-GMAIL-MSGID: =?utf-8?q?1594929052450697377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so these drivers
are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/Kconfig             |  13 --
 drivers/tty/Makefile            |   1 -
 drivers/tty/bfin_jtag_comm.c    | 353 ----------------------------------------
 drivers/tty/hvc/Kconfig         |   9 -
 drivers/tty/hvc/Makefile        |   1 -
 drivers/tty/hvc/hvc_bfin_jtag.c | 104 ------------
 6 files changed, 481 deletions(-)
 delete mode 100644 drivers/tty/bfin_jtag_comm.c
 delete mode 100644 drivers/tty/hvc/hvc_bfin_jtag.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b68e71751cc5..0840d27381ea 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -151,19 +151,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
-config BFIN_JTAG_COMM
-	tristate "Blackfin JTAG Communication"
-	depends on BLACKFIN
-	help
-	  Add support for emulating a TTY device over the Blackfin JTAG.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_jtag_comm.
-
-config BFIN_JTAG_COMM_CONSOLE
-	bool "Console on Blackfin JTAG"
-	depends on BFIN_JTAG_COMM=y
-
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	depends on HAS_IOMEM
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 47c71f43a397..c72cafdf32b4 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
 
 # tty drivers
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
-obj-$(CONFIG_BFIN_JTAG_COMM)	+= bfin_jtag_comm.o
 obj-$(CONFIG_CYCLADES)		+= cyclades.o
 obj-$(CONFIG_ISI)		+= isicom.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
diff --git a/drivers/tty/bfin_jtag_comm.c b/drivers/tty/bfin_jtag_comm.c
deleted file mode 100644
index c369bf27a67b..000000000000
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index fec457edad14..3bade5ad3d71 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -88,15 +88,6 @@ config HVC_DCC
 	 driver. This console is used through a JTAG only on ARM. If you don't have
 	 a JTAG then you probably don't want this option.
 
-config HVC_BFIN_JTAG
-	bool "Blackfin JTAG console"
-	depends on BLACKFIN
-	select HVC_DRIVER
-	help
-	 This console uses the Blackfin JTAG to create a console under the
-	 the HVC driver.  If you don't have JTAG, then you probably don't
-	 want this option.
-
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES && HVC_CONSOLE
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 0b02ec7f1dfd..b82f9f68cd23 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -10,5 +10,4 @@ obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
-obj-$(CONFIG_HVC_BFIN_JTAG)	+= hvc_bfin_jtag.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
diff --git a/drivers/tty/hvc/hvc_bfin_jtag.c b/drivers/tty/hvc/hvc_bfin_jtag.c
deleted file mode 100644
index dd7cae4c195b..000000000000
-- 
2.9.0
