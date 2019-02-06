Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A69C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F62184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NfefY0Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfBFDau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:30:50 -0500
Received: from mx3.ucr.edu ([138.23.248.64]:17436 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfBFDat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549423849; x=1580959849;
  h=from:to:cc:subject:date:message-id;
  bh=RoHy0oCGXIhna6y33HCrI+i2WKeLdKhVB5imxc0MR+A=;
  b=NfefY0TpyrDFyPa9/32x9M/MQ/Ipdn3He16GpP7ajdSPRwRTdXeO2KhR
   FReKZ6VRfP8WWGndpsXk4PkxdFeU78Z2nF21GZmBK6SKVrWkR34zcAWiT
   r8U3jsBOti8c7FMRoAVUIVHAPj/4ZDDDvR7L6bwk35mZWu4mRy8LyWTEI
   El7dJhHZfCxdaWowjfbUAp9ocu+ZALSpi7p5XWIrdGurDWSnNZ09OsLuQ
   E5iJ2Eo1e+wJgbP4D0QUItDerTlzFacLD2Qle8HxlhT2BBsRqSimlP1AM
   C8HEHWvIN5sbFzBAkXHWeYTid9nL0iR/9J3XFcphvMc8DYo1JerjRKrGN
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3A/DT9/BSHUoff3NUmlefZC8lUR9psv+yvbD5Q0YIu?=
 =?us-ascii?q?jvd0So/mwa69bBaN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR4BhJ?=
 =?us-ascii?q?detC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+?=
 =?us-ascii?q?KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxxXTv3BGYf?=
 =?us-ascii?q?5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM30u683wqRbD?=
 =?us-ascii?q?VwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4rx1QxH0li?=
 =?us-ascii?q?gIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNMfRGpBRd1RVy1HAoOz?=
 =?us-ascii?q?coABEfMPNvtWr4n8uVQOqQaxDhSoCO7h1jNEg3n71rA43es8CwHLxAwuEcwTvn?=
 =?us-ascii?q?rar9v7M7wfXfypwKTS0TnOde9a1Sv75YPVch4hu/aMXbdofMXTyEkuFgPFjkiX?=
 =?us-ascii?q?qYf4OD6U1uUMs2iB4OphSe6jl2Aqphpsojez3McgkJfGiZ8Iyl3d8yhy3YU7Jc?=
 =?us-ascii?q?WgRUJlfdKpFIFcuiKaOodsXM8uXmFltDwnxrACvZO3ZDUGxZUjyhLFdfCKfYiF?=
 =?us-ascii?q?7gj9WOuQOzt1hn1odbSijBio60eg0PfzVsys3VZPqSpKj8fDu2gW1xzW9siHUv?=
 =?us-ascii?q?x9/lq92TqX1wDc9OVEIUcsmKreMZEhw7owmoMLsUTMAyP6gUv2gLKSe0gg4OSo?=
 =?us-ascii?q?5OPnYrLppp+YKYB4kB3xMqMrmsCnAOQ4NBYBX3SD9OiiyLHu+Vf1TbZKg/EsjK?=
 =?us-ascii?q?XVrZDXKd4GqqO9BwJZyoMj5Ay+Dzei3tQYh34HLFdddROHjonpO0vBIPHkAfuj?=
 =?us-ascii?q?jVmhiypryOzcPrH7HJrCM2XDnK/7fblh805c1BYzzddH6pJQC7EBJu/zW0DouN?=
 =?us-ascii?q?zbEBA5KQq0zPjjCNhmyIMeVnyAArWDPKPRr1CI/OQvLPeIZIMPvzb9MfcltLbA?=
 =?us-ascii?q?l3g8zG4cb6m02tNDeWK4F/U+ex6xfHH2xNoNDDFZ7UIFUOX2hQjaAnZobHGoUv?=
 =?us-ascii?q?d5uWk2?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMAACFVFpcgMfXVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUgYBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZ?=
 =?us-ascii?q?QEHgUsJAQiHcIRBgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwC?=
 =?us-ascii?q?IFAEtmz0CBAIEBQIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IPAS-Result: =?us-ascii?q?A2BMAACFVFpcgMfXVdFlHAEBAQQBAQcEAQGBUgYBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZQEHgUsJAQiHcIR?=
 =?us-ascii?q?BgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwCIFAEtmz0CBAIEB?=
 =?us-ascii?q?QIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="scan'208";a="29270258"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp3.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 19:30:48 -0800
Received: by mail-pg1-f199.google.com with SMTP id 143so3734091pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 19:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YYDz1uajXM2BD9Gmd2pvUl+dFDUhIgT0Qevcatq2bns=;
        b=J455sllK7qe6i9NWLNivQ180OZkrLqrzJhkvyx7/PVIYaaEgR5eXrGnyzZSqrxTjrj
         iTFajcyDTkV+xETkf0tgOux8+RkufCRO2Jv5Hobaytdlx65xFFbwVkUz5ory2q5Lwb+k
         WZ88Ka0bS9tTOEVXW96X+lvXHKYN52jOB+HgVLTIZYwi1eTAhcEGulpY1I+poABSXl6L
         TrJ6v/rLOrZUkb7RKiE/hr4XWLLek2tAb161CEKrhG59PgJBz/Ju89H2QXs3tYn018W3
         3Fou9xcFZNVMRSiyd3Pr8K+5NLvckRorIHOCBbrIvPK5LfyhPNYBvU1/7L/d4O3w0VId
         7ejQ==
X-Gm-Message-State: AHQUAuYjzhg9wPszdCATjnBAKAnEtXKxtDgNi+wSB++aRoqEgI7W6CrM
        1N0+d5moCVYSJA1qOqiGtRLzREsnpCoxB/YaKqbFTuWQ7quh3KdtqnVDCeZnE4XetjqQHRKjuWe
        s84POEb5/eMxOInLPIQCBpiCugw==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr8345243pln.324.1549423847913;
        Tue, 05 Feb 2019 19:30:47 -0800 (PST)
X-Google-Smtp-Source: AHgI3IaToAk1qKrM98u2WVG62AntNk2kOh/LjiLDaXOGTAhdEC3TosN9dKtPsvvezCKOlTRbmIcmWg==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr8345227pln.324.1549423847721;
        Tue, 05 Feb 2019 19:30:47 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id v15sm5414056pfn.94.2019.02.05.19.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 19:30:47 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Patrice Chotard <patrice.chotard@st.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: Variable "val" in function miphy_osc_is_ready() could be uninitialized
Date:   Tue,  5 Feb 2019 19:30:36 -0800
Message-Id: <20190206033036.22729-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function miphy_osc_is_ready(), local variable "val"
could be uninitalized. if function regmap_read() returns
-EINVAL. However, this value is used in if statement.
This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/st/phy-miphy28lp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 213e2e15339c..40c7c0a611a0 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -835,7 +835,8 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
 	unsigned long finish = jiffies + 5 * HZ;
-	u32 val;
+	u32 val = 0;
+	int ret;
 
 	if (!miphy_phy->osc_rdy)
 		return 0;
@@ -844,8 +845,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 		return -EINVAL;
 
 	do {
-		regmap_read(miphy_dev->regmap,
+		ret = regmap_read(miphy_dev->regmap,
 				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
+		if (ret)
+			return ret;
 
 		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
 			cpu_relax();
-- 
2.17.1

