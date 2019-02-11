Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07FAC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D9218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901094;
	bh=huWnGPNCVeJWvkX8MsbMHTObWK0fw4Ut4nx2x9UOWEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/e66BIQFtBiiULm2WIYROoBROF6RB4p3ggXYB0ozCKhZcFGL2YnhEMAI+d+wB+ZD
	 0BOA7LiBoslwJckhrc6Z1djtDwFz9LANsEZP3kC/c46zgdGGIIlMZTLUresmrFwbIO
	 HeW7bhY6e62npcn6/v/yGhc9nhIj5d+p5CwfMEoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfBKO2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfBKO2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B8120821;
        Mon, 11 Feb 2019 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895291;
        bh=huWnGPNCVeJWvkX8MsbMHTObWK0fw4Ut4nx2x9UOWEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lP/GJoqHGMPZLuV023ZGY95IHd3L0e+t3aiqMiFkVix5A8zUKG8RlGU27BrHPW1t0
         Qgfs6GOu3koO9wBYKbqyBdUl2tOR91Zid8xzoKD14tU3tSbY4AdKCy/Wf/Ao8ewcyD
         mHarqWCJozgmBlqBvHexu1h5sSFYS7mB9dJjrVj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 157/352] phy: sun4i-usb: add support for missing USB PHY index
Date:   Mon, 11 Feb 2019 15:16:24 +0100
Message-Id: <20190211141856.772346406@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



