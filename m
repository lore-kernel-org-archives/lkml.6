Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8AFC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8F21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB4BhIO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfA1RDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:03:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36463 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733011AbfA1QOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so18706683wrp.3;
        Mon, 28 Jan 2019 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iepLtzBVPhX7pl8gXv2iT2Rr+6RSkbyfrOjRx9czEQU=;
        b=iB4BhIO3cQH34C9OZgNQSCSdLG2PUwZy1YtzezvtYtCL40i4Z0QPv+v3xzmNAhL06L
         ZVZn9Bv53oWX1qRiblXT9as4Hs5ifJKaXvShRq9gOwZVS4vx2vYxB0a8U0FVKHTvJndW
         YW/BCJdo6m4yaSbzrkeKWIdxpxaztlkzqb8tEMGVFYY12gbk+4+NRQATcqgqL3rcspXt
         BHg6SxTZcLl+n+OajkcIFYkdLCxeUbY5O8562qmMdPgB26PodYyiFp1M4h59N6D8siG2
         2rC8UJZxXU5ibgOg0vg+xOx3Y3r6aHj/d9wMrbrBKt8w208L/ofpkZdDknqOIu3YbP3B
         3TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iepLtzBVPhX7pl8gXv2iT2Rr+6RSkbyfrOjRx9czEQU=;
        b=iYfT09Mi9aZngGwIM+Z9xSxRZuAtJD4CdO/fdekbhCSkdx4DASraQrmZ834AeAn+ko
         42ArSIhFlvhhVlMBgHyul+P0C32zH8MVPj+A58isXtyIWavK0KAGzN9rX4Ai3fYR1kiN
         tZByYpat6hQe0iFZSwUlkAalcb0jYk1tA5alDhIYl0+3RSCxKlR/EaWhY1DtBW6XXzij
         GS+8KbM20Kk2tHNZIgTDOrcqoyrxHzl2UJQQCY+loru1Rz17e6jm41stUfLkMfzZGz2S
         nNQVPIK8/znSOsRbALr/27wvE8wVPMttOkHmOSEfZtDoZUKUr5fOIMMD0cF+3gVbCEsG
         EQQg==
X-Gm-Message-State: AJcUukfR/eHPFaLVgfIxqZjO62dlbuYAXpvbl9tMUvC6FN6uGtMU8nUw
        GXa3/zrh6ucINiTRlHP8huo=
X-Google-Smtp-Source: ALg8bN6drcVo2/5yizY4N2gTwsczFFPBN0wuWFroWZzR9DyRs/hX1vWpD2hq8uft79zfwNXr9DyAJA==
X-Received: by 2002:adf:df01:: with SMTP id y1mr23302210wrl.127.1548692039020;
        Mon, 28 Jan 2019 08:13:59 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:58 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 11/11] net: lora: sx130x: add patch to register fields
Date:   Mon, 28 Jan 2019 16:13:05 +0000
Message-Id: <20190128161306.27805-12-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SX130x chips require a number of constant adjustments and patches.
We add the fields for the registers which require patches, add patch
values then add a helper to patch fields. Removing one TODO.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx130x.c | 131 +++++++++++++++++++++++++++++++++++++-
 drivers/net/lora/sx130x.h |  75 ++++++++++++++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 428e82b4ccb8..6e3b42de98a0 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -27,6 +27,63 @@
 
 #include "sx130x.h"
 
+struct sx130x_fields_sequence {
+	enum sx130x_fields field;
+	u8 val;
+};
+
+static const struct sx130x_fields_sequence sx130x_regmap_fields_patch[] = {
+	/* I/Q path setup */
+	{F_RSSI_BB_FILTER_ALPHA,	6},
+	{F_RSSI_DEC_FILTER_ALPHA,	7},
+	{F_RSSI_CHANN_FILTER_ALPHA,	7},
+	{F_RSSI_BB_DEFAULT_VALUE,	23},
+	{F_RSSI_DEC_DEFAULT_VALUE,	85},
+	{F_RSSI_CHANN_DEFAULT_VALUE,	66},
+	{F_DEC_GAIN_OFFSET,		7},
+	{F_CHAN_GAIN_OFFSET,		6},
+
+	/* LoRa 'multi' demodulator setup */
+	{F_SNR_AVG_CST,			3},
+	{F_FRAME_SYNCH_PEAK1_POS,	3}, // Public LoRa network
+	{F_FRAME_SYNCH_PEAK2_POS,	4}, // Public LoRa network
+
+	/* LoRa standalone 'MBWSSF' demodulator setup */
+	{F_MBWSSF_FRAME_SYNCH_PEAK1_POS, 3}, // Public LoRa network
+	{F_MBWSSF_FRAME_SYNCH_PEAK2_POS, 4}, // Public LoRa network
+
+	/* Improvement of ref clock freq error tolerance */
+	{F_ADJUST_MODEM_START_OFFSET_RDX4L, 1},
+	{F_ADJUST_MODEM_START_OFFSET_SF12_RDX4L, (4094 & 0xFF)},
+	{F_ADJUST_MODEM_START_OFFSET_SF12_RDX4H, (4094 >> 8)},
+	{F_CORR_MAC_GAIN,		7},
+
+	/* FSK datapath setup */
+	{F_FSK_RX_INVERT,		1},
+	{F_FSK_MODEM_INVERT_IQ,		1},
+
+	/* FSK demodulator setup */
+	{F_FSK_RSSI_LENGTH,		4},
+	{F_FSK_PKT_MODE,		1},
+	{F_FSK_CRC_EN,			1},
+	{F_FSK_DCFREE_ENC,		2},
+	{F_FSK_ERROR_OSR_TOL,		10},
+	{F_FSK_PKT_LENGTH,		255},
+	{F_FSK_PATTERN_TIMEOUT_CFGL,	128},
+
+	/* TX general parameters */
+	{F_TX_START_DELAYL, (TX_START_DELAY_DEFAULT & 0xFF)},
+	{F_TX_START_DELAYH, (TX_START_DELAY_DEFAULT >> 8)},
+
+	/* TX LoRa */
+	{F_TX_SWAP_IQ,			1},
+	{F_TX_FRAME_SYNCH_PEAK1_POS,	3}, // Public LoRa network
+	{F_TX_FRAME_SYNCH_PEAK2_POS,	4}, // Public LoRa network
+
+	/* TX FSK */
+	{F_FSK_TX_GAUSSIAN_SELECT_BT,	2},
+};
+
 static const struct reg_field sx130x_regmap_fields[] = {
 	/* PAGE */
 	[F_SOFT_RESET]          = REG_FIELD(SX1301_PAGE, 7, 7),
@@ -54,6 +111,59 @@ static const struct reg_field sx130x_regmap_fields[] = {
 	[F_TX_TRIG_IMMEDIATE] = REG_FIELD(SX1301_TX_TRIG, 0, 0),
 	[F_TX_TRIG_DELAYED] = REG_FIELD(SX1301_TX_TRIG, 1, 1),
 	[F_TX_TRIG_GPS] = REG_FIELD(SX1301_TX_TRIG, 2, 2),
+
+	/* RSSI_X_FILTER_ALPHA */
+	[F_RSSI_BB_FILTER_ALPHA] = REG_FIELD(SX1301_RSSI_BB_FILTER_ALPHA, 0, 4),
+	[F_RSSI_DEC_FILTER_ALPHA] = REG_FIELD(SX1301_RSSI_DEC_FILTER_ALPHA, 0, 4),
+	[F_RSSI_CHANN_FILTER_ALPHA]	= REG_FIELD(SX1301_RSSI_CHANN_FILTER_ALPHA, 0, 4),
+	/* RSSI_X_DEFAULT_VALUE */
+	[F_RSSI_BB_DEFAULT_VALUE] = REG_FIELD(SX1301_RSSI_BB_DEFAULT_VALUE, 0, 7),
+	[F_RSSI_DEC_DEFAULT_VALUE] = REG_FIELD(SX1301_RSSI_DEC_DEFAULT_VALUE, 0, 7),
+	[F_RSSI_CHANN_DEFAULT_VALUE] = REG_FIELD(SX1301_RSSI_CHANN_DEFAULT_VALUE, 0, 7),
+	/* GAIN_OFFSET */
+	[F_DEC_GAIN_OFFSET]	= REG_FIELD(SX1301_GAIN_OFFSET, 0, 3),
+	[F_CHAN_GAIN_OFFSET]	= REG_FIELD(SX1301_GAIN_OFFSET, 4, 7),
+
+	[F_SNR_AVG_CST] = REG_FIELD(SX1301_MISC_CFG1, 4, 5),
+	[F_FRAME_SYNCH_PEAK1_POS] = REG_FIELD(SX1301_FRAME_SYNCH, 0, 3),
+	[F_FRAME_SYNCH_PEAK2_POS] = REG_FIELD(SX1301_FRAME_SYNCH, 4, 7),
+
+	[F_MBWSSF_FRAME_SYNCH_PEAK1_POS] = REG_FIELD(SX1301_BHSYNCPOS, 0, 3),
+	[F_MBWSSF_FRAME_SYNCH_PEAK2_POS] = REG_FIELD(SX1301_BHSYNCPOS, 4, 7),
+
+	[F_ADJUST_MODEM_START_OFFSET_RDX4L] =
+		REG_FIELD(SX1301_MODEM_START_RDX4L, 0, 7),  // 12 bits
+	[F_ADJUST_MODEM_START_OFFSET_RDX4H] =
+		REG_FIELD(SX1301_MODEM_START_RDX4H, 0, 3),
+	[F_ADJUST_MODEM_START_OFFSET_SF12_RDX4L] =
+		REG_FIELD(SX1301_MODEM_START_SF12_RDX4L, 0, 7), // 12 bits
+	[F_ADJUST_MODEM_START_OFFSET_SF12_RDX4H] =
+		REG_FIELD(SX1301_MODEM_START_SF12_RDX4H, 0, 3),
+	[F_CORR_MAC_GAIN] = REG_FIELD(SX1301_CORR_CFG, 4, 6),
+
+	[F_FSK_RSSI_LENGTH] = REG_FIELD(SX1301_FSK_CFG1, 3, 5),
+	[F_FSK_RX_INVERT] = REG_FIELD(SX1301_FSK_CFG1, 6, 6),
+	[F_FSK_PKT_MODE] = REG_FIELD(SX1301_FSK_CFG1, 7, 7),
+
+	[F_FSK_MODEM_INVERT_IQ] = REG_FIELD(SX1301_IQCFG, 5, 5),
+
+	[F_FSK_CRC_EN] = REG_FIELD(SX1301_FSK_CFG2, 3, 3),
+	[F_FSK_DCFREE_ENC] = REG_FIELD(SX1301_FSK_CFG2, 4, 5),
+	[F_FSK_ERROR_OSR_TOL] = REG_FIELD(SX1301_FSK_ERROR_OSR_TOL, 0, 4),
+	[F_FSK_PKT_LENGTH] = REG_FIELD(SX1301_FSK_PKT_LENGTH, 0, 7),
+	[F_FSK_PATTERN_TIMEOUT_CFGL] =
+		REG_FIELD(SX1301_FSK_PATTERN_TIMEOUT_CFGL, 0, 7),  // 10 bits
+	[F_FSK_PATTERN_TIMEOUT_CFGH] =
+		REG_FIELD(SX1301_FSK_PATTERN_TIMEOUT_CFGH, 0, 1),
+
+	[F_TX_START_DELAYL] = REG_FIELD(SX1301_TX_START_DELAYL, 0, 7), // 16 bit
+	[F_TX_START_DELAYH] = REG_FIELD(SX1301_TX_START_DELAYH, 0, 7),
+
+	[F_TX_SWAP_IQ] = REG_FIELD(SX1301_TX_CFG2, 7, 7),
+	[F_TX_FRAME_SYNCH_PEAK1_POS] = REG_FIELD(SX1301_TX_FRAME_SYNCH, 0, 3),
+	[F_TX_FRAME_SYNCH_PEAK2_POS] = REG_FIELD(SX1301_TX_FRAME_SYNCH, 4, 7),
+
+	[F_FSK_TX_GAUSSIAN_SELECT_BT] = REG_FIELD(SX1301_FSK_TX, 1, 2),
 };
 
 struct sx130x_tx_header {
@@ -263,6 +373,23 @@ static int sx130x_soft_reset(struct sx130x_priv *priv)
 	return 0;
 }
 
+static int sx130x_fields_patch(struct sx130x_priv *priv)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(sx130x_regmap_fields_patch); i++) {
+		ret = sx130x_field_force_write(priv, sx130x_regmap_fields_patch[i].field,
+					       sx130x_regmap_fields_patch[i].val);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to patch regmap field: %d\n", i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int sx130x_agc_ram_read(struct sx130x_priv *priv, u8 addr, unsigned int *val)
 {
 	int ret;
@@ -881,7 +1008,9 @@ static int sx130x_loradev_open(struct net_device *netdev)
 	if (ret)
 		goto err_calibrate;
 
-	/* TODO Load constant adjustments, patches */
+	ret = sx130x_fields_patch(priv);
+	if (ret)
+		return ret;
 
 	/* TODO Frequency time drift */
 
diff --git a/drivers/net/lora/sx130x.h b/drivers/net/lora/sx130x.h
index 38f1b58b2165..121c8a35b5c3 100644
--- a/drivers/net/lora/sx130x.h
+++ b/drivers/net/lora/sx130x.h
@@ -29,6 +29,9 @@
 #define SX1301_PA_GAIN_OFFSET 6
 #define SX1301_DAC_GAIN_OFFSET 4
 
+/* Calibrated value for 500KHz BW and notch filter disabled */
+#define TX_START_DELAY_DEFAULT  1497
+
 /* Page independent */
 #define SX1301_PAGE     0x00
 #define SX1301_VER      0x01
@@ -49,12 +52,39 @@
 #define SX1301_PAGE_BASE(n) (SX1301_VIRT_BASE + (SX1301_PAGE_LEN * n))
 
 /* Page 0 */
+#define SX1301_IQCFG        (SX1301_PAGE_BASE(0) + 0x21)
 #define SX1301_CHRS         (SX1301_PAGE_BASE(0) + 0x23)
+#define SX1301_CORR_CFG     (SX1301_PAGE_BASE(0) + 0x4E)
+#define SX1301_MODEM_START_RDX4L (SX1301_PAGE_BASE(0) + 0x51)
+#define SX1301_MODEM_START_RDX4H (SX1301_PAGE_BASE(0) + 0x52)
+#define SX1301_MODEM_START_SF12_RDX4L (SX1301_PAGE_BASE(0) + 0x53)
+#define SX1301_MODEM_START_SF12_RDX4H (SX1301_PAGE_BASE(0) + 0x54)
+#define SX1301_FRAME_SYNCH  (SX1301_PAGE_BASE(0) + 0x5F)
+#define SX1301_MISC_CFG1    (SX1301_PAGE_BASE(0) + 0x63)
+#define SX1301_GAIN_OFFSET  (SX1301_PAGE_BASE(0) + 0x68)
 #define SX1301_FORCE_CTRL   (SX1301_PAGE_BASE(0) + 0x69)
 #define SX1301_MCU_CTRL     (SX1301_PAGE_BASE(0) + 0x6A)
+#define SX1301_RSSI_BB_DEFAULT_VALUE 	(SX1301_PAGE_BASE(0) + 0x6C)
+#define SX1301_RSSI_DEC_DEFAULT_VALUE 	(SX1301_PAGE_BASE(0) + 0x6D)
+#define SX1301_RSSI_CHANN_DEFAULT_VALUE (SX1301_PAGE_BASE(0) + 0x6E)
+#define SX1301_RSSI_BB_FILTER_ALPHA 	(SX1301_PAGE_BASE(0) + 0x6F)
+#define SX1301_RSSI_DEC_FILTER_ALPHA 	(SX1301_PAGE_BASE(0) + 0x70)
+#define SX1301_RSSI_CHANN_FILTER_ALPHA 	(SX1301_PAGE_BASE(0) + 0x71)
 
 /* Page 1 */
 #define SX1301_TX_TRIG      (SX1301_PAGE_BASE(1) + 0x21)
+#define SX1301_TX_START_DELAYL      (SX1301_PAGE_BASE(1) + 0x22)
+#define SX1301_TX_START_DELAYH      (SX1301_PAGE_BASE(1) + 0x23)
+#define SX1301_TX_FRAME_SYNCH       (SX1301_PAGE_BASE(1) + 0x24)
+#define SX1301_TX_CFG2              (SX1301_PAGE_BASE(1) + 0x2A)
+#define SX1301_BHSYNCPOS            (SX1301_PAGE_BASE(1) + 0x2E)
+#define SX1301_FSK_CFG1             (SX1301_PAGE_BASE(1) + 0x3F)
+#define SX1301_FSK_CFG2             (SX1301_PAGE_BASE(1) + 0x40)
+#define SX1301_FSK_ERROR_OSR_TOL    (SX1301_PAGE_BASE(1) + 0x41)
+#define SX1301_FSK_PKT_LENGTH       (SX1301_PAGE_BASE(1) + 0x4C)
+#define SX1301_FSK_TX               (SX1301_PAGE_BASE(1) + 0x4D)
+#define SX1301_FSK_PATTERN_TIMEOUT_CFGL (SX1301_PAGE_BASE(1) + 0x53)
+#define SX1301_FSK_PATTERN_TIMEOUT_CFGH (SX1301_PAGE_BASE(1) + 0x54)
 
 /* Page 2 */
 #define SX1301_RADIO_A_SPI_DATA     (SX1301_PAGE_BASE(2) + 0x21)
@@ -98,6 +128,51 @@ enum sx130x_fields {
 	F_TX_TRIG_IMMEDIATE,
 	F_TX_TRIG_DELAYED,
 	F_TX_TRIG_GPS,
+
+	F_RSSI_BB_FILTER_ALPHA,
+	F_RSSI_DEC_FILTER_ALPHA,
+	F_RSSI_CHANN_FILTER_ALPHA,
+
+	F_RSSI_BB_DEFAULT_VALUE,
+	F_RSSI_DEC_DEFAULT_VALUE,
+	F_RSSI_CHANN_DEFAULT_VALUE,
+
+	F_DEC_GAIN_OFFSET,
+	F_CHAN_GAIN_OFFSET,
+
+	F_SNR_AVG_CST,
+	F_FRAME_SYNCH_PEAK1_POS,
+	F_FRAME_SYNCH_PEAK2_POS,
+
+	F_MBWSSF_FRAME_SYNCH_PEAK1_POS,
+	F_MBWSSF_FRAME_SYNCH_PEAK2_POS,
+
+	F_ADJUST_MODEM_START_OFFSET_RDX4L,
+	F_ADJUST_MODEM_START_OFFSET_RDX4H,
+	F_ADJUST_MODEM_START_OFFSET_SF12_RDX4L,
+	F_ADJUST_MODEM_START_OFFSET_SF12_RDX4H,
+	F_CORR_MAC_GAIN,
+
+	F_FSK_RX_INVERT,
+	F_FSK_MODEM_INVERT_IQ,
+
+	F_FSK_RSSI_LENGTH,
+	F_FSK_PKT_MODE,
+	F_FSK_CRC_EN,
+	F_FSK_DCFREE_ENC,
+	F_FSK_ERROR_OSR_TOL,
+	F_FSK_PKT_LENGTH,
+	F_FSK_PATTERN_TIMEOUT_CFGL,
+	F_FSK_PATTERN_TIMEOUT_CFGH,
+
+	F_TX_START_DELAYL,
+	F_TX_START_DELAYH,
+
+	F_TX_SWAP_IQ,
+	F_TX_FRAME_SYNCH_PEAK1_POS,
+	F_TX_FRAME_SYNCH_PEAK2_POS,
+
+	F_FSK_TX_GAUSSIAN_SELECT_BT,
 };
 
 struct regmap *sx130x_get_regmap(struct device *dev);
-- 
2.17.1

