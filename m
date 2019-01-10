Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F37208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547161597;
	bh=eKvOq4NCk4wPWMAcHIFanyfg7O5t8WfBBTE64xC8bHs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AlVXkKo7nz12z1pePbtXnnXL4tZTBaZqm10KeFVEIwSpSUszyYPfgGSVipk0aPhCF
	 4Xs9TUkHR7OKQj/mPHJzZnsScnEkhcMCQwAxsY5ZYFNitvEexvei0M48QOZFb4hr24
	 7lEjsa3DM76Q2o6WAUCXDpUgf+Qwb3cUFKQ8oOIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfAJXGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:06:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfAJXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:06:36 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8B4208E3;
        Thu, 10 Jan 2019 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547161596;
        bh=eKvOq4NCk4wPWMAcHIFanyfg7O5t8WfBBTE64xC8bHs=;
        h=From:To:Cc:Subject:Date:From;
        b=DewEyD3QBYmMBcEEiozzj2ISh6WBs1XMekrSMXXXYj7dgPEr/VL/r25A7+HA0jB+T
         XKRrFXba7wCz0/2Piy8kpo6tAJT7bg0CcIlteOu4jY4Uqw1yatOQN1w1M9YVzsCrf4
         YRwr0cARQHVv8UqTgRYcdGXMTHCcxDj+2aPwoTsg=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
Date:   Thu, 10 Jan 2019 17:06:26 -0600
Message-Id: <20190110230626.4130-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
since it can be used on other platforms such as Stratix10.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..0bdbd3d 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
 
 config ALTERA_FREEZE_BRIDGE
 	tristate "Altera FPGA Freeze Bridge"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on FPGA_BRIDGE
 	help
 	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
 	  freeze bridge is a bridge that exists in the FPGA fabric to
-- 
2.7.4

