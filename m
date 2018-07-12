Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E25DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B442147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0H10blEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B442147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGLPng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbeGLPng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:43:36 -0400
Received: from localhost (unknown [146.7.4.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D4C208E2;
        Thu, 12 Jul 2018 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531409612;
        bh=hW4cKbsbsB/HNxBlV9pDeMzHgkEA3up3t66DutRJku8=;
        h=Subject:From:To:Cc:Date:From;
        b=0H10blEK7W6Vej5NRaC/KwaHYedXxZD3NWnflsjvCiLkrCJZrfg4a38Kzk4U8Veqy
         EnWRskMQNkhmUet6wAhLgrTdp8ANg3N1U8eU1WXzajXGZYWOmnyPLsxaeL1N7Rfhw7
         +PLcXd01gLYKK/BVfCs+YbhthWJ2zRytdtznFh80=
Subject: [PATCH] staging: rtlwifi: Remove empty halmac_pcie_reg.h
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Jul 2018 10:33:30 -0500
Message-ID: <153140961070.206034.8135236312210577930.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

halmac_pcie_reg.h is empty, so remove it and the only include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/staging/rtlwifi/halmac/halmac_api.h      |    1 -
 drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h |   17 -----------------
 2 files changed, 18 deletions(-)
 delete mode 100644 drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h

diff --git a/drivers/staging/rtlwifi/halmac/halmac_api.h b/drivers/staging/rtlwifi/halmac/halmac_api.h
index 4922cc8ce6f2..e220db39c8a7 100644
--- a/drivers/staging/rtlwifi/halmac/halmac_api.h
+++ b/drivers/staging/rtlwifi/halmac/halmac_api.h
@@ -29,7 +29,6 @@
 
 #include "halmac_usb_reg.h"
 #include "halmac_sdio_reg.h"
-#include "halmac_pcie_reg.h"
 
 #include "halmac_bit2.h"
 #include "halmac_reg2.h"
diff --git a/drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h b/drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h
deleted file mode 100644
index a2552b27367b..000000000000
--- a/drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2016  Realtek Corporation.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- * Realtek Corporation, No. 2, Innovation Road II, Hsinchu Science Park,
- * Hsinchu 300, Taiwan.
- *
- * Larry Finger <Larry.Finger@lwfinger.net>
- *
- *****************************************************************************/
-#ifndef __HALMAC_PCIE_REG_H__
-#define __HALMAC_PCIE_REG_H__
-
-#endif /* __HALMAC_PCIE_REG_H__ */

