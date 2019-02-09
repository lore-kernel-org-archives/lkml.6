Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0077C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8924520643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738547;
	bh=8WEVvIuTLU+SX/bciquEI/TeRbGgmd8id2j0Jmv2m60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lodYU9pJUNxs7j3jXyhE0l6Ea9LqrOA7EBn1kB7HZolvw0Y8L97Ar96kpmGnGBdMZ
	 F73hmUQ4iGU919OFEq2vnw4/lv4sE1DlKu0LVgJgg/lXUIWcvUSDcDtR6Ahvhb6A/D
	 phTCmFKOFIsu7d6HjwcUYeQuGllEzd3j4vWHaXXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfBISzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfBISsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3990221919;
        Sat,  9 Feb 2019 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738098;
        bh=8WEVvIuTLU+SX/bciquEI/TeRbGgmd8id2j0Jmv2m60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mT24pattO/hkzNLxldNXY7C+leooGWqksI7BOSEPvkn+HZqynE8/GO264iwuw2S0I
         xUySwJUDNRGwtFCrMkZC58SzEvgiN9tpcEnA0ZPt9RhyfaCM5XSbcBV9H4o6uVJvVa
         6L3e4j68NPDQacCsBfdWem8jmLdxPJiVqdbaMQ18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 32/42] ARM: dts: da850-lcdk: Correct the sound card name
Date:   Sat,  9 Feb 2019 13:47:24 -0500
Message-Id: <20190209184734.125935-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit c25748acc5c20786ecb7518bfeae8fcef93472d6 ]

To avoid  the following error:
asoc-simple-card sound: ASoC: Failed to create card debugfs directory

Which is because the card name contains '/' character, which can not be
used in file or directory names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-lcdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index c196e37606c4..3a2fa6e035a3 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -71,7 +71,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
+		simple-audio-card,name = "DA850-OMAPL138 LCDK";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1

