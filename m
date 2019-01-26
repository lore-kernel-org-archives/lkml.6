Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62FC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F321A218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="VN86UBu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAZQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:32:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44053 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:32:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so9006603lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsBSv2w17w6lFrPapCk73CTS8LZT3j2+sF5Y7dWKzLc=;
        b=VN86UBu8NBXSChaiDHPIstNyAefKEC644yIFDOL81BghZ99qWqiGI4VWBaPrtVo+1S
         K2hAmpRAt7//vves1VSuPUaUdz4yAnsjEQPYdukgaHSVgxxgJ6rCJdgaB78Q7/nGNum7
         2nWXt14pDtC3/z57oLpwMD8LoHhcJxMu1ZiAhQeASDKqJzmeTogsRbkMHpxh3eY17+fd
         eqW9vCKXIxQOqQGE+hwH+fWGjy0+g8d+AUVUOa7mS8ShT3t/OjFr075jfkO3LR4BlCP6
         j58ehEqZ3rOK/s1teXBzJWt55x4rd7OWdBsfxpgVe/ZFQ2IIcOGtbKlYibtpppGcfRog
         6+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsBSv2w17w6lFrPapCk73CTS8LZT3j2+sF5Y7dWKzLc=;
        b=i7hYQJsNiIIBMibduEQpd2eeXI5k0cB0F0RygHRkRz/dlchKLdOCUPajGOpWjquA3H
         QTjq0mqImG732stH3SvP5tgp7AwLLgjWyeogvMRG9ZEFCClh18rmSAzAuBj9Wj4scb7u
         ts4UXKt+8XNxSpIsja8xoPI5VyVcCdII+wcthZWr3Nq8sqbJWRLhEG/jHBdV7lkDpIcI
         rXQouTzFbH2yfgS0DQIK0JeWUiNJ+95f/h5Ds8CTFZVmWVuGSVzgNPCvHIAnb0kJdZxR
         e/zFWMgdIt3BQt/Q+S+1HLmThHAaO4UgubfY7sZTBjE+YOq+3rkvcmsqRJEq0EHGeG3T
         wdEQ==
X-Gm-Message-State: AJcUukfzTvHycZOR/JRU3XRL315ya7hDMubxKvCmu9jJFDwVcFzWCcGL
        IRYGeUNpBQGmlAcvs02IJyfWrIlDI48=
X-Google-Smtp-Source: ALg8bN7LcYWaZVZJURFcXQFktVTSS0vQsLo6bWUgWp5pDrNVMQnth9Xh5ER9AATWYrc84v+OnUyDwQ==
X-Received: by 2002:a19:c954:: with SMTP id z81mr11943281lff.150.1548520345708;
        Sat, 26 Jan 2019 08:32:25 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id e94sm2170532lfi.23.2019.01.26.08.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 08:32:25 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] spi: support inter-word delay requirement for devices
Date:   Sat, 26 Jan 2019 17:32:19 +0100
Message-Id: <20190126163220.26421-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190126163220.26421-1-jonas@norrbonn.se>
References: <20190126163220.26421-1-jonas@norrbonn.se>
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

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..8e410de02af4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -118,6 +118,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line)
+ * @word_delay: microsecond delay to be inserted between consecutive words
+ *      of a transfer
  *
  * @statistics: statistics for the spi_device
  *
@@ -164,6 +166,7 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
 	int			cs_gpio;	/* chip select gpio */
+	uint16_t		word_delay;	/* inter-word delay (us) */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.19.1

