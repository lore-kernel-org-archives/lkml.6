Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393F720873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547604068;
	bh=1T/yJVFbKNn2bVKp8P6ER254fN5fNiJ1gPyfLetTJp0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=idhkxZPbkn+66A4zJVcS8zbfOHemUi76gcXBlX5yg25SJFaaz8u/LTh7GDRmzMwRR
	 NIGGwyTO/BlPfmCx8/+uF8dusePxG6O3wVIqCHu1T4tBSIwuHuI3kiz90k2xZIc6qs
	 blR1iNjNgnU2BSX6qzKwOcJ0mRjaSTCqKMn8wTxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfAPCBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfAPCBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:01:06 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AF020873;
        Wed, 16 Jan 2019 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547604065;
        bh=1T/yJVFbKNn2bVKp8P6ER254fN5fNiJ1gPyfLetTJp0=;
        h=From:To:Cc:Subject:Date:From;
        b=AuBKBgDM1RZ7tMfnrd3bnTkoZC3F236nEqf72tWFh6gwg6/FGnvQd/yBeGynVCqFK
         Ho3IfkezNuLJr9GZYHp4Rdx8dBj4wUBWcgYO4fYnAQSC51JsG4WY9xvRwaDnE9RxYc
         DA1ySRQMPudnNqHBw3Hl3XpMeChvxI8J80hHDbpQ=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3] fpga: altera_freeze_bridge: remove restriction to socfpga
Date:   Tue, 15 Jan 2019 20:01:00 -0600
Message-Id: <20190116020100.4813-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
since it can be used on other platforms such as Stratix10.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: add depends on HAS_IOMEM
v3: put both dependencies on one line
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..c20445b 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
 
 config ALTERA_FREEZE_BRIDGE
 	tristate "Altera FPGA Freeze Bridge"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on FPGA_BRIDGE && HAS_IOMEM
 	help
 	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
 	  freeze bridge is a bridge that exists in the FPGA fabric to
-- 
2.7.4

