Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F27821566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F27821566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0L2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:28:15 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58121 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0L2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:28:15 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5Oad-0002vq-IC from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:11:51 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:11:48 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 08/10] arm64: r8a77965: change to use extended audio dmac register
Date:   Thu, 27 Sep 2018 14:11:58 +0900
Message-ID: <20180927051158.17983-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Basic audio dmac register only supports busif from 0 to 3,
in order to use busif4 ~ busif7, extended audio dmac register
need to be used.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index fd00010a5ed7..6c0d5053a81c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1405,7 +1405,7 @@
 				<0 0xec5a0000 0 0x100>,  /* ADG */
 				<0 0xec540000 0 0x1000>, /* SSIU */
 				<0 0xec541000 0 0x280>,  /* SSI */
-				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+				<0 0xec760000 0 0x200>;  /* Audio DMAC peri peri*/
 			/* placeholder */
 
 			rcar_sound,dvc {
-- 
2.17.0

