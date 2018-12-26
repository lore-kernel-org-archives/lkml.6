Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B742054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863987;
	bh=/9C1g9ejYy1WWYcDpwYIn+qeokLYG+ppsndL0YUuYqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vf2Sq2Z4DAgdCTqzxA7J0Ah+ZWPSNFyDbcg2Gyy/G89pmyg/e13HLA/J/PnTcFPh+
	 ybE8VxwSTbnNlDirjRwJOR4uEtUmbxMGKoiXjmrOXOVCLbsFXGJJLfTv0vdQ24isXU
	 Z9gEgRZR4emtNs0bEVomMiV1PYdQQoOv9IrpAu7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLZWjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbeLZWi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7992054F;
        Wed, 26 Dec 2018 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863908;
        bh=/9C1g9ejYy1WWYcDpwYIn+qeokLYG+ppsndL0YUuYqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cp+ub+mthWDVE+kk0uN62gIcF53zrCW6Qje78vePTtSxaMlTOSkzntBNjrLzrCAZ4
         pPs20vbAMx2e7Rs/JX1vMjAUjjeAgQKXA3/K2NvhFqQo6wRSkWDPhtPgUhFOmRTOmn
         ABKHD+I3Ehcok3GAEJvAIBsk9ysZLHHVGVxhTfjU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 89/97] net: mvpp2: fix the phylink mode validation
Date:   Wed, 26 Dec 2018 17:35:49 -0500
Message-Id: <20181226223557.149329-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 1b451fb2051b464b9758c09a3492104403252e2b ]

The mvpp2_phylink_validate() sets all modes that are supported by a
given PPv2 port. An mistake made the 10000baseT_Full mode being
advertised in some cases when a port wasn't configured to perform at
10G. This patch fixes this.

Fixes: d97c9f4ab000 ("net: mvpp2: 1000baseX support")
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d5bc90476b4f..f8e4808a8317 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4293,6 +4293,7 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
 		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseT_Full);
 			phylink_set(mask, 10000baseCR_Full);
 			phylink_set(mask, 10000baseSR_Full);
 			phylink_set(mask, 10000baseLR_Full);
@@ -4310,7 +4311,6 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 		phylink_set(mask, 10baseT_Full);
 		phylink_set(mask, 100baseT_Half);
 		phylink_set(mask, 100baseT_Full);
-		phylink_set(mask, 10000baseT_Full);
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
-- 
2.19.1

