Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3594C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAA222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083371;
	bh=aHdslK9y2DpxGPiZqOYNcPj03dWeP7xoMxwtKqGUDsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EO28vv2LTqGkqZFMb0EY1KKpUfxgTNU4ttwcuBhXDiqFatvAP65EGVV4wNcRa+kLx
	 DcV1HJT5JPPPU9DiLatY8W3Q/PbU2dvSfr+OoIgss8X7vnUS7qPkoO+cXoCA5DtzZI
	 qji/P2yLIxQvoDFpErySOJbo8/woDpum3dYI7mBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405721AbfBMSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393940AbfBMSmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9B520811;
        Wed, 13 Feb 2019 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083364;
        bh=aHdslK9y2DpxGPiZqOYNcPj03dWeP7xoMxwtKqGUDsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5neoz5r5LDlhJdK/Sh7sy5rskM313ORKkh9UimzWR/6oPxmk09HuTLjPjaUSrfK0
         aIBqSwW+nq/mOjvlhvZXnnC6m0a/msTctYlsaDYLe++P+URAHGIOoLFX0y9RbUJRg5
         RYUzjAR4BVCJr3BAAkbk1XWtR1wDb2aB3NnloF8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.19 13/44] mei: me: add ice lake point device id.
Date:   Wed, 13 Feb 2019 19:38:14 +0100
Message-Id: <20190213183652.778687496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit efe814e90b98aed6d655b5a4092b9114b8b26e42 upstream.

Add icelake mei device id.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    2 ++
 drivers/misc/mei/pci-me.c     |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -139,6 +139,8 @@
 #define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
 #define MEI_DEV_ID_CNP_H_4    0xA364  /* Cannon Point H 4 (iTouch) */
 
+#define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
+
 /*
  * MEI HW Section
  */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -105,6 +105,8 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_4, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
+
 	/* required last entry */
 	{0, }
 };


