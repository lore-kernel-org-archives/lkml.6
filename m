Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233368-6-2642227634545359353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233367; b=A3z++FHAE9XkGrSipc3NwG/T/g+/cvWibgQANVe2GLVg5SL
    Klw1Ptl5SclhaL2dw9a9XcBFRHJy3FYll9NzhHWhzkuYc4+6rk3mGJN0LaTWyAjb
    r+cNEGr/oLjNAC0hxQNe50yhScQWx5JfJMXlVxiQyQTUgU3d+H3J36nghD9D4KdX
    M177St2DTShkiSXeGKi2qeg4MPyD0FxyxmmVdZvhO7htQ9Y8Rur29UDqPbis4iQB
    YJBfaZNt97ChCH+takg4Id98ZdLZtu0UMjE3+E6EJCnyzMynSFJOPmh3VP01j0Ky
    aC0+6NYJmdZExQtQkbt+2nKB0yauSLI/4wPWOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520233367; bh=n
    27PpBaXtk9JHMKYXcw+QCrP96Qzy6SPZSaq1n6yBxc=; b=oSTMYRSmid5hRBgxd
    i/mEzN4HCwwtLx5fednA26QRpeg6D2JbfGO2reEtVxDUWDa59js0LX4v5IQlcsWg
    sTEKQrSslM53LkqUSKyEog47TFSLJ6BVYeg2v9WxK3YrFAGRwBdnqEz6uIS2k0+j
    7lpOhmf5OXIRdM+uE7qMXJaGT6xRUxav5fsUIYumV+UCs9JlQs028wuAVwLs0ecs
    uZBoZWAJMxrZapOuQ0MVvaOwNvgx6rgeTKgIdKShHLpb7jDF81kgBGmqdkuoFqKq
    LpioN+Qus5pr7TkGVMFCYVTllvsTBs6E/2T0nytI8pHElpV78pqWDSTwIImEF9Rr
    51Q6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon,  5 Mar 2018 08:02:14 +0100
Message-Id: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 1/6 v2] staging: pi433: fix CamelCase for packetFormat enum
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warnings:

  CHECK: Avoid CamelCase: <packetFormat>
  CHECK: Avoid CamelCase: <packetLengthFix>
  CHECK: Avoid CamelCase: <packetLengthVar>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
v2: order patches so they apply correctly

 drivers/staging/pi433/pi433_if.c  | 8 ++++----
 drivers/staging/pi433/rf69.c      | 8 ++++----
 drivers/staging/pi433/rf69.h      | 2 +-
 drivers/staging/pi433/rf69_enum.h | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index aad1debd34a2..b1cbec876857 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -222,11 +222,11 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 			return ret;
 	}
 	if (rx_cfg->enable_length_byte == OPTION_ON) {
-		ret = rf69_set_packet_format(dev->spi, packetLengthVar);
+		ret = rf69_set_packet_format(dev->spi, packet_length_var);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_packet_format(dev->spi, packetLengthFix);
+		ret = rf69_set_packet_format(dev->spi, packet_length_fix);
 		if (ret < 0)
 			return ret;
 	}
@@ -337,11 +337,11 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 	}
 
 	if (tx_cfg->enable_length_byte == OPTION_ON) {
-		ret = rf69_set_packet_format(dev->spi, packetLengthVar);
+		ret = rf69_set_packet_format(dev->spi, packet_length_var);
 		if (ret < 0)
 			return ret;
 	} else {
-		ret = rf69_set_packet_format(dev->spi, packetLengthFix);
+		ret = rf69_set_packet_format(dev->spi, packet_length_fix);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index b2cea5f52eea..54d8105b5812 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -661,12 +661,12 @@ int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8])
 	return retval;
 }
 
-int rf69_set_packet_format(struct spi_device *spi, enum packetFormat packetFormat)
+int rf69_set_packet_format(struct spi_device *spi, enum packet_format packet_format)
 {
-	switch (packetFormat) {
-	case packetLengthVar:
+	switch (packet_format) {
+	case packet_length_var:
 		return rf69_set_bit(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE);
-	case packetLengthFix:
+	case packet_length_fix:
 		return rf69_clear_bit(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE);
 	default:
 		dev_dbg(&spi->dev, "set: illegal input param");
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index cf89b556cb00..7b7932a553e8 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -50,7 +50,7 @@ int rf69_disable_sync(struct spi_device *spi);
 int rf69_set_fifo_fill_condition(struct spi_device *spi, enum fifo_fill_condition fifo_fill_condition);
 int rf69_set_sync_size(struct spi_device *spi, u8 sync_size);
 int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8]);
-int rf69_set_packet_format(struct spi_device *spi, enum packetFormat packetFormat);
+int rf69_set_packet_format(struct spi_device *spi, enum packet_format packet_format);
 int rf69_enable_crc(struct spi_device *spi);
 int rf69_disable_crc(struct spi_device *spi);
 int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index cba3c5b3995c..682b667bf342 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -118,9 +118,9 @@ enum fifo_fill_condition {
 	always
 };
 
-enum packetFormat {
-	packetLengthFix,
-	packetLengthVar
+enum packet_format {
+	packet_length_fix,
+	packet_length_var
 };
 
 enum tx_start_condition {
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
