Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597699-1521060272-2-12975876740508379724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060272; b=tzJmDqSokiROVOz1/xY0i4kB+h9NEAd4zGeTk0fZYupBRUT
    z9srwAqguWaGA/ZRG7g2m7ObJHR/HqPwD8kFNbV3G3ny4iJvJXP0FPrA/sFKaBU6
    +8JoLHNcpkPC+hvHP5BEuIUchZGrCpQdWTb9EhrKPnxv6xlc0lkvZhgu2bcxwcg4
    Q8yK4YCOs/URb2DIJm0yBt11dIMSqpWUGUhuhRBxDMGpa0pfSsXSb2XPBL46azsE
    oU6JzaLYXwlVHDcpgNdulTWB1kRPJzIARsaB3bN0DflAxDmmAMZfgl/8n20AWQJh
    9OEJ7viVaU1Acqnxvdao7jOUyMmP4n6v/O7fQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060272; bh=W
    8uwV+7jszongBj5tKC7LYevujS6JTUOgbzXd83zGdM=; b=TH93FFjabSmmuv34e
    N2kJ1XU7I8eXa/79KDbyjnw67KDYtQtX0zJfQKaMZ8xAlJe7DC7+8nKibCPiLbYf
    sDwgiQhkFNRqL11oHKmuv6k78fqQVHDmhnQRRDrRr6KzgEYwLKcwGkxqVn3ocUMp
    bCW9FM/bUDYXWbk1uU0TPUg75hD0Fs4rZ0eMY3ZpfCaJ1Bd2IdyMVwaajYcSty5h
    gn4EyXOtX8VDQ1o17Q4tmRaKRuLwophQMhfsJxUBOQDAuqi17s8Ah3OkZdi67ct5
    XeYCD1nwlDmdUY6+G7/0FXwZP4C/OCksLMUFbDDu9O0cq612+DIJEGJ2A00qKCIh
    6+JfA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
Date: Wed, 14 Mar 2018 21:44:06 +0100
Message-Id: <20180314204407.2777-6-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
References: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 6/7] staging: pi433: fix CamelCase for lnaGain enum
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

  CHECK: Avoid CamelCase: <lnaGain>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Documentation/pi433.txt | 2 +-
 drivers/staging/pi433/pi433_if.h              | 2 +-
 drivers/staging/pi433/rf69.c                  | 4 ++--
 drivers/staging/pi433/rf69.h                  | 2 +-
 drivers/staging/pi433/rf69_enum.h             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 79bccc586869..3bb38644eb6e 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -196,7 +196,7 @@ rf params:
 		sets the electrical adoption of the antenna
 		fifty_ohm	- for antennas with an impedance of 50Ohm
 		two_hundred_ohm	- for antennas with an impedance of 200Ohm
-	lnaGain
+	lna_gain
 		sets the gain of the low noise amp
 		automatic	- lna gain is determined by an agc
 		max		- lna gain is set to maximum
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index be4a96055a97..b6e214c29ddf 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -117,7 +117,7 @@ struct pi433_rx_cfg {
 	__u8			rssi_threshold;
 	enum threshold_decrement threshold_decrement;
 	enum antenna_impedance	antenna_impedance;
-	enum lnaGain		lna_gain;
+	enum lna_gain		lna_gain;
 	enum mantisse		bw_mantisse;	/* normal: 0x50 */
 	__u8			bw_exponent;	/* during AFC: 0x8b */
 	enum dagc		dagc;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e3394094f6a1..0bc459e32f6b 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -399,9 +399,9 @@ int rf69_set_antenna_impedance(struct spi_device *spi, enum antenna_impedance an
 	}
 }
 
-int rf69_set_lna_gain(struct spi_device *spi, enum lnaGain lnaGain)
+int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
 {
-	switch (lnaGain) {
+	switch (lna_gain) {
 	case automatic:
 		return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN, LNA_GAIN_AUTO);
 	case max:
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 4d6fc07f8255..b9f6850e3316 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -37,7 +37,7 @@ int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask);
 int rf69_set_output_power_level(struct spi_device *spi, u8 power_level);
 int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp);
 int rf69_set_antenna_impedance(struct spi_device *spi, enum antenna_impedance antenna_impedance);
-int rf69_set_lna_gain(struct spi_device *spi, enum lnaGain lnaGain);
+int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain);
 int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
 int rf69_set_bandwidth_during_afc(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
 int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement threshold_decrement);
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 5ac3d33a3d0c..eabaea99949d 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -65,7 +65,7 @@ enum antenna_impedance {
 	two_hundred_ohm
 };
 
-enum lnaGain {
+enum lna_gain {
 	automatic,
 	max,
 	max_minus_6,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
