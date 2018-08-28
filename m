Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5D20867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1pdVush6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeH1TLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbeH1TLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:11:44 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACDD20867;
        Tue, 28 Aug 2018 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535469575;
        bh=D9rxHjZzkkVGxMW8qOnm5rpqMg0Ggf5Rth9rHK7ly+I=;
        h=From:To:Cc:Subject:Date:From;
        b=1pdVush6unz/2Tr8RV6WFVXJsWEc6cKdurgmiMszAtES6OoOOtvza2wX2OLygZN6+
         +YAFJNmhgmeeu1/BkhI/e8Op5cNCfPjsg9qLzRg0ddz4GVQdz9girN3DXhIkSS6dhg
         ldbAPOMFtOnUx22dkD13QQaEDChpfY8CyFv1auG8=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     davem@davemloft.net
Cc:     dinguyen@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: build the dwmac-socfpga platform driver for Stratix10
Date:   Tue, 28 Aug 2018 10:19:20 -0500
Message-Id: <1535469560-2304-1-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix10 SoC is an AARCH64 based platform that shares the same ethernet
controller that is on other SoCFPGA platforms. Build the platform driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index edf2036..a14085b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -110,7 +110,7 @@ config DWMAC_ROCKCHIP
 
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
-	default ARCH_SOCFPGA
+	default (ARCH_SOCFPGA || ARCH_STRATIX10)
 	depends on OF && (ARCH_SOCFPGA || ARCH_STRATIX10 || COMPILE_TEST)
 	select MFD_SYSCON
 	help
-- 
2.7.4

