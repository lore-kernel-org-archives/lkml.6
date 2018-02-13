Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeBMBhc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:37:32 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34621 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbeBMBha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:37:30 -0500
X-Google-Smtp-Source: AH8x226+cQTfTgwEB1CZiX31vgopbZLhLnvxIif0dqYh3uqe6ZDvI90nsUumEoeCjruCfK8hcPq8Wg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Govind Singh <govinds@qti.qualcomm.com>,
        Shon Parate <sparate@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: msm8996: Add rmtfs sharedmem node
Date: Mon, 12 Feb 2018 17:37:24 -0800
Message-Id: <20180213013724.3177-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180213013724.3177-1-bjorn.andersson@linaro.org>
References: <20180213013724.3177-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 2MB shared memory region is used on MSM8996 for exchanging sector data
in rmtfs. Add this chunk of reserved memory now that we have the
rmtfs-mem compatible to describe it and its memory protection
properties.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4b2afcc4fdf4..d04babb5f526 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -75,6 +75,17 @@
 			reg = <0x0 0x86200000 0x0 0x2600000>;
 			no-map;
 		};
+
+		rmtfs@86700000 {
+			compatible = "qcom,rmtfs-mem";
+
+			size = <0x0 0x200000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
 	};
 
 	cpus {
-- 
2.15.0
