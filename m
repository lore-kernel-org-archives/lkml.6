Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AH8x226QpRHe5+WgBB1UjYX4rtgC0wn2y/GCnOBcgDf4/L66FrkgurgFNsRKVMnEiZHjI08aK4L/
ARC-Seal: i=1; a=rsa-sha256; t=1519135418; cv=none;
        d=google.com; s=arc-20160816;
        b=Ge+ZhggeGO5Ch84rOYrs0AKMJr7foPgIXLWSbYJtYWgk6ekTw6uaSg31zDrwUk+ort
         ZHu6arCGuJL8/mE4LWigbe7bHApxpVtSuN7XQeCoPG0GfiADQ+Z1gpU3RcpkrFTnRUpf
         DWPFN0WTS+RqAnchoRcNY0m+Szf80tjQd/DlkE/LeshBRIEmmnX5ZqH9e8AsyapXVGEC
         exl19bIgiYCcZIj5FLm1CRSM7HKxoTqzrW5YferTBAUHrxPTR03l03vob9IUhAKBfIQH
         k9gFIG2t7eG11xTq8sP+TT+IXuaDGuO0d5twg6FVUEewo4OGgnH4HYYVo7/iJSzXJbGg
         mwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:message-id:date:cc:to:from:arc-authentication-results;
        bh=I2iaWw2KtNKvscc8wzflbc3OYyyFKDWv5RW/ZA6/XWE=;
        b=Yd08uprd2xQ9L/SgFeAsP9eGciCbxkOXovmb7b17/fc5hPTWzAxn805bDqkW04OG09
         jriUhuo5MC7ntxwWq4IWjN0YPEgr+iZeVx+yygYlUWWsUUgc7GTBl/W+2Itld9R2yFuc
         VAdfCHAU8J2Bn3AWdGAh8Hif9ZgvuUerbMAgZuh1/AfvUn0in4TjATHuVFW+5isIgO4S
         CPPQhedzoUMhqfmB3Wzn6QaZ/B/eBa+5CIxunW1qczXUbCripZHLMjqTTQEXZW1z6hWD
         ditwZB3gUOZkhnbltbLXl/9UbEDF/KcckOo1rCXLzTYtT8QwOky52L6L7xCseogrl8Dq
         Z2dg==
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
Date: Tue, 20 Feb 2018 15:03:30 +0100
Message-Id: <20180220140330.22100-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] staging: pi433: fix CamelCase for thresholdDecrement
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592928939994849789?=
X-GMAIL-MSGID: =?utf-8?q?1592928939994849789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warning:

  CHECK: Avoid CamelCase: <thresholdDecrement>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Documentation/pi433.txt | 2 +-
 drivers/staging/pi433/pi433_if.h              | 2 +-
 drivers/staging/pi433/rf69.c                  | 4 ++--
 drivers/staging/pi433/rf69.h                  | 2 +-
 drivers/staging/pi433/rf69_enum.h             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 61ba9700d7dc..3313dff3c37e 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -180,7 +180,7 @@ rf params:
 		threshold value for the signal strength on the receiver input.
 		If this value is exceeded, a reception cycle starts
 		Allowed values: 0...255
-	thresholdDecrement
+	threshold_decrement
 		in order to adapt to different levels of singnal strength, over
 		time the receiver gets more and more sensitive. This value
 		determs, how fast the sensitivity increases.
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 69847f978a69..22c1631d0bf0 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -115,7 +115,7 @@ struct pi433_rx_cfg {
 	enum modulation		modulation;
 
 	__u8			rssi_threshold;
-	enum thresholdDecrement	threshold_decrement;
+	enum threshold_decrement threshold_decrement;
 	enum antenna_impedance	antenna_impedance;
 	enum lnaGain		lna_gain;
 	enum mantisse		bw_mantisse;	/* normal: 0x50 */
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 722d95a3777f..91c834059710 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -476,9 +476,9 @@ int rf69_set_bandwidth_during_afc(struct spi_device *spi, enum mantisse mantisse
 	return rf69_set_bandwidth_intern(spi, REG_AFCBW, mantisse, exponent);
 }
 
-int rf69_set_ook_threshold_dec(struct spi_device *spi, enum thresholdDecrement thresholdDecrement)
+int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement threshold_decrement)
 {
-	switch (thresholdDecrement) {
+	switch (threshold_decrement) {
 	case dec_every8th:
 		return rf69_read_mod_write(spi, REG_OOKPEAK, MASK_OOKPEAK_THRESDEC, OOKPEAK_THRESHDEC_EVERY_8TH);
 	case dec_every4th:
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 147d89390745..21d7034e2c79 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -40,7 +40,7 @@ int rf69_set_antenna_impedance(struct spi_device *spi, enum antenna_impedance an
 int rf69_set_lna_gain(struct spi_device *spi, enum lnaGain lnaGain);
 int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
 int rf69_set_bandwidth_during_afc(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
-int rf69_set_ook_threshold_dec(struct spi_device *spi, enum thresholdDecrement thresholdDecrement);
+int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement threshold_decrement);
 int rf69_set_dio_mapping(struct spi_device *spi, u8 DIONumber, u8 value);
 bool rf69_get_flag(struct spi_device *spi, enum flag flag);
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 196c95dfe327..478e3a4c4948 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -82,7 +82,7 @@ enum mantisse {
 	mantisse24
 };
 
-enum thresholdDecrement {
+enum threshold_decrement {
 	dec_every8th,
 	dec_every4th,
 	dec_every2nd,
-- 
2.16.1
