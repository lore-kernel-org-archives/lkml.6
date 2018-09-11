Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37212C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E414020854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E414020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIKNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:20:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38903 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeIKNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:20:51 -0400
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="19314069"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Sep 2018 01:22:36 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Tue, 11 Sep 2018 01:22:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anuragku@xilinx.com>,
        <cyrille.pitchen@microchip.com>, <nicolas.ferre@microchip.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/3] mtd: spi-nor: add Global Block Unlock support
Date:   Tue, 11 Sep 2018 11:22:29 +0300
Message-ID: <20180911082232.28678-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid inadvertent writes during power-up, SST26 flash memories are
write-protected by default after a power-on reset cycle. Unlock the serial
flash memory by using the Global Block Protection Unlock command - it offers
a single command cycle that unlocks the entire memory array.

v2:
- add Cyrille's reviewed-by tag
- add cover letter
- fix link to initial work done by Anurag Kumar Vulisha

Tudor Ambarus (3):
  mtd: spi-nor: add Global Block Unlock support
  mtd: spi-nor: unlock global block protection on sst26vf064b
  mtd: spi-nor: add support for Microchip SST26 QSPI flash memories

 drivers/mtd/spi-nor/spi-nor.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.9.4

