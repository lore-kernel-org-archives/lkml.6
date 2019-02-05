Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3393C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD3320811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="MAhnsmP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfBEWeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:34:22 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:30975 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfBEWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549406060; x=1580942060;
  h=from:to:cc:subject:date:message-id;
  bh=pl2wCuyh70ie1wWfRv7gV8omPHFI21RoCFDV58aFI/U=;
  b=MAhnsmP1W2nehvyFZdkiMrQMxcHy1Y9xNCOkpBEyyeCnPCESzO5hy8RA
   gi9IUu9yuBlWu7vMUNI5hT2OzA3Chn2zuVu/u7hftQvd3p0SRc1/o3ua4
   F1+bwLtTx67C7UGjTaGsphC5QzvN5yMozfJw/MwdC5hKpvHl2crjEKLuZ
   a5aQXrGOFdVZuiGOq0+7Sz/Ypcjv2HjfD9a3711Lufj88BAhQkESvlkoQ
   XErEGILcOjNpqQfzN3cdU1q/iXFDrbsSgI9vz+jwG6lkPjfkNKwVvGa+w
   P2FHal0zGOBK3P7DjWkAVSmps5BNXkHVqgIdt8GxNvIOjR7rve1E0PX5X
   g==;
IronPort-PHdr: =?us-ascii?q?9a23=3AVc0VBRCOEael3qNbjl/mUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSPvzpcbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzfqbcfdMBXmpBX8BRVyNcCY2i?=
 =?us-ascii?q?doUEEuQBPedGoIn5ulQFsB+yCAewCO/qzDJDm3340rAg0+k5EQ/IwhEuEdwNvn?=
 =?us-ascii?q?rTt9j5KLseXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBUrBxccvQyUkvCgTFhUiX?=
 =?us-ascii?q?pI3lPjKV1v4Cs2mH4+Z8W++ikHMnpB1rojS12Mgjl5TJi5sTx1vZ9it52J44Kc?=
 =?us-ascii?q?OkREN/e9KpE5tduzuEO4drXs8uWX9ktDomxrEepJK2fSwHxI45yxPRa/GLaZaE?=
 =?us-ascii?q?7xP5WOuTLjp1gm9udqiliBao60egz/XxVsyz0FlXsCVIisLMtnUR1xzL7ciHV+?=
 =?us-ascii?q?d98l+h2TmR0wDT7flJIUUumqraL54t26YwlpQOvUjaEC/6hln6gLOMekUr/eio?=
 =?us-ascii?q?7OvnYrH4qZOGK4B0jQT+Prwvmsy5H+s4LhADU3aH9em4zrHu/k30TK9UgvErjq?=
 =?us-ascii?q?XVqo7WKdgHqqKhBg9ayIcj6xKxDze819QYmGEKLVJEeRKHlYfpOk3CLOz2APqk?=
 =?us-ascii?q?nlSjjC1ry+rYMbL8H5XBNmLDn6v5fbZh905czxI+zdRe55JSF7EAL+v/Wkzvu9?=
 =?us-ascii?q?zCCB82LQi0zv35CNVyyIweQ3iDAqyHP6PIt1+H+OYvL/OLZI8PtzauY9Y/4Pu7?=
 =?us-ascii?q?vH4rmUIaNf24z5seaSjgRdx7KF/fbHbx1IRSWVwWtxYzGbS5wGaJViReMjPtB6?=
 =?us-ascii?q?8=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2D3AAAHD1pcgMjSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBVAQBAQsBgztKD4x8ixdSBoIxiDQYbYVZgnOHCgEKAQEshECDFCI3Bg0BAwE?=
 =?us-ascii?q?BAgEBAgETAQEJDQkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hDzyMFzOIYgEHg?=
 =?us-ascii?q?UsJAQiHcIRBgQ+BB4ERgl2IU4JDAoEsAQEBiESHRFiQbgEGAgGBZYFDjwslgWy?=
 =?us-ascii?q?BSoZ+OIdaAS2bOQIEAgQFAgUPIYE7gXhNJYFsCoFEglKOLB4zgQeNcwE?=
X-IPAS-Result: =?us-ascii?q?A2D3AAAHD1pcgMjSVdFlHAEBAQQBAQcEAQGBVAQBAQsBgzt?=
 =?us-ascii?q?KD4x8ixdSBoIxiDQYbYVZgnOHCgEKAQEshECDFCI3Bg0BAwEBAgEBAgETAQEJD?=
 =?us-ascii?q?QkIGwwxgjopgl82UoEVAQUBNVuCRwGBdA2hDzyMFzOIYgEHgUsJAQiHcIRBgQ+?=
 =?us-ascii?q?BB4ERgl2IU4JDAoEsAQEBiESHRFiQbgEGAgGBZYFDjwslgWyBSoZ+OIdaAS2bO?=
 =?us-ascii?q?QIEAgQFAgUPIYE7gXhNJYFsCoFEglKOLB4zgQeNcwE?=
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="1052818625"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 14:34:12 -0800
Received: by mail-pf1-f200.google.com with SMTP id m3so3682439pfj.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RAc6nwFWbtOczH2XwZLlPP8vQcNX6Mwgi29G/8IKFAo=;
        b=c1BiEQcMmFOZS9GM33tb8Q9jXdSLtnANWfCMSdadGBgfNGQInqQ2rVKkiBR+dOJTeA
         qL6srDtFODw5jAFryDasj/9VpiGVzbFQ3QjjlLIIKOXqcy0nE6AjT4oRZJyB1CC1tHLO
         h2XRons2TvMPSuUbyJvzr7kzKGAmV35hbIK7siN0W+nESvfpHsPtw2dkwbJL1M0eLL/k
         oY1SSp1WHPzMzeowhZ1qkjQs3uSqrA2wbV8L49VsTpOWWoulxjXXfrCUBA4OdBgQpkmq
         hAcurmGQv55wEBqSsz6OmjA5b4V+LUkaM/yCc4TadOhTmnC8+xCJuIPNeWJd7hx+WDsr
         x/Ng==
X-Gm-Message-State: AHQUAuYFFCeSUlY88q5M8sDHjYm1tscDlg5Qvemk4r3vOqJUZoaALE3E
        Y//fpw7hNnm54SPBis5Rlij9oeCFbBbb0m8xLP6Tw+xknJrCQear1Iv6HsT0uav05KIOrlmouE5
        w5ghhmolt7OgJR4RmCuZDutBjKQ==
X-Received: by 2002:a62:4886:: with SMTP id q6mr7539839pfi.182.1549406051580;
        Tue, 05 Feb 2019 14:34:11 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbHOe90CmkG9c/uYcgfUU1hlIY5cyNTJeis8VfQv/e0FZNpoPZcliHbgz4x/X95k+EbxAzh6w==
X-Received: by 2002:a62:4886:: with SMTP id q6mr7539827pfi.182.1549406051349;
        Tue, 05 Feb 2019 14:34:11 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id y1sm5170882pfe.9.2019.02.05.14.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:34:10 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PHY: Variable "val" in function pistachio_usb_phy_power_on() could be uninitialized
Date:   Tue,  5 Feb 2019 14:34:01 -0800
Message-Id: <20190205223401.18086-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function pistachio_usb_phy_power_on(), local variable "val"
could be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the if statement, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/phy-pistachio-usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-pistachio-usb.c b/drivers/phy/phy-pistachio-usb.c
index c6db35e6bb63..ae9b6df1667d 100644
--- a/drivers/phy/phy-pistachio-usb.c
+++ b/drivers/phy/phy-pistachio-usb.c
@@ -95,9 +95,13 @@ static int pistachio_usb_phy_power_on(struct phy *phy)
 
 	timeout = jiffies + msecs_to_jiffies(200);
 	while (time_before(jiffies, timeout)) {
-		unsigned int val;
+		unsigned int val = 0;
 
-		regmap_read(p_phy->cr_top, USB_PHY_STATUS, &val);
+		ret = regmap_read(p_phy->cr_top, USB_PHY_STATUS, &val);
+		if (ret) {
+			dev_err(p_phy->dev, "Failed to read USB_PHY_STATUS.\n");
+			goto disable_clk;
+		}
 		if (val & USB_PHY_STATUS_VBUS_FAULT) {
 			dev_err(p_phy->dev, "VBUS fault detected\n");
 			ret = -EIO;
-- 
2.17.1

