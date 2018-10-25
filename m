Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD0ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BD321479
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFtT8zUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BD321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeJYWwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeJYWwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:23 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91DAE2086D;
        Thu, 25 Oct 2018 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477165;
        bh=pWkrmpjONz3J2UxsOyS2hjVuhB66z3RrMORSIDhVbB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFtT8zUhHonLJDf9RrhT71p3ZILoQ79AF1YXsjVSy8Z/tdnEPaPfifRVb1zWzMLAj
         5F10IeduTchVkA6VkekqxkxlV2HoSNCxo1R1X/BU3NdVrfteS3l22sBYBe4JnEGLeX
         8ms6fiCWrS7A+OjY2uiviMYHEkIBLpfvK8ZBB8tY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 19/98] phy-sun4i-usb: Change disconnect threshold value for sun6i
Date:   Thu, 25 Oct 2018 10:17:34 -0400
Message-Id: <20181025141853.214051-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 372400344afb60e275a271f3f5ccce17af0e45cb ]

The allwinner SDK uses a value of 3 for the disconnect threshold setting on
sun6i, do the same in the kernel.

In my previous experience with sun5i problems getting the threshold right
is important to avoid usb2 devices being unplugged sometimes going unnoticed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-sun4i-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0baf5efc8a40..1a2b045d6a67 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -240,7 +240,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	else
 		data->num_phys = 3;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
 		data->disc_thresh = 3;
 	else
 		data->disc_thresh = 2;
-- 
2.17.1

