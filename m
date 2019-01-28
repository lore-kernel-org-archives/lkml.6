Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D2CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A767120881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FP7HwM2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfA1Sdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:33:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfA1Sdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so19268779wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVxxzmEh7O/wpeFAQp3T6SExbMI3Aurwjiqrjgi1z+A=;
        b=FP7HwM2TSUkrIzNgUgG81sDzpBy1MOMEoPvqCecdfRPpDpVQ5LmCEuFQKYFV9eBd12
         /O3Il73uqXfnJ+Y7g4nX3CpLkaCZm2o4JRrFE+4B2Quez8vvqQN1bIdW86sjujlDMt3b
         riz5HTi3W5KUdadChQakj9B/2+sw+7Hfj6BLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVxxzmEh7O/wpeFAQp3T6SExbMI3Aurwjiqrjgi1z+A=;
        b=WP6hQ38dhHo2jLXPfymcryulYI2ie8yR7cR61LjGQree6gOVHzMUQW9SFwcQrc+FjS
         Bd1otiJgLVH/uE2cR3wFcjjj2Ry64wOe7w1odS4cy4MmzjcvWXQ5kIlCy6CJezshluR3
         pOpfAWzjMyaa8gPcpSQyHs6EZxNK6pk3B27xJFOHzJ6ydWRhFQOyCTlyUZyHwYCQGLX/
         OkfDFPIzYBVjP+Pe//hgMZdShp4sXCFCOfhLcg2wur9FhxYjvXhU2la5ge8K/V9TNq1g
         caDdJKINO4glI+hO+OuSP+59ggla2Pl7fCrjADvt2YDNAz8DL9bJ3rI2UhkEJpvjVrYn
         3bMg==
X-Gm-Message-State: AJcUuke485tO/bRO2KD6yeDy9/XfmzcrLVCFE36j2hjvMV5NL8c51LXG
        LKgTUkZaIfwKYcy8HhRjGdOoyw==
X-Google-Smtp-Source: ALg8bN4SXh1T9ga64YDOTO69/f0UDKj9oqz1dD6hdFF1PkvJnEnxBBXmTr4nQlg7jzgMSnBfwyKZVA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr23945970wrn.142.1548700416145;
        Mon, 28 Jan 2019 10:33:36 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:35 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 11/14] arm64: dts: qcom: qcs404: Add HFPLL node
Date:   Mon, 28 Jan 2019 19:32:58 +0100
Message-Id: <1548700381-22376-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4594fea7..6a4f8a2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,7 +62,7 @@
 		};
 	};
 
-	cpu_opp_table: cpu_opp_table {
+	cpu_opp_table: cpu-opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -375,6 +375,15 @@
 			#mbox-cells = <1>;
 		};
 
+		apcs_hfpll: clock-controller@b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

