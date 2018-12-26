Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE1BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81915214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864261;
	bh=VXCF/lyo3eF+JnAzHz5BwJZVn+JUR6UrH6voO7rsHMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZitUGWkwPFtZb2Sfl+Pe/5bff/1tssvzWAZJJJ4xx4VOzO+adbA7PNSpPrNZ23xq
	 QifxiQrRyJOMBs4Tloz2Mm/j2UXy0y+GliAxcnzuQJJst14o4fEaWw6GZceLX8av3r
	 WxrnyibWygvL+Fu9apUPRQWp5ZRzh+BHhb56Dtl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeLZWkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbeLZWkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC3720651;
        Wed, 26 Dec 2018 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864043;
        bh=VXCF/lyo3eF+JnAzHz5BwJZVn+JUR6UrH6voO7rsHMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb9DICdMK5FGKIccxMUzGDPVCAfnSVEnNlxjX8TZ3kJ74Q/t6WMS/UYgnNRgjWoTC
         Ns58UvDeAcYc6iSxIyGPcWbLZF0RrdGiqPHlqmf5SzTlfj+Uw78iSegtQo8bOJDuFK
         VGUkb6+regqm23sHrOt8Z4wRagHT+QD6quw53YbM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 4.14 29/59] x86, hyperv: remove PCI dependency
Date:   Wed, 26 Dec 2018 17:38:09 -0500
Message-Id: <20181226223839.150262-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@kernel.org>

[ Upstream commit c629421a990033ba539eb8585e73a2e6fa9ea631 ]

Need to be able to boot without PCI devices present.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 50b89ea0e60f..247a62604d1f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -2,7 +2,7 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
2.19.1

