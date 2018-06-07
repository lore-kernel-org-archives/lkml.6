Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id y+PRDPZGGVtuOgAAmS7hNA
	; Thu, 07 Jun 2018 14:53:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2495B608B8; Thu,  7 Jun 2018 14:53:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A7E06074D;
	Thu,  7 Jun 2018 14:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A7E06074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935290AbeFGOxj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:53:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40950 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933674AbeFGOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:53:33 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zk-4z; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002xC-Gh; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel Baluta" <daniel.baluta@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ioana Ciornei" <ciorneiioana@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.577974665@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 172/410] staging: iio: adc: remove the use of CamelCase
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Ciornei <ciorneiioana@gmail.com>

commit 5f7e280f5ae61450a7aecd9feefe3f032b6a5abf upstream.

Remove the use of CamelCase to follow the kernel naming conventions

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/iio/adc/ad7192.c  | 10 +++++-----
 drivers/staging/iio/adc/ad7192.h  |  2 +-
 drivers/staging/iio/adc/ad7280a.c |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -125,7 +125,7 @@
 #define AD7192_GPOCON_P1DAT	(1 << 1) /* P1 state */
 #define AD7192_GPOCON_P0DAT	(1 << 0) /* P0 state */
 
-#define AD7192_INT_FREQ_MHz	4915200
+#define AD7192_INT_FREQ_MHZ	4915200
 
 /* NOTE:
  * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
@@ -226,14 +226,14 @@ static int ad7192_setup(struct ad7192_st
 	switch (pdata->clock_source_sel) {
 	case AD7192_CLK_EXT_MCLK1_2:
 	case AD7192_CLK_EXT_MCLK2:
-		st->mclk = AD7192_INT_FREQ_MHz;
+		st->mclk = AD7192_INT_FREQ_MHZ;
 		break;
 	case AD7192_CLK_INT:
 	case AD7192_CLK_INT_CO:
-		if (pdata->ext_clk_Hz)
-			st->mclk = pdata->ext_clk_Hz;
+		if (pdata->ext_clk_hz)
+			st->mclk = pdata->ext_clk_hz;
 		else
-			st->mclk = AD7192_INT_FREQ_MHz;
+			st->mclk = AD7192_INT_FREQ_MHZ;
 		break;
 	default:
 		ret = -EINVAL;
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -34,7 +34,7 @@
 struct ad7192_platform_data {
 	u16		vref_mv;
 	u8		clock_source_sel;
-	u32		ext_clk_Hz;
+	u32		ext_clk_hz;
 	bool		refin2_en;
 	bool		rej60_en;
 	bool		sinc3_en;
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -89,7 +89,7 @@
 
 #define AD7280A_ALL_CELLS				(0xAD << 16)
 
-#define AD7280A_MAX_SPI_CLK_Hz		700000 /* < 1MHz */
+#define AD7280A_MAX_SPI_CLK_HZ		700000 /* < 1MHz */
 #define AD7280A_MAX_CHAIN		8
 #define AD7280A_CELLS_PER_DEV		6
 #define AD7280A_BITS			12
@@ -850,7 +850,7 @@ static int ad7280_probe(struct spi_devic
 
 	ad7280_crc8_build_table(st->crc_tab);
 
-	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_Hz;
+	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
 	st->spi->mode = SPI_MODE_1;
 	spi_setup(st->spi);
 
