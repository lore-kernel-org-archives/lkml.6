Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3834B20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218619;
	bh=RCLJVBJXc3w+e+c73EzCdbEencZv76EbPLuxfPy3EQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SS9yo8PdF7/t/Xv/Nby/oy+cMFN9JFXlpYoTsXu94v3CW/JAfJv5L1bwvlEZE+CMO
	 TmaSK76kUyOPoIyjRod0RAAJySuBJWL8ksaItePX8ABPKIsxrqa0HGpPB/UI/sAYUU
	 5od8PNStKewD/o6WCxYRMASLQcYDIEjthaG8yd60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbfAKOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390142AbfAKOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F7C204EC;
        Fri, 11 Jan 2019 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217325;
        bh=RCLJVBJXc3w+e+c73EzCdbEencZv76EbPLuxfPy3EQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP5AwhjYqmhSruykL3LiC3N1G1nL8wAe9QhAIAVIDv6Y7eM3DfOtCqYMB1RH1GbIU
         +PvvCSHUgCVEHHNq6/iQ/TftOiCVxESYoRJ8huJOiQ92eHLZw/x27zCwW7AU+Rmj0p
         kN92Qg4j0BUIRyZQPY3E1CgYLX7dddWRxH63Dpyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/148] arm64: dts: mt7622: fix no more console output on rfb1
Date:   Fri, 11 Jan 2019 15:13:01 +0100
Message-Id: <20190111131114.468803794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



