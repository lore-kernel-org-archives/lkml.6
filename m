Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2263469-1520157383-2-12920214614857716258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520157383; b=luYcWWyGcSFiDdK5wlWRkbIeR5loVEazzHwCE/kK8Ay564u
    K8X20WWckLS12jv1Ll9e4hTULET0CBcY24KIgS7fcPe06WZSv573vUUGuX5aFcyk
    S67WEsvJKUzCMuRNS0tp0X9EJ0c9n+hdprYU4gus64UAjG73X1KoLmX9PujrfXJP
    IUEsHHPJNlAg7DXnLWsxyZmcaIz3kVImyloIXF5LkUnupDQdhRgbKe4r1j51zHXm
    7iUnSQ7sG031T7mdADRR98Tq+5Tr3EnvaQXc7cm/I+IYDdWJmMsEmXXlIpyBbLZ/
    T27Y9NwuYR1f0LmfBdQg/9CLQCvnzLTugv5+FBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:subject:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520157383; bh=Q
    bmGKUCQ0GSOCe6r4tZk62mL2/4gVqFHGWc4HAzwsAw=; b=Nv2eK0CpV2RQx5yeA
    afVPrWj75OF08XtzMIqhoqTULg7fZkpP4fopk73HTOyuY8d4plvVxUxpFzAXbUac
    VqpYYehkNUtrfUHUPpcooQuhzhFEKV7QshgX29Bc8Wf2B1CrAam7SAq7UAnlC4U+
    IGe845pTtMeEu7gXxJC019ZB9gWHIFIV76sKOT6M00nTkBi3yasbFHi3HbuiSH5r
    Rd9uAcbMVNQbo5qmKRqri5MxboKL7wnrjcNG0sEToT+ZiqAJBTBz4TDh81eDOSxH
    mQg2R7dX0yk8EgkuZHjACzpHBO5EuYJOBh1F5BuDHcQnF4RI6w0wwAQds+QhhNaW
    wggbg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun,  4 Mar 2018 10:56:06 +0100
Message-Id: <20180304095606.10386-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] staging: pi433: fix CamelCase for flag enum
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

  CHECK: Avoid CamelCase: <modeSwitchCompleted>
  CHECK: Avoid CamelCase: <readyToReceive>
  CHECK: Avoid CamelCase: <readyToSend>
  CHECK: Avoid CamelCase: <pllLocked>
  CHECK: Avoid CamelCase: <rssiExceededThreshold>
  CHECK: Avoid CamelCase: <syncAddressMatch>
  CHECK: Avoid CamelCase: <packetSent>
  CHECK: Avoid CamelCase: <crcOk>
  CHECK: Avoid CamelCase: <batteryLow>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c  |  4 ++--
 drivers/staging/pi433/rf69.c      | 18 +++++++++---------
 drivers/staging/pi433/rf69_enum.h | 18 +++++++++---------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b1cbec876857..57db806ff5af 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -443,7 +443,7 @@ pi433_receive(void *data)
 		return retval;
 
 	/* now check RSSI, if low wait for getting high (RSSI interrupt) */
-	while (!rf69_get_flag(dev->spi, rssiExceededThreshold)) {
+	while (!rf69_get_flag(dev->spi, rssi_exceeded_threshold)) {
 		/* allow tx to interrupt us while waiting for high RSSI */
 		dev->interrupt_rx_allowed = true;
 		wake_up_interruptible(&dev->tx_wait_queue);
@@ -452,7 +452,7 @@ pi433_receive(void *data)
 		dev_dbg(dev->dev, "rx: going to wait for high RSSI level");
 		retval = wait_event_interruptible(dev->rx_wait_queue,
 						  rf69_get_flag(dev->spi,
-								rssiExceededThreshold));
+								rssi_exceeded_threshold));
 		if (retval) /* wait was interrupted */
 			goto abort;
 		dev->interrupt_rx_allowed = false;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 54d8105b5812..fc4919711477 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -545,21 +545,21 @@ int rf69_set_dio_mapping(struct spi_device *spi, u8 DIONumber, u8 value)
 bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 {
 	switch (flag) {
-	case modeSwitchCompleted:
+	case mode_switch_completed:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_MODE_READY);
-	case readyToReceive:
+	case ready_to_receive:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RX_READY);
-	case readyToSend:
+	case ready_to_send:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_TX_READY);
-	case pllLocked:
+	case pll_locked:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_PLL_LOCK);
-	case rssiExceededThreshold:
+	case rssi_exceeded_threshold:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI);
 	case timeout:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_TIMEOUT);
 	case automode:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_AUTOMODE);
-	case syncAddressMatch:
+	case sync_address_match:
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_SYNC_ADDRESS_MATCH);
 	case fifo_full:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_FULL);
@@ -571,13 +571,13 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_LEVEL);
 	case fifo_overrun:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_OVERRUN);
-	case packetSent:
+	case packet_sent:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PACKET_SENT);
 	case payload_ready:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PAYLOAD_READY);
-	case crcOk:
+	case crc_ok:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_CRC_OK);
-	case batteryLow:
+	case battery_low:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_LOW_BAT);
 	default:			 return false;
 	}
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 682b667bf342..81287ce6be35 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -94,23 +94,23 @@ enum threshold_decrement {
 };
 
 enum flag {
-	modeSwitchCompleted,
-	readyToReceive,
-	readyToSend,
-	pllLocked,
-	rssiExceededThreshold,
+	mode_switch_completed,
+	ready_to_receive,
+	ready_to_send,
+	pll_locked,
+	rssi_exceeded_threshold,
 	timeout,
 	automode,
-	syncAddressMatch,
+	sync_address_match,
 	fifo_full,
 //	fifo_not_empty, collision with next enum; replaced by following enum...
 	fifo_empty,
 	fifo_level_below_threshold,
 	fifo_overrun,
-	packetSent,
+	packet_sent,
 	payload_ready,
-	crcOk,
-	batteryLow
+	crc_ok,
+	battery_low
 };
 
 enum fifo_fill_condition {
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
