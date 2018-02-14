Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966849AbeBNDui (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:50:38 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42231 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966835AbeBNDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:50:34 -0500
X-Google-Smtp-Source: AH8x225XjejsRZbMPwHMvqmJ0hO+OnSr/1V5oWihMu8EUY74F6wUfu9H5Zg9BG4qQQW8rk3tyPU4GA==
From: Leo Yan <leo.yan@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Ruyi Wang <wangruyi@huawei.com>
Subject: [PATCH RESEND v5 3/3] dts: arm64: Add mailbox binding for hi3660
Date: Wed, 14 Feb 2018 11:49:51 +0800
Message-Id: <1518580191-26451-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
References: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add DT binding for mailbox driver.

Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 22570c3..1ef7b94 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -286,6 +286,14 @@
 			#reset-cells = <2>;
 		};
 
+		mailbox: mailbox@e896b000 {
+			compatible = "hisilicon,hi3660-mbox";
+			reg = <0x0 0xe896b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <3>;
+		};
+
 		stub_clock: stub_clock@e896b500 {
 			compatible = "hisilicon,hi3660-stub-clk";
 			reg = <0x0 0xe896b500 0x0 0x0100>;
-- 
1.9.1
