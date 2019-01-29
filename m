Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D0C282D1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8412083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762874;
	bh=/ACvBFsJYqh5cv/3r2UcDnEjbXdLO76XUHFyNfhOBXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oLHT7eHWuPy8zP5THY/9baZ79hpP5hcdi+SrKZis03q+ad0ckcVd0D76eZGQASn0R
	 xt40+ZZnmhyeNgugBv0L8huJMkeD/dCZOuoMYg9RQk4kirgt0jok7bCiVBoFXKBgIs
	 7ewLeqiBe7CRgcIK6enLulkO56eIe2CyivYPBxcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfA2LvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbfA2LvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16532083B;
        Tue, 29 Jan 2019 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762681;
        bh=/ACvBFsJYqh5cv/3r2UcDnEjbXdLO76XUHFyNfhOBXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qTsEt5I8CQ3F3tzw8SYeytwTZJFCMbN/igOfHVVxqT+ZXmNL+5TPHduOmM1/taGK
         23vwQw+2CMvaYtCmI2IWsDLmVxH4PX19GhGM3HS494zvx5jRVHCq4ddAx+JJYpVvLo
         l5nhgOUFQ2x4vrYsqKw3ornyx/LHZPDiDSqH2IkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/44] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date:   Tue, 29 Jan 2019 12:36:03 +0100
Message-Id: <20190129113140.773786691@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 99d570da309813f67e9c741edeff55bafc6c1d5e upstream.

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
register read and write APIs, if registered, can be used.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -399,6 +399,7 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports


