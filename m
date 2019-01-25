Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E9D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Scu+8dMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfAYSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:14:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45369 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfAYSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:14:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4505442pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=92rcxnZwHHwkt8E/fg+74lwd4Lhb6qATXYJlRZ4Zam0=;
        b=Scu+8dMCCI70YNjSpr71//0DZzMuAzPQlh8VRKvm65oCE6SYaj9G/oiWySPqDOS55u
         7ZcJfzzghmyzDXt9eyJh5XVFINnQvLG9cIq/TYxQ8Tu5/3kilKtqFStwU9rDm8DQNMx7
         GcrL4Wf91SVWyM5Yii7Gd5+YpIbkAWRD1dg40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=92rcxnZwHHwkt8E/fg+74lwd4Lhb6qATXYJlRZ4Zam0=;
        b=MXegelJ30Trw1AxfoO453vksiFD+26sKXwn+VQf+icmJ0gKMlzfi4azevw/g4NtW91
         iIORluYqK9ER2gFDosfQ7XnPm1lbvHyRsCPU7boqgaCXPRiOomkeAZ6WbzCu31ZWvUUA
         CYK0gz13Nz4eE1xXJvcon8G+a1Z8bZi+nElePxUG1iaJfc4evoodPGBo2fX9xdQKDeOl
         dMwmwlEQiJDd0aOxgLibOjMRB/qaQZGz/O0coH1I1h6r2YAdWwBBanS0OpGYgGfhDa6u
         3dDtHRM1ECRDyj6JHK5aYlMS+1SGdBSFn5E0OQwKEr2paIa7VWlaXEDErWbT/1idau3s
         75pw==
X-Gm-Message-State: AJcUukeT58Ka/5UTuGGMuoSpj/nuKpYq6pc3wlsZn3zWu+PKpdJDq7MF
        gAbVwp5TFTCVCIqj5MfGpUJiRQ==
X-Google-Smtp-Source: ALg8bN6B90IrpGEMd5f5992BXqWJ/3W9fhAs3dRu43/E1hsU/ZXq71MlcfIdBquVyTVBcikmdbtDYQ==
X-Received: by 2002:a65:434d:: with SMTP id k13mr10934818pgq.269.1548440088037;
        Fri, 25 Jan 2019 10:14:48 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l11sm33283334pff.65.2019.01.25.10.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:14:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: [PATCH] arm64: dts: qcom: qcs404: Add rpmcc node
Date:   Fri, 25 Jan 2019 10:14:22 -0800
Message-Id: <20190125181422.21434-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rpm clock controller node, to provide the low-noise baseband
clock for the USB PHYs, among other things.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index b3be39e088db..d90decd00f5c 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -225,6 +226,11 @@
 		rpm_requests: glink-channel {
 			compatible = "qcom,rpm-qcs404";
 			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: clock-controller {
+				compatible = "qcom,rpmcc-qcs404";
+				#clock-cells = <1>;
+			};
 		};
 	};
 
-- 
2.18.0

