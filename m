Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53D8ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0E72133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf00N5/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0E72133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeKIHmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbeKIHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC03A20844;
        Thu,  8 Nov 2018 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714706;
        bh=Zednp/VaRocmPjQiq3qqKGmzLbENXTGMAFs95Xa5BaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lf00N5/QJ3L+28CIRxa7Az8GMCHdA8NRAR/KPYUi5hX3ITndkTOmNtRHQjsoQY/Zv
         h0J3FRVM7xObZnZpOYhxOCyDPHNKb1jfhxyfiqkq1zbp665j1tSNsyO5WQ8Y1JsNiA
         5aXWR6qraGf0g/hhW3Rn/FmRohykVa2gRmYxwTzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 050/171] net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.
Date:   Thu,  8 Nov 2018 13:50:20 -0800
Message-Id: <20181108215131.131109474@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c505873eaece2b4aefd07d339dc7e1400e0235ac ]

88E1145 also need this autoneg errata.

Fixes: f2899788353c ("net: phy: marvell: Limit errata to 88m1101")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index c60c147708c4..520352327104 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1610,7 +1610,7 @@ static struct phy_driver marvell_drivers[] = {
 		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1145_config_init,
-		.config_aneg = &marvell_config_aneg,
+		.config_aneg = &m88e1101_config_aneg,
 		.read_status = &genphy_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
 		.config_intr = &marvell_config_intr,
-- 
2.17.1



