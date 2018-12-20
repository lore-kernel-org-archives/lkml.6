Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DD1218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PRbQL18f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeLTVYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:24:10 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57638 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730898AbeLTVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:24:09 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A30C46CD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 21:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zmngUplNB2DO for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 15:24:08 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 690C956D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:24:08 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id w5so2449267iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l9LH1XfMbCF2vR+t4aLzNXUzHxNLKn7MMQWy4zB86vc=;
        b=PRbQL18fBERhPZ/7eCPZoq2cC+qmYqN8JZvl5oOTBFFg5PJTgMCOGLHGbIOvidv83u
         Yd4f5qf3+qowzboRdLJBdsnetgKKLIN/5Tg02e/ZhcM6n5N+mnbZu9ufYK8cRoxdU55z
         z3O0Y261zDNEPNj+pp1HWElI8x26pe0g39gvu4nmo6ZzKXBgvlhMjBZWVyUbI7ykA36l
         pJMz1Gt3Om0lrut1n7O5357AaRSzRresQvXikuu7bElEa0jppfCKR/KYfJfYnph3RbKw
         lphCNaSDf31nNsQYdFVnWay06yfTaFGZC9BmvyaZ1pTkV6D/LHImd5wlyhItmcqSNnEr
         AJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l9LH1XfMbCF2vR+t4aLzNXUzHxNLKn7MMQWy4zB86vc=;
        b=qrTsIYtq+fTn5inatde5eR8UYDV4XPwehQQLwnb/uWsDjEdHN+W8a4UF+d0KM9Y2KN
         9Kotu9WHukAvQAyBU102gdSuJ201g+fwYzbmNYL+tzfPwHMAiaVLtA23UBdRksakjLwN
         cf8D6OIjWaorHhz1BdWysHPfTr0C7xEfouegf7lQm5O5iPmtgTdBsH8fSnoHBUCKmbgi
         AsFB6B8ioQdNPJwVRs1n9xWi5B3UAsNUYK/DXPV1VEZE5RFanxdZHLgoxXAoKjzkWr0g
         JKz44RptziTYWywn8fw3RYjbzBGBuI/zyJoKMDYsRTNboJTpRKAWOXSg+TunDQt2Kg1d
         ywWQ==
X-Gm-Message-State: AA+aEWZGP2irt+E2AjD71LJVoZKIb8wNdSHYEC+3iT87Tnh8pt8iLFfR
        ow0dvWgGeFp7tcSdBbLt5/UF+YXPmbSHTU09fz16HT3FCuPk7HwyzxVj4a9ICJ6iHMvX+IdWyNO
        wjWR/vGLjdHDJN50ZgecTbj/tf2pJ
X-Received: by 2002:a6b:900b:: with SMTP id s11mr22594052iod.159.1545341048045;
        Thu, 20 Dec 2018 13:24:08 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UPlA2ux+7J35SQQTak62D2AnAvUKhAGzw3881836qL5lW0PgErxZEQ/SNvdulVG1OB1EqlHA==
X-Received: by 2002:a6b:900b:: with SMTP id s11mr22594038iod.159.1545341047808;
        Thu, 20 Dec 2018 13:24:07 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id w3sm488949ior.28.2018.12.20.13.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:24:07 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: 80003es2lan: fix a missing check of read failure
Date:   Thu, 20 Dec 2018 15:23:59 -0600
Message-Id: <20181220212359.564-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When e1000_read_kmrn_reg_80003es2lan() fails, "kum_reg_data" is
uninitialized and may contain random value. However, it is further
used in the following execution, which will lead to undefined
behaviors.
The fix checks the failure of e1000_read_kmrn_reg_80003es2lan() and
returns with its error code if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59bc9c6..8a6f8e80e062 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -754,8 +754,11 @@ static s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 		return ret_val;
 
 	/* Disable IBIST slave mode (far-end loopback) */
-	e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					&kum_reg_data);
+	ret_val = 
+	    e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
+					    &kum_reg_data);
+	if (ret_val)
+		return ret_val;
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
 	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					 kum_reg_data);
-- 
2.17.1

