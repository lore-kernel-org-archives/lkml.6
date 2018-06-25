Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E21C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED5F258CC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED5F258CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933853AbeFYMK7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:10:59 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:55224 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933170AbeFYMEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:04:50 -0400
Received: from cnzgrivvl-t440p.carpriv.carnet.hr ([161.53.12.131]:36720 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fXQEg-0003hr-Uu; Mon, 25 Jun 2018 14:04:47 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 4E27A20E53; Mon, 25 Jun 2018 14:04:43 +0200 (CEST)
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Marcus Wolf <linux@Wolf-Entwicklungen.de>,
        =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Michael Panzlaff <michael.panzlaff@fau.de>,
        Derek Robson <robsonde@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hugo Lefeuvre <hle@owl.eu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date:   Mon, 25 Jun 2018 14:04:41 +0200
Message-Id: <20180625120441.10175-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.18.0.rc2
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH] staging: pi433: cleanup comments in rf69.h
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning:

  WARNING: line over 80 characters

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/rf69.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c131ffbdc2db..d80c41966d39 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -20,10 +20,11 @@
 #include "rf69_enum.h"
 #include "rf69_registers.h"
 
-#define F_OSC		32000000  /* in Hz */
-#define FREQUENCY	433920000 /* in Hz, modifying this value impacts CE certification */
-#define FIFO_SIZE	66		/* in byte */
-#define FIFO_THRESHOLD	15		/* in byte */
+/* NOTE: Modifying FREQUENCY value impacts CE certification */
+#define F_OSC		32000000	/* Hz */
+#define FREQUENCY	433920000	/* Hz */
+#define FIFO_SIZE	66		/* bytes */
+#define FIFO_THRESHOLD	15		/* bytes */
 
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
-- 
2.18.0.rc2

