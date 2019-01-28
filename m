Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C9F2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690705;
	bh=xRz9z9fe4cnM7O27lB9bmw/V8TQEWxMYuGqXPSOQKgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mY14cGii9xSCa93v/MzvDNii1hr+8milDGsLyZJV11do1ihSQ8gYYGS5tvvX8sEAX
	 rb6IIR46JglxTBNcPegvEIcCBvz/sfNKG080a21lZmmZIwYLyrwyxuyVp/DAZQ1nI8
	 DY12uRGyBuhJQPoI0WTu9MC2wRvLiU0PSMfYzuNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfA1Pvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfA1Pvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F48C20880;
        Mon, 28 Jan 2019 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690700;
        bh=xRz9z9fe4cnM7O27lB9bmw/V8TQEWxMYuGqXPSOQKgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bA2lDTWUgFBSQmPwxcvCiCQr8akspi8DPCqxmy0CipEc7Iv+wUnQoLnxy5KnCi1i
         lnvbjdk9N1ymtQfuzWjIL00A62hX4soVM1yx4E6I6cc1MQQaHRPdLPI+oD52jZPopi
         eDZl9bWBR1a+w1xMkn7xuvo7DjUcy8n3rXXvvHWE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 168/304] phy: sun4i-usb: add support for missing USB PHY index
Date:   Mon, 28 Jan 2019 10:41:25 -0500
Message-Id: <20190128154341.47195-168-sashal@kernel.org>
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

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit 2659392e5c08dff626e6db1d739adff58a94604d ]

The new Allwinner H6 SoC's USB2 PHY has two holes -- USB1 (which is a
3.0 port with dedicated PHY) and USB2 (which doesn't exist at all).

Add support for this kind of missing USB PHY index.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index d4dcd39b8d76..881078ff73f6 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -126,6 +126,7 @@ struct sun4i_usb_phy_cfg {
 	bool dedicated_clocks;
 	bool enable_pmu_unk1;
 	bool phy0_dual_route;
+	int missing_phys;
 };
 
 struct sun4i_usb_phy_data {
@@ -646,6 +647,9 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 	if (args->args[0] >= data->cfg->num_phys)
 		return ERR_PTR(-ENODEV);
 
+	if (data->cfg->missing_phys & BIT(args->args[0]))
+		return ERR_PTR(-ENODEV);
+
 	return data->phys[args->args[0]].phy;
 }
 
@@ -741,6 +745,9 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		struct sun4i_usb_phy *phy = data->phys + i;
 		char name[16];
 
+		if (data->cfg->missing_phys & BIT(i))
+			continue;
+
 		snprintf(name, sizeof(name), "usb%d_vbus", i);
 		phy->vbus = devm_regulator_get_optional(dev, name);
 		if (IS_ERR(phy->vbus)) {
-- 
2.19.1

