Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670872146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfBSOIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:08:17 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:65528 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfBSOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:08:17 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1JE84bM082702;
        Tue, 19 Feb 2019 23:08:04 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 19 Feb 2019 23:08:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1JE81Zl082668
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 Feb 2019 23:08:04 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH 2/2] arm64: dts: rockchip: fix cts, rts pin assign of UART3 for rk3399
Date:   Tue, 19 Feb 2019 23:08:00 +0900
Message-Id: <20190219140800.12624-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219140800.12624-1-katsuhiro@katsuster.net>
References: <20190219140800.12624-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes pin assign of cts and rts signal of UART3.

Currently GPIO3_C2 and C3 pins are assigned but TRM says that
GPIO3_C0 and C1 are correct.

Refer:
  RK3399 TRM v1.4 - Table 19-1 UART Interface Description

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 76fc2c7af80a..beaa92744a64 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2535,12 +2535,12 @@
 
 			uart3_cts: uart3-cts {
 				rockchip,pins =
-					<3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC0 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			uart3_rts: uart3-rts {
 				rockchip,pins =
-					<3 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.20.1

