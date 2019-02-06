Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09043C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28652184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Glt2XeIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfBFBsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:48:04 -0500
Received: from mx3.ucr.edu ([138.23.248.64]:3389 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfBFBsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549417684; x=1580953684;
  h=from:to:cc:subject:date:message-id;
  bh=MkIFH725olQXVn1J0td1c/AMRtWp8ZUI3+26TG4Oq/o=;
  b=Glt2XeIl8L9WmiVh7VmcB9KzUJXTDhkDKi7Qr6wvL2evmC4Hf+zcwPv4
   CA+3DgJgnVwvXlBNhHYxzWgvrb6UdZ9bCMsTuNFTR0S07Rr3i8zW+qWh2
   q8L7jHu/Y+4H1JgnSPJaorF04H0zfeE9HOw94RIshea8OwVw16wLveIJx
   r8nCwdx5Z6mAXROumU9daBqsdiVCFakHFYDIgYoyaHEJdtmkL5nKO6isL
   XR9xi05B//DTEBthkVZLrf+LbMTVaqFh9+xbZIIEcbb9rOwQeoD9C8mvW
   IViKQ1X2Q14KpLuCEv8sz4zFMbHkoGciKbIQb8r9NyvZM8RcbQNIKjKaN
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AXgvoCxTHS2ndkguJ1IfBDjhcu9psv+yvbD5Q0YIu?=
 =?us-ascii?q?jvd0So/mwa69bBaN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR4BhJ?=
 =?us-ascii?q?detC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+?=
 =?us-ascii?q?KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxxXTv3BGYf?=
 =?us-ascii?q?5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM30u683wqRbD?=
 =?us-ascii?q?VwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4rx1QxH0li?=
 =?us-ascii?q?gIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNMfRGpBRd1RVy1HAoOz?=
 =?us-ascii?q?coABEfMPNvtWr4n8uVQOqQaxDhSoCO7h1jNEg3n71rA43es8CwHLxAwuEcwTvn?=
 =?us-ascii?q?rar9v7M7wfXfypwKTS0TnOde9a1Sv75YPVch4hu/aMXbdofMXTyEkuFgPFjkiX?=
 =?us-ascii?q?qYf4OD6U1uUMs2iB4OphSe6jl2Aqphpsojez3McgkJfGiZ8Iyl3d8yhy3YU7Jc?=
 =?us-ascii?q?WgRUJlfdKpFIFcuiKaOodsXM8uXm5ltDwnxrACu5O3ZDUGxZUjyhLFdfCKfYiF?=
 =?us-ascii?q?7gj9WOuQOzt1hn1odbSijBio60eg0PfzVsys3VZPqSpKj8fDu2gW1xzW9siHUv?=
 =?us-ascii?q?x9/lq92TqX1wDc9OVEIUcsmKreMZEhw7owmoMLsUTHAyP6gUv2gLKSe0gm4OSo?=
 =?us-ascii?q?5OPnYrLppp+YKYB4kB3xMqMrmsCnAOQ4NBYBX3SD9OiiyLHu+Vf1TbZKg/EsjK?=
 =?us-ascii?q?XVrZ/XKd4GqqO9AQJZyoMj5Ay+Dzei3tQYh34HLFdddROHjonpO0vBIPHkAfuj?=
 =?us-ascii?q?jVmhiypryOzcPrH7HJrCM2XDnK/7fblh805c1BYzzddH6pJQC7EBJu/zW0DouN?=
 =?us-ascii?q?zbEBA5KQq0zPjjCNhmyIMeVnyAArWDPKPRr1CI/OQvLPeIZIMPvzb9MfcltLbA?=
 =?us-ascii?q?l3g8zG4cb6m02tNDeWK4F/U+ex6xfHH2xNoNDDFZ7UIFUOX2hQjaAnZobHGoUv?=
 =?us-ascii?q?d5uWk2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AACXPFpcgMXWVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBgztKD4wdX4sWUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQM?=
 =?us-ascii?q?BAQIBAQIBEwEBCQ0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNoRQ8jBcziGQBB?=
 =?us-ascii?q?4FLCQEIh3CEQYEPgQeDbohTgkMCgSwBAQGIRIdEWJBuAQYCAYFlgUOPCyWBbIF?=
 =?us-ascii?q?Khn44h1oBLZs5AgQCBAUCBQ8hgSWCDk0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IPAS-Result: =?us-ascii?q?A2A1AACXPFpcgMXWVdFlHAEBAQQBAQcEAQGBUQcBAQsBgzt?=
 =?us-ascii?q?KD4wdX4sWUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQMBAQIBAQIBEwEBC?=
 =?us-ascii?q?Q0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNoRQ8jBcziGQBB4FLCQEIh3CEQYE?=
 =?us-ascii?q?PgQeDbohTgkMCgSwBAQGIRIdEWJBuAQYCAYFlgUOPCyWBbIFKhn44h1oBLZs5A?=
 =?us-ascii?q?gQCBAUCBQ8hgSWCDk0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="29253170"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp3.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 17:47:45 -0800
Received: by mail-pl1-f197.google.com with SMTP id x14so3780965pln.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 17:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v2+oUWDnQz4pz+6QK9pnqRnNQZm/eHZVWJ/uZZFNW/A=;
        b=hVY5+Zc1VkZyIV/JaafCIu7tyY+LYlE/3vixwWrHByOz3kdpoU+EfyR4OGXotJ+uOf
         4LlAUauwLLgxDuVgfw0h+roJFT8TUHeh0SRZijPXZzDbOegA9nbtAHQz70o2gACCJw6/
         9maZtYoxzfXOR56fgxusECReFL0/uxiPgyYEd9/ltllJ9iLG3+5ITXJRYKSfi2ct0+6k
         GNxOqhJqI6X44v0Az0tDwLSb3I+LNFAO87IvGa8XuEve8uLqxasDvuCxhCTlCVhrVfQS
         zuVHJnZdX90ZhhdhcN4zyNr67XhM15s709tarMqLUq9/wduJHrv3qruYB74tgNrGl5Tg
         H9fQ==
X-Gm-Message-State: AHQUAuY5ApUoq4wMcX9Fn1baejalYpCWo24JPfp9st1cp9HE7QQzlTlr
        x1gvmKm8SpVT6p9ES58pC78mPGILE5tukrax+YqD+heAftxysazK6HZWtIC5YaF8jwqlxMAXLg+
        2kIBLBgXAoIGbGf2K69dfMeCTMg==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr8219310pfb.122.1549417663965;
        Tue, 05 Feb 2019 17:47:43 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZ/Dj8XlceW1pvJi4tE1ublOmi4prcBrw/600wizMg1uz17vyyzMG0/5Rf2549oAiXQIVi4mQ==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr8219285pfb.122.1549417663512;
        Tue, 05 Feb 2019 17:47:43 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id z13sm8736089pgf.84.2019.02.05.17.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 17:47:42 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: Variable "caldone" in function rockchip_emmc_phy_power() could be uninitialized
Date:   Tue,  5 Feb 2019 17:47:33 -0800
Message-Id: <20190206014733.21094-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rockchip_emmc_phy_power(), local variable "caldone"
could be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index f1b24f18e9b2..ca921ae08309 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -85,11 +85,12 @@ struct rockchip_emmc_phy {
 static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	unsigned int caldone;
+	unsigned int caldone = 0;
 	unsigned int dllrdy;
 	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
 	unsigned long rate;
 	unsigned long timeout;
+	int err;
 
 	/*
 	 * Keep phyctrl_pdb and phyctrl_endll low to allow
@@ -164,9 +165,14 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	 * wait 5us for calpad busy trimming
 	 */
 	udelay(5);
-	regmap_read(rk_phy->reg_base,
+	err = regmap_read(rk_phy->reg_base,
 		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
 		    &caldone);
+	if (err) {
+		pr_err("Failed to read status.\n");
+		return err;
+	}
+
 	caldone = (caldone >> PHYCTRL_CALDONE_SHIFT) & PHYCTRL_CALDONE_MASK;
 	if (caldone != PHYCTRL_CALDONE_DONE) {
 		pr_err("rockchip_emmc_phy_power: caldone timeout.\n");
-- 
2.17.1

