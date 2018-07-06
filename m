Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48539C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D665323FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jG1nNlji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D665323FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbeGFN1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:27:33 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:37428 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeGFN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:26:32 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 77C0E10C1AB5;
        Fri,  6 Jul 2018 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530883591; bh=im0yx8NLmmk4YSOCHqr5ZTYVBeurvysuHYRHrMrQlKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jG1nNljiZXveppqiDvGuQifVOgItx0wJ17QN6tp8Re1wR7N29BXDpxwqRrjTYmti3
         Su6m/Rfv4oLyPZNFTRXsu0seDn7Fl327WzoPv6+OjDre6cECR8ASIxl+KdHBx181QF
         vjkRiTPqxJQd38L0k+kDTvL2vp/5oFWdBLWTN6aUCkfLKPXYxG0YF5XGdWb94rLvBM
         W6NaFlgm+mp0BtN2y6YF9bEy3l+iZAS73/2T/Y2dsp0j8IkqMwY5Eqzxb+rUwxkj5V
         DW6uSxcowYYTV1I7ykqCnQKki9Ctq2/Ah0dMzptWcClRfx/I0eBz6dB2GZRhw1081H
         uiglc44/ydHqw==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 33DB15E9B;
        Fri,  6 Jul 2018 06:26:31 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 038173F7A3;
        Fri,  6 Jul 2018 14:26:30 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v7 11/11] PCI: endpoint: Add MSI set maximum restriction.
Date:   Fri,  6 Jul 2018 14:26:23 +0100
Message-Id: <51871d1b368bc222213bbbad00f5da5620c37373.1530877028.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
References: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
References: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_epc_set_msi() maximum 32 interrupts validation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v4->v5:
 - New patch file.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Nothing changed, just to follow the patch set version.

 drivers/pci/endpoint/pci-epc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c72e656..094dcc3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	u8 encode_int;
 	unsigned long flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    interrupts > 32)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
-- 
2.7.4


