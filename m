Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC874C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C427A40
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1C427A40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936154AbeF1XEJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:04:09 -0400
Received: from avasout05.plus.net ([84.93.230.250]:51595 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeF1XEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:04:08 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id Yfq0fWs4J05ijYfq1f40Es; Thu, 28 Jun 2018 23:56:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QJJGuDDL c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=7mUfYlMuFuIA:10 a=beXlt2xKAAAA:8 a=prGIIqvf5DvdsizFjxoA:9
 a=gcY2M4Ci8LIz02MwfSIM:22
Received: by hairyalien (sSMTP sendmail emulation); Thu, 28 Jun 2018 23:56:28 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1] ARM: dts: imx51-zii-rdu1: correct touchscreen axis inversion
Date:   Thu, 28 Jun 2018 23:56:26 +0100
Message-Id: <20180628225626.26203-1-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4wfN89GqMIB8Cvgz0vCsWqLDFSoxzL3mEpqtoJlQz23I+2fiijC19Chc8/gKSw4Lj+0HCdtIbLwnUYp08zMaxdxv+RAJR5fZWpoUS5uMkmaIxLLJlp8lDf
 JtbyRy23EwpPQn3QvvnSB0Y1FubwDQSnVBdMnWcpCRjTR7An/FOhRW1QA62QmLXvJbVOIT3njTEh/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RMI4 touchscreen driver applied inversion and axis swap in the
wrong order, violating the DT binding for those properties. This was fixed in
645a397, so correct the RDU1 DT to apply the inversion to the
correct axis.

Tested on Zii RDU1 00-5105-30 rev B

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 68f5c1d5ecd0..b1d83fb08150 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -553,7 +553,7 @@
 
 		rmi4-f11@11 {
 			reg = <0x11>;
-			touchscreen-inverted-y;
+			touchscreen-inverted-x;
 			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
-- 
2.17.1

