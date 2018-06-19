Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E394C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9DA20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzz3nk3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9DA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965027AbeFSE2s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:28:48 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:60621 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeFSE2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:28:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5J4Sh6T017435;
        Mon, 18 Jun 2018 23:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529382523;
        bh=y3qlz3OnCGenc0CKjo6jOfPx9d35NMrn7ZYzv9XYRCY=;
        h=From:To:CC:Subject:Date;
        b=hzz3nk3cY6eSKpRn974RFQv63vBnc9jQg4oh8QKCAEYR3X8uJB2Mv+2BOm5pgvuPQ
         /VbkB9ZECDQltUceo+oVX68UD1rkutBcJPZtA1Zfi4U+s+ekF+KElhw0s2Gf/aU8w4
         FI8bzhwBLXtsciQZL9VOtlaYSqSbDU80/48WVj4c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4Shm0001047;
        Mon, 18 Jun 2018 23:28:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 18
 Jun 2018 23:28:43 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 18 Jun 2018 23:28:43 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4SeQq004959;
        Mon, 18 Jun 2018 23:28:41 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <d-gerlach@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 0/4] clk: clk: Add functions to save/restore clock context en-masse
Date:   Tue, 19 Jun 2018 09:58:21 +0530
Message-ID: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deep enough power saving mode can result into losing context of the clock
registers also, and they need to be restored once coming back from the power
saving mode. Hence add functions to save/restore clock context.

Tested for DS0 on am437x-gp-evm

Based on top of linux-next

Keerthy (2):
  clk: clk: Add clk_dflt_restore
  soc: ti: pm33xx: Save/restore clk context based on enable_off_mode
    setting

Russ Dill (2):
  clk: clk: Add functions to save/restore clock context en-masse
  clk: ti: Add functions to save/restore clk context

 arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
 drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
 drivers/clk/ti/clock.h               |   2 +
 drivers/clk/ti/divider.c             |  36 ++++++++++
 drivers/clk/ti/dpll.c                |   6 ++
 drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
 drivers/clk/ti/gate.c                |   3 +
 drivers/clk/ti/mux.c                 |  29 ++++++++
 drivers/soc/ti/pm33xx.c              |  13 ++++
 include/linux/clk-provider.h         |   9 +++
 include/linux/clk.h                  |  25 +++++++
 include/linux/clk/ti.h               |   6 ++
 include/linux/platform_data/pm33xx.h |   1 +
 13 files changed, 362 insertions(+)

-- 
1.9.1

