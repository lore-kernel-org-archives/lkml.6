Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46048C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0842720578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="p5owKd9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbeLQPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:37:13 -0500
Received: from mail.nic.cz ([217.31.204.67]:51560 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387528AbeLQPhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:37:12 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5EEBF62E78;
        Mon, 17 Dec 2018 16:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545061031; bh=brS6IceeqdnjRv78pNjHmb1qn7jgmR7GRLBxofocQXY=;
        h=From:To:Date;
        b=p5owKd9/Ty8XXQzBhNOyRzP1Ko/zXpEUcJBrM5BFyAVeWopEarOQFTLGPDBvOGqY2
         K1edaj+pBFWykXYxUIWINXkM2q4NvJ8BTrEpKSI30oLYGY3fQ0aLZa1iEnUNQ/+e8G
         QlnhVtpIOyLexlCYO93DBBq0MUCfuvXmlrvOorVo=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v1 3/3] arm64: dts: marvell: armada-37xx: add mailbox node
Date:   Mon, 17 Dec 2018 16:37:06 +0100
Message-Id: <20181217153706.25873-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181217153706.25873-1-marek.behun@nic.cz>
References: <20181217153706.25873-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rWTM BIU mailbox node for communication with the secure
processor.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 4472bcd8f9fb..c4c578f7d5e1 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -334,6 +334,13 @@
 				clocks = <&nb_periph_clk 15>;
 			};
 
+			rwtm: mailbox@b0000 {
+				compatible = "marvell,armada-37xx-rwtm-mailbox";
+				reg = <0xb0000 0x100>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <1>;
+			};
+
 			sdhci1: sdhci@d0000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
-- 
2.18.1

