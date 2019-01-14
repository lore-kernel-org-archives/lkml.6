Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A82C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6350A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:43:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33745 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:43:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so29977pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEPj3gwfHL0lmQt8i9cpEJHC7YdOzae9+2BrYxoGEH8=;
        b=kxODf2BUPXe6qpbMT6sYczQw/BEcQQwJONNLhWorw3hAgE7k8P+WwucaxY3899hCwQ
         JgJQYF20asreFBqL+gopPExOAiIw3R+NQXcRLD/jFPu6y34CHGw1dqRvV6+llhoxPTrD
         EXr6gQDvdOBjGCrWQb1r0yHuZ3qtb1AVzX4UPiCDzJs2TE1MOmVTo/E+35k7h9WGOp/a
         w4fKgll26vrfSWAKflqo1Gvp/cT6JofR/LqhQbWN1xM7CE2WwXlDd7kH+aafoxfMEriA
         DlYDeHSv1MjsD/Xo3pRnn9ug9lo07pEThc/rnvwCC/50CunHixhpqQqLIuGrnf4td4ew
         Qavg==
X-Gm-Message-State: AJcUuke+bCmZ+wulRW4/KF7Bx9sfUv25PBa+bN2TdfRXrGC18GzABWdu
        IfTxRYAuxdl2sLFiTs/ehCKAhw==
X-Google-Smtp-Source: ALg8bN4wHpFDmuWairamlt1Mix3xcf+GUbdNTZWE9nY+Mlw3dJCAkh+fcjiqMcETF5TBRV26bLCG9g==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr19461747pfo.20.1547491392444;
        Mon, 14 Jan 2019 10:43:12 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v191sm1197512pgb.77.2019.01.14.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:43:11 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: sdm845: Add CPU topology
Date:   Mon, 14 Jan 2019 10:42:55 -0800
Message-Id: <20190114184255.258318-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
that describes this topology.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a6..f6c0d87e663f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -192,6 +192,44 @@
 				next-level-cache = <&L3_0>;
 			};
 		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+
+				core1 {
+					cpu = <&CPU5>;
+				};
+
+				core2 {
+					cpu = <&CPU6>;
+				};
+
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
 	};
 
 	pmu {
-- 
2.20.1.97.g81188d93c3-goog

