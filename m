Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233369-2-12441708153320421723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233368; b=bq0gP3Sn8kofcquQBusU9aDHLRLlMtmG9Kgr551baIZUbWb
    ySnc5BOOe0Y7Mmj/6JcmHVsQ3DdBIj4Ck8C55hpNnleZgvxBCWDc1efZdFu7bLbc
    iAiPf3IoO+G/jWUcOabKMxReapKeGNR1ot5/ao9r3/BJp0PmYe7AWjfpDam0b1jO
    sLe5joAM4pKO0oHg+Gq2+CJ5+947FfvOqZl2XiCLhqDCNyZW1b47X9DuNA7OJ/hL
    2OTrffNXGpDH8jVOi0ffTS+rhP5H6SPPQneH4DKt6kAmoy7e2FdrIekQJ7g2iTB6
    910ONXLTAlp7Uw+A2PVUPNZTSimzTEpszoaFlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520233368; bh=s
    DDNVHsi8mR5HWUL0ZMi9B7sHviixr1hqOwJwargE34=; b=Tqra+lC9F3/hUilf1
    YbzsnLOsWnK0XvY6IFTN1mEL/LjTlHes82wCwHJC/kntWDCgsh8Bf6Lsq5j0UevC
    kFwxlLaHBmbsrGYcG/yDyUMSY0WVRaSn40WKa7emoib6vpBZ3w4Xo4ewaT6DoVTK
    58+P4/xb76RCO5hnw1+CYM6+hRdDBx0P6XAubJqF2vO0JQfUmQtkLrgmQpgcmGuM
    wMatymkOiP0a+CrHmGhxunelfdzApod/CRwM/wr/KDkMtNbHtC4gwtvRPuCjL+ka
    U2SbOVyjr/RVJ9t0TIF09uMqpmVG8nWUrNujtT+wihfeF5nDLNXGCI1vKlA0Eosm
    kzsFA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
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
Date: Mon,  5 Mar 2018 08:02:19 +0100
Message-Id: <20180305070219.7131-6-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
References: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH 6/6] staging: pi433: fix CamelCase for paRamp enum
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

Fixes checkpatch warning:

  CHECK: Avoid CamelCase: <paRamp>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Documentation/pi433.txt | 2 +-
 drivers/staging/pi433/pi433_if.h              | 2 +-
 drivers/staging/pi433/rf69.c                  | 4 ++--
 drivers/staging/pi433/rf69.h                  | 2 +-
 drivers/staging/pi433/rf69_enum.h             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 2e8835bf2c9a..79bccc586869 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -92,7 +92,7 @@ rf params:
 		shaping0_3	- gauss filter with BT 0.3 (FSK only)
 		shapingBR	- filter cut off at BR (OOK only)
 		shaping2BR	- filter cut off at 2*BR (OOK only)
-	paRamp (FSK only)
+	pa_ramp (FSK only)
 		ramp3400	- amp ramps up in 3.4ms
 		ramp2000	- amp ramps up in 2.0ms
 		ramp1000	- amp ramps up in 1ms
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index b3fa4fe64c5c..be4a96055a97 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -67,7 +67,7 @@ struct pi433_tx_cfg {
 	enum modulation		modulation;
 	enum mod_shaping	mod_shaping;
 
-	enum paRamp		pa_ramp;
+	enum pa_ramp		pa_ramp;
 
 	enum tx_start_condition	tx_start_condition;
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index c143ffc7596f..e5c7e48a3b86 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -345,9 +345,9 @@ int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
 	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER, power_level);
 }
 
-int rf69_set_pa_ramp(struct spi_device *spi, enum paRamp paRamp)
+int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
 {
-	switch (paRamp) {
+	switch (pa_ramp) {
 	case ramp3400:
 		return rf69_write_reg(spi, REG_PARAMP, PARAMP_3400);
 	case ramp2000:
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 677091319d7e..d83808a5dd86 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -35,7 +35,7 @@ int rf69_set_frequency(struct spi_device *spi, u32 frequency);
 int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
 int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask);
 int rf69_set_output_power_level(struct spi_device *spi, u8 power_level);
-int rf69_set_pa_ramp(struct spi_device *spi, enum paRamp paRamp);
+int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp);
 int rf69_set_antenna_impedance(struct spi_device *spi, enum antenna_impedance antenna_impedance);
 int rf69_set_lna_gain(struct spi_device *spi, enum lnaGain lnaGain);
 int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 43990e74db85..5ac3d33a3d0c 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -41,7 +41,7 @@ enum mod_shaping {
 	SHAPING_2BR
 };
 
-enum paRamp {
+enum pa_ramp {
 	ramp3400,
 	ramp2000,
 	ramp1000,
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
