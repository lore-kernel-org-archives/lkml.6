Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEBC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FD6217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="U/vSO0UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfBFDNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:13:12 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:27950 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfBFDNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549422790; x=1580958790;
  h=from:to:cc:subject:date:message-id;
  bh=RoHy0oCGXIhna6y33HCrI+i2WKeLdKhVB5imxc0MR+A=;
  b=U/vSO0UY9tvs1ED84OtcVaRd0p6HGd+nQm5+9042ww1VysRzvCkqbowP
   qpdRMq7Y1Bgp4BPx9v4ngr3FEjfoRrO48ulInDWDwQSS+o2YXKjBxksP1
   o4TTfyRkOuVaB7Me5zK5SUBywrBc56wr8aQ8yDiiWNnNrbVipN+btjWbg
   MuTiuTPLTooChVA3m6U47GdkJUjCCQ7vWRmfAbeiHpzD0Yxl4OvdH29d8
   OcDBgrT5v1MGuF3suSN7juYRpxrXhCjAlDxcl+PSBqUDWBY3h7byLG1sN
   UE0t40yrQiQxX4uc1VfD5KqDLoBiBy9wgLK8ZbdYKGx4cHMaGOkHhG1y8
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AeImxeBZhiuCfrPp0bqbJXq//LSx+4OfEezUN459i?=
 =?us-ascii?q?sYplN5qZoMS4bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUxJXwe?=
 =?us-ascii?q?43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRp?=
 =?us-ascii?q?OOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0AbCrGFSe+?=
 =?us-ascii?q?RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG81/9HktQPC?=
 =?us-ascii?q?TQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58axlVAHnhz?=
 =?us-ascii?q?sGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7deNIaRXFaXsZQUSxBDZ63?=
 =?us-ascii?q?YZUWAeEcM+ZYrpfyp18TohCjAQWhCv/jxjpOi3Tr36M1zv4hHBnG0gI+AtwAvn?=
 =?us-ascii?q?faotLuOasOTey41rXEwC/fY/9K3zr29YjGcgomofGJRb9/c8vRyEgvFwPYiVWb?=
 =?us-ascii?q?tIvoPjOU1+QNqWeb7vZsWf6hhmM8tgF+viKvyt0yhYbUm4IY01bJ/jh6zoYtPd?=
 =?us-ascii?q?C0VlJ3bNq+HJZTtyyWLZV6Tt4+T21ypio21qEKtYamcCULzJkr3QDTZvKHfoSS?=
 =?us-ascii?q?/B7uVfydLDV3iX9jZbmxnQy98VK6xe35TsS01VFKoTdbndTUrXAN0gDT6tCASv?=
 =?us-ascii?q?tg4ketwTaP2B7X6uFDOU00kLDUK58lwrIpjpoTv1nPEjb4mEnokKOaal8o+uev?=
 =?us-ascii?q?6+TgbbXmooGTO5VohQH5N6Qigs2/AeImPQgSR2WX5/iw2bn58UD6QLhGlOM6nr?=
 =?us-ascii?q?TFvJzAO8gXurK1DxdQ0ok56ha/Czmm0M4fnXkCNF9EeBOGj4jzNFHPPPz0Efmy?=
 =?us-ascii?q?jk+xkDh33fDKJKPuDYjQLnTbirfuYa5961JAyAo01d1f45NUCrccIPP8Q0Pxt8?=
 =?us-ascii?q?LXDgU/MwOqx+bqE8t91owAVmKVGKOZM73dsUWO5u0xJ+mAfogVuCzyK6ttyeTp?=
 =?us-ascii?q?iCoImE0dYK7hiYoFaHm5Rqw9C1iSezzhjspXQjRChRY3UOG/0A7KajVUfXvnGv?=
 =?us-ascii?q?1k6w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMAACCUFpcgMjSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUgYBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZ?=
 =?us-ascii?q?QEHgUsJAQiHcIRBgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwC?=
 =?us-ascii?q?IFAEtmz0CBAIEBQIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IPAS-Result: =?us-ascii?q?A2BMAACCUFpcgMjSVdFlHAEBAQQBAQcEAQGBUgYBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI1CA0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hCzyMFzOIZQEHgUsJAQiHcIR?=
 =?us-ascii?q?BgQ+BB4NuiFOCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwCIFAEtmz0CBAIEB?=
 =?us-ascii?q?QIFDyGBJgGCDE0lgWwKgUSCUo4sHjOBB41zAQ?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="scan'208";a="1052827044"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 19:13:09 -0800
Received: by mail-pf1-f200.google.com with SMTP id 74so4194019pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 19:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YYDz1uajXM2BD9Gmd2pvUl+dFDUhIgT0Qevcatq2bns=;
        b=QvtaztSwiQ0vuMTDbQljgh7t/YA2KNyB9DqmlCUpVd9MNjgannuaVAy6z2j3UyeDMx
         iBXUnFZZ4b2m/V+5XR201MjRYzK10riX7/SsLfXZLwidUAvelohXIxc5NLRbsMgw3Tb0
         rAl5nl12+SZ5/IJ0BkrtvpGGrgRi5MIWwLtoBYBm5jF/4zGXeMqVB3DAkxJMKyQdwGJB
         xAMv1+wXgnNyfWzsHfKOfLHxyXSApSlNdM+jToOZRCMCx4yIqdfgAd9YneivqsBG2Fqx
         DlUU9hO/6ShcULTBBaYoZwBbZYmsbN6oHwuRgDwicieKCqQb6/ZzLq5J3EwmThQ33xi/
         ZEhw==
X-Gm-Message-State: AHQUAuaUvrZp0SuF9szCscx9O3DZjs4a0ogZaX33d4r5fC9IiWUeFwRR
        8hKlEJMc9uWig8HgKdjkljh8vkSdJKTwpQkcnQIShMQ/J+lgcHbyxsevb+7gruYDCmsQscIr8cw
        4HBm68w1YwT3Qq9r1qVOjgasL6w==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr8461156plb.256.1549422789164;
        Tue, 05 Feb 2019 19:13:09 -0800 (PST)
X-Google-Smtp-Source: AHgI3IaeCRQc9opHP2/SPoEliLwcrh3aaO85I7bM3TBhacFo7U2dv422YbEPqOxKBlckPLSaLHN+mg==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr8461132plb.256.1549422788787;
        Tue, 05 Feb 2019 19:13:08 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id q187sm12357838pfq.128.2019.02.05.19.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 19:13:07 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhuyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Patrice Chotard <patrice.chotard@st.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: Variable "val" in function miphy_osc_is_ready() could be uninitialized
Date:   Tue,  5 Feb 2019 19:12:57 -0800
Message-Id: <20190206031257.22494-1-yzhai003@ucr.edu>
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

