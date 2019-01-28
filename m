Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F320881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697773;
	bh=pjsAXJbtyB1iAWgkdfNmb6hLowyHxPrS1Ejc2s3qPHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUoYUjHcd0PnIZwmOWQzs2CZQ792u5kFgIOuRp2WcpfrJse+k1hP3FULtqSX9UKZz
	 4knEhkf8ldWgAUJSHWHN8NjsW6qUDgIo1167Nrewt/wwuQxohyW7MdP1RHEMeHCUme
	 YO3N/PM03D3vlZ21Yo3tb0AtWMYVQU7XFLioAcQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfA1Rtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfA1PpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F02C2147A;
        Mon, 28 Jan 2019 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690308;
        bh=pjsAXJbtyB1iAWgkdfNmb6hLowyHxPrS1Ejc2s3qPHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNqRx1Rg+UbUD4UXKSR5O9CblOKpZx6k1uqqTf9q33wqE16BVG/0IefnDQMpK0Klz
         HocnQLYPBfVbbMuhaNJAonpKPOlpko76XqJRCTLAWFEVGRL7LI+zkpcpxJbIfwvdVm
         5+EQHHMUvb02xTYwkMkyThNBoyPfm4dHuLx1q0e0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Puhm <puhm@oregano.at>, Anatolij Gustschin <agust@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 043/304] fpga: altera-cvp: Fix registration for CvP incapable devices
Date:   Mon, 28 Jan 2019 10:39:20 -0500
Message-Id: <20190128154341.47195-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Puhm <puhm@oregano.at>

[ Upstream commit 68f60538daa4bc3da5d0764d46f391916fba20fd ]

The probe function needs to verify the CvP enable bit in order to
properly determine if FPGA Manager functionality can be safely
enabled.

Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
Signed-off-by: Andreas Puhm <puhm@oregano.at>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index d9fa7d4bf11f..36d79b039c57 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	struct altera_cvp_conf *conf;
 	struct fpga_manager *mgr;
 	u16 cmd, val;
+	u32 regval;
 	int ret;
 
 	/*
@@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
+	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
+	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
+		dev_err(&pdev->dev,
+			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
+			regval);
+		return -ENODEV;
+	}
+
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
-- 
2.19.1

