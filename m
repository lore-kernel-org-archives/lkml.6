Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A65C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E4208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6E4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbeHAKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:32:54 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:54664 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388529AbeHAKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:32:53 -0400
Received: from cl?rock-chips.com (unknown [192.168.167.233])
        by regular1.263xmail.com (Postfix) with ESMTP id 09CAF2A4;
        Wed,  1 Aug 2018 16:48:11 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 7CD79383;
        Wed,  1 Aug 2018 16:47:57 +0800 (CST)
X-RL-SENDER: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: cl@rock-chips.com
X-UNIQUE-TAG: <6f40c948e141a84a13d2b8f3ab51a8b2>
X-ATTACHMENT-NUM: 0
X-SENDER: cl@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 289877DI0QP;
        Wed, 01 Aug 2018 16:48:08 +0800 (CST)
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v3 2/4] dt-bindings: rockchip: grf: add grf and pmugrf description for px30
Date:   Wed,  1 Aug 2018 16:45:14 +0800
Message-Id: <1533113116-8820-3-git-send-email-cl@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of GRF and PMUGRF for PX30 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index 7dc5ce8..46e27cd 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -13,6 +13,7 @@ On RK3328 SoCs, the GRF adds a section for USB2PHYGRF,
 Required Properties:
 
 - compatible: GRF should be one of the following:
+   - "rockchip,px30-grf", "syscon": for px30
    - "rockchip,rk3036-grf", "syscon": for rk3036
    - "rockchip,rk3066-grf", "syscon": for rk3066
    - "rockchip,rk3188-grf", "syscon": for rk3188
@@ -23,6 +24,7 @@ Required Properties:
    - "rockchip,rk3399-grf", "syscon": for rk3399
    - "rockchip,rv1108-grf", "syscon": for rv1108
 - compatible: PMUGRF should be one of the following:
+   - "rockchip,px30-pmugrf", "syscon": for px30
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
 - compatible: SGRF should be one of the following
-- 
1.9.1


