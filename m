Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E507C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED0521855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900184;
	bh=Zwen8NgYYDNFLrUAiTea203zgui0ONXANg3YE43Pvto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJssgkw/wCVpojuhYU3DtwJUE+URnR/C6767d6WDp+w8Wf62QsFCnFW3WeI910Tsu
	 sq0Q5TfyT/wSCZdou96OyA9vmeBCsowNEUodHJC/pVBDbaCIFkXu9a1Y0uHQLNgMAh
	 COBY0Qh/CwyswJ357bmaNND4ImjsGl8toHqKX4x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfBKPtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731908AbfBKOjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088EB20700;
        Mon, 11 Feb 2019 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895974;
        bh=Zwen8NgYYDNFLrUAiTea203zgui0ONXANg3YE43Pvto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOx9z7axeypzwaVJJnQOgucZBQpSswY+1u6hyvPbw3h1odw7kfKuJrZVEoM31ud87
         T0aTOGyH20QcsgYO42nA2R+TcVt66FrCP21JAMVg4Iy67wEImlQkvUv0/V91rtEO4v
         I7hptHcQm744Jp6shw+WXb6E6CJ4msX7ziJ+aHHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Puhm <puhm@oregano.at>,
        Anatolij Gustschin <agust@denx.de>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/313] fpga: altera-cvp: Fix registration for CvP incapable devices
Date:   Mon, 11 Feb 2019 15:15:12 +0100
Message-Id: <20190211141855.568482000@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 68e4b2b98c8f..1f4c26b4794a 100644
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



