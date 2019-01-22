Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CA320879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdmohsLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAVFwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:52:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38740 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAVFvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so10898695plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sl0tPf1cXbi8vKXNTpstL1d2A0LU8sPSxUtRPLPpSis=;
        b=jdmohsLojjOXN7ZQvPlPNBhjKdQ064xBypP6dAerbnzu3JsPhiYI+qfSmt1CceY+fk
         Ih7o4ri/aUprfZdFV2uh/65qyyPCerWRmwl+bJliVsV5D9qO2fkStrZHxJNiIyHctnOV
         zBJYTHkIprgPYm/yF505qjMVZZd2hDnWKfvB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sl0tPf1cXbi8vKXNTpstL1d2A0LU8sPSxUtRPLPpSis=;
        b=RHQMUjaIrKFKVjmejQUf8XWWjhncpo5CcOWs11jDGmgcbClxj/uYZrjABN2kkTSYA8
         DNyhX/VeeHYr6iaOOe8vjox7I4shzvjpFXS95sFOAiyz06usnyseMJVGJykDC4e/ZobL
         nl9QFU3F7228EXj1qOHfOPxzB5g54WNdQ5lW4CLUmXbdAA7msxI8PhRMez4dm1xWN1R9
         klUkWhyMq+XnCmfZmDbmJ96RHMI31R2Br3PTRc3wSCFDSwsP/31wdGGInK36c6jVWSlb
         fZZGB6DagwqHqwGrSs/Kr8tOLLySzDoQgEluRojqrX74QfaYQqTNnPt3Z7m3kcHnRofT
         AE+A==
X-Gm-Message-State: AJcUukcUVDnB86w9Kw5C9yl/pTjOfzTyF9qY4Cc0qw13hm3/cuPrSbmo
        +fPjaL78SMG2bztbKaR8MAepHA==
X-Google-Smtp-Source: ALg8bN7VMWkLqWTStgimPzUr4QTWvd7RBAme1Ia4dMkZvDaKLfYrFZcGERXZYKd2uBMGXO2XN3Xtwg==
X-Received: by 2002:a17:902:e10a:: with SMTP id cc10mr33287703plb.165.1548136306281;
        Mon, 21 Jan 2019 21:51:46 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:45 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region memory map
Date:   Mon, 21 Jan 2019 21:51:03 -0800
Message-Id: <20190122055112.30943-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122055112.30943-1-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update existing and add all missing PIL regions to the reserved memory
map, as described in version 10.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0ec827394e92..cdcac3704c13 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -89,12 +89,47 @@
 		};
 
 		memory@86200000 {
-			reg = <0 0x86200000 0 0x2d00000>;
+			reg = <0 0x86200000 0 0x100000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@96700000 {
-			reg = <0 0x96700000 0 0x100000>;
+		memory@86300000 {
+			reg = <0 0x86300000 0 0x4800000>;
+			no-map;
+		};
+
+		memory@8ab00000 {
+			reg = <0 0x8ab00000 0 0x1400000>;
+			no-map;
+		};
+
+		memory@8bf00000 {
+			reg = <0 0x8bf00000 0 0x500000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@8c410000 {
+			reg = <0 0x8c410000 0 0x5000>;
+			no-map;
+		};
+
+		memory@8c415000 {
+			reg = <0 0x8c415000 0 0x2000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1a00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8df00000 {
+			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
@@ -103,10 +138,30 @@
 			no-map;
 		};
 
+		venus_mem: memory@95800000 {
+			reg = <0 0x95800000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@95d00000 {
+			reg = <0 0x95d00000 0 0x800000>;
+			no-map;
+		};
+
 		mba_region: memory@96500000 {
 			reg = <0 0x96500000 0 0x200000>;
 			no-map;
 		};
+
+		slpi_mem: memory@96700000 {
+			reg = <0 0x96700000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: memory@97b00000 {
+			reg = <0 0x97b00000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	cpus {
-- 
2.18.0

