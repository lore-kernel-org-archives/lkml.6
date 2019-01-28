Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBC621741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694801;
	bh=59c4kl/kX/ZOEEQsOciG9l6TfLHFGvv4w3RADOKGkOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x5dpO4hLbqHe9Fg4z+DTdZwVD1qQE4innX986nzBs+jMeqqUefjxbbLhVFP97IITb
	 x+kaMQb9aD/vW4dmcTBrmhgyVUUxt63oQujCNkkhwXeEFqVBHuVt0XDceHhDLa50Tt
	 hX25i0kGrmk2iwNKO/Jn5JA06Vu/15Qhz77ZssnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfA1Q77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733131AbfA1QPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634792147A;
        Mon, 28 Jan 2019 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692154;
        bh=59c4kl/kX/ZOEEQsOciG9l6TfLHFGvv4w3RADOKGkOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seOqLyCconvDZyc9B/MIf+TW0hyFRXB8i7ycz7/+PDMFEaCHPHWXw1nxS+oX5uIbm
         coTOaCDMt2Z5DkopngXRgW7evJ21vKTqr0TEQ2hb3GXJZ1zfwjSNisNr6ecgS44pdT
         Az8z7m5OL/s1Y2z0S0sqdspINTWSnGdR0FjMjeVw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 091/170] phy: sun4i-usb: add support for missing USB PHY index
Date:   Mon, 28 Jan 2019 11:10:41 -0500
Message-Id: <20190128161200.55107-91-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index afedb8cd1990..d1ccff527756 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -125,6 +125,7 @@ struct sun4i_usb_phy_cfg {
 	bool dedicated_clocks;
 	bool enable_pmu_unk1;
 	bool phy0_dual_route;
+	int missing_phys;
 };
 
 struct sun4i_usb_phy_data {
@@ -645,6 +646,9 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 	if (args->args[0] >= data->cfg->num_phys)
 		return ERR_PTR(-ENODEV);
 
+	if (data->cfg->missing_phys & BIT(args->args[0]))
+		return ERR_PTR(-ENODEV);
+
 	return data->phys[args->args[0]].phy;
 }
 
@@ -740,6 +744,9 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
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

