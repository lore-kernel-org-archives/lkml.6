Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A5AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D40218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjAWQyMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfAXMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:45:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38659 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAXMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:45:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so4196829lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVf1u1bMHpoQIEvtOx2yyfgG4CbBfs3I9VI/LP9BasM=;
        b=bjAWQyMyAn4VcBFh3wcFsgaOuywUkYHSu+LoBoWC6LnnptyHWwOTjy85Wylo58m41f
         mI7kQiZrLwkDfi/aCeBK6+xdHEuVV3/EAql3T6gQnfwQCEhzuh/IrpivSYgJ6WuuWneO
         yKvBs2ZRoHjkh9mq5WqYePo/Z9UEZWXA910yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVf1u1bMHpoQIEvtOx2yyfgG4CbBfs3I9VI/LP9BasM=;
        b=dulLC4QTtOL8i8PzD7V6JE61Al+rFWbLbJtrGCJLgTtobs3Vxo9YpqFRMcGMkJ9JXL
         1S7Vyt2MCS6GKoD/oPRm1pEQo8Wcmqk5hsN1/hoThXO+NIevBtURaIlqRF7mGkcBLHuf
         afSC80L0ogfQgdQaACtiGvcD9AxnP+rMjRZxNqp7CA2wnDDzvetobUbHrCdiJXiTdsPF
         lWnDytCQTds9YhVV2Hdyun8syGMexY43BlLgbC/oaIrBbRPZu7BDkUEjgqE/9SlzLv3p
         dNWY2oN+cVBCLscUGoDn7rYtnZdl2+iqibON94CgDDVSPKmP313XDC5zKGY8EisJOSgf
         plGA==
X-Gm-Message-State: AJcUukduPqsuGEjVkipV2AHVL6+ZfIksWFE5G4vj04FAiOWegoWjYxDH
        qb2Wv/gPR1s5IhDTGyof4rDr5g==
X-Google-Smtp-Source: ALg8bN72gdOYskRBxuFW74QpFP+BwcW9A9OOAU82OK/2aOF8wvkVFH+ZsrPwU1esck/zIcj/v2AW1w==
X-Received: by 2002:a19:3b45:: with SMTP id i66mr5415300lfa.28.1548333931532;
        Thu, 24 Jan 2019 04:45:31 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o14-v6sm982829lji.70.2019.01.24.04.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 04:45:30 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: dts: msm8916: remove bogus argument to the cpu clock
Date:   Thu, 24 Jan 2019 13:45:08 +0100
Message-Id: <20190124124508.6541-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The apcs node has #clock-cells = <0>, which means that those who
references it should specify 0 arguments.

The apcs reference in the cpu node incorrectly specifies an argument,
remove this bogus argument.

Fixes: 65afdf458360 ("arm64: dts: qcom: msm8916: Add CPU frequency scaling support")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a1..e4bfd47178b1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -111,7 +111,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -123,7 +123,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -135,7 +135,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
@@ -147,7 +147,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
-			clocks = <&apcs 0>;
+			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
 		};
-- 
2.19.1

