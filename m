Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A9EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 01:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42C20846
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 01:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C42C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeIBGAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:00:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:5918 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeIBGAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:00:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 18:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="86895302"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2018 18:46:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fwHSJ-000EI4-7g; Sun, 02 Sep 2018 09:45:35 +0800
Date:   Sun, 2 Sep 2018 05:23:50 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     kbuild-all@01.org, richard.genoud@gmail.com, pirea.radu@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
Subject: [RFC PATCH] spi: at91-usart: at91_usart_spi_transfer_one() can be
 static
Message-ID: <20180901212350.GA89606@lkp-ib04>
References: <20180831134141.9335-6-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831134141.9335-6-radu.pirea@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 5890bab41187 ("spi: at91-usart: add driver for at91-usart as spi")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 spi-at91-usart.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 4712bd4..a924657 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -215,9 +215,9 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
-				struct spi_device *spi,
-				struct spi_transfer *xfer)
+static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
+				       struct spi_device *spi,
+				       struct spi_transfer *xfer)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 
@@ -242,8 +242,8 @@ int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
-int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
-				   struct spi_message *message)
+static int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
+					  struct spi_message *message)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
@@ -256,8 +256,8 @@ int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
 	return 0;
 }
 
-int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
-				     struct spi_message *message)
+static int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
+					    struct spi_message *message)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 
