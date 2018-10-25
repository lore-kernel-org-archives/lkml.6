Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B35FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C97A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zz2kC/g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C97A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJYWsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbeJYWsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:03 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D7320854;
        Thu, 25 Oct 2018 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476907;
        bh=aNYpF3/knIOBXUM41FZ2SEOMHpehelsVNA5yxxBDWJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zz2kC/g1p+/BVy7OrkzYiYff2tRUxBtmZrPrYgkLyjMS5rP5IGk5LUSBFaII+eGl2
         HDYjf9SaO9Zv45Vj4LERTjUQb6mm/RUhM8Jugh86qYu1CpPWzxXR6FrbXC0c2UUUvO
         Lnxod+8K3O133oxIjlHjcDaY8oFxp2J0YswkUxhc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 28/98] reset: hi6220: Set module license so that it can be loaded
Date:   Thu, 25 Oct 2018 10:13:13 -0400
Message-Id: <20181025141423.213774-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <lintonrjeremy@gmail.com>

[ Upstream commit 4497a224f759cd8350e07382307b55f870ef0df2 ]

The hi6220_reset driver can be built as a standalone module
yet it cannot be loaded because it depends on GPL exported symbols.

Lets set the module license so that the module loads, and things like
the on-board kirin drm starts working.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
Reviewed-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 35ce53edabf9..d5e5229308f2 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -155,3 +155,5 @@ static int __init hi6220_reset_init(void)
 }
 
 postcore_initcall(hi6220_reset_init);
+
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

