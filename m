Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2063CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37120643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197403;
	bh=3RXJQS5dcp5hndMZgFiHdrsJd6e2DZp1+DTeSvJP6IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lo1QzvKVAsQwlGt7ryyVhXWphDTgzC55bLkQo6PdXTm/Htyg14OtBZ7S7dpfMV0Lq
	 MlarO4uzIkab2KpGHhM8JkqN5P8n1fZbYaM2qvanxqQjTVi6Z8YP3XE24KweYMB/xU
	 io4u7YIIHuRsBK/VtIeUK760T7KAFW0w2BifxXiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfBOCXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391726AbfBOCOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941AA20643;
        Fri, 15 Feb 2019 02:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196874;
        bh=3RXJQS5dcp5hndMZgFiHdrsJd6e2DZp1+DTeSvJP6IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JthVVuFCG9fdwzTnFoDMnEcz/53zqw4Yf7DFvZBeUcfCc/miW5kHxM1tzl33kAA2f
         FIp/62DzuZ+8ONnQoSHvEXgIehPa7XUeUw4GNLWaWg738GRa8fNlCq/Mx/rxzlD2kb
         FrcImJzKE1f7ObzRAVrGff8t/DGQkJEtluhcOOYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 04/27] thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
Date:   Thu, 14 Feb 2019 21:14:01 -0500
Message-Id: <20190215021424.178979-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3fe931b31a4078395c1967f0495dcc9e5ec6b5e3 ]

The intel_soc_dts_iosf_init() function doesn't return NULL, it returns
error pointers.

Fixes: 4d0dd6c1576b ("Thermal/int340x/processor_thermal: Enable auxiliary DTS for Braswell")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index ff3b36f339e3..06d46e2ff337 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -416,7 +416,7 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
 					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
 
-		if (proc_priv->soc_dts && pdev->irq) {
+		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);
 			if (!ret) {
 				ret = request_threaded_irq(pdev->irq, NULL,
-- 
2.19.1

