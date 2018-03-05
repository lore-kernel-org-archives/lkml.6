Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233367-2-3147760567476060395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233366; b=Odc8fWkPUPuPU+RUwRTtx49Wg2ioWfFW50pltMBLWIzBipy
    DHs5uJQ77rAyFwTT06/BJzBcEENhnja6CgClatgiGVH9p1hbaCHXxFDe8yhBcYO5
    2hN4RVfytm/y6jxgexJl/8dVEoCVZnLmGpJ7ts8A6X9FmS6SlTng8xcGQiwXaE60
    uxsTvaedkUsgVyWR/0mW27DFiuevRgndrtqa5+UE0Zvc1iwmKBb49PoWkIFB56Nt
    48mA4P4nI84WKet/RhD2LGdnMwN5wjcY9r7sFywVgKNoz/adgTyA7gXa3Xbfucl1
    L8rXjzP/XzkLuwCn9ZISJABLooKlOG2PV6eqXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520233366; bh=t
    QZVlgJtP7c44WQGm9KdX5TCy6YH7VLf2kWi7zOJE0U=; b=lX2CltytNDTHkhMFM
    JsD7MP1nM7915pVkd5s4Jd/5iqI8QEEyhZXZuWeY7pq/Z3HILp9LgxnG6aOSMJPn
    HOJSRSQFnFP4k9Z/qV9PCcHhfHOlLOTEA7qhphbyv4VvLww6+4kp4v8wCgW7u2s6
    QDnkETtZNYVsAtxISw/YlH15V9XTUTq+xTVcJhK9x1BjnULeIwHTGrU+6l1rU62Y
    YVO8VPMcC0mX7Slz86a9wMC282o89pyBBI4cyqe1ETWgDvuKE2UsJhcf0hTpIeIq
    uAveI+mVrLlSGKCs41PyJ8+s8O5rsBksC63nTNrf7BwAZzBr65ByvwznhRNDt9RO
    Oo29g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon,  5 Mar 2018 08:02:18 +0100
Message-Id: <20180305070219.7131-5-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
References: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 5/6] staging: pi433: fix CamelCase for Address variables
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

  CHECK: Avoid CamelCase: <nodeAddress>
  CHECK: Avoid CamelCase: <broadcastAddress>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/rf69.c | 8 ++++----
 drivers/staging/pi433/rf69.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index f419a3d4485b..c143ffc7596f 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -704,14 +704,14 @@ int rf69_set_payload_length(struct spi_device *spi, u8 payload_length)
 	return rf69_write_reg(spi, REG_PAYLOAD_LENGTH, payload_length);
 }
 
-int rf69_set_node_address(struct spi_device *spi, u8 nodeAddress)
+int rf69_set_node_address(struct spi_device *spi, u8 node_address)
 {
-	return rf69_write_reg(spi, REG_NODEADRS, nodeAddress);
+	return rf69_write_reg(spi, REG_NODEADRS, node_address);
 }
 
-int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcastAddress)
+int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcast_address)
 {
-	return rf69_write_reg(spi, REG_BROADCASTADRS, broadcastAddress);
+	return rf69_write_reg(spi, REG_BROADCASTADRS, broadcast_address);
 }
 
 int rf69_set_tx_start_condition(struct spi_device *spi, enum tx_start_condition tx_start_condition)
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 7b7932a553e8..677091319d7e 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -55,8 +55,8 @@ int rf69_enable_crc(struct spi_device *spi);
 int rf69_disable_crc(struct spi_device *spi);
 int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering);
 int rf69_set_payload_length(struct spi_device *spi, u8 payload_length);
-int rf69_set_node_address(struct spi_device *spi, u8 nodeAddress);
-int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcastAddress);
+int rf69_set_node_address(struct spi_device *spi, u8 node_address);
+int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcast_address);
 int rf69_set_tx_start_condition(struct spi_device *spi, enum tx_start_condition tx_start_condition);
 int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_dagc(struct spi_device *spi, enum dagc dagc);
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
