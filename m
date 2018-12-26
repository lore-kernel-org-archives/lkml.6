Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDD218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863773;
	bh=9887e4ZceVdhmA1B0di26ifOMecye3fDgR/AALFH/Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ys2ad7V2xRIbuSDi1d0nGGQSHrlBuLTpGFQQuXDZ9mgzvnh3m9iWpny3YHO+mTSVY
	 UVEZL2DUqxXnNzY4EFkJaj8aqJ2eKqsCiMUn2lvyHceFuacniug4BeWGavA/7HzSG6
	 PqyoEpwhlN98EmKcfEnmq8+5mrY6qsIHvnsSKK5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLZWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeLZWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A27B218E2;
        Wed, 26 Dec 2018 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863763;
        bh=9887e4ZceVdhmA1B0di26ifOMecye3fDgR/AALFH/Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4nrfE+yM8gs9aCZd8dEhHCQI9s2NotfBMSHY3pJu5vDzpGrQPpINhS+pboXBAxIM
         JqFaXi5wUJNWm7NV40EvR8CaCdeE1Y/IFZPWSObS/LpuhkbENosVfL6+u1sjlImRwZ
         4myFUb9rb3G5LO2ufr2SzoCP+ppAH+dUle9vAoZI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/97] arm64: dts: mt7622: fix no more console output on rfb1
Date:   Wed, 26 Dec 2018 17:34:23 -0500
Message-Id: <20181226223557.149329-3-sashal@kernel.org>
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

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 6c05946e349d92f527d98644fbc9c41f06312c00 ]

No default serial console on boot.
Fix this by using a 'stdout-path' property that points to the device.

Fixes: c0d9f9ad4f76 ("arm64: dts: mt7622: add earlycon to mt7622-rfb1 board")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
[mb: Fix commit message]
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index a747b7bf132d..387be39d40cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -17,8 +17,13 @@
 	model = "MediaTek MT7622 RFB1 board";
 	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
 	chosen {
-		bootargs = "earlycon=uart8250,mmio32,0x11002000 console=ttyS0,115200n1 swiotlb=512";
+		stdout-path = "serial0:115200n8";
+		bootargs = "earlycon=uart8250,mmio32,0x11002000 swiotlb=512";
 	};
 
 	cpus {
-- 
2.19.1

