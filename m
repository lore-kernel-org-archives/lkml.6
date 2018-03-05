Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233376-2-7670181099472185110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233374; b=G4Mcczverm/ltZj+dAvW1l1sOy6xjN7zoKvfwBPr0Z09ugv
    fPnvsvSPTaFKh6gLbyVAqVVFw9+R3AAVVuFSeXfIvgOTpiWaEZmRhOksJT5zJ1Dk
    puuuRtTm2S+X40ejBlQ9/ayL4rlUMBlsOB6wt725NBIAVSxLN4k2ywGZAPSvwBIM
    92L4+UVBS2vTt182XrVvggmzQBrAfHylMWExdtfjwXALw0TMhglLU9WXrnsp/4m9
    eKLzJ4nQs5HBjpT+YirI37uwXUFzWztyXQxmJ21kwe02D7d2njsIGiTXziARpx3w
    MQWpaFnF1iIQZnY/2bs8IMMsLkqBdQ8fO1JkxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520233374; bh=U
    anCs2sokfvfKWqVMMzjUbeOVBv6s+1qsT6x8C77WfM=; b=LQUmnVQLekVaziwce
    MTydrdpbFEQK9iac75CtR6tJy1CVRvB/KAZym9nRJLejctE4kPuSyeNaqdcdYVE1
    rYjuFqMfo4/YYDaBzi9VI+82GHJalB7olmhy563O2KOJaxKRzycW0gfs2hwfA6AA
    rSYyRY225MtUMeW5z3rKBA5TNNP0qfOWl6UxsFVADetXeWMJrJSvDfqrv3ke7wM2
    o53tLKJcneQuDrRVvE2tSryA4+x6qHg8w7ZgDL0gysedOPUkCyP1/KHKCY3H2qqN
    v3VGHgvWmyQyr9ISBtjhP1Ft1VoG1kP2F3n3kZT5wnntpX9pvKi3Zsami1TflznP
    E8AwQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
Date: Mon,  5 Mar 2018 08:02:17 +0100
Message-Id: <20180305070219.7131-4-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
References: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 4/6] staging: pi433: fix CamelCase for address_filtering enum
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

  CHECK: Avoid CamelCase: <filteringOff>
  CHECK: Avoid CamelCase: <nodeAddress>
  CHECK: Avoid CamelCase: <nodeOrBroadcastAddress>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Documentation/pi433.txt | 12 ++++++------
 drivers/staging/pi433/pi433_if.c              |  6 +++---
 drivers/staging/pi433/rf69.c                  |  6 +++---
 drivers/staging/pi433/rf69_enum.h             |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 3313dff3c37e..2e8835bf2c9a 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -232,12 +232,12 @@ rf params:
 			     amount of bytes that were requested by the read request.
 		Attention: should be used in combination with sync, only
 	enable_address_filtering;
-		filteringOff		- no address filtering will take place
-		nodeAddress		- all telegrams, not matching the node
-					  address will be internally discarded
-		nodeOrBroadcastAddress	- all telegrams, neither matching the
-					  node, nor the broadcast address will
-					  be internally discarded
+		filtering_off		  - no address filtering will take place
+		node_address		  - all telegrams, not matching the node
+					    address will be internally discarded
+		node_or_broadcast_address - all telegrams, neither matching the
+					    node, nor the broadcast address will
+					    be internally discarded
 		Attention: Sync option must be enabled in order to use this feature
 	enable_crc
 		optionOn	- a crc will be calculated over the payload of
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 730200597218..88da91d31e61 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -257,7 +257,7 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 		payload_length = rx_cfg->fixed_message_length;
 		if (rx_cfg->enable_length_byte  == OPTION_ON)
 			payload_length++;
-		if (rx_cfg->enable_address_filtering != filteringOff)
+		if (rx_cfg->enable_address_filtering != filtering_off)
 			payload_length++;
 		ret = rf69_set_payload_length(dev->spi, payload_length);
 		if (ret < 0)
@@ -274,7 +274,7 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 		if (ret < 0)
 			return ret;
 	}
-	if (rx_cfg->enable_address_filtering != filteringOff) {
+	if (rx_cfg->enable_address_filtering != filtering_off) {
 		ret = rf69_set_node_address(dev->spi, rx_cfg->node_address);
 		if (ret < 0)
 			return ret;
@@ -502,7 +502,7 @@ pi433_receive(void *data)
 	}
 
 	/* address byte enabled? */
-	if (dev->rx_cfg.enable_address_filtering != filteringOff) {
+	if (dev->rx_cfg.enable_address_filtering != filtering_off) {
 		u8 dummy;
 
 		bytes_total--;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index a73a3d2c0685..f419a3d4485b 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -687,11 +687,11 @@ int rf69_disable_crc(struct spi_device *spi)
 int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering)
 {
 	switch (address_filtering) {
-	case filteringOff:
+	case filtering_off:
 		return rf69_read_mod_write(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_ADDRESSFILTERING, PACKETCONFIG1_ADDRESSFILTERING_OFF);
-	case nodeAddress:
+	case node_address:
 		return rf69_read_mod_write(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_ADDRESSFILTERING, PACKETCONFIG1_ADDRESSFILTERING_NODE);
-	case nodeOrBroadcastAddress:
+	case node_or_broadcast_address:
 		return rf69_read_mod_write(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_ADDRESSFILTERING, PACKETCONFIG1_ADDRESSFILTERING_NODEBROADCAST);
 	default:
 		dev_dbg(&spi->dev, "set: illegal input param");
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index d82d2be88cbd..43990e74db85 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -129,9 +129,9 @@ enum tx_start_condition {
 };
 
 enum address_filtering {
-	filteringOff,
-	nodeAddress,
-	nodeOrBroadcastAddress
+	filtering_off,
+	node_address,
+	node_or_broadcast_address
 };
 
 enum dagc {
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
