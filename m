Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDEC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0366F20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfAMLbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:31:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:22351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMLbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:31:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 03:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,473,1539673200"; 
   d="scan'208";a="266762713"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2019 03:31:09 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc 3/3] mei: me: add denverton innovation engine device IDs
Date:   Sun, 13 Jan 2019 14:24:48 +0200
Message-Id: <20190113122449.7252-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113122449.7252-1-tomas.winkler@intel.com>
References: <20190113122449.7252-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Denverton innovation engine (IE) device ids.
The IE is an ME-like device which provides HW security
offloading.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index e4b10b2d1a08..23739a60517f 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -127,6 +127,8 @@
 #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
 #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
 
+#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
+
 #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
 
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index c2bf3e99955e..e89497f858ae 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -93,6 +93,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_BXT_M, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
+
 	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
-- 
2.20.1

