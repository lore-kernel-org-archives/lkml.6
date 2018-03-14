Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042942-2-7695182639976821711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042942; b=GL6rY/gSFoLWe78HgNpJyTiF5PsyNnEOJOrGpoEBc3H3JqT
    4VEs3y0LfsQKNDT6Ey1Ra7up3VLIe+dr/OZfUi7pZEpDHaPc+4VqxVzxQrL8vYln
    ST1jg//k3CgknqzKSUqnBVlbq6BfLoNoV+ntMF9lLQ7lW72wCslQt2qYeMzzYi4I
    RnY+rrpBYLbyCHLPNHvqZOuEOPIAYKZHH69qvwiggt4wR8nFtYpunKatB1fl6NoU
    ZDYMmRG6hOWgxsrnSXrF4nmyrWQPO06b8fVUe6BbDuPIoCipOj7MwfFnErUP9MTC
    duN4wZeNkw9jHeTgzI8As7EKi/Gu/yl5gCSSNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521042942; bh=X
    WJUby+MRrbtkLhD7rGtYlPXgU6UbOSoRl/vTbCeCys=; b=j94mTjiKhCD9J2jrG
    tR1Sts0HGYVo/m+blAwREH7aZK+2xYCiG/nv2Hh0QK2N/N/DN0KvTYaWQoEqy9O0
    CWR4X8c3EU9g5jvGWbWHoGlym/EEVdm8m6e5da0pqW9XU7hNr/2SGNj0nD6AV3Rv
    cKg+FWuMME4kKPzadmVLqUGc+bC20SP30wCL54e/poE3+GPIfnN2tSAP4gRhK4jG
    Qv6/6Fi8w4lDS6d9Eg8/fknBl/FXqHVT5tcbLb/7aPuGMo68G6XgDk619iybiFMD
    1Ook6uMyuOMt64dBCzeoKuZeSOZ5Hsru0m/rUDOmttfnGXx9LaSKm+0wF3HNpO3t
    6bvsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 46/47] staging: irda: remove bfin_sir driver
Date: Wed, 14 Mar 2018 16:35:59 +0100
Message-Id: <20180314153603.3127932-47-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:f+8nRjTLQJPKR43oSjEH5DNnPf6qgCOOdlZwSAk41SvcrI4heWE
 LXClnNxq85xEazRlgtbEpmuSAJjqHskyWk8uQSWqAoTw3w2WmqhffVMcLmRAc0gI7hTqCGi
 oKFrvmllnEbYfU7TciRJ2ZNFhGrZUDylr9ubhu1aQfQR5KDeUZaUBIQq07ZcpuOWgI3vi9X
 YhOxgAZdpPDVxG2enF+Nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hIEeWr03Zq4=:Zp9AH3FT3wD+hgW/lttMkr
 2Fp48GnrPNGPexF2WJRDPwk+/gkBe+pA95VmBAytckjvIs3/RM59Xs36Gi9CSVbhyKeczdEFG
 Q91WuVYfI5bFCkVYqh+KW6CcaKnmhnKAF+2ZRgnQG/krfhOhYP6QlcyRGZ1Kyz1o2vMjZs21A
 nGXzJFo97UO4p1bDkuxn6TKwh1RLjbHSxZA/UcR5x4o4QDTqB/YcLw1ssyv+wSS0C+Nk9DmBZ
 LQIapAa70mTCh08FTT39lqjAQg6SrNuolc5WtwSkTCC0IYqOV2Q8eWCor1c3SuXO32822u8Ab
 Setdm9uU22rlpcnK7vMEivnmptyBuRN7EIOl3GHh2L06XP9F4nSHF7RLwwcnO/GNzJb5jN21V
 dyuwKxNxI3VRZVc7T0SPnHQ+FD72hgOrj+ljCIGNw2avvou5XlAE6JWXgLvLk6n3X34t0yxid
 dU8mJTtTmkp558rwEgPX/TFq2xym0rTcqUyri6EFonHvpQh4K1thygENkUJvywaBzWhjHZio/
 yGz04zdemN+EZJPEbpbnFeA57Dh/6On9m2qkmKTSeE/7c+t0z9ZtWq5hl+B5y/Nav4B/yQX9t
 BRpe3vz+dOzvyFNhAvADfaV+Ulmem6ynMlbucj4z0qD97CjwxB6mwBQjgGI0fu+fvMbMT0Weu
 lyGZYEDpoP3IdfRMVpba6iCZfaXdcRHl7uJwvbz979kWEeSQLnjwOFrEt9DOR1fxfHyQ3AbqE
 6rGxVSjd+o1cRuBxES8gxdevOc6j9lExzuQC0Q==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so this
driver is now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/irda/drivers/Kconfig    |  45 --
 drivers/staging/irda/drivers/Makefile   |   1 -
 drivers/staging/irda/drivers/bfin_sir.c | 819 --------------------------------
 drivers/staging/irda/drivers/bfin_sir.h |  93 ----
 4 files changed, 958 deletions(-)
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.c
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.h

diff --git a/drivers/staging/irda/drivers/Kconfig b/drivers/staging/irda/drivers/Kconfig
index e070e1222733..71ac76c5295a 100644
--- a/drivers/staging/irda/drivers/Kconfig
+++ b/drivers/staging/irda/drivers/Kconfig
@@ -17,51 +17,6 @@ config IRTTY_SIR
 
 	  If unsure, say Y.
 
-config BFIN_SIR
-	tristate "Blackfin SIR on UART"
-	depends on BLACKFIN && IRDA
-	default n
-	help
-	  Say Y here if your want to enable SIR function on Blackfin UART
-	  devices.
-
-	  To activate this driver you can start irattach like:
-	  "irattach irda0 -s"
-
-	  Saying M, it will be built as a module named bfin_sir.
-
-	  Note that you need to turn off one of the serial drivers for SIR
-	  to use that UART.
-
-config BFIN_SIR0
-	bool "Blackfin SIR on UART0"
-	depends on BFIN_SIR && !SERIAL_BFIN_UART0
-
-config BFIN_SIR1
-	bool "Blackfin SIR on UART1"
-	depends on BFIN_SIR && !SERIAL_BFIN_UART1 && (!BF531 && !BF532 && !BF533 && !BF561)
-
-config BFIN_SIR2
-	bool "Blackfin SIR on UART2"
-	depends on BFIN_SIR && !SERIAL_BFIN_UART2 && (BF54x || BF538 || BF539)
-
-config BFIN_SIR3
-	bool "Blackfin SIR on UART3"
-	depends on BFIN_SIR && !SERIAL_BFIN_UART3 && (BF54x)
-
-choice
-	prompt "SIR Mode"
-	depends on BFIN_SIR
-	default SIR_BFIN_DMA
-
-config SIR_BFIN_DMA
-	bool "DMA mode"
-	depends on !DMA_UNCACHED_NONE
-
-config SIR_BFIN_PIO
-	bool "PIO mode"
-endchoice
-
 config SH_SIR
 	tristate "SuperH SIR on UART"
 	depends on IRDA && SUPERH && \
diff --git a/drivers/staging/irda/drivers/Makefile b/drivers/staging/irda/drivers/Makefile
index e2901b135528..d5307ed2d9b4 100644
--- a/drivers/staging/irda/drivers/Makefile
+++ b/drivers/staging/irda/drivers/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_MCS_FIR)	        += mcs7780.o
 obj-$(CONFIG_AU1000_FIR)	+= au1k_ir.o
 # SIR drivers
 obj-$(CONFIG_IRTTY_SIR)		+= irtty-sir.o	sir-dev.o
-obj-$(CONFIG_BFIN_SIR)		+= bfin_sir.o
 obj-$(CONFIG_SH_SIR)		+= sh_sir.o
 # dongle drivers for SIR drivers
 obj-$(CONFIG_ESI_DONGLE)	+= esi-sir.o
diff --git a/drivers/staging/irda/drivers/bfin_sir.c b/drivers/staging/irda/drivers/bfin_sir.c
deleted file mode 100644
index 59e409b68349..000000000000
diff --git a/drivers/staging/irda/drivers/bfin_sir.h b/drivers/staging/irda/drivers/bfin_sir.h
deleted file mode 100644
index d47cf14bb4a5..000000000000
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
