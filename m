Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AH8x226l+WUeK03Te/zjBv0Qzo8/3dwHiFsWOgK78BRK0JWlyAc+Z4VVAPs6zxrAtHCN+EVaHR3A
ARC-Seal: i=1; a=rsa-sha256; t=1519135023; cv=none;
        d=google.com; s=arc-20160816;
        b=PI3KNEr4G8diR3VkLPBjTDgh8T4FAFsOcVvNLpv5hNT+pL6nWO6zURlJyJ19+zaMyl
         FEQQgIN6zwKSrytlQFn1V1oXIqim+BVS2910sjwrVh2zqUvESeh6RZ+uBdB8OzyucORF
         P99zbdMGA23hXa3x+gYYY33U+UfsU1aoKJaxsb4vuK0ueW58cxAomHuiAUPyjSCLJwqi
         0HNt5f1D0Zc9Yhse0fcWteGrpiA0KfjR0nAd9U5wN56WInVXzKBw7ux1rntz+mxEmtZc
         AV2eEhOEnQvLl+NfDXPQxAzjhh/u7kCbAYTD3ojZF2QfoB93NtAC4TbsURyCmhyEwKip
         VTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:message-id:date:cc:to:from:arc-authentication-results;
        bh=iOZEbiDD+tYPG5At4Ix7oBlRtK++jPRxiAo5ZM4+Mgw=;
        b=lnm1PMUpD8pXYfIMVcu8o2QzgUXgDFIxN6qqurGgMs8hbFt02uMEoY2ExeLvLQc3YG
         pYEBdL8YwSeAP9f6/86sXtgimzWBVJSHs+RWslIYKvI24nbDejcTsWrLqKRhimwzlWBA
         1hwd4/43SfrhuLhJn4U8or+3WIPSXHPcivZ0KwXjQJgXoeaioo8vgY5aU7glciLlMVzP
         YGBDM7ts76ka3W3pHcBjCjPR6gOZIId4S+IB/TBxcmfdPyf07Vcpc0ALa1Z5ToCQ7SZV
         g8lDTKnrWofccD36+Tr/ZtJXcwBPg65ng/1VFaKjy8tvLKUBUW1b/j8RZIPWIypzCIg9
         4GTg==
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
Date: Tue, 20 Feb 2018 14:56:45 +0100
Message-Id: <20180220135645.20985-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: fix CamelCase for txStartCondition
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592928526833154329?=
X-GMAIL-MSGID: =?utf-8?q?1592928526833154329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warning:

  CHECK: Avoid CamelCase: <txStartCondition>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.h  | 2 +-
 drivers/staging/pi433/rf69.c      | 4 ++--
 drivers/staging/pi433/rf69.h      | 2 +-
 drivers/staging/pi433/rf69_enum.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index c4e4ea086a24..69847f978a69 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -69,7 +69,7 @@ struct pi433_tx_cfg {
 
 	enum paRamp		pa_ramp;
 
-	enum txStartCondition	tx_start_condition;
+	enum tx_start_condition	tx_start_condition;
 
 	__u16			repetitions;
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 42c2e1c6b386..722d95a3777f 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -714,9 +714,9 @@ int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcastAddress)
 	return rf69_write_reg(spi, REG_BROADCASTADRS, broadcastAddress);
 }
 
-int rf69_set_tx_start_condition(struct spi_device *spi, enum txStartCondition txStartCondition)
+int rf69_set_tx_start_condition(struct spi_device *spi, enum tx_start_condition tx_start_condition)
 {
-	switch (txStartCondition) {
+	switch (tx_start_condition) {
 	case fifo_level:
 		return rf69_clear_bit(spi, REG_FIFO_THRESH, MASK_FIFO_THRESH_TXSTART);
 	case fifo_not_empty:
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 2c0d130f7a03..147d89390745 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -57,7 +57,7 @@ int rf69_set_adressFiltering(struct spi_device *spi, enum addressFiltering addre
 int rf69_set_payload_length(struct spi_device *spi, u8 payload_length);
 int rf69_set_node_address(struct spi_device *spi, u8 nodeAddress);
 int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcastAddress);
-int rf69_set_tx_start_condition(struct spi_device *spi, enum txStartCondition txStartCondition);
+int rf69_set_tx_start_condition(struct spi_device *spi, enum tx_start_condition tx_start_condition);
 int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_dagc(struct spi_device *spi, enum dagc dagc);
 
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 5629af716e4f..196c95dfe327 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -123,7 +123,7 @@ enum packetFormat {
 	packetLengthVar
 };
 
-enum txStartCondition {
+enum tx_start_condition {
 	fifo_level,
 	fifo_not_empty
 };
-- 
2.16.1
