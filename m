Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED8C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B002146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6bmO5No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B002146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeK3Bdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEACE2146D;
        Thu, 29 Nov 2018 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501688;
        bh=Lrzf6QfPvK/zsYqHv7P1QTOTrea6KsBOq+k3qdVMEgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6bmO5NohEzfatPlz9/dp2Z+4JZfIr9cIZwdxAojQdfyPW/JKbl1ezIF9l+CBRBaX
         Lxs5BGbdam+axWkGaoSDAngaO1Yps/6p3tLuOZsQwZuODAKpySl+JsORad3FxT7MbT
         RneBIxGzWGwn6q8NPniYxWkvH04ZY2xNniy8n6ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 085/100] clk: samsung: exynos5250: Add missing clocks for FIMC LITE SYSMMU devices
Date:   Thu, 29 Nov 2018 15:12:55 +0100
Message-Id: <20181129140106.133177825@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 5b23fceec1ff94305c5d1accde018cae27448005 upstream.

FIMC LITE SYSMMU devices are defined in exynos5250.dtsi, but clocks for
them are not instantiated by Exynos5250 clock provider driver. Add needed
definitions for those clocks to fix IOMMU probe failure:

ERROR: could not get clock /soc/sysmmu@13c40000:sysmmu(0)
exynos-sysmmu 13c40000.sysmmu: Failed to get device clock(s)!
exynos-sysmmu: probe of 13c40000.sysmmu failed with error -38
ERROR: could not get clock /soc/sysmmu@13c50000:sysmmu(0)
exynos-sysmmu 13c50000.sysmmu: Failed to get device clock(s)!
exynos-sysmmu: probe of 13c50000.sysmmu failed with error -38

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: bfed1074f213 ("clk: exynos5250: Add missing sysmmu clocks for DISP and ISP blocks")
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/samsung/clk-exynos5250.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -560,6 +560,8 @@ static const struct samsung_gate_clock e
 		0),
 	GATE(CLK_GSCL3, "gscl3", "mout_aclk266_gscl_sub", GATE_IP_GSCL, 3, 0,
 		0),
+	GATE(CLK_CAMIF_TOP, "camif_top", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 4, 0, 0),
 	GATE(CLK_GSCL_WA, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
 	GATE(CLK_GSCL_WB, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
 	GATE(CLK_SMMU_GSCL0, "smmu_gscl0", "mout_aclk266_gscl_sub",
@@ -570,6 +572,10 @@ static const struct samsung_gate_clock e
 			GATE_IP_GSCL, 9, 0, 0),
 	GATE(CLK_SMMU_GSCL3, "smmu_gscl3", "mout_aclk266_gscl_sub",
 			GATE_IP_GSCL, 10, 0, 0),
+	GATE(CLK_SMMU_FIMC_LITE0, "smmu_fimc_lite0", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 11, 0, 0),
+	GATE(CLK_SMMU_FIMC_LITE1, "smmu_fimc_lite1", "mout_aclk266_gscl_sub",
+			GATE_IP_GSCL, 12, 0, 0),
 
 	GATE(CLK_FIMD1, "fimd1", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 0, 0,
 		0),


