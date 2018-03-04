Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AG47ELsD0H7pbOpZAJ9Kfha10rXDX5oIJQEpepaaCpOYo0dm7NZeGPNP673jqXxjmVPo+8mQ0CfF
ARC-Seal: i=1; a=rsa-sha256; t=1520157399; cv=none;
        d=google.com; s=arc-20160816;
        b=JZjEMJqm/1dXw9khh6kYinqgsldECIawcdQ/dS9zwEL8Hb0u3moLl23lkbCr6qUgYf
         OCzMy1rrp5UTtYG6KyiffrQqfNw335lGSAGfJzCbSygzyAdQZHdlmZkFUYCqVfHCeLg3
         6wLbQG/NY+61eJ8UO9H55O2GfaZfh4zITFRVolHqkG/nxw74hHOH+nS2NVF4RaorMf7C
         GunZbkXRSJL6Hr+rJsolQ7Wc6tsiFrKlu5znNMDTo6ZEuRqEZ1k8r+FU03MYLyOO/Yhi
         pWzcsWq7KaasDudlkGyf8fd52EVwov9PHkXraoV90loAg9afAviGWUaPPDVSKJypX4+Y
         Sk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:message-id:date:cc:to:from:arc-authentication-results;
        bh=zgkRm3JXQgxjL3X0QhRv3Pnij0xQlGeO+NDxZjhucBE=;
        b=DNppenmyXiT4Uoz7i4VcZq1btHnswftd2qVS+q8HmerPPc+qjTsjDxf8sl0lXj5FAN
         uSG+ljOGvatNCJSfmHMMs5mqlBuKpw2WtYzAlDbFKLbVJWB41bzimCcQ6KHpkpVRnc2c
         E9FTILpDvTemoKJ/OSDeq7UEaRKIzNH1Y5xQ2+8dk7NsRDOPesUTnGevWlxxBxifVqcg
         mCQ+gm1t7NUUmroyncUqX2PzMSrVpNX/Ur3Y/jpiw2Cp3eIfJw8n2KkVwbMbg3nFBpEF
         dpFOf+pyDRmi0DXBBBqODCWza/Y5px7lXx5zyHxgjYB4ihH/hlFFMIHV2evWiQFo5Iz1
         ycPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
	Marcus Wolf <linux@Wolf-Entwicklungen.de>,
	=?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>,
	Marcin Ciupak <marcin.s.ciupak@gmail.com>,
	Michael Panzlaff <michael.panzlaff@fau.de>,
	Derek Robson <robsonde@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date: Sun,  4 Mar 2018 10:56:36 +0100
Message-Id: <20180304095636.10534-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: fix CamelCase for Address variables
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594000565285143756?=
X-GMAIL-MSGID: =?utf-8?q?1594000565285143756?=
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
