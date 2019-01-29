Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31891C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1ED20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="mXjC6LeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfA2UzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:55:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40548 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfA2UzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:55:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so15699991lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVn7rJu2HIS1t/pLrBEM9tglmF08bUzUVQnXDkx+btM=;
        b=mXjC6LeG56EHotJrntbS8szRPxBKea+HEGVLKE7ysgXPWRe4+i7Q2Pv3DXNmA4B2/2
         px/a8gNzBglenLmMSek6T4K5e/91wpt6cm0MI1UvHeVbWkXDAwrwH9X1V7nPF7a0AmI6
         Nu+ZEvahl53MLzha1tEjkAhTH5ffsEwX19E4c09spc3AUIQgj/09j2QEaTrfzKWLT0kM
         qyTUorrdzUZzKYxEVZe/JXfDc6pkqOVlyerBhL7q4sjiUTZ60+GaVobWlahqkE8eqJIJ
         QYlGMkwKTAulJHHMpVXoSK29zQt2uQmkBFf3uPc4uy9May5SHsybjq8+seBaDQjwKcZe
         SwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVn7rJu2HIS1t/pLrBEM9tglmF08bUzUVQnXDkx+btM=;
        b=HlUzk0gFdE5tnduA1VQ9s0Gpzi0RElMNS/F9sgkuGt85cLbTWDX1Y5txUvpOSvcwuk
         5zeptMXudrpPWq1TNDiZw3kLQ+GCjktVXLMHlBZGGiibDiWM/P2xhDMy5nkZajveQluQ
         Zcq2C744R0X7bMMKOkA10DnHsJmmNN8prEdL2nBjbmrIsIXtbJcmx+O9tYE/+Wh/22H1
         GGq2/JI9b1UGKOQLdZsnJ5Ae1ub3blBzAwMZPfp438qIT2nAEGulke0QlpksEdedmm+X
         zaNfWMPPRrHkCjM5t4LJG4zKHs1zh8hNxRfSokALzB7ynGq46KHgtS+6cqIzI7zNmsb2
         rvyw==
X-Gm-Message-State: AJcUukc2t7Y02+73Za4EdOOmcrq4XNAwfbEVHQw9v54t4+X12F9mQmqF
        /Ny/xEVS+cnupOSUyPQeJp2AvSTTWuU=
X-Google-Smtp-Source: ALg8bN6LrDYkgwzG24sPDTX/FjfgqfnSeLwlkmP/0rz21oVbSnkdrlOzizeIx75wrfLpfxyJZN7KPQ==
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr19527973lfa.106.1548795306270;
        Tue, 29 Jan 2019 12:55:06 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id o17sm3677287lff.77.2019.01.29.12.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:55:05 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] spi: support inter-word delay requirement for devices
Date:   Tue, 29 Jan 2019 21:55:01 +0100
Message-Id: <20190129205502.7741-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129205502.7741-1-jonas@norrbonn.se>
References: <20190129205502.7741-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Note that, for spi_transfer, there is already a field word_delay that
provides similar functionality.  This field, however, is specified in
clock cycles (and worse, SPI controller cycles, not SCK cycles); that
makes this value dependent on the master clock instead of the device
clock for which the delay is intended to provide some relief.  This
patch leaves this old word_delay in place and provides a time-based
word_delay_us alongside it; the new field fits in the struct padding
so struct size is constant.  There is only one in-kernel user of the
word_delay field and presumably that driver could be reworked to use
the time-based value instead.

The time-based delay is limited to 8 bits as these delays are intended
to be short.  The SAMA5D2 that I've tested this on limits delays to a
maximum of ~100us, which is already many word-transfer periods even at
the minimum transfer speed supported by the controller.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 drivers/spi/spi.c       | 5 +++++
 include/linux/spi/spi.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0e0f2c62973c..448443adee3a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3050,6 +3050,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * it is not set for this transfer.
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
+	 * Ensure transfer word_delay is at least as long as that required by
+	 * device itself.
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
@@ -3120,6 +3122,9 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				!(spi->mode & SPI_RX_QUAD))
 				return -EINVAL;
 		}
+
+		if (xfer->word_delay_us < spi->word_delay_us)
+			xfer->word_delay_us = spi->word_delay_us;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 916bba47d156..555ba125bb89 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -122,6 +122,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
+ * @word_delay_us: microsecond delay to be inserted between consecutive
+ *	words of a transfer
  *
  * @statistics: statistics for the spi_device
  *
@@ -169,6 +171,7 @@ struct spi_device {
 	const char		*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
+	uint8_t			word_delay_us;	/* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -721,6 +724,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay_us: microseconds to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
@@ -803,6 +808,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		word_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.19.1

