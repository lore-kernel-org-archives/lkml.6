Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2146C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8302084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7NyBYra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8302084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeKCEBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:06 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1622B2084A;
        Fri,  2 Nov 2018 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184770;
        bh=mNn4gJXiE9lsWUOKVLt/H2weCUO6f+tPCJc2GkrKOO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7NyBYraZfARQ1wRzlMTJvyqAmmO/IWFM02jYVC0ba+yeKVp7ToutAMv3DTjypvIR
         ItzwDww9QiobKxXb1HDuvRzOkRNB5xV9yur4WwqEN8ckf5hPuf7/St5xPuWDylY1SR
         iOoIKLX7lPgOKDvXYGNyfKhae0gd8sSn16XfEQMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 092/143] net: stmmac: mark PM functions as __maybe_unused
Date:   Fri,  2 Nov 2018 19:34:37 +0100
Message-Id: <20181102182905.249190572@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 81a8b0799632627b587af31ecd06112397e4ec36 ]

The newly added suspend/resume functions cause a build warning
when CONFIG_PM is disabled:

drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:324:12: error: 'stmmac_pci_resume' defined but not used [-Werror=unused-function]
drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:306:12: error: 'stmmac_pci_suspend' defined but not used [-Werror=unused-function]

Mark them as __maybe_unused so gcc can drop them silently.

Fixes: b7d0f08e9129 ("net: stmmac: Fix WoL for PCI-based setups")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 6a393b16a1fc..c54a50dbd5ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -303,7 +303,7 @@ static void stmmac_pci_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int stmmac_pci_suspend(struct device *dev)
+static int __maybe_unused stmmac_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret;
@@ -321,7 +321,7 @@ static int stmmac_pci_suspend(struct device *dev)
 	return 0;
 }
 
-static int stmmac_pci_resume(struct device *dev)
+static int __maybe_unused stmmac_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret;
-- 
2.17.1



