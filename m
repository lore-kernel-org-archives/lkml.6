Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90609ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D3920840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D3920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJaQrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:47:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54108 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJaQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:47:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 362862000AB;
        Wed, 31 Oct 2018 08:50:23 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 790822000A8;
        Wed, 31 Oct 2018 08:50:20 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BF7B2402C8;
        Wed, 31 Oct 2018 15:50:16 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v3] clk: qoriq: add more chips support
Date:   Wed, 31 Oct 2018 15:46:16 +0800
Message-Id: <20181031074616.24412-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more chip-specific compatible strings to support more Socs.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v3:
  - undo deleting old bindings
  - split dts and driver code to different patchset
v2:
  - remove all legacy code

 drivers/clk/clk-qoriq.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4c30b6e..5baa9e0 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1418,12 +1418,23 @@ static void __init clockgen_init(struct device_node *np)
 
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_b4420, "fsl,b4420-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_b4860, "fsl,b4860-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p3041, "fsl,p3041-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p5020, "fsl,p5020-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p5040, "fsl,p5040-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t1023, "fsl,t1023-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
-- 
1.7.1

