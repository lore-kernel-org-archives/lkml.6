Return-Path: <simon@nikanor.nu>
ARC-Seal: i=1; a=rsa-sha256; t=1523046787; cv=none;
        d=google.com; s=arc-20160816;
        b=NLisyKc9OMxBsEx5JA2pF5Fi39vcicf1+l/NgBfsHtZWFBDYdA1bT2oArLi7SyhABU
         aYU+XUKAR2LviuGXbSamYD4Q2f9s735Vi7kP5KC3hxEPD8ncCE0xEriLr2t7XVaqnvz4
         kvNcecrxYXAhiNWB5hxqLHe8Q4UQHfiOtpTbjnUnRmhn7ym+VlgmeC00/4I/jGqSTeDM
         Bff/4iuQSEdC1zcmvpzedRJOHh4BwR6Pl52XYckPPjelcXIpOQObWqWHfdJk09eUYIXJ
         jy4AN52AOhT3zd9w+XZlRQJ9AYbP/Ng/EoTFy75AGbphNV8FWtY9jzlHNJtjA5VOdYCM
         yL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=wmdjvA1j2AxKgLOBCuQodCX2lnRSc2kqmMJLIxhSmcg=;
        b=JrxtPtBGpoNVRrFsAEtt6Dqvz37xCjRdmjESd5dI+HecR9ZtY+7vxsYYZq4PV7nkif
         qYBehgFhJIGojqcWhHs1Bqe2fLwGAqs5LTaGV3w24ZmY3F9toA2yalFvKpS9tjOWueks
         iWnCAJZnqQhxtuMJPQZPfML5cx97IsoOai0hkx9nn9hW3EcIslpWqvZhw6fPyitnzbcc
         DEPcViu2ECML96siBFbENbr0MNU0/SlaVIL03fBCu6mCDSlFts7S1nkbNdwlKFw5IPYt
         lQQ/4HrQ+UnDMfE570zx2K9dzTfzAErYRBpnYGOVWru/zJ07m4kYqesRYQIUrvwW2XZ4
         ZLhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nikanor-nu.20150623.gappssmtp.com header.s=20150623 header.b=ojG2+EQd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of simon@nikanor.nu) smtp.mailfrom=simon@nikanor.nu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nikanor-nu.20150623.gappssmtp.com header.s=20150623 header.b=ojG2+EQd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of simon@nikanor.nu) smtp.mailfrom=simon@nikanor.nu
X-Google-Smtp-Source: AIpwx49jTaYXlQzDrWIKv5tJWITQlVhVNh25W67NOFu2dg0dTZX/BOL9HV3hb0TeXw7QB0VXMLHkMg==
From: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To: gregkh@linuxfoundation.org
Cc: Valentin.Vidic@CARNet.hr,
	marcin.s.ciupak@gmail.com,
	linux@Wolf-Entwicklungen.de,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: break long lines
Date: Fri,  6 Apr 2018 22:33:05 +0200
Message-Id: <20180406203305.6686-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597030308671594565?=
X-GMAIL-MSGID: =?utf-8?q?1597030308671594565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Breaks long lines in rf69.h, fixing checkpatch.pl warnings:
"WARNING: line over 80 characters"

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/pi433/rf69.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index b9f6850e3316..c131ffbdc2db 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -28,7 +28,8 @@
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
-int rf69_set_modulation_shaping(struct spi_device *spi, enum mod_shaping mod_shaping);
+int rf69_set_modulation_shaping(struct spi_device *spi,
+				enum mod_shaping mod_shaping);
 int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
 int rf69_set_deviation(struct spi_device *spi, u32 deviation);
 int rf69_set_frequency(struct spi_device *spi, u32 frequency);
@@ -36,28 +37,37 @@ int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
 int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask);
 int rf69_set_output_power_level(struct spi_device *spi, u8 power_level);
 int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp);
-int rf69_set_antenna_impedance(struct spi_device *spi, enum antenna_impedance antenna_impedance);
+int rf69_set_antenna_impedance(struct spi_device *spi,
+			       enum antenna_impedance antenna_impedance);
 int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain);
-int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
-int rf69_set_bandwidth_during_afc(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
-int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement threshold_decrement);
+int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse,
+		       u8 exponent);
+int rf69_set_bandwidth_during_afc(struct spi_device *spi,
+				  enum mantisse mantisse,
+				  u8 exponent);
+int rf69_set_ook_threshold_dec(struct spi_device *spi,
+			       enum threshold_decrement threshold_decrement);
 int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value);
 bool rf69_get_flag(struct spi_device *spi, enum flag flag);
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length);
 int rf69_enable_sync(struct spi_device *spi);
 int rf69_disable_sync(struct spi_device *spi);
-int rf69_set_fifo_fill_condition(struct spi_device *spi, enum fifo_fill_condition fifo_fill_condition);
+int rf69_set_fifo_fill_condition(struct spi_device *spi,
+				 enum fifo_fill_condition fifo_fill_condition);
 int rf69_set_sync_size(struct spi_device *spi, u8 sync_size);
 int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8]);
-int rf69_set_packet_format(struct spi_device *spi, enum packet_format packet_format);
+int rf69_set_packet_format(struct spi_device *spi,
+			   enum packet_format packet_format);
 int rf69_enable_crc(struct spi_device *spi);
 int rf69_disable_crc(struct spi_device *spi);
-int rf69_set_address_filtering(struct spi_device *spi, enum address_filtering address_filtering);
+int rf69_set_address_filtering(struct spi_device *spi,
+			       enum address_filtering address_filtering);
 int rf69_set_payload_length(struct spi_device *spi, u8 payload_length);
 int rf69_set_node_address(struct spi_device *spi, u8 node_address);
 int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcast_address);
-int rf69_set_tx_start_condition(struct spi_device *spi, enum tx_start_condition tx_start_condition);
+int rf69_set_tx_start_condition(struct spi_device *spi,
+				enum tx_start_condition tx_start_condition);
 int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_dagc(struct spi_device *spi, enum dagc dagc);
 
-- 
2.11.0
