Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6725720878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6725720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbeGJUgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:36:25 -0400
Received: from mailoutvs31.siol.net ([185.57.226.222]:47398 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732333AbeGJUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:36:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2B9E352272C;
        Tue, 10 Jul 2018 22:35:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lSsbJnUEfd9g; Tue, 10 Jul 2018 22:35:40 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id BBC9152271C;
        Tue, 10 Jul 2018 22:35:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 03AD552272D;
        Tue, 10 Jul 2018 22:35:37 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 08/18] ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
Date:   Tue, 10 Jul 2018 22:35:01 +0200
Message-Id: <20180710203511.18454-9-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun4i-drm DT binding, second paragraph of the first section says:

For all connections between components up to the TCONs in the display
pipeline, when there are multiple components of the same type at the
same depth, the local endpoint ID must be the same as the remote
component's index.

Add mixer ids in R40 DT as mandated by DT binding.

Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 2afb079a3776..1dd088d82773 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -576,9 +576,12 @@
 				#size-cells = <0>;
 
 				tcon_top_mixer0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
 
-					tcon_top_mixer0_in_mixer0: endpoint {
+					tcon_top_mixer0_in_mixer0: endpoint@0 {
+						reg = <0>;
 						remote-endpoint = <&mixer0_out_tcon_top>;
 					};
 				};
@@ -606,9 +609,12 @@
 				};
 
 				tcon_top_mixer1_in: port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <2>;
 
-					tcon_top_mixer1_in_mixer1: endpoint {
+					tcon_top_mixer1_in_mixer1: endpoint@1 {
+						reg = <1>;
 						remote-endpoint = <&mixer1_out_tcon_top>;
 					};
 				};
-- 
2.18.0

