Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2AFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372E020881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqulDG1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfA1SeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:34:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfA1Sdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so19236243wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
        b=SqulDG1htlstay/n1BHzyLU2JQGWF4RcVpu7TJm73i+S5Fwr+HCfyNcMj/gpDjDYK4
         gFskLeTNSduRkgrAzr+oYZGbPzCkSuEcRZ0babBtOqcd4KKxZkGbns0m7Wx7mB4L/1Kk
         r/8EwQt55R5byIizULDYs4GIaxcrrL7l7/Lh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
        b=jnV96S42FgHnGX4fQvvdtbZLcCV2wWoU0NJ9geGrS1VcQDAn3I+WErvFnpE2LrhYw6
         VBizo6OrDEtvfuMWFsfbEt2huJzfV1Ai7ByHF3S2GyCBMgF1mZe92dPXwUfkuP3i1Cd4
         pbB9KxXKJhSQLEaW7c2CQuSq283gpVzaYp0LtANXf1PrNERfr5dvi6auzkJOOoW1wWJv
         lfTq+xb1MvsodYLqgVYJThJcO2+3dncP6gXqW1b8gpP0MTbkP+G/NHpZUtMR4j7qNiPd
         S2pIzQ3t2uLXEQH9wxmTQ627IQ84G9rLhQewGCr+DeBKxJ6eFPeT7DXqBneE7TUOSIRI
         eW6A==
X-Gm-Message-State: AJcUukf4e31ghRjR+ABjtLTKcifKJX6RuKzOxZIq7R0MBu8iWnItPYG8
        ZaUR4GM6NwWxg67/Y30E6SJYCw==
X-Google-Smtp-Source: ALg8bN5DOJIKZG0xMjU6d3Nh9DE1ZaDcgoyjVebiHC2cVRDceHePkKjSLdouz4HUMHLiqUO88F69nA==
X-Received: by 2002:adf:e846:: with SMTP id d6mr23424491wrn.72.1548700414206;
        Mon, 28 Jan 2019 10:33:34 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:33 -0800 (PST)
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
Subject: [PATCH v2 10/14] arm64: dts: qcom: qcs404: Add OPP table
Date:   Mon, 28 Jan 2019 19:32:57 +0100
Message-Id: <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a CPU OPP table to qcs404

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c165..4594fea7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,6 +62,21 @@
 		};
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-qcs404", "qcom,scm";
-- 
2.7.4

