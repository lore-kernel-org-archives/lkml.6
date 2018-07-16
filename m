Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0469F208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0469F208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGPJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:25:44 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:2748 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727182AbeGPJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:25:44 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 16 Jul 2018 17:59:18 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id B06C678F09;
        Mon, 16 Jul 2018 17:59:18 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,360,1526310000"; 
   d="scan'208";a="286981851"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 16 Jul 2018 17:59:17 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 0/2] i2c: designware: Add support for a bus clock
Date:   Mon, 16 Jul 2018 09:59:11 +0100
Message-Id: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys I2C Controller has a bus clock, but typically SoCs hide this away.
However, on some SoCs you need to explicity enable the bus clock in order to
access the registers.

Phil Edworthy (2):
  dt: snps,designware-i2c: Add clock bindings documentation
  i2c: designware: Add support for a bus clock

 Documentation/devicetree/bindings/i2c/i2c-designware.txt |  9 +++++++--
 drivers/i2c/busses/i2c-designware-common.c               | 14 +++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h                 |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c              |  2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.7.4

