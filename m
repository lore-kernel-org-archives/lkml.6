Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A62C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD949214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762458;
	bh=rY20fYlae+XPRjdawJ3Wl1o+P+2JTh12pDzOswQscgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FWS4sQ5tR9snH6558kNJvEdLlmAHAZgFAoLdCgCwalmhpzXL02FhI9Y8xpQwhwKLQ
	 i1rv1yoiiGbsCvDjyEO+x4uVuPqpros2kdpZUypRJoY+m+p5P8MMpI+vBtxSg8ZBLs
	 7l4ppkGrhaBNcVXTdoZMLzwvF7o2rHGY6Z/UCgXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfA2Lrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbfA2Lrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F3F2086C;
        Tue, 29 Jan 2019 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762456;
        bh=rY20fYlae+XPRjdawJ3Wl1o+P+2JTh12pDzOswQscgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1wX1Zd27OgV5WIYuBRHWFyNQCnp0h/+KehpP+sO5LA3VLtfYHS9W/qYawzfgIKb9
         HyE3tx0X/ZJxJjwP4cDOYCaftn9aFQdIWFSImMOhKhPGrH7k0CxhO7HovIyw4E9l6m
         VwMpeiaoaegTnT0I4shw3O8vfjC8i9eXPoCP1LVM=
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
Subject: [PATCH 4.14 11/68] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date:   Tue, 29 Jan 2019 12:35:33 +0100
Message-Id: <20190129113132.532656951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -429,6 +429,7 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports


