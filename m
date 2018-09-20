Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A46C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6103A2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6103A2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeITRao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:30:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48060 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeITRao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:30:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8A4F20001A;
        Thu, 20 Sep 2018 13:47:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB78120000C;
        Thu, 20 Sep 2018 13:47:36 +0200 (CEST)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 647F420618;
        Thu, 20 Sep 2018 13:47:36 +0200 (CEST)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     oss@buserror.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH] powerpc/dts/fsl: t2080rdb: reorder the Cortina PHY XFI lanes
Date:   Thu, 20 Sep 2018 14:47:01 +0300
Message-Id: <1537444021-10113-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the T2080RDB schematics, for the CS4315 PHY, the XFI 1 lane is
connected to SFP 2 and the XFI 2 lane is connected to SFP 1. Change the
device tree to reflect the correct PHY order and port association.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t2080rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t2080rdb.dts b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
index 55c0210..092a400 100644
--- a/arch/powerpc/boot/dts/fsl/t2080rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
@@ -77,12 +77,12 @@
 		};

 		ethernet@f0000 {
-			phy-handle = <&xg_cs4315_phy1>;
+			phy-handle = <&xg_cs4315_phy2>;
 			phy-connection-type = "xgmii";
 		};

 		ethernet@f2000 {
-			phy-handle = <&xg_cs4315_phy2>;
+			phy-handle = <&xg_cs4315_phy1>;
 			phy-connection-type = "xgmii";
 		};

--
1.9.1

